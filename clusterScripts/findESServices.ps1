$elasticDockerFile = "elastic-docker-tls.yml"

Write-Host "Parsing YAML and Injecting Kibana password into YAML File"

$yaml = Get-Content ..\main-cluster\$elasticDockerFile -Raw
$PSYaml = ConvertFrom-Yaml -Yaml $yaml

foreach ($service in $PSYaml.services.keys)
{
    Write-Host ($service)
}
