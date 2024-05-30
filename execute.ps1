$userProfiles = Get-WmiObject -Class Win32_UserProfile

foreach ($profile in $userProfiles) {
    $userSID = $profile.SID
    $userAccount = $null

    try {
        $userAccount = [System.Security.Principal.SecurityIdentifier]::new($userSID).Translate([System.Security.Principal.NTAccount]).Value
    } catch {

    }

    if ($userAccount -eq $null) {
        Delete the user profile
        Write-Host "Deleting user profile with SID $userSID"
        Remove-WmiObject -InputObject $profile
    }
}

Write-Host "User profiles cleanup completed."
