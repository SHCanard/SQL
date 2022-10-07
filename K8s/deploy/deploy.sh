kubectl create namespace mssql
kubectl config set-context mssql --namespace=mssql
kubectl config use-context mssql
kubectl create secret generic mssql-secret --from-literal=SA_PASSWORD="Sql2019isfast"
kubectl apply -f server2019-latest.yml --record
