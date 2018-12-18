class NotifyExpiredRentsJob
  include Sidekiq::Worker

  def perform
    Rent.ending_today.find_in_batches do |rent_batch|
      rent_batch.each do |rent|
        notify_expried_rent(rent)
      end
    end
  end

  private

  def notify_expried_rent(rent)
    RentMailer.with(rent: rent).expired_rent_email.deliver_now
  end
end
