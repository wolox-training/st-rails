class RentMailer < ApplicationMailer

  def new_rent_email
    @rent = params[:rent]
    mail(to: @rent.user.email, subject: 'New rent has been registered')
  end
end
