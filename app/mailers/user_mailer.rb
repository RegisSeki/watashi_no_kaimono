class UserMailer < ApplicationMailer
  def validation_email
    @user = params[:user]

    mail(to: @user.email, subject: "You got a new order!")
  end
end
