help:
	@echo "setup - Enable plugins and create namespace"
	@echo "setup-db - Apply the db.sql on the postgres database"
	@echo "dashboard - start the kubernetes dashboard"
	@echo "deploy-mattermost - Deploy the mattermost service on a specific environeent (ENV parameter is required)"
	@echo "deploy-database - Deploy the postgres on a specific environeent (ENV parameter is required)"
	@echo "deploy-monitoring - Deploy the monitoring job on a specific environeent (ENV parameter is required)"
	@echo "deploy-backup - Deploy the backup job on a specific environeent (ENV parameter is required)"
	@echo "gen-kube-secret - Generate a base64 string for kubernetes secret (SECRET parameter is required)"
	@echo "secrets - Deploy secrets (ENV parameter is required)"
	@echo "get-pods - Get all pods from a specific environment (ENV parameter is required)"

setup:
	minikube addons enable heapster
	minikube addons enable kube-dns
	minikube addons enable dashboard
	kubectl create -f ./namespace-staging.yaml
	kubectl create -f ./namespace-production.yaml


deploy-mattermost:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) apply -f ./mattermost-service.yaml
	kubectl --namespace=$(ENV) apply -f ./mattermost-deployment.yaml
	kubectl --namespace=$(ENV) apply -f ./mattermost-autoscale.yaml
endif

deploy-database:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) apply -f ./postgresql-service.yaml
	kubectl --namespace=$(ENV) apply -f ./postgresql-deployment.yaml
endif

setup-db:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) cp db.sql  $(ENV)/$(shell kubectl --namespace=$(ENV) get pod -l "app=postgres" -o go-template='{{(index .items 0).metadata.name}}'):tmp/db.sql
	kubectl --namespace=$(ENV) exec -ti $(shell kubectl --namespace=$(ENV) get pod -l "app=postgres" -o go-template='{{(index .items 0).metadata.name}}') -- /usr/local/bin/psql -U postgres -f /tmp/db.sql
endif

deploy-monitoring:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) apply -f ./monitoring-job.yaml
endif

deploy-backup:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) apply -f ./backup-job.yaml
endif

secrets:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) apply -f ./secrets.yaml
endif

dashboard:
	minikube dashboard

gen-kube-secret:
ifndef SECRET
	$(error SECRET is not set)
else
	echo -n "$(SECRET)" | base64
endif

get-pods:
ifndef ENV
	$(error ENV is not set)
else
	kubectl --namespace=$(ENV) get pod
endif
