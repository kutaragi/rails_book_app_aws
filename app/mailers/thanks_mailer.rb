class ThanksMailer < ApplicationMailer
	def complete_user(user)
		@user = user
		mail(to: @user.email, subject: "Complete!")
	end
end
