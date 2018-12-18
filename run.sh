NAME_PROJECT=bitrix-123458;
NAME_CLUSTER=bitrix;

gcloud projects create $NAME_PROJECT --name $NAME_CLUSTER --enable-cloud-apis \
&& gcloud config set project $NAME_PROJECT \
&& gcloud projects list \
&& gcloud container clusters create $NAME_CLUSTER --zone europe-north1-a
