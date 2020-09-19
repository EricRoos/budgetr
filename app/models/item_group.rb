class ItemGroup < ApplicationRecord
  belongs_to :project
  has_many :items
end
