class EncryptorService
  def initialize
    @crypt = ActiveSupport::MessageEncryptor.new("Aswertyuioasdfghjkqwertyuiqwerty")
  end

  def encrypt(subject)
    @crypt.encrypt_and_sign(subject)
  end

  def decrypt(subject)
    @crypt.decrypt_and_verify(subject)
  end
end
