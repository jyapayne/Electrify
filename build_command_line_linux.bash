
rm -rf build ElectrifyLinux*

VERSION=$(cat files/version.txt)

pyinstaller --onefile --exclude-module PyQt5 --exclude-module PyQt4 --hidden-import PIL._imaging --hidden-import PIL.Jpeg2KImagePlugin --hidden-import pkg_resources --hidden-import PIL._imaging --hidden-import configobj --distpath ElectrifyLinux-CMD -n electrify-linux command_line.py
cp -rf files ElectrifyLinux-CMD/files
rm -rf ElectrifyLinux-CMD/files/downloads/*
rm ElectrifyLinux-CMD/files/error.log ElectrifyLinux-CMD/files/last_project_path.txt ElectrifyLinux-CMD/files/recent_files.txt ElectrifyLinux-CMD/files/compressors/upx-mac ElectrifyLinux-CMD/files/compressors/upx-win.exe

rm -rf ElectrifyLinux
pyinstaller -F --exclude-module PyQt5 --exclude-module PyQt4 --hidden-import PIL._imaging --hidden-import PIL.Jpeg2KImagePlugin --hidden-import configobj --hidden-import PIL._imaging --hidden-import pkg_resources -n electrify --distpath ElectrifyLinux main.py
cp -rf files ElectrifyLinux/files
rm -rf ElectrifyLinux/files/downloads/*
rm ElectrifyLinux/files/error.log ElectrifyLinux/files/last_project_path.txt ElectrifyLinux/files/recent_files.txt ElectrifyLinux/files/compressors/upx-mac ElectrifyLinux/files/compressors/upx-win.exe


zip -r -9 ElectrifyLinux-CMD.zip ElectrifyLinux-CMD/*
zip -r -9 ElectrifyLinux-${VERSION}.zip ElectrifyLinux

python3.4 upload_release.py
