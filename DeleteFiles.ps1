#############################################################################################
#                                                                                           #
#         Script to delete files older than 7 days from Downloads folder                    #
#         Version:  1.1                                                                     #
#         Created:  28/06/2018                                                              #
#                                                                                           #
#         Change Log                                                                        #
#         Version     Change Date     Description                                           #
#         1           28/6/18         Initial Version                                       #
#         1.1         28/6/18         Added $14limit option                                 #
#                                                                                           #
#############################################################################################

[remote "origin"]
  url = "https://github.com/wilcotom/WindowsMaintenance"
[branch = "master"]


$7limit = (Get-Date).AddDays(-7)
$14limit = (Get-Date).AddDays(-14)
$path = "C:\Users\tomgp\Downloads\"

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $7limit } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
