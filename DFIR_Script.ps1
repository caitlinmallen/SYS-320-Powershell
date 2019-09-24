﻿Write-Host ("
 (       (      (      (        (                                     
 )\ )    )\ )   )\ )   )\ )     )\ )                               )  
(()/(   (()/(  (()/(  (()/(    (()/(         (     (            ( /(  
 /(_))   /(_))  /(_))  /(_))    /(_))   (    )(    )\   `  )    )\()) 
(_))_   (_))_| (_))   (_))     (_))     )\  (()\  ((_)  /(/(   (_))/  
 |   \  | |_   |_ _|  | _ \    / __|   ((_)  ((_)  (_) ((_)_\  | |_   
 | |) | | __|   | |   |   /    \__ \  / _|  | '_|  | | | '_ \) |  _|  
 |___/  |_|    |___|  |_|_\    |___/  \__|  |_|    |_| | .__/   \__|  
                                                       |_|            

                         Created by Caitlin M Allen



")

#Function for All Services
function Services-Collection{Write-Host ("Starting services collection.")

    Get-Process -IncludeUserName | Select-Object Id,Name,Username,Path | Sort-Object Username | Export-Csv -NoTypeInformation -Path "$($env:USERPROFILE)\Desktop\ServiceList.csv"

    Start-Sleep 1.5

    Write-Host ("Processes have been exported to your desktop as 'ServiceList.csv")
}



#Function for Live Services
function LiveServices-Collection{Write-Host ("Collecting live services..")

    Start-Sleep 1.5

    Get-Service | Where-Object {$_.Status -eq "Running"} | Export-Csv -NoTypeInformation -Path "$($env:USERPROFILE)\Desktop\LiveServicesList.csv"
    
    Start-Sleep 1.5

    Write-Host ("Processes have been exported to your desktop as 'LiveServicesList.csv'") 
}

#Function for collecting all users on the machine 

function All-Users {Write-Host ("Now collecting a list of all users on this machine...")

    Start-Sleep 1.5

    Get-WmiObject -Class Win32_UserAccount | Select Name, SID, AccountType, Domain | Export-Csv -NoTypeInformation -Path "$($env:USERPROFILE)\Desktop\UsersList.csv"

    Start-Sleep 1.5 

    Write-Host ("A list of all users including local and AD have been exported to the desktop as UsersList.csv")
}


#Function for collecting installed software

function Installed-Software {Write-Host ("Now collecting a list of all installed software...")

    Start-Sleep 1.5

    Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Export-Csv -NoTypeInformation -Path "$($env:USERPROFILE)\Desktop\InstalledSoftwareList.csv"

    Start-Sleep 1.5

    Write-Host ("A list of all installed software was exported to the dekstop as InstalledSoftwareList.csv")
}

#Function for collecting TCP Connections

function TCP {Write-Host ("Now creating a list of all TCP connections...")

Start-Sleep 1.5

Get-NetTCPConnection| Export-Csv -NoTypeInformation -Path "$($env:USERPROFILE)\Desktop\TCPList.csv"

Start-Sleep 1.5

Write-Host ("A list of TCP connections has been exported to the desktop as TCPList.csv")
}

#Exit function

function exit {Write-Host ("Thanks for using this incident response script!") 

}


$continue = $true 

DO{

    $Choice = Read-Host "What would you like to do?
    
    [1] - List all services on this computer
    [2] - List all live services on this computer
    [3] - List all users on this computer
    [4] - List all installed software on this computer
    [5] - List all TCP connections being made to this computer
    [6] - Exit this program" 


    switch ($Choice){
        "1" {Services-Collection; break}
        "2" {LiveServices-Collection; break}
        "3" {All-Users; break}
        "4" {Installed-Software; break}
        "5" {TCP; break}
        "6" {$continue = $false; break}
        default {echo "Please select a valid choice."; break}

       }
  
} while ($continue)
 

