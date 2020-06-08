# Public small files for sharing
x4_focused_pan : x4-foundations UI patch for comfort play
Version 1.0 (for game version 3.20):
- it allows players to use middle mouse button to perform camera-space map panning (in the original game, map paning is always along the x-z sector plane)
- fixed: in the original game, after zoomed in on an object well below sector plane, once you start panning map, you will lose zoomed focus; after zoomed in on an object well above the sector plane, once you start panning map, the focus will shift onto the plane right behind the object, so you get very high mouse sensitivity
- fixed: in the original game, after zoomed in on an object well below sector plane, if you attempt to click on any nearby objects, your camera will zoom out, and the clicked object will not be selected 
- enhance: in the original game, reset-camera function will always focus on the player, however, very often the player is manipulating units far away from his current location. Now, reset-camera will first check mouse cursor, if it points to an object, it will reset direction and focus on that object; elseif an object is selected, it will reset direction and focus on the selected object; else it will reset direction and focus on the player
- enhance: now, you can fire/hire/set-guidance-to any workforce NPC on your own station, by right-clicking the NPC in the station-crew-info menu workforce list, i.e., 'hire' means work-somewhere-else

Note: UI mod changes Lua code, so it can hardly apply to a different game version although I have put in effort to make my modification as compatible as possible. But hopefully, some of the enhancements can be integrated into some subsequent game patches by the developer team.
