local composer = require( "composer" )
local scene = composer.newScene()
local database = require('database')
--------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight
-- forward declaration
local background, pageText,podioGroup,scoreGroup
local alumnos = {}
local imagePath = "src/assets/"

local achievementsGroup
local playerAchievements

local logros = {}
local baseH = 150

local distance = 40



function backToMenu( e )
	
	if e.phase == "ended" or e.phase == "cancelled" then
		composer.gotoScene( "title"  )
	end
	return true
end

function compare(a,b)
	if a.score > b.score then
	  return a['score'] > b['score']
	elseif b.score < a.score then
		return b.score < a.score 
	elseif a.score == b.score then
		return a.competencia > b.competencia
	end
end




function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( sceneGroup, _W/2, _H/2, _W, _H )
	background:setFillColor( 0.42 )

	local backBbutton = display.newImage( sceneGroup,  imagePath.. "atras.png",50 ,50   )

	backBbutton:addEventListener( "touch", backToMenu )

	playerAchievements = display.newText( sceneGroup, "", _W/2, _H/10,"arial", 30  )
	playerAchievements:setFillColor( 0,24, 0.12, 0.86 )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	


	if phase == "will" then
		for i, v in pairs(event.params) do
			print(i,v)
		end
		playerAchievements.text = "Achievements for " .. event.params.name
	elseif phase == "did" then


		logros = database.getAchievements(event.params.id)

		table.sort( logros, compare )

		for i=1,#logros do
			print( "logros de " .. event.params.name )
			for k,v in pairs(logros[i]) do
				print(k,v)
			end

			local competencia = display.newText( sceneGroup, "Competencia " .. logros[i].competencia .. ": " .. logros[i].score, _W/8, baseH + (distance *i), "arial", 20,"left" )
			competencia.anchorX = 0

		end





	end


end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then

		
	elseif phase == "did" then

	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

