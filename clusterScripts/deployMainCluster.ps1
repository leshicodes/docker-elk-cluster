$esPasswordFile = "elastic-passwords.txt"
$esDockerConfigFile = "elastic-docker-tls.yml"
$secondsToSleep = 15

cd $PSScriptRoot
cd ../main-cluster
docker-compose -f create-certs.yml run --rm create_certs
docker-compose -f $esDockerConfigFile up -d

echo "Sleeping for $secondsToSleep seconds to initialize cluster..."
Start-Sleep -s $secondsToSleep
cls
echo "Writing generated passwords to : $esPasswordFile"
docker exec es01 /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://es01:9200" >> $esPasswordFile

docker-compose -f $esDockerConfigFile stop


$confirmation = Read-Host "Please navigate to `"$esDockerConfigFile`" and edit the ELASTICSEARCH_PASSWORD variable under kib01 to the user/pass combination generated in `"$esPasswordFile`"; Press 'y' to continue AFTER this is completed"
if ($confirmation -eq 'y') {
    docker-compose -f $esDockerConfigFile up -d
    cd $PSScriptRoot
    cd ../
    exit 0
}
cd $PSScriptRoot
cd ../
exit 1

