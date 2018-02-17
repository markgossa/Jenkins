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

$securePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $securePassword


Describe "Restart-ComputerService" {
    It "Creates test file" {
        Invoke-Command -ComputerName $Computer -Credential $cred -ScriptBlock {
            if(Get-Item C:\temp\jenkinstest.txt)
            {
                return $true
            }
            else 
            {
                return $false
            }
        } | Should Be $true
    }
}