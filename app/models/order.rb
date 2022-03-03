class Order < ApplicationRecord
    enum status: [:enabled,:disabled]
    enum process: [:sell,:buy]
    belongs_to :user 
    belongs_to :currency
end
