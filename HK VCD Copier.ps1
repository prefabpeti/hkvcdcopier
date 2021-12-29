$tempdir ="$env:TEMP\"
$tempguid = New-Guid
$tempdir = $tempdir + $tempguid

$title = ''
$audiochannel = 'r'
$noofdiscs = 2
$cddrive = 'e'
$converttomkv = $false

$tmpnewdir = New-Item -Path $tempdir -ItemType directory

Write-Host "HK VCD Copier" -ForegroundColor Green
Write-Host "Preserve old VCDs and play them on modern hardware, also to isolate L or R audio"
Write-Host "Temporary path created: $tempdir"

$ffmpegexists = Test-Path -Path "ffmpeg.exe" -PathType Leaf

if (!$ffmpegexists) {
Write-Host "ffmpeg.exe not detected in directory!" -ForegroundColor Red
Exit
}

Write-Host "ffmpeg.exe detected"

$title= Read-Host -Prompt "Title"


$audiochannel = Read-Host -Prompt "L or R audio channel? (default r)"

if(!$audiochannel) {
$audiochannel = 'r'
}

$audiochannel = $audiochannel.ToLower()


$noofdiscs= Read-Host -Prompt "No of discs (default 2)"

if(!$noofdiscs) {
$noofdiscs = 2
}

$cddrive = Read-Host -Prompt "CD-ROM drive letter (default e)"

if (!$cddrive) {
	$cddrive = 'e'
}

$tmpconverttomkv = Read-Host -Prompt "Convert to MKV? Y/N (default y)"

if (!$tmpconverttomkv) {
	$converttomkv = $true
}
else {
	$tmpconverttomkv = $tmpconverttomkv.ToLower()
	if ($tmpconverttomkv -eq 'y') {
		$converttomkv = $true;
	}
}

for ($num = 1; $num -le $noofdiscs; $num++){
	Read-Host "Copying disc $num (press enter)"
	$tmpnewdiscdir = $tempdir + "/" + $num
	$tmpnewdir = New-Item -Path $tmpnewdiscdir -ItemType directory

	$tmpdrive = $cddrive + ':\MPEGAV'
	Get-ChildItem -Path $tmpdrive |
	Foreach-Object {
	Write-Host $_.FullName
	Copy-Item $_.FullName -Destination $tmpnewdir
	}
}

for ($num = 1; $num -le $noofdiscs; $num++){
	Write-Host "Gathering files for join $num"
	
	$tmpnewdiscdir = $tempdir + "/" + $num

	Get-ChildItem $tmpnewdiscdir -recurse -include *.dat| ForEach-Object { "file '" + $_.FullName + "'" } >> $tempdir\files.txt
}

(Get-Content $tempdir\files.txt) | Set-Content $tempdir\files.txt -Encoding ASCII

./ffmpeg -f concat -safe 0 -i $tempdir\files.txt -c:v copy $tempdir\combined.mpg

if($audiochannel -eq 'l') {
	.\ffmpeg.exe -i $tempdir\combined.mpg -map_channel 0.1.0 -c:v copy $tempdir\output.mpg
}
else {
	.\ffmpeg.exe -i $tempdir\combined.mpg -map_channel 0.1.1 -c:v copy $tempdir\output.mpg
}

if ($converttomkv -eq $true) {
./ffmpeg -i $tempdir\output.mpg -c:v h264 -b:v 0.9M -c:a libvorbis 'output.mkv'
Move-Item -Path .\output.mkv -Destination .\$title.mkv
}
else {
Move-Item -Path $tempdir\output.mpg -Destination .\$title.mpg
}

Write-Host "Removing temporary files"
Remove-Item -Recurse -Force $tempdir


Read-Host -Prompt "Completed!"