require 'sinatra'
require 'sinatra/reloader' if development?

require_relative './controllers/post_controller.rb'

use Rack::MethodOverride

run PostsController 