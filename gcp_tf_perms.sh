PROJECT="test1-430504"           # <== CHANGE
SA_NAME="idmeauth"                           # <== CHANGE
SA_KEY_FILE="/home/taxi/idme/secret/gcp_tf_key.json"

gcloud iam service-accounts create $SA_NAME  --description "id.me please... for i am but a name" --display-name "$SA_NAME"

# SET IAM policies
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/cloudsql.admin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/compute.admin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/compute.networkAdmin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/compute.securityAdmin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/compute.viewer
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/container.admin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/container.clusterAdmin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/container.developer
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/file.editor
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/iam.serviceAccountAdmin
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:${SA_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/resourcemanager.projectIamAdmin

# create keyfile
# set the 'credentials' attribute in the google terraform provider's resource block
gcloud iam service-accounts keys create ${SA_KEY_FILE} --iam-account ${SA_NAME}@${PROJECT}.iam.gserviceaccount.com
chmod 500 ${SA_KEY_FILE}

