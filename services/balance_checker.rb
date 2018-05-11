class BalanceChecker < Struct.new(:bank_name, :token, :pkey, :passphrase)
  @queue = :low

  SPLITER = ';PASSWORD{'

  def self.perform(*args)
    new(*args).perform
  end

  def perform
    bank.process!
    balance_diff = bank.balance.to_f - $redis.get(bank_name).to_f

    if balance_diff != 0
      LineNotify.notify message: "#{bank_name}\ntransaction value is #{balance_diff}\nbalance is #{bank.balance} THB"

      $redis.set bank_name, bank.balance.to_f
    end
  end

  private

    def bank
      @bank ||= Object.const_get(bank_name).new username, password
    end

    def decrypted_token
      @decrypted_token ||= private_key.private_decrypt(Base64.decode64 token)
    end

    def private_key
      @private_key ||= OpenSSL::PKey::RSA.new(pkey, passphrase)
    end

    def username
      @username ||= decrypted_token.split(SPLITER)[0]
    end

    def password
      @password ||= decrypted_token.split(SPLITER)[1]
    end
end
