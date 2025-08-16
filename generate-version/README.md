# generate-version

This build step image prepares the environment to generate a version for a NodeJS project.

## Configuration

After building the image, you need to configure the build step to use it.

The build step uses the `GITHUB_TOKEN` secret to authenticate with GitHub fine-grained token with the following scopes:

- `Metadata: Read-only`
- `Pull requests: Read and write`

Here is an example of how to configure the build step:

```yaml
steps:
  - name: gcr.io/$PROJECT_ID/generate-version
    id: generate-version
    entrypoint: bash
    secretEnv: ['GITHUB_TOKEN']
    args:
      - -lc
      - |
        echo "$$GITHUB_TOKEN" | gh auth login --hostname github.com --with-token
        git config --global user.name "$_GITHUB_USER_NAME"
        git config --global user.email "$_GITHUB_USER_EMAIL"
        # your step code here

availableSecrets:
  secretManager:
  - versionName: projects/$PROJECT_ID/secrets/GITHUB_TOKEN/versions/latest
    env: GITHUB_TOKEN

substitutions:
  _GITHUB_USER_NAME: cloud-build # replace with your GitHub username
  _GITHUB_USER_EMAIL: cloud-build@$PROJECT_ID.iam.gserviceaccount.com # replace with your GitHub user email
```
