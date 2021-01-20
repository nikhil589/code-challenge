class Company < ApplicationRecord
  attr_accessor :details
  has_rich_text :description

  validates_with EmailValidator
  validate :is_valid_zip_code?

  before_save :save_zip_code_details

  # Method to validate if it's a valid zip code
  def is_valid_zip_code?
    self.details = ZipCodes.identify(self.zip_code)
    self.errors.add(:zip_code,"Invalid Zip Code") unless details.present?
  end

  # Method to save city and state details 
  def save_zip_code_details
    self.city = details[:city]
    self.state = details[:state_name]
  end


end
