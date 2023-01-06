class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @channel = Channel.new
    @channels = Channel.public_channels

    @channel_name = get_name(@user, current_user)
    @single_channel = Channel.where(name: @channel_name).first || Channel.create_private_channel([@user, current_user], @channel_name)

    @message = Message.new
    @messages = @single_channel.messages.order(created_at: :asc)

    render 'channels/index'
  end

    private

    def get_name(user1, user2)
      user = [user1, user2].sort
      "private_#{user[0].id}_#{user[1].id}"
    end
end
