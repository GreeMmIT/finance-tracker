class StocksController < ApplicationController

  def search
    if params[:stock].present? #controlla se ci sono parametri validi! se seono presenti
      @stock = Stock.new_lookup(params[:stock]) 
      if @stock 
        respond_to do |format|
          format.js{ render  partial: 'users/result'} # <- qua richiama un file js che rappresenta un partial della pagina
        end
        #render 'users/my_portfolio' <---- qui ricarica tutta la pagina
      else  
        respond_to do |format|
          flash.now[:alert] = "Inserire symbolo valido"    
          format.js{ render  partial: 'users/result'} 
        end
        #redirect_to my_portfolio_path
      end 
    else
      respond_to do |format|
        flash.now[:alert] = "Inserire symbolo da cercare"
        format.js{ render  partial: 'users/result'} 
      end
      #redirect_to my_portfolio_path
    end 
  end

end

