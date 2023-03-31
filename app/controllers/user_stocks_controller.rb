class UserStocksController < ApplicationController

  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end

    @user_stock = UserStock.create(user: current_user,stock: stock )
    flash[:notice]= "Stock #{stock.name} è stato aggiunto al tuo portfolio"
    redirect_to my_portfolio_path
    

  end

  def destroy
    stock = Stock.find(params[:id])
    user_stocks = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stocks.destroy
    flash[:notice] = "#{stock.ticker} was successfully remove from portfolio"
    redirect_to my_portfolio_path
  end

end
