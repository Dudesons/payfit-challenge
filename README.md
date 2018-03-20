# Payfit DevOps

Requirements:
 * minikube
 * base64
 * make

```bash
$> make
setup - Enable plugins and create namespace
setup-db - Apply the db.sql on the postgres database
dashboard - start the kubernetes dashboard
deploy-mattermost - Deploy the mattermost service on a specific environeent (ENV parameter is required)
deploy-database - Deploy the postgres on a specific environeent (ENV parameter is required)
deploy-monitoring - Deploy the monitoring job on a specific environeent (ENV parameter is required)
deploy-backup - Deploy the backup job on a specific environeent (ENV parameter is required)
gen-kube-secret - Generate a base64 string for kubernetes secret (SECRET parameter is required)
secrets - Deploy secrets (ENV parameter is required)
get-pods - Get all pods from a specific environment (ENV parameter is required)
clean - Clean an environment (ENV parameter is required)
```

In the follwing document variables:
 * ENV: Represent the Kubernetes namespace

## Setup

```bash
# This command will:
#  - enable addons
#  - create staging and production namespaces
make setup

## Deploy secrets on a specific environment
make secrets ENV=<KUBERNETES_NAMEPACE>
```

## Deploy DB

```bash
make deploy-database ENV=<KUBERNETES_NAMEPACE>
```

When the database is ready
```bash
make setup-db ENV=<KUBERNETES_NAMEPACE>
```

## Deploy mattermost application

```bash
make deploy-mattermost ENV=<KUBERNETES_NAMEPACE>
```

## Deploy jobs

```bash
make deploy-monitoring ENV=<KUBERNETES_NAMEPACE>
make deploy-backup ENV=<KUBERNETES_NAMEPACE>
```

## Utils

Start dashboard
```bash
make dashboard
```

List all pods in a en environment
```bash
make get-pods ENV=<KUBERNETES_NAMEPACE>
```

Gen a password for Kubernetes secret system
```bash
make gen-kube-secret SECRET=<PLAIN_TEXT_SECRET>
```

Get the mattermost endpoint
```bash
make get-endpoint ENV=<KUBERNETES_NAMEPACE>
```

Clean an environment
```bash
make clean ENV=<KUBERNETES_NAMEPACE>
```
