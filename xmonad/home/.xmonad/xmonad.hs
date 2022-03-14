-- IMPORTS
-- Base
import XMonad
import System.Exit (exitSuccess)
import XMonad.StackSet (swapUp, swapDown, swapMaster, focusUp, focusDown, focusMaster, sink, RationalRect(..))

-- Actions
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies)

-- Hooks
import XMonad.Hooks.EwmhDesktops (ewmhDesktopsEventHook, fullscreenEventHook, ewmhDesktopsLogHook, ewmh)
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, docks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doRectFloat, isDialog, isInProperty)

  
-- Layouts
import XMonad.Layout.ResizableTile

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??), Toggle(..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.NamedScratchpad

-- Misc
import Foreign.C.Types (CLong)

-- VARIABLES
myXMessage :: String
myXMessage = "xmessage -default okay -bg black -fg white "
  
myBrowser :: String
myBrowser = "qutebrowser "

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "

myEditor :: String
myEditor = "emacsclient -c -a 'emacs' "

myEventHook = ewmhDesktopsEventHook <+> fullscreenEventHook
myLogHook = ewmhDesktopsLogHook
  
--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- LAYOUTS
tall         = limitWindows 12
             $ ResizableTall 1 (3/100) (1/2) []
  
myLayoutHook = spacingWithEdge 30
             $ avoidStruts
             $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) tall

-- SCRATCH PADS
scratchpads :: [NamedScratchpad]
scratchpads = [
  NS "terminal" "alacritty -t ScratchT"
     (title =? "ScratchT")
     (customFloating $ RationalRect 0.05 0.05 0.9 0.9),
  NS "spotify" "psst-gui"
     (className =? "Psst-gui")
     (customFloating $ RationalRect 0.05 0.05 0.9 0.9)
  ]

-- MANAGE HOOK
myManageHook = composeAll
    [ isFullscreen                  --> doFullFloat
    , isInProperty "_NET_WM_WINDOW_TYPE" "NET_WM_WINDOW_TYPE_DIALOG" --> doFloat
    
    -- Picture in Picture (Firefox)
    -- , title =? "Picture-in-Picture"
    --  --> doRectFloat (RationalRect 0.65 0.07 0.3 0.3)
    -- , title =? "Picture-in-Picture"
    --  --> doF copyToAll
    -- , title =? "Picture-in-Picture"
    --  --> spawn "picom-trans -t -c 100",
    , className =? "confirm"        --> doFloat
    , className =? "file_progress"  --> doFloat
    , className =? "dialog"         --> doFloat
    , className =? "download"       --> doFloat 
    , className =? "error"          --> doFloat 
    , className =? "Gimp"           --> doFloat 
    , className =? "notification"   --> doFloat 
    , className =? "pinentry-gtk-2" --> doFloat 
    , className =? "splash"         --> doFloat 
    , className =? "toolbar"        --> doFloat 
    , resource  =? "download"       --> doIgnore
    , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat 
    ] <+> namedScratchpadManageHook scratchpads

-- STARTUP HOOK
myStartupHook :: X ()
myStartupHook = do
  spawnOnce "/usr/bin/emacs --daemon"

