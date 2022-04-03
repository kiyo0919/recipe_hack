namespace :task do
  desc "notification/1日1回動かす"
  task :notification => :environment do
    today = Date.today
    stock_foods = StockFood.all
    n = stock_foods.count
    today = Date.today
    stock_foods.each do |stock_food|
      user = stock_food.user
      if today + 3 == stock_food.expiration_date
        Notification.create(stock_food_id: stock_food.id, user_id: user.id, action: "warning")
      elsif stock_food.notification == nil && today > stock_food.expiration_date
        Notification.create(stock_food_id: stock_food.id, user_id: user.id, action: "expired")
      elsif stock_food.notification.present? && today > stock_food.expiration_date.to_date
        stock_food.notification.update(action: "expired")
      end
      n -= 1
      puts "残り#{n}/#{stock_foods.count}"
    end
  end
end
