return {
	on = {
		devices = {105},
	},
	execute = function(dz, device)
        os.execute('synologset1 sys info 0x11100000 "Ceci est un test de log pour montrer à Nath"')
	end
}