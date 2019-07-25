class Machine < ApplicationRecord
  mount_uploaders :images, ImageUploader
  belongs_to :brand
  belongs_to :category
  belongs_to :user

  
  def title
    [self.category.name, self.brand.name, self.model_type].join(" ")
  end
end

