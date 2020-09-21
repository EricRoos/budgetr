class ItemGroup < ApplicationRecord
  belongs_to :project, touch: true
  has_many :items, dependent: :delete_all
  has_rich_text :note
end
