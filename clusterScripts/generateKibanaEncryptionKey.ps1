$elasticKibanaFile = "kibana.yml"

Function Get-KibanaEncryptionKey {
	
	[CmdletBinding()]
	Param (
        [int] $length = 8
	)

	Begin{
	}

	Process{
        Write-Output ( -join ((0x30..0x39) + (0x30..0x39) + (0x30..0x39) + (0x30..0x39) | Get-Random -Count $length  | % {[char]$_}) )
	}	
}


$KibanaEncryptionKey = $(Get-KibanaEncryptionKey -length 32)
Write-Host "Generated Kibana Encryption Key: $KibanaEncryptionKey"

Write-Host "Parsing generated Encryption key to kibana configuration file...."
Write-Host "Old file being backed up to $elasticKibanaFile.bak"
$yaml = Get-Content "..\main-cluster\configuration\kibana\$elasticKibanaFile" -Raw
$PSYaml = ConvertFrom-Yaml -Yaml $yaml
$PSYaml.'xpack.encryptedSavedObjects.encryptionKey' = $KibanaEncryptionKey
ConvertTo-Yaml $PSYaml -OutFile $PSScriptRoot\$elasticKibanaFile
Move-Item "..\main-cluster\configuration\kibana\$elasticKibanaFile" "..\main-cluster\configuration\kibana\$elasticKibanaFile.bak" -Force
Move-Item $PSScriptRoot\$elasticKibanaFile "..\main-cluster\configuration\kibana\$elasticKibanaFile"