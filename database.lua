module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight
local sqlite3 = require ("sqlite3")

--Path to store the db file
local pathsql="recursos.sqlite"
local path = system.pathForFile(pathsql, system.DocumentsDirectory)

local jugadores = "jugadores"
local competencias = "competencias"
local rendimiento = "rendimiento"

function createDatabase( )
	--Open the DB to create tables
	 db = sqlite3.open( path ) 
	 -- creacion de tablas

	 local table1 = "create table if not exists " .. jugadores .. "(id_jugador integer PRIMARY KEY AUTOINCREMENT, name VARCHAR(50), score integer(60) );"
	 local table2 = "create table if not exists " .. competencias .. "(id_competencia integer PRIMARY KEY AUTOINCREMENT, name VARCHAR(50) );"
	 local table3 = "create table if not exists " .. rendimiento .. "(id_rendimiento integer PRIMARY KEY AUTOINCREMENT, id_competencia integer, id_alumno integer, score integer(60) );"


	 db:exec( table1)
	 db:exec( table2)
	 db:exec( table3)

	 db:close()
end

function addParticipante( params )
	db = sqlite3.open( path ) 
	print(params)
	local query = "INSERT INTO " .. jugadores .. " (name, score) VALUES ('".. params.name .. "', " .. params.score .. ");"
	
	db:exec(query)
	print("executed")
	db:close()	
end


local participantes = {
	{name="Priscila Ando", score=0},
	{name="Valeria Succi", score=00},
	{name="Rosa Zambrana ", score=0},
	{name="Sergio Perez", score=1},
	{name="Sergio Bellot", score=2},
	{name="Sergio Marzana", score=1},
	{name="Paola Rivas", score=0},
	{name="Luis Choque", score=0}
}

local valoresCompetencias = {
	{'parcipacion'},
	{'puntualidad'},
	{'conocimientos_previos'},
	{'conocimientos_nuevos'},
	{'colaboracion'},
}


--createDatabase()


function insertarrCompetencias( param )
	db = sqlite3.open( path )
	print(param)
	local sql =  "INSERT into " .. competencias .. " (name) VALUES ('" ..param .." ')"
	db:exec(sql)
	db:close()
end

function cargarParticipantes(  )
	db = sqlite3.open( path ) 
	participantes = {}
	local query = "SELECT * FROM " .. jugadores .. ";"
	local k = 1
	print("starting look")
	for row in db:nrows(query) do
		print(row.name)
		participantes[k] = {id = row.id_jugador, name=row.name, score = row.score}
		k = k+1
	end

	db:close()	
	return participantes
end



function iniciarBaseDeDatos(  )
	for i=1,#participantes do
		addParticipante(participantes[i])
	end

	for i=1,#valoresCompetencias do
		print(valoresCompetencias[i][1])
		insertarrCompetencias(valoresCompetencias[i][1])
	end

end

function obtenerJugador( id )

	db = sqlite3.open( path ) 
	jugador = {}	

	local query = "SELECT * FROM " .. jugadores .. " WHERE id_jugador = " .. id .. ""; 

	for x in db:nrows(query) do
		jugador = {id_jugador = x.id_jugador, name = x.name, score = x.score}
	end
		
	db:close()
	return jugador
end

function actualizarScoreJugador( params )

	id = params.id
	db = sqlite3.open( path ) 
	local new_score = params.score
	local query = "UPDATE " .. jugadores  .. " SET score = " ..new_score .. " WHERE id_jugador = " .. id ..";"  

	db:exec(query)

	db:close()
end

function aumentarScoreJugador( params )

	id = params.id
	local jugador = obtenerJugador(id)
	db = sqlite3.open( path ) 
	local new_score = params.score + jugador.score

	local query = "UPDATE " .. jugadores  .. " SET score = " ..new_score .. " WHERE id_jugador = " .. id ..";"  

	db:exec(query)

	db:close()
end

function crearRendimiento(  )

	db = sqlite3.open( path ) 
		
	local query = "SELECT * FROM " .. jugadores ..";"	

	for row in db:nrows(query) do
		local id = row.id_jugador
		local query2 = "SELECT * FROM " .. competencias .. ""


	end


	db:close()

end



--iniciarBaseDeDatos()
