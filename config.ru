require 'sinatra'
require 'sinatra/reloader' if development?

require_relative './controllers/recipe_controller.rb'

use Rack::MethodOverride

run RecipeController 