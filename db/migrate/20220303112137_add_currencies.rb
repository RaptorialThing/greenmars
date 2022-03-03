class AddCurrencies < ActiveRecord::Migration[7.0]
  def up
    currencies = ['RUR','RUB','USD','EUR','CNY','CNH','GBP','CHF','BTC','ETF','USDT','LTC']
    currencies.map{|e| Currency.create(label: e) }
  end

  def down
    Currency.delete_all
  end
end
