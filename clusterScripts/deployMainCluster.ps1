$esPasswordFile = "elastic-passwords.txt"
$esDockerConfigFile = "elastic-docker-tls.yml"
$secondsToSleep = 45

cd $PSScriptRoot
cd ../main-cluster
docker-compose -f create-certs.yml run --rm create_certs
docker-compose -f $esDockerConfigFile up -d

cls
. $PSScriptRoot\generateKibanaEncryptionKey.ps1

echo "Sleeping for $secondsToSleep seconds to initialize cluster..."
Start-Sleep -s $secondsToSleep
cls
echo "Writing generated passwords to : $esPasswordFile"
docker exec es01 /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://es01:9200" >> $esPasswordFile

docker-compose -f $esDockerConfigFile stop

cls
. $PSScriptRoot\updateKibanaPassword.ps1
docker-compose -f $esDockerConfigFile up -d

cd $PSScriptRoot
cd ../
exit 1

