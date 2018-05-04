# default untuk send message bot
class SendMessage
  attr_reader :message
  def err_deploy_chat(chatid, user, stg, name)
    @message = {
      chat_id: chatid,
      text: error_deploy(user, stg, name),
      parse_mode: 'HTML'
    }
  end

  def err_deploy_from(fromid, user, stg, name)
    @message = {
      chat_id: fromid,
      text: error_deploy(user, stg, name),
      parse_mode: 'HTML'
    }
  end

  def empty_deploy(id, user)
    @message = {
      chat_id: id,
      text: empty_deployment(user)
    }
  end

  def check_new_staging(id, user, stg)
    @message = {
      chat_id: id,
      text: new_staging(user, stg),
      parse_mode: 'HTML'
    }
  end

  def queue_deployment(id, user, stg, branch, name, queue)
    @message = {
      chat_id: id,
      text: msg_queue_deploy(user, stg, branch, name, queue),
      parse_mode: 'HTML'
    }
  end

  def check_empty_staging(id, txt, user)
    @sendmessage = {
      chat_id: id,
      text: empty_staging(txt, user),
      parse_mode: 'HTML'
    }
  end
end
