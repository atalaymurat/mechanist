class Machine < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  belongs_to :user
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: :all_blank

  
  def title
    [self.brand.name, self.model_type].join(" ")
  end

  def brand_name
    brand.try(:name)
  end

  def brand_name=(name)
    self.brand = Brand.find_or_create_by(name: name.downcase.chomp) if name.present?
  end

end

