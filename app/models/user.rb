class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol) #cerco se già esistena db
    return false unless stock #se non esiste restituisco false
    stocks.where(id: stock.id).exists? #a questo punto restituisce vero se è già associato o false se non lo è
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name 
    "Anonymous"
  end

end
