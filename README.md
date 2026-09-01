## About Custom Patches
This transmission has been modified to announce that there are zero downloads.

## Building
```
 docker build -f Dockerfile.builder . -t transmission:builder
 docker build . -t transmission:latest
```

## Sync With Upstream
Run the following whenever the upstream repository has new commits:
```
git remote add upstream https://github.com/transmission/transmission.git

# Update remote information
git fetch upstream

# Update main to exactly match upstream/main
git switch main
git reset --hard upstream/main
git push origin main --force-with-lease

# Rebase custom patches on top of the latest upstream
git switch patch/zero-download
git rebase main

# Push the updated patch branch 
git push origin patch/zero-download --force-with-lease
```
