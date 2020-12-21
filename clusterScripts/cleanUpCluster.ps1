$confirmation = Read-Host "This will remove ALL Docker containers and volumes from your system; Press 'y' to continue"
if ($confirmation -eq 'y') {
    echo "Removing ALL docker containers..."
    docker rm $(docker ps -aq) --force
    echo "Removing ALL docker volumes..."
    docker volume rm $(docker volume ls -q)
}
else
{
    echo "Response not in parameters, exiting"
    exit 1
}