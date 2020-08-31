
function ImportData()
{
    $sourceFile = 'FAIS009AUGRWG.csv'

    $event_records = Get-Content -Path $sourceFile 

    $raw_headers = $event_records[0].split(',')

    $parsed_headers = @()

    $raw_headers | Foreach-Object {
                                     $entry = $_
                                     
                                     if($entry -notin $parsed_headers)
                                     {
                                        $parsed_headers += $entry
                                     }
                                     elseif($parsed_headers -contains $entry)
                                     {
                                        $entry = $entry+'_ALT'
                                        $parsed_headers += $entry
                                     }
                                     else 
                                     {
                                        continue    
                                     }
                                  }

    $event_records = Import-CSV -Path $sourceFile -Header $parsed_headers

    #$parsed_headers | Foreach-Object { Write-Host $_  }
             
    $event_records | Foreach-Object {
                                        try {
                                                $user_name   = $_.TargetUserName
                                                $hostname    = $_.Computer
                                                $event_code  = $_.EventCode
                                                $system_time = $_.SystemTime
                                                $date        = $system_time.split('T')[0]
                                                $date        = $date.TrimStart("'")
                                                $time        = $system_time.split('T')[1]
                                                $segments    = $time.split(':')
                                                $zulu        = $segments[0]+':'+$segments[1]+":"+$segments[2].substring(0,2)
                                                $date_time   = $date+' '+$zulu
                                                $gmt         = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -match  'GMT Standard Time'}
                                                $pst         = [System.TimeZoneInfo]::GetSystemTimeZones() | Where-Object { $_.Id -eq  'Pacific Standard Time'}
                                                $format_conv = [datetime]::parseexact($date_time,'yyyy-MM-dd H:mm:ss', $null) 
                                                $dateTime    = [System.TimeZoneInfo]::ConvertTime($format_conv,$gmt,$pst)
                                                Write-Host -ForegroundColor Green "[*] $user_name accessed $hostname at $dateTime "
                                        }
                                        catch 
                                        {
                                            Write-Host $null
                                        }
                                        
                                    }
                                    
}

ImportData
