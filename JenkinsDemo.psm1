function Restart-ComputerService
{
    param 
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Password,
        [Parameter(Mandatory = $true)]
        [String]
        $Username,
        [Parameter(Mandatory = $true)]
        [String]
        $Computer
    )

    # Ensure the build fails if there is a problem.
    # The build will fail if there are any errors on the remote machine too.
    $ErrorActionPreference = 'Stop'

    # Create a PSCredential Object using the "User" and "Password" parameters that you passed to the job
    $securePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $securePassword

    # Invoke a command on the remote machine.
    # It depends on the type of job you are executing on the remote machine as to if you want to use "-ErrorAction Stop" on your Invoke-Command.
    Invoke-Command -ComputerName $Computer -Credential $cred -ScriptBlock {
        Restart-Service -Name W32Time
        New-Item -Type File C:\temp\jenkinstest.txt -Force
    }
}