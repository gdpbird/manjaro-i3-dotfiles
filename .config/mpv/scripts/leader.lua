local mp = require 'mp' -- isn't actually required, mp still gonna be defined

local opts = {
  leader_key = ',',
  pause_on_open = false,
  resume_on_exit = "only-if-was-paused", -- another possible value is true
  hide_timeout = 2, -- timeout in seconds to hide menu
  which_key_show_delay = 0.1, -- timeout in seconds to show which-key menu
  strip_cmd_at = 28, -- max symbols for cmd names in which-key menu

  -- styles
  font_size = 21,
  menu_x_padding = 3, -- this padding for now applies only to 'left', not x
  which_key_menu_y_padding = 3,
}

(require 'mp.options').read_options(opts, mp.get_script_name())

package.path =
mp.command_native({ "expand-path", "~~/script-modules/?.lua;" }) .. package.path

local leader = require "leader"

leader:init(opts) -- binds leader key

mp.register_script_message("leader-bindings-request", function()
  leader:provide_leader_bindings()
end)

-- FIXME: need timeout below since we need all functions to be defined before
-- this script will run. Trying to call init() with this timeout won't work
-- since it's gonna pause loading of all other scripts.

-- another more reliable, but longer way to set leader bindings after all
-- scripts have loaded is to set a timer, threshold and set an observer on
-- 'input-bindings' mpv prop and run timer each time this prop gets updated. And
-- if timer passes threshold - run 'set_leader_bindings'

