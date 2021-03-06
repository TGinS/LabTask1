-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local stopBtn

local function onStopBtnRelease()
    -- go to stage scene
    composer.gotoScene( "menu", "fade", 500 )

    return true	-- indicates successful touch
end

function scene:create( event )

    -- Called when the scene's view does not exist.
    --
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

    local sceneGroup = self.view

    -- create a grey rectangle as the backdrop
    local background = display.newRect( 0, 0, screenW, screenH )
    background.anchorX = 0
    background.anchorY = 0
    background:setFillColor( 0.5 )

    -- create stopbtn
    -- create a widget button (which will loads level1.lua on release)
    stopBtn = widget.newButton{
        label="Stop",
        labelColor = { default={255}, over={128} },
        default="button.png",
        over="button-over.png",
        width=154, height=40,
        onRelease = onStopBtnRelease	-- event listener function
    }
    stopBtn.x = display.contentWidth*0.5
    stopBtn.y = display.contentHeight - 50

    -- make a crate (off-screen), position it, and rotate slightly
    local crate = display.newImageRect( "crate.png", 90, 90 )
    crate.x, crate.y = 160, 100

    -- all display objects must be inserted into group
    sceneGroup:insert( background )
    sceneGroup:insert( stopBtn )
    sceneGroup:insert( crate )
end


function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        --
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc.
        physics.start()
    end
end

function scene:hide( event )
    local sceneGroup = self.view

    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        physics.stop()
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end

end

function scene:destroy( event )

    -- Called prior to the removal of scene's "view" (sceneGroup)
    --
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc.
    local sceneGroup = self.view
    print("destroy")
    if stopBtn then
        stopBtn:removeSelf()	-- widgets must be manually removed
        stopBtn = nil
    end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene