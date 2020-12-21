$confirmation = Read-Host "This will remove ALL Docker containers and volumes from your system; Press 'y' to continue"
$esPasswordFile = "elastic-passwords.txt"
if ($confirmation -eq 'y') {
    echo "Removing ALL docker containers..."
    docker rm $(docker ps -aq) --force
    echo "Removing ALL docker volumes..."
    docker volume rm $(docker volume ls -q)
    if(Test-Path $PSScriptRoot\..\main-cluster\$esPasswordFile)
    {
        echo "Removing elastic password file..."
        rm $PSScriptRoot\..\main-cluster\$esPasswordFile
    }
}
else
{
    echo "Response not in parameters, exiting"
    exit 1
}