class Activity < ApplicationRecord
  belongs_to :object, polymorphic: true
end
