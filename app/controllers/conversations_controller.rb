class ConversationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :concerned_user, only: [:show, :reply, :trash, :untrash]
  helper_method :mailbox, :conversation

  def index
    @unread     = mailbox.conversations({ read: false })
    @read_conv  = mailbox.conversations({ read: true, mailbox_type: 'not_trash' })
    @read = []
    @read_conv.each do |conv|
      @read.push(conv) unless conv.last_message.is_unread?(current_user)
    end
  end

  def create
    recipient_names = conversation_params(:recipients).split(',')
    recipients = User.where(name: recipient_names).all

    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def show
    conversation.mark_as_read(current_user)
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end

  def concerned_user
    begin
      if !conversation.is_participant?(current_user)
        flash[:alert] = "You do not have permission for this action"
        redirect_to :conversations
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You do not have permission for this action"
      redirect_to :conversations
    end
  end
end