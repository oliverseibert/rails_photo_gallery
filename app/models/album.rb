class Album < ApplicationRecord
  has_many :shares
  has_many :photos
  belongs_to :user
  accepts_nested_attributes_for :shares
  accepts_nested_attributes_for :user
  attr_accessor :share_email
end
