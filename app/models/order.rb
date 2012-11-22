class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :transactions, :class_name => "OrderTransaction"
  attr_accessor :card_number, :card_verification
  attr_accessible :address, :email, :name, :pay_type, :card_type, :card_number, :card_verification,:card_expires_on
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  validates :pay_type, :inclusion => PAYMENT_TYPES
  
  validate :validate_card, :on => :create
  
  
   def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
  
  def price_in_cents
    (total_price*100).round
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
  def add_line_items_from_cart(cart) 
    cart.line_items.each do |item|      item.cart_id = nil
      line_items << item    end 
  end
  
  private
  
   def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end
  
  
   def purchase_options
    {
      :ip => "127.0.0.0",
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :brand              => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => name,
      :last_name          => name
    )
  end
  
end
