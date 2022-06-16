class Form::Product < StockFood
  REGISTRABLE_ATTRIBUTES = %i(register user_id name expiration_date)
  attr_accessor :register
end