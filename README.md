# Voting App — ArgoCD + Helm on AKS

This is the third iteration of my voting app deployment series, combining ArgoCD (GitOps) with Helm charts for the deployment on AKS.

## Previous Projects
- [ArgoCD + plain manifests](https://github.com/Chetna-DevOps/voting-app-aks-argocd)
- [Helm + Azure DevOps CD](https://github.com/Chetna-DevOps/voting-app-aks-helm)

## How It Works

Azure DevOps pipeline builds the image and pushes to ACR, then updates the image tag in `values.yaml` and commits it back to the repo. ArgoCD detects the change and automatically runs `helm upgrade` on the cluster.

```
Code push → Azure DevOps (build + update values.yaml) → ArgoCD → AKS
```

## Tech Stack

- **Vote frontend** — Python (Flask) — lets users vote between two options
- **Result frontend** — Node.js — shows live voting results
- **Worker** — C# (.NET) — consumes votes from Redis and stores in PostgreSQL
- **Redis** — Bitnami Helm chart
- **Database** — PostgreSQL (Bitnami Helm chart)
- **Registry** — Azure Container Registry (ACR)
- **Ingress** — NGINX on AKS
- **CD** — ArgoCD + Helm

## Project Structure

```
├── vote/
│   ├── charts/          # Helm chart
│   ├── app.py
│   └── Dockerfile
├── result/
│   ├── charts/          # Helm chart
│   └── ...
├── worker/
│   ├── charts/          # Helm chart (no ingress)
│   └── ...
├── scripts/
│   └── updateK8sManifests.sh
└── .azure-pipelines/
    └── argocd-helm-deploy/
        ├── argocd-helm-vote.yml
        ├── argocd-helm-result.yml
        └── argocd-helm-worker.yml
```

## Setup

- Create variable group `ci-cd-variables` in Azure DevOps Library with: `containerregistryserviceconnection`, `acr_login_server`, `aksClusterName`, `resourceGroup`, `pat_token`, `azure_devops_org_url`, `azure_repo_name_gitops`, `git_email`, `git_name`
- Create ACR pull secret in the cluster: `kubectl create secret docker-registry acr-secret ...  -n staging`
- Deploy Redis and PostgreSQL via ArgoCD using Bitnami charts
- Point ArgoCD apps to `vote/charts`, `result/charts`, `worker/charts` with auto-sync enabled

## App URLs

```
http://vote-argo-helm.<CLUSTER-IP>.nip.io
http://result-argo-helm.<CLUSTER-IP>.nip.io
```

## Credits

Base application from [dockersamples/example-voting-app](https://github.com/dockersamples/example-voting-app).

## What I Did

- Created Helm charts for all three custom services
- Used Bitnami charts for Redis and PostgreSQL via ArgoCD
- Built Azure DevOps pipelines that update `values.yaml` instead of deployment manifests
- Configured ArgoCD to deploy Helm charts with auto-sync and self-heal
- Deployed everything in `staging` namespace alongside two other versions of the same app on the same cluster
