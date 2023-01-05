class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @channel = Channel.new
    @channels = Channel.public_channels

    @single_channel = Channel.find(params[:id])

    @users = User.all_except(current_user)
  end

  def create
    @channel = Channel.create(name: params["channel"]["name"])
  end
end
