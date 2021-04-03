class EditLock < ApplicationRecord
  belongs_to :lockable, polymorphic: true, touch: true
end
