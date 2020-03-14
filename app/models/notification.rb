class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true
end
