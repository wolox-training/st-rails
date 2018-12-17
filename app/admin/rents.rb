ActiveAdmin.register Rent do
  permit_params :user_id, :book_id, :start_date, :end_date
end
