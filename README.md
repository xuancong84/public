# Public small files for sharing
x4_focused_pan : x4-foundations UI patch for comfortable play experience

Version: 2.0 (for game version 3.20)
#### How to install?
Download the zip archive, extract the x4_focused_pan folder to <game_folder>/extensions/


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
