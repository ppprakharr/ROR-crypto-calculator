class CurrenciesController < ApplicationController
  def index
  end

  def search
    # @currencies = Currency.where("LOWER(name) LIKE ?", "%{params[:search].downcase}%")
    # @currencies = Currency.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%")
    @currencies = Currency.where("LOWER(name) LIKE ?", "%#{params[:search].to_s.downcase}%")


    render json: { currencies: @currencies }
  end

  # takes in currency id and the amount own and returns the final calculations
  def calculate
    amount = params[:amount]
    Rails.logger.debug "Amount received: #{amount.inspect}"

  # Ensure amount is a number (extracting first element if it's an array)
  amount = amount.is_a?(Array) ? amount.first.to_f : amount.to_f
    render json: {
      currency: currency,
      current_price: currency.current_price,
      amount: amount,
      value: currency.calculate_value(amount)
    }
  end

  private
  def currency
    @currency ||= Currency.find(params[:id])
  end
end
