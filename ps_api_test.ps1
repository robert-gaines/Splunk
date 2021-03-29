# Conversion of http://docs.splunk.com/Documentation/Splunk/latest/RESTAPI/RESTsearch#search.2Fjobs.2Fexport 
# example using curl, to PowerShell with Invoke-RestMethod cmdlet
#
# $ curl -k -u admin:changeme https://localhost:8089/services/search/jobs/export 
#        --data-urlencode search="search index=_internal | stats count by sourcetype" 
#        -d output_mode=json -d earliest="rt-5m" -d latest="rt"

$cred = Get-Credential

# This will allow for self-signed SSL certs to work
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

$server = ''

$url = "https://${server}:8000/services/search/jobs/export" # braces needed b/c the colon is otherwise a scope operator

$search = "search index=_internal | stats count by sourcetype" # Cmdlet handles urlencoding

$body = @{
    search = $search
    output_mode = "json"
    earliest_time = "rt-5m"
    latest_time = "rt"
}

Invoke-RestMethod -Method Post -Uri $url -Credential $cred -Body $body

