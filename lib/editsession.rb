require 'editor'
require 'tempfile'

class EditSession

	def initialize
		@body = nil
	end

	def start(template, body)
		if template.nil?
			bodytempfile = Tempfile.new(self.class.name + '-')
		else
			bodytempfile = Tempfile.new(self.class.name + '-' + template + '-')
		end
		unless body.nil?
			body.rewind
			bodytempfile.syswrite body.read
		end
		Editor.run(bodytempfile.path)
		@body = bodytempfile
		self
	end

	attr_reader :body

end
