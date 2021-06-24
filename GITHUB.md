# Github

Here are the findings for the github crossplane provider.

provider page: https://github.com/crossplane-contrib/provider-github

provider docs: N/A

## Issues

* No recent image on docker hub. ( crossplane/provider-github out of date and does not work)
Can build and execute from source 


## Run

``` bash
make # prepare Makefile (Might need to update build/makelib/golang.mk
go generate linux_amd64 # create crd
kubeclt apply -f packages/crds
go build cmd/provider
./provider --debug
```
