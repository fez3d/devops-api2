class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  after_validation :log_errors, :if => Proc.new {|m| m.errors}

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def log_errors
    Rails.logger.warn self.errors.full_messages.join("\n")
  end
end