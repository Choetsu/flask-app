# Projet DevOps sur Azure avec Terraform et Kubernetes

Mise en place d'une application Flask avec une base de données Redis dans un cluster Kubernetes (AKS) sur Azure, en utilisant Terraform pour le déploiement de l'infrastructure et Helm pour la configuration de l'Ingress Controller.

## Prérequis

- Compte Azure
- Azure CLI
- kubectl
- Terraform
- Helm

## Installation et Configuration

### Clonez le Répertoire du Projet :

```
git clone git@github.com:Choetsu/flask-app.git
cd flask-app
```

### Configuration Azure CLI :

Connectez-vous à votre compte Azure :

``` 
az login 
```

### Initialisation de Terraform :
Accédez au répertoire contenant vos fichiers Terraform et initialisez Terraform :

```
cd terraform
terraform init
```

### Déploiement avec Terraform :

```
terraform plan
```

Vérifiez que la configuration Terraform est correcte.

Appliquez la configuration Terraform :

```
terraform apply
```

Confirmez l'opération en saisissant yes lorsque vous y êtes invité.

## Création de l'Image Docker et Publication sur le Registre Azure

### Connexion au Registre Azure :

```
cd ../flask-app
az acr login --name acrrgesgiamallahchemlal.azurecr.io
```

### Création de l'image Docker :

```
docker build -t myapp .
```

### Publiez l'image Docker sur le registre Azure :

```
docker tag myapp acrrgesgiamallahchemlal.azurecr.io/samples/myapp
docker push acrrgesgiamallahchemlal.azurecr.io/samples/myapp
```

### Vérification de la Publication de l'Image Docker :

Accédez au registre Azure et vérifiez que l'image a été publiée.

```
az acr repository list --name  acrrgesgiamallahchemlal --output table
```

## Configuration Kubernetes

### Récupérez les Informations du Cluster AKS :

Utilisez Azure CLI pour configurer kubectl pour votre cluster AKS :

```
az aks get-credentials --overwrite-existing -n aksrg-ESGI-amallah-chemlal -g rg-ESGI-amallah-chemlal
```

### Vérification du contexte Kubernetes

```
kubectl config current-context
```

## Installation de l'Ingress Controller avec Helm :

Installez l'Ingress Controller (par exemple, NGINX) dans votre cluster :

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
```

## Déployez l'Application et les Services :
Revenez au répertoire racine et appliquez les configurations Kubernetes :

```
cd ..
kubectl apply -f kubernetes/
```

## Test de l'Application
Pour tester l'application, utilisez curl ou un navigateur pour accéder à l'adresse IP publique du cluster AKS:

### Récupérez l'adresse IP publique du cluster AKS :

```
kubectl get service nginx-ingress-ingress-nginx-controller
ou
kubectl get svc nginx-ingress-ingress-nginx-controller -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

### Testez l'application :

```
curl <adresse-ip-publique>
```

Vous devriez voir un message confirmant que l'application Flask est accessible.

## Nettoyage des Ressources
Nettoyer les ressources une fois que vous avez terminé :

### Supprimez les Ressources Kubernetes :

```
kubectl delete -f kubernetes/
```

### Supprimez l'Ingress Controller :

```
helm uninstall nginx-ingress
```

### Détruisez l'Infrastructure Terraform :

```
cd terraform
terraform destroy
```

Confirmez l'opération en saisissant yes lorsque vous y êtes invité.
