class EncryptorService
  ENCRYPTOR_KEY = Rails.application.credentials.encryptor_key

  def initialize
    @crypt = ActiveSupport::MessageEncryptor.new(ENCRYPTOR_KEY)
  end

  def encrypt(subject)
    @crypt.encrypt_and_sign(subject)
  end

  def decrypt(subject)
    @crypt.decrypt_and_verify(subject)
  end
end
