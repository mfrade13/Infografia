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
local imagePath = "src/assets/"


local first,second,third, first_mame, second_name, third_name
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

	local gradient = {
    type="gradient",
    color1={ 1, 0.8, 1 }, color2={ 0.2, 0.1 , 0.2 }, direction="down"
	}
	-- display a background image
--	background = display.newImageRect( sceneGroup, "cover.jpg", display.contentWidth, display.contentHeight )
	background = display.newRect(0,0,_W,_H)
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	background:setFillColor(0.45,0.25,012,0.43)
--	background:setFillColor(gradient)
		sceneGroup:insert( background )


	local titulo = display.newText(sceneGroup, "INFOGRAFIA", _W/2,_H/4,system.nativeFont, 50 ) 
	titulo:setTextColor(gradient)

	local encabezado = display.newRect(sceneGroup, 150,inicioTablaY ,220,30)
	encabezado:setFillColor(0)
	encabezado:setStrokeColor(1)
	encabezado.strokeWidth=3
	local texto = display.newText(sceneGroup,"ALUMNO", 150,inicioTablaY,"arial",20)
	texto:setFillColor(1,0,0)
	
	local box2 = display.newRect(sceneGroup, 150+encabezado.x, inicioTablaY ,80,30)
	box2.originX = 0
	box2:setFillColor(0)
	box2:setStrokeColor(1)
	box2.strokeWidth=3
	local score = display.newText(sceneGroup, "Puntaje", box2.x, inicioTablaY,"arial",20)
	score:setFillColor(1,0,0)


	local podio = display.newLine(sceneGroup, _W/2 -50, _H/2+80, _W/2+100, _H/2+80)
	podio:append(_W/2+100,_H/2, _W/2+250,_H/2,_W/2+250,_H/2+100,_W/2+400,_H/2+100)
	podio:append(_W/2+400,_H/2+240,_W/2 - 50,_H/2+240,_W/2 -50,_H/2+80 )
	podio:setStrokeColor(1)
	podio.strokeWidth = 3

	first = display.newImageRect(sceneGroup, imagePath.. "oro.png", 150, 150)
	first.x = _W/2+ 175
	first.y = _H/2 + 80

	second = display.newImageRect(sceneGroup, imagePath.. "plata.png", 140, 140)
	second.x = _W/2+ 30
	second.y = _H/2 + 160

	third = display.newImageRect(sceneGroup, imagePath.. "Bronce.png", 120, 120)
	third.x = _W/2+ 330
	third.y = _H/2 + 180


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