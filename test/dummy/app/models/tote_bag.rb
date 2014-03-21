class ToteBag < ActiveRecord::Base
  include BirdOnIt

  validates :colour, presence: true
end