mp.add_timeout(0.3, function()
  leader:set_leader_bindings(
  -- key, name (must be unique!), comment, [follower bindings]

    {
--    +-----------+
--    | universal |
--    +-----------+
      { ':', 'M-x', 'execute-extended-command' }, -- script#m-x
      { ' ', 'script-binding Blackbox' },         -- script#blackbox
--    { 'c', 'script-binding Colorbox' },         -- script#colorbox
      { 't', 'script-binding clock-show-hide' },  -- script#clock
      { 'l', 'seek  1 exact' },
      { 'h', 'seek -1 exact' },
      { 'L', 'seek  5 exact' },
      { 'H', 'seek -5 exact' },
      { 'j', 'add volume -1' },
      { 'k', 'add volume  1' },
      { '[', 'multiply speed 1/1.1', 'decrease playback speed' },
      { ']', 'multiply speed 1.1', 'increase playback speed' },
      { '\\', 'set speed 1.0', 'reset speed to normal' },
      { 'q', 'quit-watch-later' },
      { 'd', 'script-message cycle-osd "script-message osc-visibility always" "set osd-level 1; script-message osc-visibility auto"' },

--    +----------+
--    | subtitle |
--    +----------+
      { 's', 'prefix', 'subtitle', {
        { 'p', 'cycle sub-visibility' },
        { 'e', 'cycle secondary-sub-visibility' },
        { 'j', 'add sub-pos -1' },
        { 'k', 'add sub-pos +1' },
        { 's', 'cycle secondary-sid; cycle sub' },
        { 'h', 'sub-seek -1' },
        { 'l', 'sub-seek  1' },
        { 'y', 'prefix', 'yank', {
          { 'p', 'script-binding copy-subtitle-primary' },     -- script#copy-subtitle
          { 'a', 'script-binding copy-subtitle-primary-ass' }, -- script#copy-subtitle
          { 'e', 'script-binding copy-subtitle-secondary' },   -- script#copy-subtitle
        } },
      } },

--    +--------+
--    | aspect |
--    +--------+
      { 'a', 'prefix', 'aspect', {
        { 'f', 'cycle fullscreen' },
        { 'k', 'cycle-values keepaspect "yes" "no"' },
        { 'o', 'cycle-values video-aspect-override "16:9" "4:3" "2.35:1" "-1"' },
      } },

--    +------+
--    | zoom |
--    +------+
      { 'z', 'prefix', 'zoom', {
        { 'k', 'add video-zoom 0.1' },
        { 'j', 'add video-zoom -0.1' },
        { 'i', 'set video-zoom 0' },
      } },

--    +------+
--    | yank |
--    +------+
      { 'y', 'prefix', 'yank', {
        { 'b', 'script-binding copy-filename-basename' },      -- script#copy-filename
        { 'a', 'script-binding copy-filename-absolute-path' }, -- script#copy-filename
        { 'r', 'script-binding copy-filename-relative-path' }, -- script#copy-filename
        { 't', 'script-binding copy-timestamp-formatted' },    -- script#copy-timestamp
        { 'w', 'script-binding copy-timestamp-raw' },          -- script#copy-timestamp
      } },

--    +------+
--    | loop |
--    +------+
      { 'o', 'prefix', 'loop', {
        { 's', 'script-binding ab-loop-set-sub' },   -- script#ab-loop-set-points
        { 'a', 'script-binding ab-loop-set-a' },     -- script#ab-loop-set-points
        { 'b', 'script-binding ab-loop-set-b' },     -- script#ab-loop-set-points
        { 'h', 'script-binding ab-loop-set-a-sub' }, -- script#ab-loop-set-points
        { 'l', 'script-binding ab-loop-set-b-sub' }, -- script#ab-loop-set-points
        { 'd', 'script-binding ab-loop-show' },      -- script#ab-loop-set-points
        { 'c', 'script-binding ab-loop-clear' },     -- script#ab-loop-set-points
        { 't', 'script-binding ab-loop-toggle' },    -- script#ab-loop-set-points
        { '[', 'script-binding ab-loop-seek-a' },    -- script#ab-loop-seek-points
        { ']', 'script-binding ab-loop-seek-b' },    -- script#ab-loop-seek-points
      } },

--    +------+
--    | play |
--    +------+
      { 'p', 'prefix', 'play', {
        { '?', 'script-binding play-before-long' },   -- script#play-before-and-after
        { '?', 'script-binding play-after-long' },    -- script#play-before-and-after
        { '?', 'script-binding play-before-medium' }, -- script#play-before-and-after
        { '?', 'script-binding play-after-medium' },  -- script#play-before-and-after
        { 'h', 'script-binding play-before-short' },  -- script#play-before-and-after
        { 'l', 'script-binding play-after-short' },   -- script#play-before-and-after
      } },

--    +-----+
--    | edl |
--    +-----+
      { 'e', 'prefix', 'edl', {
        { 'c', 'script-binding ab-loop-to-edl-segment-copy-path' },            -- script#ab-loop-to-edl-segment
        { 'C', 'script-binding ab-loop-to-edl-segment-copy-path-alternate' },  -- script#ab-loop-to-edl-segment
        { 'w', 'script-binding ab-loop-to-edl-segment-write-path' },           -- script#ab-loop-to-edl-segment
        { 'W', 'script-binding ab-loop-to-edl-segment-write-path-alternate' }, -- script#ab-loop-to-edl-segment
      } },

--    +-------+
--    | scale |
--    +-------+
      { 'S', 'prefix', 'scale', {
        { 'l', 'add video-scale-x  0.01', 'scale up video horizontally' },
        { 'i', 'add video-scale-y  0.01', 'scale up video vertically' },
        { ',', 'add video-scale-y -0.01', 'scale down video vertically' },
        { 'j', 'add video-scale-x -0.01', 'scale down video horizontally' },
        { 'k', 'set video-scale-x 1; set video-scale-y 1', 'reset video scale' },
      } },

--    +-----+
--    | pan |
--    +-----+
      { 'P', 'prefix', 'pan', {
        { 'm', 'add video-pan-x -0.01; add video-pan-y  0.01', 'move video left and down' },
        { ',', 'add video-pan-y  0.01'                       , 'move video down' },
        { '.', 'add video-pan-x  0.01; add video-pan-y  0.01', 'move video right and down' },
        { 'j', 'add video-pan-x -0.01'                       , 'move video left' },
        { 'k', 'set video-pan-x  0.00; set video-pan-y  0.00', 'reset video position' },
        { 'l', 'add video-pan-x  0.01'                       , 'move video right' },
        { 'u', 'add video-pan-x -0.01; add video-pan-y -0.01', 'move video left and up' },
        { 'i', 'add video-pan-y -0.01'                       , 'move video up' },
        { 'o', 'add video-pan-x  0.01; add video-pan-y -0.01', 'move video right and up' },
      } },

--    +-------+
--    | align |
--    +-------+
      { 'A', 'prefix', 'align', {
        { 'm', 'add video-align-x -0.01; add video-align-y  0.01', 'align video left and down' },
        { ',', 'add video-align-y  0.01',                          'align video down' },
        { '.', 'add video-align-x  0.01; add video-align-y  0.01', 'align video right and down' },
        { 'j', 'add video-align-x -0.01',                          'align video left' },
        { 'k', 'set video-align-x  0.00; set video-align-y  0.00', 'reset video alignment' },
        { 'l', 'add video-align-x  0.01',                          'align video right' },
        { 'u', 'add video-align-x -0.01; add video-align-y -0.01', 'align video left and up' },
        { 'i', 'add video-align-y -0.01',                          'align video up' },
        { 'o', 'add video-align-x  0.01; add video-align-y -0.01', 'align video right and up' },
      } },

--    +-----------+
--    |  playlist |
--    +-----------+
      { 'T', 'prefix', 'playlist', {
        { ' ', 'show-text ${playlist}', 'show the playlist' },
        { 'n', 'playlist-next', 'skip to the next file' },
        { 'p', 'playlist-previous', 'skip to the previous file' },
      } },

--    +---------+
--    | chapter |
--    +---------+
      { 'c', 'prefix', 'chapter', {
        { 'l', 'show-text ${chapter-list}' },
        { 'm', 'chapters-menu', 'open current video chapters' },
        { 'n', 'add chapter 1', 'seek to the next chapter' },
        { 'p', 'add chapter -1', 'seek to the previous chapter' },
      } },

--    +--------+
--    | filter |
--    +--------+
      { 'f', 'prefix', 'filter', {
        { 'c', 'add contrast 1' },
        { 'C', 'add contrast -1' },
        { 'b', 'add brightness 1' },
        { 'B', 'add brightness -1' },
        { 'g', 'add gamma 1' },
        { 'G', 'add gamma -1' },
        { 's', 'add saturation 1' },
        { 'S', 'add saturation -1' },
      } },

--    +-------+
--    | track |
--    +-------+
      { 't', 'prefix', 'track', {
        { 'l', 'show-text ${track-list}', 'show the list of video, audio and sub tracks' },
      } },

--    +-------+
--    | test |
--    +-------+
      { 'M', 'prefix', 'test', {
       { 's', 'script-binding shaders-rofi' }
      } },
    }
  )
end)
