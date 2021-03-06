module Bot
  class Command
    # menyambut seseorang yang baru pertama kali japri bot
    class WelcomeText < Command
      def check_text
        bot_start if @txt == '/start'
      end

      def bot_start
        @bot.api.send_message(chat_id: @message.from.id, text: welcome_text(@firstname))
      rescue StandardError => e
        @bot.api.send_message(chat_id: ENV['ID_PRIVATE'], text: blocked_bot(@username))
        raise e
      end
    end
  end
end
