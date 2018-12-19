ActiveAdmin.register Book do
  permit_params :title, :genre, :author, :image, :editor, :year
end
