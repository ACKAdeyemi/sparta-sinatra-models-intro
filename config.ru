require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require_relative './models/Post.rb'
require_relative './controllers/posts_controller.rb'

# Middleware
use Rack::MethodOverride

run PostsController