-- KEYBINDINGS
-- Start Keys
myKeys :: [(String, X ())]
myKeys = [
  -- Xmonad --
  ("M-q", spawn "xmonad --recompile; xmonad --restart")
  , ("M-S-q", io exitSuccess)

  -- Applications --
  , ("M-S-<Return>", spawn "alacritty")
  , ("M-e", spawn "emacsclient -c")
  , ("M-S-s", spawn "flameshot gui")

  -- Scratch Pads --
  , ("M-C-t", namedScratchpadAction scratchpads "terminal")
  , ("M-C-s", namedScratchpadAction scratchpads "spotify")
  
  -- Rofi --
  , ("M-p", spawn "rofi -show run")
  , ("M-C-p", spawn "rofi -show window")
  , ("M-C-b", spawn "rofi-bluetooth")
  , ("M-b", spawn "bwmenu")
  
  -- Change Focus --
  , (" -j", windows focusDown)
  , (" -k", windows focusUp)
  , ("M-m", windows focusMaster)

  -- Swap Windows --
  , ("M-<Return>", windows swapMaster)
  , ("M-S-j", windows swapDown)
  , ("M-S-k", windows swapUp)

  -- Resize Windows --
  , ("M-n", refresh)
  , ("M-h", sendMessage Shrink)
  , ("M-l", sendMessage Expand)

  --  Pin Windows --
  , ("M-a", windows copyToAll)
  , ("M-S-a", killAllOtherCopies)

  -- Act On Windows --
  , ("M-S-t", spawn "picom-trans -t -c 100")
  , ("M-f", sendMessage $ Toggle NBFULL)
  , ("M-g",  sendMessage ToggleStruts)
  , ("M-S-f", toggleScreenSpacingEnabled
            >> toggleWindowSpacingEnabled
            >> sendMessage (Toggle NBFULL)
            >> sendMessage ToggleStruts)
  , ("M-S-c", kill)

  -- Layouts --
  , ("M-<Space>", sendMessage NextLayout)
  , ("M-t", withFocused $ windows . sink)
  , ("M-,", sendMessage (IncMasterN 1))
  , ("M-.", sendMessage (IncMasterN (-1)))]

-- MAIN
main :: IO ()
main = do
  -- Launch polybar
  xmproc <- spawnPipe ("pkill polybar || true && polybar xmonad")
  
  -- Start xmonad
  xmonad $ ewmh $ docks $ def {
    -- simple stuff
    terminal           = "alacritty",
    focusFollowsMouse  = False,
    clickJustFocuses   = True,
    borderWidth        = 2,
    modMask            = mod4Mask,
    workspaces         = ["1","2","3","4","5","6","7","8","9"],
    normalBorderColor  = "#dddddd",
    focusedBorderColor = "#ff6666",
    -- hooks, layouts
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
    } `additionalKeysP` myKeys

-- HELP
help :: String
help = unlines [
  "The default modifier key is 'alt'. Default keybindings:",
  "",
  "-- launching and killing programs",
  "mod-Shift-Enter  Launch alacritty",
  "mod-p            Launch rofi",
  "mod-Shift-p      Launch rofi for window selection",
  "mod-Shift-c      Close/kill the focused window",
  "mod-Space        Rotate through the available layout algorithms",
  "mod-Shift-Space  Reset the layouts on the current workSpace to default",
  "mod-n            Resize/refresh viewed windows to the correct size",
  "",
  "-- move focus up or down the window stack",
  "mod-Tab        Move focus to the next window",
  "mod-Shift-Tab  Move focus to the previous window",
  "mod-j          Move focus to the next window",
  "mod-k          Move focus to the previous window",
  "mod-m          Move focus to the master window",
  "",
  "-- modifying the window order",
  "mod-Return   Swap the focused window and the master window",
  "mod-Shift-j  Swap the focused window with the next window",
  "mod-Shift-k  Swap the focused window with the previous window",
  "",
  "-- resizing the master/slave ratio",
  "mod-h  Shrink the master area",
  "mod-l  Expand the master area",
  "",
  "-- floating layer support",
  "mod-t  Push window back into tiling; unfloat and re-tile it",
  "",
  "-- increase or decrease number of windows in the master area",
  "mod-comma  (mod-,)   Increment the number of windows in the master area",
  "mod-period (mod-.)   Deincrement the number of windows in the master area",
  "",
  "-- quit, or restart",
  "mod-Shift-q  Quit xmonad",
  "mod-q        Restart xmonad",
  "mod-[1..9]   Switch to workSpace N",
  "",
  "-- Workspaces & screens",
  "mod-Shift-[1..9]   Move client to workspace N",
  "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
  "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
  "",
  "-- Mouse bindings: default actions bound to mouse events",
  "mod-button1  Set the window to floating mode and move by dragging",
  "mod-button2  Raise the window to the top of the stack",
  "mod-button3  Set the window to floating mode and resize by dragging"
  ]
