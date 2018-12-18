class RentMailer < ApplicationMailer
  def new_rent_email
    @rent = Rent.find params[:rent_id]
    I18n.locale = @rent.user.locale
    mail(to: @rent.user.email, subject: I18n.t('rent_mailer.new_rent.subject'))
  end

  def expired_rent_email
    @rent = params[:rent]
    I18n.locale = @rent.user.locale
    mail(to: @rent.user.email, subject: I18n.t('rent_mailer.expired_rent.subject'))
  end
end
