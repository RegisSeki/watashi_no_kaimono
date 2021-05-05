class AuthenticationService
  HMAC_SECRET = Rails.application.credentials.token[:hmac_secret]
  ALGORITHM_TYPE = Rails.application.credentials.token[:algorithm_type]
  TOKEN_EXPIRATION_SECONDS = 86400

  def self.encode_token(user_id)
    encryptor_service = EncryptorService.new
    encrypted_user_id = encryptor_service.encrypt(user_id)
    encrypted_date = encryptor_service.encrypt(User.update_token_date(user_id))

    params = {
      id: encrypted_user_id,
      date: encrypted_date
    }

    JWT.encode params, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.authenticate_token(token)
    token_params = decode_token(token)

    encryptor_service = EncryptorService.new
    user_id = encryptor_service.decrypt(token_params[0]['id'])
    date = encryptor_service.decrypt(token_params[0]['date'])

    raise 'Token date is not valid!' unless token_date_is_valid?(date)
    raise 'User is not authenticated!' unless User.is_authenticated?(user_id, date)

    user_id
  end

  def self.refresh_token(token)
    authenticate_token(token)
    encode_token(obtain_user_id(token))
  end

  private

  def self.token_date_is_valid?(date)
    (date + TOKEN_EXPIRATION_SECONDS).to_s > Time.zone.now.to_s
  end

  def self.decode_token(token)
    JWT.decode token, HMAC_SECRET, true, { algorith: ALGORITHM_TYPE }
  end

  def self.obtain_user_id(token)
    encryptor_service = EncryptorService.new
    encryptor_service.decrypt(decode_token(token)[0]['id'])
  end
end
