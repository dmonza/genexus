# Calculo de machineKey para alta disponibilidad en .NetFramework

function New-MachineKey {
    param([int]$Bytes = 64)
    $buf = New-Object byte[] $Bytes
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($buf)
    ($buf | ForEach-Object { $_.ToString("X2") }) -join ''
}

# "validationKey: " + (New-MachineKey -Bytes 64)   # HMACSHA256
# "decryptionKey: " + (New-MachineKey -Bytes 32)   # AES-

"<machineKey validationKey=`"$(New-MachineKey -Bytes 64)`" decryptionKey=`"$(New-MachineKey -Bytes 32)`" validation=`"HMACSHA256`" decryption=`"AES`" />"