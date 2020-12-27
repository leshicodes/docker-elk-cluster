# docker-elk-cluster

## Prerequisites & Project Requirements
- Powershell Version >= [7.0](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1)
- [Docker](https://www.docker.com/)
- Docker Compose
- [Powershell-yaml](https://github.com/cloudbase/powershell-yaml)
  
## Running the Elastic Cluster
    cd clusterScripts
    .\deployMainCluster.ps1

Wait about 5 minutes and navigate to [https://localhost:5601](https://localhost:5601). You can check the status of the Kibana container by running the following command
    
    docker logs -f kib01

When you are at the login screen you can login with the "elastic" user's username and password combonation, which is logged to "elastic-passwords.txt" in the **main-cluster** folder

## Cleaning Up our Elastic Cluster
    cd clusterScripts
    .\cleanUpCluster.ps1