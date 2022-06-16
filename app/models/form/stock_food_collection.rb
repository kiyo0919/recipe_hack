class Form::StockFoodCollection < Form::Base
  DEFAULT_ITEM_COUNT = 5
  attr_accessor :stock_foods

  def initialize(attributes = {})
    super attributes
    self.stock_foods = DEFAULT_ITEM_COUNT.times.map { Form::StockFood.new } unless stock_foods.present?
  end

  def stock_foods_attributes=(attributes)
    self.stock_foods = attributes.map do |_, stock_food_attributes|
      Form::StockFood.new(stock_food_attributes).tap { |v| v.availability = false }
    end
  end

  def valid?
    valid_stock_foods = target_stock_foods.map(&:valid?).all?
    super && valid_stock_foods
  end

  def save
    return false unless valid?
    StockFood.transaction { target_stock_foods.each(&:save!) }
    true
  end

  def target_stock_foods
    self.stock_foods.select { |v| value_to_boolean(v.register) }
  end
end