# Ensure the build fails if there is a problem.
# The build will fail if there are any errors on the remote machine too.
$ErrorActionPreference = 'Stop'

# Create a PSCredential Object using the "User" and "Password" parameters that you passed to the job
$SecurePassword = $env:Password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $env:User, $SecurePassword

# Invoke a command on the remote machine.
# It depends on the type of job you are executing on the remote machine as to if you want to use "-ErrorAction Stop" on your Invoke-Command.
Invoke-Command -ComputerName $env:Computer -Credential $cred -ScriptBlock {
    # Restart the W32Time service
    Restart-Service -Name W32Time
}