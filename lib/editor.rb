class Editor

	@editor_command = 'gvim -f'

	def self.run(filename)
		system *[ self.editor_command.split(' '), filename ].flatten
	end

	class << self
		attr_accessor :editor_command
	end

end
