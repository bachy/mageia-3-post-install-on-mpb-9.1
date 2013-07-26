#! /bin/sh

# install Sublime Sublime text 2
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net


#sublime text 2
cd /home/bachir/Downloads
mkdir sublimetext2
cd sublimetext2
wget http://c758482.r82.cf2.rackcdn.com/Sublime Text 2.0.1 x64.tar.bz2
tar -vxjf Sublime\ Text\ 2.0.1\ x64.tar.bz2
sudo mv Sublime\ Text\ 2 /opt/
sudo ln -s /opt/Sublime\ Text\ 2/sublime_text /usr/bin/sublime
sudo echo "[Desktop Entry]
Version=1.0
Name=Sublime Text 2
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Text Editor

Exec=sublime
Terminal=false
Icon=/opt/Sublime Text 2/Icon/48x48/sublime_text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity" > /usr/local/share/applications/sublime.desktop

sudo sed -i 's/gedit.desktop/sublime.desktop/g' /usr/share/applications/defaults.list

# install package manager for sublime text 2
# on sublime console
# import urllib2,os; pf='Package Control.sublime-package'; ipp=sublime.installed_packages_path(); os.makedirs(ipp) if not os.path.exists(ipp) else None; urllib2.install_opener(urllib2.build_opener(urllib2.ProxyHandler())); open(os.path.join(ipp,pf),'wb').write(urllib2.urlopen('http://sublime.wbond.net/'+pf.replace(' ','%20')).read()); print 'Please restart Sublime Text to finish installation'
# throught shell script
cd /home/bachir/Downloads
wget https://sublime.wbond.net/Package%20Control.sublime-package
mv Package\ Control.sublime-package /home/bachir/.config/sublime-text-2/Installed\ Packages/


echo '{
	"installed_packages":
	[
		"All Autocomplete",
		"ApacheConf.tmLanguage",
		"Auto Encoding for Python",
		"Auto Semi-Colon",
		"BracketHighlighter",
		"BufferScroll",
		"Clipboard History",
		"Color Schemes by carlcalderon",
		"ColorPicker",
		"ConvertToUTF8",
		"CSS Media Query Snippets",
		"Drupal",
		"Drupal Snippets",
		"EasySettings",
		"FileDiffs",
		"FileTemplates",
		"Git",
		"Git Config",
		"GitGutter",
		"Goto Documentation",
		"Goto Drupal API",
		"HighlightDuplicates",
		"HostsEdit",
		"jQuery",
		"LaTeXTools",
		"LESS",
		"Package Control",
		"PhpDoc",
		"Processing",
		"Python Auto-Complete",
		"Search Stack Overflow",
		"SFTP",
		"SideBarEnhancements",
		"SideBarGit",
		"SSH Config",
		"STProjectMaker",
		"SublimeCodeIntel",
		"SublimeTODO",
		"SyncedSideBar",
		"Theme - Soda",
		"Todo",
		"Web Inspector",
		"WordCount",
		"XAML"
	]
}
' > /home/bachir/.config/sublime-text-2/Packages/User/Package\ Control.sublime-settings

echo '{
	"color_scheme": "Packages/Color Schemes by carlcalderon/Stereokai/Stereokai.tmTheme",
	"font_face": "",
	"font_size": 11,
    	"theme": "Soda Dark.sublime-theme",
    	"bold_folder_labels": true,
	"preview_on_click": false,
	"tab_size": 2,
  	"translate_tabs_to_spaces": true,
	"ignored_packages":
	[
		"Vintage"
	]
}
' > /home/bachir/.config/sublime-text-2/Packages/User/Preferences.sublime-settings

echo '[
	{ "keys": ["super+alt+1"], "command": "focus_group", "args": { "group": 0 } },
	{ "keys": ["super+alt+<"], "command": "focus_side_bar" },
	{ "keys": ["f1"], "command": "fold" },
	{ "keys": ["alt+f1"], "command": "unfold" },
	{ "keys": ["f5"], "command": "goto_documentation" },
	{ "keys": ["ctrl+t"], "command": "side_bar_new_file2" },
	{ "keys": ["f2"], "command": "side_bar_rename" },
	{ "keys": ["ctrl+alt+f"], "command": "side_bar_find_files_path_containing" }
]' > /home/bachir/.config/sublime-text-2/Packages/User/Default\ \(Linux\).sublime-keymap
