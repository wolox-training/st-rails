class RentMailer < ApplicationMailer
  def new_rent_email
    @rent = Rent.find params[:rent_id]
    mail(to: @rent.user.email, subject: 'New rent has been registered')
  end
end
