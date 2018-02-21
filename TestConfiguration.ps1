configuration TestFile
{
    param 
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Computer
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    node ($Computer)
    {
        File TestFile
        {
            Ensure          = 'Present'
            Contents        = 'Test file'
            DestinationPath = 'C:\temp\jenkinstest.txt'
            Type            = 'File'
        }    
    }
}

