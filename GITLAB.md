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
