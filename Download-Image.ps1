Function Download-Image {

[CmdletBinding()]

param ([string] $URL) 
    
    Write-Verbose $URL 
    $wc = new-object System.Net.WebClient
    [byte[]]$imageBytes = $wc.DownloadData("$URL")

    Add-Type -AssemblyName System.Windows.Forms

    $img = [System.Drawing.Image]::FromStream([System.IO.MemoryStream]$imagebytes)
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.Width =  $img.Width
    $pictureBox.Height =  $img.Height
    $pictureBox.Image = $img

    $form = new-object Windows.Forms.Form
    $form.Width = $img.Width
    $form.Height =  $img.Height
    $form.AutoSize = $True
    $form.AutoSizeMode = "GrowAndShrink"
    $form.Icon = $icon
    $form.controls.add($pictureBox)
    $form.Add_Shown( { $form.Activate() } )
    $form.ShowDialog()
}
