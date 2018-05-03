require './require.rb'

@token = ENV['TOKEN_JENKINS']
@chat_id = ENV['ID_JENKINS']
@private = ENV['ID_PRIVATE']

@msg = MessageText.new
@db = Connection.new
@status = ConnectionStatus.new
@is_group = Group.new
@chat = Chat.new

bot_start = Telegram::Bot::Client.new(@token)
p 'jenkins online'
chat_id = @db.message_chat_id

chat_id.each do |id_grup|
  begin
    @status.online(@token, (id_grup['chat_id']).to_s, bot_start, '')
  rescue StandardError => e
    p id_grup['chat_id']
    bot_start.api.send_message(chat_id: @private, text: chat_not_found)
    puts e
  end
end

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      @txt = message.text
      next unless @txt # txt nil?
      @msg.read_text(@txt)

      if @is_group.not_private_chat?(message.chat.type)
        command = [
          '/deploy', '/lock', '/start', '/restart', '/stop', '/deployment',
          '/migrate', '/reindex', '/precompile', '/normalize', '/help'
        ]

        if command.include?(@msg.bot_name) || command.include?(@msg.booking_name)
          jenkins_group(@token, @chat_id, bot, message, @txt)
          @chat.delete(bot, message.chat.id, message.message_id)
        end
      else
        jenkins_private
      end
    end
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    puts e
    sleep(5)
    retry
  rescue Telegram::Bot::Exceptions::ResponseError => e
    puts telegram_error if e.error_code.to_s == '502'
    retry
  rescue StandardError => e
    chat_id = @db.message_chat_id

    chat_id.each do |id_grup|
      begin
        @status.offline(@token, (id_grup['chat_id']).to_s, bot, mention_admin)
      rescue StandardError => err
        bot.api.send_message(chat_id: @private, text: chat_not_found)
        puts err
      end
    end

    bot.api.send_message(chat_id: @private, text: send_off('jenkins'))
    raise e
  end
end
