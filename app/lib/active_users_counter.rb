require 'net/http'

class ActiveUsersCounter
  def self.add(username)
    username = prepare_data(username)

    if @users_list[username]
      @users_list[username] += 1
    else
      @users_list[username] = 1
    end
  end

  def self.remove(username)
    username = prepare_data(username)

    if @users_list[username] && @users_list[username] > 1
      @users_list[username] -= 1
    else
      @users_list.delete(username)
    end
  end

  def self.get
    @users_list&.keys
  end

  private

  def self.prepare_data(username)
    @users_list ||= {}
    username.to_s
  end
end
