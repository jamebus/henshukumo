class Editor

	EDITOR_COMMAND = ENV['HENSHUKUMO_EDITOR_COMAMND'] || 'gvim -f'

	def self.run(filename)
		system *[ EDITOR_COMMAND.split(' '), filename ].flatten
	end

end
