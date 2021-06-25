# crossplane-git-poc
Proof of concept to use crossplane for member managment in github/gitlab. Made possible by VSHNHackday

In order for the crossplane operator to work correctly the crossplane serviceAccount needs cluster-admin permissions.

Add this to the `cluster-admin` clusterrolebinding:
```yaml
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: system:masters
- kind: ServiceAccount
  name: crossplane
  namespace: crossplane-system
```

## Installation

Please read `GITHUB.md` and `GITLAB.md` for instructions how to build the images.

Once that's done you'll have to adjust `git*/crossplane/provider.yaml` with the right images.

You'll also have to create tokens for Github and Gitlab. The Github token needs org management permissions and the Gitlab one needs API permissions.

`gituser/gituser.yaml` is an example to create a github and gitlab user all in one step. You'll have to adjust the details prior to the apply.

Then:
```bash
kubectl apply -f gitlab/crossplane/
kubectl apply -f github/crossplane/
kubectl apply -f compositeresourcedefinition/
kubectl apply -f gituser/
```
