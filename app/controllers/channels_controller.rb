class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @channel = Channel.new
    @channels = Channel.public_channels

    @users = User.all_except(current_user)
    render 'index'
  end

  def show
    @single_channel = Channel.find(params[:id])

    @channel = Channel.new
    @channels = Channel.public_channels

    @message = Message.new
    @messages = @single_channel.messages.order(created_at: :asc)

    @users = User.all_except(current_user)

    render 'index'
  end

  def create
    @channel = Channel.create(name: params["channel"]["name"])
  end
end
