rd /S /Q ElectrifyWin
del *.zip
call pyinstaller --onefile --hidden-import PIL.Jpeg2KImagePlugin --hidden-import configobj --hidden-import pkg_resources -i icon.ico --distpath command_line_builds -n electrify-win command_line.py
rd /S /Q command_line_builds\files
echo D | xcopy /s files command_line_builds\files


call pyinstaller -w --onefile --hidden-import PIL.Jpeg2KImagePlugin --hidden-import pkg_resources --hidden-import configobj -i icon.ico --distpath ElectrifyWin -n Electrify main.py
echo D | xcopy /s files ElectrifyWin\files

del ElectrifyWin\files\compressors\upx-mac
del ElectrifyWin\files\compressors\upx-linux-x64
del ElectrifyWin\files\compressors\upx-linux-x32

del command_line_builds\files\compressors\upx-mac
del command_line_builds\files\compressors\upx-linux-x64
del command_line_builds\files\compressors\upx-linux-x32

makensis /V4 Electrify.nsi

set /p Version=<files\version.txt

7z a ElectrifyWin-%Version%.zip -r ElectrifyWin
cd command_line_builds
7z a ..\ElectrifyWin-CMD.zip -tzip -r *
cd ..
7z a ElectrifyWin-Setup.zip Electrify-Setup.exe

call python upload_release.py
