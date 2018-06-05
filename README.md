# osu! for Mac Stable (Latest)

### Step to Install:
1. Download zip (196M) from this page, it should be sitting in Download folder.

2. If you are upgrading from the old client, DO NOT move to /Application and replace the old client immediately. There are some migration need to do.
   1. Open osu! folder for both old and new clients (right click on app - show package content - drive_c - Program Files - osu!)
   2. Hold command key and select all of the following folders and files from the old client side
		* Folders: Data, Songs, Skins
		* Files: collection.db, presence.db, scores.db, osu!.db, osu!.cfg, osu!.[Username].cfg
   3. Drag them to the new client side while holding option key. Note: If a symlink a created instead of copying the actual file (A symlink can be identified by an arrow at the corner), remove those symlink files and repeat those steps
	
3. Open the new client by right click and select open.
   * An error of no runtime can be ignored.
   * If prompted Gecko package is not installed, click cancel.
   * When osu! installer appear, change the install location before countdown and select drive_c/Program Files/osu!
   * osu! will take a while to download and install itself. The game will start automatically when it finishes.
4. For the best perfomance, go to setting, set the frame limit to 240fps (Unlimited would not work properly) and turn full screen mode off.
5. Play a few games. If you're happy with it, move the game to /Application and enjoy!

---------------------------
### Testing Environment:
Mac Mini (Late 2014) 2.6GHz, 8G Memory, 256G SSD, MacOS High Sierra 10.13.4, Wrapper Wineskin-2.6.2, Engine WS9Wine2.22

---------------------------
### A Little Bouns for all:

To move the beatmaps faster, open the terminal, copy and paste this command followed by return:
* `echo "alias osu='mv ~/Downloads/*.osz /Applications/osu\!.app/drive_c/Program\ Files/osu\!/songs'" >> .bash_profile`

Restart terminal and from now on, you can simply type "osu" in the terminal to move all beatmaps from download folder to game beatmap folder, don't forget to fn+f5 to refresh the game list.

---------------------------
### Known Issues
1. With 2018-001 update installed, wine package downloaded with browser will not open. However, download with git clone would work properly.
2. gdiplus is not compactible with cjkfonts, so it's a trade off to get the setting icons and control buttons work and cjkfonts work. If you prefer cjkfonts more than those graphic glitches, you can follow these steps:
   1. Right click osu! - show package content - open wineskin - click advance.
   2. Click tools at the top - config Utility on top left, The config windows may take a few seconds to jump out.
   3. Go to Libries tab at the top - select gdiplus and click edit - then select built in (wine) and save.
   4. You can revert this setting by the same steps and select native (windows) to revert.
3. For in-game settings, Shaders would not work, enable Soften Filters will blank the screen, enable Compactible Mode will crash the game. If you accidently turn these settings on, you can go to osu! folder and edit osu!.[Username].cfg with textedit and change the value of BloomSoftening or CompactibilityContext to 0 to fix it.
4. Some other glitches, osu! Direct from osu website would not work (in-game download works good). Discord-rpc will not work. Double Clicking beatmap files or dragging to game window will not open them (So the only way to import beatmaps is move to the folder manually, or use the command above).
