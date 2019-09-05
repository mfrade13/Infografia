-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local database = require('database')
--------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight
-- forward declaration
local background, pageText
local alumnos = {}
-- Touch listener function for background object
local function onBackgroundTouch( self, event )
	if event.phase == "ended" or event.phase == "cancelled" then
		-- go to page1.lua scene
		composer.gotoScene( "page1", "slideLeft", 800 )		
		return true	-- indicates successful touch
	end
end

local inicioTablaY = 300

function compare(a,b)
  return a['score'] > b['score']
end


function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
--	background = display.newImageRect( sceneGroup, "cover.jpg", display.contentWidth, display.contentHeight )
	background = display.newRect(0,0,_W,_H)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	background:setFillColor(0.45,0.25,012,0.43)
	sceneGroup:insert( background )

	local titulo = display.newText(sceneGroup, "INFOGRAFIA", _W/2,_H/4,system.nativeFont, 50 ) 

	local encabezado = display.newRect(sceneGroup, 150,inicioTablaY ,220,30)
	encabezado:setFillColor(0)
	encabezado:setStrokeColor(1)
	encabezado.strokeWidth=3
	local texto = display.newText(sceneGroup,"Alumno", 150,inicioTablaY,"arial",20)
	texto:setFillColor(1,0,0)
	
	local box2 = display.newRect(sceneGroup, 150+encabezado.x, inicioTablaY ,80,30)
	box2.originX = 0
	box2:setFillColor(0)
	box2:setStrokeColor(1)
	box2.strokeWidth=3
	local score = display.newText(sceneGroup, "Puntaje", box2.x, inicioTablaY,"arial",20)
	score:setFillColor(1,0,0)

	-- Add more text
	
	-- all display objects must be inserted into group
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
		alumnos = database.cargarParticipantes()

		table.sort( alumnos, compare )
		for i = 1,#alumnos do
			print(alumnos[i])
			local box = display.newRect(sceneGroup, 150,inicioTablaY+(i*40) ,220,30)
			box:setFillColor(0)
			box:setStrokeColor(1)
			box.strokeWidth=3
			local name = display.newText(sceneGroup,"".. alumnos[i].name, 150,inicioTablaY +(i*40),"arial",20)
			name:setFillColor(1,0,0)
			local box2 = display.newRect(sceneGroup, 150+box.x,inicioTablaY+(i*40) ,80,30)
			box2.originX = 0
			box2:setFillColor(0)
			box2:setStrokeColor(1)
			box2.strokeWidth=3
			local score = display.newText(sceneGroup,"".. alumnos[i].score, box2.x, inicioTablaY +(i*40),"arial",20)
			score:setFillColor(1,0,0)
		end
		-- background.touch = onBackgroundTouch
		-- background:addEventListener( "touch", background )
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

		-- remove event listener from background
		background:removeEventListener( "touch", background )
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene