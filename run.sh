NAME_PROJECT=bitrix-123458;
NAME_CLUSTER=bitrix;

echo "Why do it use current project and it not create new project: enter 'N'?";
read a;
if [ "$a" = "Y" ]
then
  gcloud projects create $NAME_PROJECT --name $NAME_CLUSTER --enable-cloud-apis \
  && gcloud config set project $NAME_PROJECT \
  && gcloud projects list;
  gcloud container clusters get-credentials $NAME_CLUSTER --zone europe-north1-a --project $NAME_PROJECT
fi;

gcloud container clusters create $NAME_CLUSTER \
  --machine-type=n1-standard-1 --disk-size=10GB --image-type ubuntu \
  --scopes compute-rw,gke-default \
  --machine-type=custom-1-1024 \
  --cluster-version=1.11 --enable-autoupgrade \
  --num-nodes=1 --enable-autoscaling --min-nodes=1 --max-nodes=2 \
  --zone europe-north1-a

#kubectl config set-context dev \
#  --namespace=development \
#  --cluster=gke_su22-224621_europe-north1-a_bitrix \
#  --user=gke_su22-224621_europe-north1-a_bitrix

#kubectl config use-context dev
kubectl config set-context $(kubectl config current-context) --namespace=development
kubectl apply -f namespace.yaml
kubectl create -f deploymnet.yaml -f loadbalancer.yaml
