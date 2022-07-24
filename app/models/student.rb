class Student < ApplicationRecord
  belongs_to :instructor

  validates :name, presence:true
  validates :age, exclusion: 0..17
end
