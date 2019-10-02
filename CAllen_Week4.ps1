#Caitlin Allen 
#Week 4 Assignment 1
#SYS-320 

#Imports CSV



#Search the CSV by Entry Name function

function Entry-Name{
    $Name = Read-Host ("What is the name of the CVE Entry you would like to search?")
    $CSV = Get-Content "$($env:USERPROFILE)\Downloads\cve-test.csv" | Select -skip 2 | ConvertFrom-Csv

    $SearchResult = $CSV | where {$_.Name -ilike "*$Name*"}

    foreach($Column in $SearchResult) {
        Write-Host 'Name:' $Column.Name `n,'Status:' $Column.Status `n,'Description' $Column.Description

    }
}

#Search  the CSV by description function

function Keyword-Description{
    $Keyword = Read-Host ("What is the name of the CVE Entry you would like to search?")
    $CSV = Get-Content "$($env:USERPROFILE)\Downloads\cve-test.csv" | Select -skip 2 | ConvertFrom-Csv

    $SearchResult = $CSV | where {$_.Description -ilike "*$Keyword*"}

    foreach($Column in $SearchResult) {
        Write-Host 'Name:' $Column.Name `n,'Status:' $Column.Status `n,'Description' $Column.Description

        }
}


#Search the CSV by status function


function Status{
    $Stat = Read-Host ("Search the CSV by CVE status")
    $CSV = Get-Content "$($env:USERPROFILE)\Downloads\cve-test.csv" | Select -skip 2 | ConvertFrom-Csv

    $SearchResult = $CSV | where {$_.Status -ilike "*$Stat*"}

    foreach($Column in $SearchResult) {
        Write-Host 'Name:' $Column.Name `n,'Status:' $Column.Status `n,'Description' $Column.Description
    }



}

#Exit function

function exit {Write-Host ("Thanks for using this script.") 

}

#Switch function for menu 

$continue = $true 

DO{

    $Choice = Read-Host "What would you like to do with this CSV?
    
    [1] - Search for a CVE Entry Name
    [2] - Search for a keyword in the description
    [3] - Search by status
    [4] - Exit this program"


    switch ($Choice){
        "1" {Entry-Name; break}
        "2" {Keyword-Description; break}
        "3" {Status; break}
        "4" {$continue = $false; break}
        default {echo "Select a valid choice from the menu." ; break}

        }
  
} while ($continue)
 