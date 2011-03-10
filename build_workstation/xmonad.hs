import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.EwmhDesktops

-- for mykeys
import XMonad.Actions.CopyWindow
import qualified Data.Map as M

-- fullscreen video
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
 
myManageHook = composeAll
-- Allows focusing other monitors without killing the fullscreen
  [ isFullscreen --> doFullFloat --(doF W.focusDown <+> doFullFloat)
 
-- Single monitor setups, or if the previous hook doesn't work
--    [ isFullscreen --> doFullFloat
    -- skipped
  ]

myKeys conf@(XConfig {XMonad.modMask = modm}) =
    [ ((modm .|. shiftMask, xK_c     ), kill1) -- @@ Close the focused window
    ] ++
    [ ((m .|. modm, k), windows $ f i) 
        | (i, k) <- zip (workspaces conf) [xK_1 ..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (copy, shiftMask .|. controlMask)]]

newKeys x = M.union (M.fromList (myKeys x)) (keys gnomeConfig x) 

main = xmonad $ ewmh gnomeConfig 
    { workspaces = ["a", "b", "c","com","mus", "util"]
    , keys       = newKeys
    --, modMask    = mod4Mask 
    , layoutHook = smartBorders $ layoutHook gnomeConfig -- Don't put borders on fullFloatWindows
    --, manageHook = myManageHook <+> manageHook gnomeConfig
    --, handleEventHook = fullscreenEventHook
}


