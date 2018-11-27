##-- RenameToStandard.ps1 ------------------------------
#
# Author:
#  David Martin
#
# Purpose:
#  Batch renames image files to the naming standard
# 
# Description:
#  The file name standard is as follows:
#  
#  ####-XXXXXX-XXXX-###
#   
#  #### - Site Code: 4 digit site code
#  XXXXXX - Room Code: AMS room code (6-8 alphanumeric characters)
#  XXXX - Descriptor: A brief description of content ie BD, CD, CD2, WAP
#  ### - Batch and Index: First car is batch number (1st visit, 2nd visit, etc). Index
#        is a zero padded number representing the photo number for the respective batch
#
# Execution:
#  Run the script and provide the requested details as prompted in accordance with the
#  naming standard defined above
#
##--------------------------------------------------


#-----------------------------------------
# Get directory and image files
#-----------------------------------------

# Get path
$dir = Read-Host 'Enter the full path of the directory containing the image files'
while(!(Test-Path -Path $dir)) {
    $dir = Read-Host "Directory input: >$dir< does not exist. Please enter a valid path"
}

# Get files
$files = Get-ChildItem -Path $dir\* -Include *.jpg, *.gif, *.bmp, *.png
if ($files -eq $null) {
    Write-Output "No image files found in $dir. Exiting script..."
    Exit
} else {
    $filesLenMsg = "Images found: " + $files.length
    Write-Output $filesLenMsg
}

#---------------------
# Get name inputs
#---------------------

# Iterate request for user input
while ($true) {

    # Get Site Code
    while ($true) {
        $siteCode = Read-Host 'Enter the site code (ie 0230, 4411)'
        if ($siteCode -notmatch '^\d{4}$') {
            Write-Output "Site code input: >$siteCode< is invalid."
        } else {
            break
        }
    }

    # Get AMS Room Code
    while($true) {
        $roomCode = Read-Host 'Enter the AMS room code (ie LR0024, AR1017)'
        if ($roomCode -notmatch '^[a-zA-Z]{2,4}\d{4}$') {
            Write-Output "AMS room code input: >$roomCode< is invalid."
        } else {
            break
        }
    }

    # Get Descriptor
    while($true) {
        $picDesc = Read-Host 'Enter the descriptor (ie BD, CD2, WAP)'
        if ($picDesc -notmatch '^\w*$') {
            Write-Output "Descriptor input: >$picDesc< is invalid."
        } else {
            break
        }
    }
    
    # Get Batch number
    while($true) {
        $batchNum = Read-Host 'Enter the starting batch number (3 digit 0 padded integer, ie 001, 401)'
        if ($batchNum -notmatch '^\d{3}$') {
            Write-Output "Batch number input: >$batchNum< is invalid."
        } else {
            $batchNum = [int]$batchNum
            break
        }
    }

    break
}

#------------------------------
# Iterate files in directory
#------------------------------

# Iterate through files in path
forEach ($file in $files) {

    # Capture the file extension and concatinate new file name
    $fileExt = $file.Name.Substring($file.Name.Length - 4, 4)
    $newFileName = $siteCode + '-' + $roomCode + '-' + $picDesc + '-' + $batchNum.ToString("000") + $fileExt

    # Rename each file and increment the batch number
    Rename-Item -Path (Join-Path -Path $dir -ChildPath $file.Name) -NewName $newFileName
    $batchNum++
}

# End script
Write-Output "`nScript execution complete. Exiting..."




