class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks 

  validates :name, :ticker,  presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
                                  publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
                                  secret_token: 'sk_172404201627431f8f7848cf14816f98',
                                  endpoint: 'https://cloud.iexapis.com/v1'
                                )
    #return client.price(ticker_symbol) non funziona per colpa delle policy del sito
    #return rand(1.5..9999.0)
    begin
      new(ticker:ticker_symbol ,name: 'GreeMm Team',last_price:rand(1.5..9999.0))
    rescue => exception 
      return nil 
    end 

  end

  def self.check_db(ticker_symbol)
    return where(ticker: ticker_symbol).first
  end


end
