$confirmation = Read-Host "This will remove ALL of the Docker containers and volumes created from this project from your system; Press 'y' to continue"
$esPasswordFile = "elastic-passwords.txt"
$elasticDockerFile = "elastic-docker-tls.yml"
$elasticKibanaFile = "kibana.yml"

$esDockerContainers= @("es01", "es02", "es03", "kib01")
$esDockerVolumes = @("es_certs", "es_data01", "es_data02", "es_data03")

if ($confirmation -eq 'y') {
    echo "Removing docker containers..."
    #docker rm $(docker ps -aq) --force  #not very nice to other docker containers :/

    foreach ($container in $esDockerContainers)
    {
        Write-Host "Removing Container: $container"
        docker rm $container --force
    }

    echo "Removing ALL docker volumes..."
    #docker volume rm $(docker volume ls -q) # again, not very nice. :/

    foreach ($volume in $esDockerVolumes)
    {
        Write-Host "Removing Volume: $volume"
        docker volume rm $volume --force
    }

    if(Test-Path $PSScriptRoot\..\main-cluster\$esPasswordFile)
    {
        echo "Removing elastic password file..."
        rm $PSScriptRoot\..\main-cluster\$esPasswordFile
    }
    if(Test-Path "$PSScriptRoot\..\main-cluster\$elasticDockerFile.bak")
    {
        echo "Replacing elastic docker file..."
        rm "$PSScriptRoot\..\main-cluster\$elasticDockerFile"
        Move-Item "$PSScriptRoot\..\main-cluster\$elasticDockerFile.bak" "$PSScriptRoot\..\main-cluster\$elasticDockerFile"
    }
    if(Test-Path "..\main-cluster\configuration\kibana\$elasticKibanaFile.bak")
    {
        echo "Replacing Kibana config file..."
        rm "..\main-cluster\configuration\kibana\$elasticKibanaFile"
        Move-Item "..\main-cluster\configuration\kibana\$elasticKibanaFile.bak" "..\main-cluster\configuration\kibana\$elasticKibanaFile"
    }
}
else
{
    echo "Response not in parameters, exiting"
    exit 1
}