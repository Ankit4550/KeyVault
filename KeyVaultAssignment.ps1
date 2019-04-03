#connecting to Azure Portal
Connect-AzureRmAccount
#create Keyvault
New-AzureRmKeyVault -VaultName "globantkeyvault" -ResourceGroupName "cloud-shell-storage-centralindia" -Location "central india"
#set the access policies to set and retrieve secrets
Set-AzureRmKeyVaultAccessPolicy -VaultName "globantkeyvault" -ResourceGroupName "cloud-shell-storage-centralindia" -UserPrincipalName "ankit.singh@globant.com" -PermissionsToSecrets get,set,list -PassThru
# Creating the key value pair
$splitsamples=@{

    psreventHubName = "timeseries-eh-psr"
    psrconsumerGrpName = "cntnr-2.0.0"
    psreventHubnamespace ="dataq-ts-eh-psr"
    psrSASName = "ListenPolicy"
    psrSASKey = ""

    storageAccountName = "dataqtssa"
    storageAccountKey = ""
    storageContainerName = "dataqjava"

    rawSamplesEventHubName = "timeseries-eh-rawsample"
    rawSamplesEventHubnamespace = "dataq-ts-eh-rawsamples"
    rawSamplesSASName = "SendPolicy"
    rawSamplesSASKey = ""
    
    psrStatusEventHubName = "timeseries-eh-psrstatus"
    psrStatusEventHubnamespace = "dataq-ts-eh-status"
    psrStatusSASName = "SendPolicy"
    psrStatusSASKey = ""
}
foreach($keyname in $splitsamples.Keys)
{
    $deployvalue= $splitsamples[$keyname]
    $secret=ConvertTo-SecureString -String $deployvalue -AsPlainText -Force
    Set-AzureKeyVaultSecret -VaultName "globantkeyvault" -Name $keyname -SecretValue $secret
}
