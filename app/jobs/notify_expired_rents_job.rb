class NotifyExpiredRentsJob
  include Sidekiq::Worker

  def perform
    Rent.ending_today.find_each do |rent|
      notify_expried_rent(rent)
    end
  end

  private

  def notify_expried_rent(rent)
    RentMailer.with(rent_id: rent.id).expired_rent_email.deliver_later
  end
end
