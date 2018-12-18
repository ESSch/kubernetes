NAME_PROJECT=bitrix-123458;
NAME_CLUSTER=bitrix;

echo "\nCreate a new project: enter 'Y'?";
read a;
if [ "$a" = "Y" ]
then
  gcloud projects create $NAME_PROJECT --name $NAME_CLUSTER --enable-cloud-apis \
  && gcloud config set project $NAME_PROJECT \
  && gcloud projects list;
  gcloud container clusters get-credentials $NAME_CLUSTER --zone europe-north1-a --project $NAME_PROJECT
fi;

gcloud container clusters create $NAME_CLUSTER --zone europe-north1-a
