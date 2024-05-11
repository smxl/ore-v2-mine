param (
    [int]$timesToRun = 1
)

$scriptPath = "${PWD}\wsl-mine.ps1"

for ($i = 0; $i -lt $timesToRun; $i++) {
    Start-Process PowerShell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "$scriptPath"
}
