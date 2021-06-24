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
