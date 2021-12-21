# Public small files for sharing

# 1. RPi4 : Raspberry Pi 4 utilities
See /boot/switch-\*.sh
- switch between HDMI/TFT display
- switch between PXE/microSD boot
- switch between using fbcp (a user program that keeps copying frame-buffer) or direct /dev/fb1 (X11 directly render to /dev/fb1)


# 2. Retro-gaming list tools:
**Utility Tool 1** (gamelist-merge.py):

I claim it as the world’s best program (up to today 🤩) for merging gamelist.xml because:

- It can merge multiple game lists in one go
- It can resolve duplicates both within the same gamelist.xml (e.g., "Ace Combat 2 (USA).chd" and "Ace Combat 2 (USA).PBP") and across multiple gamelist.xml
- It can work on just the list files (gamelist.xml) only or together with the directory of all the files
- For input: you can keep different sources in different folders or lump every source into one single folder (because ROM pack can be huge, taking lots of disk space, so it takes much more space to keep them in separate folders)
- For output: you can modify resources in place (by specifying the same input/output directory) or output to a different folder (same disk-space consideration as in 4)
- You can specify merge rules (or no internal merge), for string field you can choose to keep “longer” or “shorter” string, for files you can choose to keep “bigger” or “smaller” file

By default, it will keep longer string field (more detailed description is better), smaller ROM file (more efficient compression is better), and bigger resource file (higher resolution image/video is better), but you can customize the merge rule by yourself.

Since different retro-gaming OS takes slightly different gamelist.xml, if certain XML fields (such as <sortname>) is not needed, you can use simple shell commands such as sed to delete those lines.
  
**Utility Tool 2** (copy-if-absent.py):

  In another scenario, you might have a folder of ROMs without scrape info, i.e., no gamelist.xml. You want to copy over ROMs without duplicates in different filename extensions. For example, you have "Phoenix 3 (USA).iso" in one folder, "Phoenix 3 (USA).CHD" in a second folder, and "Phoenix 3 (USA).cue/img/ccd/sub" in a third folder. They all refer to the same game "Phoenix 3 (USA)", just in different ROM formats, but for the same emulator. So how to merge them into one folder without creating duplicates. This tool allows you to do so. You need to specify source folders and destination folder, and file extensions that indicate ROMs (e.g., “iso chd cue”). When a ROM needs to be copied over (e.g., "Phoenix 3 (USA).cue" as stated in the path field in gamelist.xml), all files with the same base name ("Phoenix 3 (USA).cue", "Phoenix 3 (USA).img", "Phoenix 3 (USA).ccd", "Phoenix 3 (USA).sub", etc.) will be copied over, even though the other three are not referred in "gamelist.xml". Moreover, you also have the option of moving files over instead of copying file over (--move option).


# 3. x4\_focused\_pan : x4-foundations UI patch for comfortable play experience
Version: 2.0 (for game version 3.20)
#### How to install?
Download the zip archive, extract the x4\_focused\_pan folder to <game_folder>/extensions/


#### Modifications:
- it allows players to use middle mouse button to perform camera-space map panning (in the original game, map paning is always along the x-z sector plane)
- fixed: in the original game, after zoomed in on an object well below sector plane, once you start panning map, you will lose zoomed focus; after zoomed in on an object well above the sector plane, once you start panning map, the focus will shift onto the plane right behind the object, so you get very high mouse sensitivity
- fixed: in the original game, after zoomed in on an object well below sector plane, if you attempt to click on any nearby objects, your camera will zoom out, and the clicked object will not be selected 
- enhance: in the original game, reset-camera function will always focus on the player, however, very often the player is manipulating units far away from his current location. Now, reset-camera will first check mouse cursor, if it points to an object, it will reset direction and focus on that object; elseif an object is selected, it will reset direction and focus on the selected object; else it will reset direction and focus on the player
- enhance: now, you can fire/hire/set-guidance-to any workforce NPC on your own station, by right-clicking the NPC in the station-crew-info menu workforce list, i.e., 'hire' means work-somewhere-else
- enhance: 3.20 comes with a bug, in the info menu, when you double-click on the title of the table, sometimes the camera will no longer focus on the object; now when an object is selected, in the info menu, if you right-click the title row, the camera will center on the object without resetting camera direction
- enhance: in the original game, the toggle-trade button is too small,  Now you can use middle-click on map to toggle trade display; moreover, middle-click on any station will set the trade filter to that station’s trade offers (both buy and sell offers). To set to buy offers only, use CTRL middle-click the station; to set to sell offers only, use SHIFT middle-click the station. Middle-click on any of your own ship will set the trade filter to that ship's cargo (very often, it takes your auto-trade ship a long time to find a seller)
- enhance: very often you want to have your predefined list of trade wares (typically those wares that make most profit) that can be easily switched to, but setting the trade filter is really a headache in the original game. Now, you can use the save/load button next to the reset-view button, or use CTRL middle-click to save current trade filter list, and use SHIFT middle-click to load previously saved trade filter list.

Note: UI mod changes Lua code, so it can hardly apply to a different game version although I have put in effort to make my modification as compatible as possible. But hopefully, some of the enhancements can be integrated into some subsequent game patches by the developer team.
