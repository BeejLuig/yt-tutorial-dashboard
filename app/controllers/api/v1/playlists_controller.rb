class Api::V1::PlaylistsController < ApplicationController
  before_action :authenticate_token!, only: [:index, :create]

  def index

  end

  def create

  end
end
