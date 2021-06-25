# Gitlab

Here are the findings for the gitlab crossplane provider.

provider page: https://github.com/crossplane-contrib/provider-gitlab

provider docs: N/A (except four examples)

## Issues

there are currently no images available on docker hub.
there seem to be hardcoded references to other non-existing docker images

can be run with make dev though, works pretty well

``` bash
make generate # create CRDs on cluster
make dev # run operator
```

## How to build and push images

Build the images:

```bash
git clone https://github.com/crossplane-contrib/provider-gitlab
cd provider-gitlab
make
```

You'll have to edit `package/crossplane.yaml` so that `spec.controller.image` points to your registry.

Example:

```yaml
apiVersion: meta.pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-gitlab
spec:
  controller:
    image: kidswiss/provider-gitlab-controller:latest
```

Then get the names of the newly built images and re-tag them:
```bash
docker images
docker docker tag build-ba3d69b1/provider-gitlab-amd64 kidswiss/provider-gitlab
docker tag build-ba3d69b1/provider-gitlab-controller-amd64 kidswiss/provider-gitla-controller
# and then push them
```
