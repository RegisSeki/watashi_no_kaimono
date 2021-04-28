# test/mailers/previews/user_mailer_preview.rb

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def validation_email
    # Set up a temporary order for the preview
    user = User.new(username: 'Joe Smith', password: '123456')

    UserMailer.with(user: user).validation_email
  end
end
