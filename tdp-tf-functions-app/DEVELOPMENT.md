# Documentation

## README.md

The documentation is generated using `terraform-docs`:

```shell
terraform-docs .
```

## CHANGELOG.md

Also add any changes, additions and removals to the _CHANGELOG.md_. Check the file for the correct formatting.

## Code formatting and linting

Using Terraform itself, reformat the code:

```shell
terraform fmt --recursive
```

## Releasing

Create a git tag and push it to the remote repository. For instance:

```shell
git tag vX.Y.Z -m "<MESSAGE>"
git push origin vX.Y.Z
```
