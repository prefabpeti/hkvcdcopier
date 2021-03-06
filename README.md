# HK VCD Copier
Tool for copying VCDs to a more modern format

- Allows to select just the left or right channel (usually Cantonese or Mandarin)
- Joins all files together, across CDs
- Option to convert to MKV


Originally created to allow VCDs to be still viewed using modern TVs or DVD/Blu-Ray players. For example modern Panasonic players have not been able to play VCD for a couple of generations now.

This tool is intended for preservation of hard to find films and not for mass distribution. Also bear in mind this was made for my own use, so please keep any feedback constructive.

Requires ffmpeg (https://www.gyan.dev/ffmpeg/builds/) and Powershell.
Tested with: ffmpeg 2021-12-27-git-617452ce2c-full_build-www.gyan.dev

Usage:
- Place the file in the same directory as ffmpeg
- Right-click 'HK VCD Copier.ps1' and select 'Run with Powershell'
- OR type: & '.\HK VCD Copier.ps1' (from Powershell in the directory)
- Type the name of the film
- Which audio channel you want (check this first by playing it and listening with headphones or similar)
- How many discs the film is (most are 2, but there are a handful of 3 disc VCDs out there)
- Which drive letter your CD/DVD/Blu-Ray drive is
- Whether you want the resulting file to be also converted to an MKV (smaller file size and more modern format - quality should be similar)

Tested with:<br/>

<table>
  <tr><th>Title</th><th>Cat. No</th><th>Publish</th><th>Works?</th></tr>
  <tr><td>Tiger On The Beat 2</td><td>VCD 1362</td><td>Universe Laser & Video Co,.Ltd.</td><td>Yes</td></tr>
  <tr><td>Winner Takes All</td><td>VCD 7203</td><td>DELTAMAC</td><td>Yes</td></tr>
  
  <tr><td>The God of Cookery</td><td>VCD 1485</td><td>Universe Laser & Video Co,.Ltd.</td><td>Yes</td></tr>
  <tr><td>Thunderbolt</td><td>VCD213</td><td>Mei Ah Laser Disc., Ltd.</td><td>Yes</td></tr>
  <tr><td>Banana Spirit</td><td>VCD 1442</td><td>Universe Laser & Video Co,.Ltd.</td><td>Yes</td></tr>
  <tr><td>My Flying Wife</td><td>VCD296</td><td>Mei Ah Laser Disc., Ltd.</td><td>Yes</td></tr>
</table>

If the script fails to run, you may need to run the following in Powershell first:<br/>
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

If you see one of the following errors:
- Non-monotonous DTS in output stream
- Warning MVs not available
- Queue input is backward in time
- buffer underflow

This seems to point to non-compliant MPEG1/VCD streams, but the file output may well be fine. Check the output to be satisfied yourself.


Future improvements or known problems:
- When putting the second disc in, the interface isn't very forgiving so make sure the drive is ready


Feedback:
- I'd like to know about any discs that don't work properly, so I can see if the ffmpeg commands can be improved for better compatibility
- Ideally then copies of the files to be made available to me on cloud storage of some kind so I can reproduce the result and investigate
