# docker-elk-cluster

## Prerequisites & Project Requirements
- Powershell Version >= [7.0](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1) (**Note:** The Default Version of Powershell is 5.1 in Windows 10. You will need to upgrade manually.)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Powershell-yaml](https://github.com/cloudbase/powershell-yaml)
  
## Running the Elastic Cluster
    cd clusterScripts
    
    #For the first run only!
    .\configureDockerVM.ps1

    #Every other deploy.
    .\deployMainCluster.ps1
Next, go to your preferred internet browser and navigate to [https://localhost:5601](https://localhost:5601)



## Cleaning Up our Elastic Cluster
    cd clusterScripts
    .\cleanUpCluster.ps1