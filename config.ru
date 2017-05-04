# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

require 'rack/cors'

use Rack::Cors do
  allow do
    origins 'http://localhost:3000/', 'https://yttd.herokuapp.com/'
    resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :patch, :options, :head]
  end
end
