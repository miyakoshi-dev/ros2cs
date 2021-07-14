$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$pluginDir=$args[0]

function Print-Help {
"
Usage: 
deploy_unity_plugins.ps1 [PLUGINS_DIR]

PLUGINS_DIR - Assets/Plugins/ directory of Unity project.
"

}

if (([string]::IsNullOrEmpty($pluginDir)))
{
    Print-Help
    exit
}

if (Test-Path -Path $pluginDir) {
    (Copy-Item -verbose -Path $scriptPath\install\lib\dotnet\* -Destination ${pluginDir} 4>&1).Message
    Write-Host "Plugins copied to: '$pluginDir'" -ForegroundColor Green
    if(-not (Test-Path -Path $pluginDir\Windows\x86_64\)) {
        mkdir ${pluginDir}\Windows\x86_64\
    }
    (Copy-Item -verbose -Path $scriptPath\install\bin\*.dll -Destination ${pluginDir}\Windows\x86_64\ 4>&1).Message
    (Copy-Item -verbose -Path $scriptPath\install\standalone\*.dll -Destination ${pluginDir}\Windows\x86_64\ 4>&1).Message
    Write-Host "Libraries copied to '${pluginDir}\Windows\x86_64\'" -ForegroundColor Green
} else {
    Write-Host "Plugins directory: '$pluginDir' doesn't exist." -ForegroundColor Red
}
