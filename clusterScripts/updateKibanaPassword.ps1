

$passwordFile = "..\main-cluster\elastic-passwords.txt"
$elasticDockerFile = "elastic-docker-tls.yml"

Write-Host "Finding Kibana Password in $elasticDockerFile"

$kibPasswordLine = Select-String -Raw -Path $passwordFile -Pattern 'PASSWORD kibana_system'
$kibPassword = $kibPasswordLine.Split('=')
$kibPassword = $kibPassword[1]
$kibPassword = $kibPassword.Substring(1)

Write-Host "Parsing YAML and Injecting Kibana password into YAML File"

$yaml = Get-Content ..\main-cluster\$elasticDockerFile -Raw
$PSYaml = ConvertFrom-Yaml -Yaml $yaml
$PSYaml.services.kib01.environment.ELASTICSEARCH_PASSWORD = "$kibPassword"
ConvertTo-Yaml $PSYaml -OutFile $PSScriptRoot\$elasticDockerFile
mv ..\main-cluster\$elasticDockerFile "..\main-cluster\$elasticDockerFile.bak"
mv $PSScriptRoot\$elasticDockerFile ..\main-cluster\$elasticDockerFile