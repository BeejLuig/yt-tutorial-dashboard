# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

require 'rack/cors'

use Rack::Cors do

  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://yt-tutorial-dashboard.herokuapp.com/',
              'http://localhost:3000/'
      resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :patch, :options, :head]
    end
  end
end
