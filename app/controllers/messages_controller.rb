class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(body: msg_params[:body], channel_id: params[:channel_id])
  end

  private

  def msg_params
    params.require(:message).permit(:body)
  end
end
