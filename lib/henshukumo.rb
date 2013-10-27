require 'rubygems'
require 'editor'
require 'editsession'
require 'uri'
require 'sinatra'
require 'sinatra/config_file'

configure do
	config_file [ Dir.pwd, 'henshukumo.yml' ].join('/')
	set :auth, {}                    unless settings.respond_to? :auth
	set :auth, { 'username' => nil } unless settings.auth['username']
	set :auth, { 'password' => nil } unless settings.auth['password']
	Editor.editor_command = settings.editor_command if settings.respond_to? :editor_command
end

get '/' do
	"編集クモは生きている！\n"
end

before '/' do
	authenticate! if request.request_method == 'POST'
end

post '/' do
	param_url_host = params[:url].nil? ? nil : URI(params[:url]).host
	es = EditSession.new.start(param_url_host, request.body)
	content_type :text
	es.body.rewind
	es.body.read
end

helpers do
	def authenticate!
		return if settings.auth['username'].nil?
		return if settings.auth['password'].nil?
		return if authenticated?
		headers['WWW-Authenticate'] = 'Basic realm="Henshukumo"'
		halt 401, "Not authorized.\n"
	end

	def authenticated?
		@auth ||=  Rack::Auth::Basic::Request.new(request.env)
		@auth.provided? and \
			@auth.basic? and \
			@auth.credentials and \
			@auth.credentials == [ settings.auth['username'], settings.auth['password'] ]
	end
end
