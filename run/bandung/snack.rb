require './require.rb'

@token = ENV['TOKEN_REMINDER']
@chat_id = ENV['ID_REMINDER']
@private = ENV['ID_PRIVATE']

@status = ConnectionStatus.new
@today = Bot::TodayWeather.new
@msg = MessageText.new
@is_group = Group.new
@chat = Chat.new
@is_user = User.new
@dday = Day.new
@db = Connection.new
@send = SendMessage.new

bot_start = Telegram::Bot::Client.new(@token)
@status.online(@token, @chat_id, bot_start, msg_weather(@today.weather, @today.poem))

Telegram::Bot::Client.run(@token) do |bot|
  begin
    bot.listen do |message|
      new_member(message, bot) # new member is coming
      left_member(message, bot) # member is left

      case message
      when Telegram::Bot::Types::CallbackQuery
        case message.data
        when 'wtb', 'dana', 'art', 'core', 'disco', 'bandung', 'email'
          @is_user.spammer?(bot, @chat_id, message.from.username, message, message.data)
          check_data(@token, @chat_id, bot, message, message.data) if @is_user.spam == false
        when 'mon', 'tue', 'wed', 'thu', 'fri'
          @dday.read_day(message.data)
          @count_schedule = @db.snack_schedule(message.data)
          amount = @count_schedule.count

          @array = []
          @count_schedule.each { |row| @array.push(row['name']) }

          @name = @array.to_s.gsub('", "', "\n").delete('["').delete('"]')
          @send.day_schedule(message.from.id, @dday.day_name, @name, amount)
          bot.api.send_message(@send.message)
        end
      when Telegram::Bot::Types::Message
        @txt = message.text
        next unless @txt # txt nil?
        @msg.read_text(@txt)

        if @is_group.not_private_chat?(message.chat.type)
          command = [
            '/add', '/edit', '/delete', '/reminder', '/cancel', '/done', '/holiday', '/normal', '/change', '/hi5',
            "/help@#{ENV['BOT_REMINDER']}"
          ]

          if command.include?(@msg.bot_name) || command.include?(@msg.booking_name) || command.include?(@msg.command)
            snack_group(@token, @chat_id, bot, message, @txt)
            @chat.delete(bot, message.chat.id, message.message_id)
          end
        else
          snack_private(@token, message.from.id, bot, message, @txt)
        end
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
    @status.offline(@token, @chat_id, bot, mention_admin('snack'))
    bot.api.send_message(chat_id: @private, text: send_off('snack'))
    raise e
  end
end
