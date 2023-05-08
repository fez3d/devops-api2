class Book < ApplicationRecord
  validates :rating, :release, numericality: { only_integer: true }
  validates :rating, :release, :genre, :name, :publisher, presence: true
  after_validation :log_errors, :if => Proc.new {|m| m.errors}

  def log_errors
    Rails.logger.warn self.errors.full_messages.join("\n")
  end
end
