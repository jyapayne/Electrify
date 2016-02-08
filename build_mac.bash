VERSION=$(cat files/version.txt)

rm -rf ElectrifyMac*
rm  files/error.log files/last_project_path.txt files/recent_files.txt
rm -rf files/downloads/*
rm -rf ElectrifyMac-CMD/files
pyinstaller --hidden-import PIL.Jpeg2KImagePlugin --hidden-import configobj --hidden-import pkg_resources --distpath ElectrifyMac-CMD --onefile -n electrify-mac command_line.py
cp -rf files ElectrifyMac-CMD/files/

rm -rf build dist Electrify.app

#sudo python build_mac_setup.py py2app --iconfile icon.icns 
pyinstaller -w --hidden-import PIL.Jpeg2KImagePlugin --hidden-import PyQt4 --hidden-import PIL --hidden-import configobj --hidden-import pkg_resources --distpath ElectrifyMac --onefile -n Electrify main.py

#sudo chown -R joey dist/Electrify.app
#sudo chown -R joey dist/ build/
#mv dist/Electrify.app Electrify.app

mv ElectrifyMac/Electrify.app .

#rm -rf Electrify.app/Contents/Frameworks/QtDesigner*
#rm -rf Electrify.app/Contents/Frameworks/QtXml*
#rm -rf Electrify.app/Contents/Frameworks/QtWebKit*
#rm -rf Electrify.app/Contents/Frameworks/QtScript*

cp icon.icns Electrify.app/Contents/Resources/icon-windowed.icns
cp -rf files Electrify.app/Contents/MacOS/

rm -rf build dist

/Applications/Keka.app/Contents/Resources/keka7z a -r ElectrifyMac-CMD.zip ElectrifyMac-CMD
/Applications/Keka.app/Contents/Resources/keka7z a -r ElectrifyMac-${VERSION}.zip Electrify.app

python3.4 upload_release.py
