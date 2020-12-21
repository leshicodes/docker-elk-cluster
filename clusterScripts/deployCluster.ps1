$esPasswordFile = "elastic-passwords.txt"
$esDockerConfigFile = "elastic-docker-tls.yml"
$secondsToSleep = 15

cd ../
docker-compose -f create-certs.yml run --rm create_certs
docker-compose -f $esDockerConfigFile up -d

echo "sleeping for $secondsToSleep seconds..."
Start-Sleep -s $secondsToSleep
echo "Writing generated passwords to : $esPasswordFile"
docker exec es01 /bin/bash -c "bin/elasticsearch-setup-passwords auto --batch --url https://es01:9200" >> $esPasswordFile

docker-compose -f $esDockerConfigFile stop


$confirmation = Read-Host "Please navigate to `"$esDockerConfigFile`" and edit the ELASTICSEARCH_PASSWORD variable under kib01 to the user/pass combination generated in `"$esPasswordFile`"; Press 'y' to continue AFTER this is completed"
if ($confirmation -eq 'y') {
    docker-compose -f $esDockerConfigFile up -d
    exit 0
}
exit 1

