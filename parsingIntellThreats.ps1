#This is kind of a working mess, apologies in advanced for whoever reads this code


# Array of websites containing threat intell
$drop_urls = @('https://rules.emergingthreats.net/blockrules/emerging-botcc.rules','https://rules.emergingthreats.net/blockrules/compromised-ips.txt')

# Loop through the URLs for the rules list
foreach ($u in $drop_urls) {

    # Extract the filename
    $temp = $u.split("/")

   # The last element in the array plucked off is the filename
    $file_name = "./" + $temp[4]

    # Temp to prevent routinely downloading the files 
    if (Test-Path -Path $file_name) {

        continue 


    } else {


    

   # Download the rules list
   Invoke-WebRequest -Uri $u -OutFile $file_name

            } #end check if file exists

} #End foreach loop

# Array containing the filename
$input_paths = @('.\emerging-botcc.rules' , '.\compromised-ips.txt')
# Extract the IP addresses.
$regex_drop = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\b'
# Append the IP addresses to the temporary IP list.
select-string -Path $input_paths -Pattern $regex_drop | `
ForEach-Object {$_.Matches }  | `
#Extract the values and then sort to get unique values
ForEach-Object {$_.Value } | sort | Get-Unique | `
#Write results to a file
Set-Content -Path "ips-bad.txt"

# Get the IP addresses discovered, loop through and replace the beginning of the line with the IPTables syntax
# After the IP address, add the remaining IPTables syntax and save the results to a file.
#IPtables: iptables -A input -s 104.131.182.103 -j DROP
(Get-Content -Path ".\ips-bad.txt") | `
% {$_ -replace "^" ,"iptables -A INPUT -s " -replace "$", " - DROP"}



#TASK: Create a prompt and ask the user if they want to save the file for IPTables
#or as a Cisco ACL, then create the appropriate syntax

#cisco example:

#access-list 1 deny host 103.133.104.71


# Get the IP addresses discovered, loop through and replace the beginning of the line with the IPTables syntax
# After the IP address, add the remaining IPTables syntax and save the results to a file.
#IPtables: iptables -A input -s 104.131.182.103 -j DROP
(Get-Content -Path ".\ips-bad.txt") | `

Set-Content -Path "toLinuxFirewall.bash"
# Extract the IP addresses.
$regex_drop = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\b'
# Append the IP addresses to the temporary IP list.
select-string -Path $input_paths -Pattern $regex_drop | `
ForEach-Object {$_.Matches }  | `

Set-Content -Path "Cisco-ACL.txt"
% {$_ -replace "^" ,"access-list 1 deny host" -replace "$"}
