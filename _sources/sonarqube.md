# Class 10: Sonar Qube 

```{note}
You can use GitHub CodeSpaces as a virtual machine.
```

## Server

Run the following code in shell to set up a SonarQube server on port 9000
```bash
docker run \
    -d \
    --name sonarqube \
    -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
    -p 9000:9000 \
    sonarqube:latest
```
Access the admin panel of the server from the forwarded address. In VS Code/Code Spaces, the forwarded address can be checked under the tab "Ports" and looks like this:
```
https://maciejskorski-stunning-space-orbit-p7xwrv9q455376q4-9000.preview.app.github.dev/
```
Configure your project as shown below:
![SonarQube Configuration](figures/sonarqube.png)

## Client

Run the scanner from its Docker image, mounting your source code directory:
```bash
docker run \
    --rm \
    --network=host \
    -e SONAR_HOST_URL="http://localhost:9000" \
    -e SONAR_LOGIN="admin" \
    -e SONAR_PASSWORD="abcd1234" \
    -v "/home/maciej.skorski/duplicate-detection:/usr/src" \
    sonarsource/sonar-scanner-cli -Dsonar.projectKey="test-project"
```

## Inspect Results
Once the client tests are done, you can inspect the dashboard on the server
![SonarQube Dashboard](figures/sonarqube_dashboard.png)

## Read more

* [SonarQube Documentation](https://docs.sonarqube.org/latest/)