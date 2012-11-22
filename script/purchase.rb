require "rubygems"
require "active_merchant"

ActiveMerchant::Billing::Base.mode = :test

gateway = ActiveMerchant::Billing::PaypalGateway.new(
  :login => "anniem_1353478568_biz_api1.gmx.fr",
  :password => "1353478623",
  :signature => "AE9O2aY63e-R2gqFe3NF-s2hDQ8KA0Lo4GoEppYGCnz8OzGvs41M51fa"
)

credit_card = ActiveMerchant::Billing::CreditCard.new(
  :brand              => "visa",
  :number             => "4024007148673576",
  :verification_value => "123",
  :month              => 1,
  :year               => Time.now.year+1,
  :first_name         => "Jean Pierre",
  :last_name          => "Muller"
)

if credit_card.valid?
  # or gateway.purchase to do both authorize and capture
  response = gateway.authorize(1000, credit_card, :ip => "127.0.0.1")
  if response.success?
    gateway.capture(1000, response.authorization)
    puts "Purchase complete!"
  else
    puts "Error: #{response.message}"
  end
else
  puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
end