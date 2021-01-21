class EmailValidator < ActiveModel::Validator
 
  def validate(record)
    if record.email.present?
      unless is_valid_domain?(record.email)
        record.errors.add(:email, "Invalid Email! Should belongs to @getmainstreet domain")
      end
    end
  end

  private

  # Method to check if it's a valid domain
  def is_valid_domain?(obj)
    obj.to_s.match(/\b[A-Z0-9._%a-z\-]+@+getmainstreet.com\z/) == nil ? false : true
  end



end