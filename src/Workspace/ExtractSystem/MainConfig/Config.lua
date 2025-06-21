local ServerConfig = {
	----------------------------------------------------------------------------------------------------
	-----------------=[ OVERALL ]=----------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	RaidTimer = true				-- Raid has a time limit?
	,TimeHours = 0
	,TimeMinutes = 30
	,TimeSeconds = 0
	,TimeBeforeExit = 0				-- Will players be given some time after the raid timer is up? (In seconds) (Set to 0 for no extra time)
	,RunThroughEnabled = true			-- Can players get a 'run-through' status for finishing the raid too early/with not enough EXP?
	,MaxExits = 5					-- How many exits can a player access per raid? (Does not affect exits with the 'Priority' value)
	
	
	
}

return ServerConfig
