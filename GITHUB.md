# Github

Here are the findings for the github crossplane provider.

provider page: https://github.com/crossplane-contrib/provider-github

provider docs: N/A

## Issues

* No recent image on docker hub. ( crossplane/provider-github out of date and does not work)
Can build and execute from source 


## Run

### Run Locally

``` bash
make # prepare Makefile (Might need to update build/makelib/golang.mk
go generate linux_amd64 # create crd
kubeclt apply -f packages/crds
go build cmd/provider
./provider --debug
```


### Build Provider


``` bash
# Clone repo
...

make # prepare Makefile (This will most likely fail)

# Update makefile dependencies (o/w build will most likely fail)
cd build
git checkout master
cd ..

# Update spec.controller.image in packages/crossplane.yml to something you can push to e.g. <you>/provider-github-controller
...

make # This might take a while

# Retag resulting docker images to something you can push
docker images # find new images
docker tag build-<hash>/provider-github-amd64 <you>/provider-github
docker push <you>/provider-github
docker tag build-<hash>/provider-github-contoller-amd64 <you>/provider-github-controller
docker push <you>/provider-github-controller

```

### Deploy from Image

To deploy in-cluster from a previously built image, apply the following

```yaml
---
apiVersion: pkg.crossplane.io/v1beta1
kind: Provider
metadata:
  name: provider-github
  namespace: crossplane-system
spec:
  package: "<you>/provider-github:latest"
```

There is a provider resource with a pre-built image in `github/crossplane/provider.yml`

## Configure

To configure the provide you first need to get your own api token for `github.com`.
Then you apply the following with your token:

```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: gh-creds
  namespace: crossplane-system
type: Opaque
stringData:
  token: <token>

---
apiVersion: github.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
  namespace: crossplane-system
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane-system
      name: gh-creds
      key: token
```



### Add User to Org

To add a user to a github organisation you need to apply the following:

```yaml
---
apiVersion: organizations.github.crossplane.io/v1alpha1
kind: Membership
metadata:
  name: first
  namespace: crossplane-system
spec:
  forProvider:
    user: <username>
    email: <email>
    organization: <organisation-name>
    role: <admin | direct_member>
  providerConfigRef:
    name: default
  # a reference to a Kubernetes secret to which the controller will write the runnersToken
  writeConnectionSecretToRef:
    name: github-member-first
    namespace: crossplane-system
```


