class UserMailer < ApplicationMailer

	def welcome_email(user)
		@user = user
		p "welcome_email @user :", @user
		mail(to: @user, subject: 'Welcome to Fulcrum')
	end
end
