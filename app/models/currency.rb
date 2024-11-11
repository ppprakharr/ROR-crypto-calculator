class Currency < ApplicationRecord
  def current_price
    # api_key = "f16a154a-06e1-4277-8a0f-1b0ca183cf38"
    # cur_symbol = Currency.where(slug: self.slug).pluck(:currency_symbol).first

    # # Step 1: Use the CoinMarketCap map API to get the currency ID
    # url_map = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/map"
    # headers = {
    #   "X-CMC_PRO_API_KEY" => api_key,
    #   "Accept" => "application/json"
    # }

    # query_map = { symbol: cur_symbol } # Use symbol to fetch the currency ID

    # # Send the API request for the currency ID
    # response_map = HTTParty.get(url_map, query: query_map, headers: headers)

    # if response_map.success?
    #   # Step 2: Get the currency ID from the response
    #   data_map = JSON.parse(response_map.body)["data"]
    #   if data_map.any?
    #     currency_id = data_map.first["id"]  # Fetch the first result's ID

    #     # Step 3: Now use this ID to fetch the latest price
    #     url_listings = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    #     query_listings = { id: currency_id }  # Use the currency ID to fetch price

    #     response_listings = HTTParty.get(url_listings, query: query_listings, headers: headers)

    #     if response_listings.success?
    #       data_listings = JSON.parse(response_listings.body)["data"]
    #       if data_listings.any?
    #         first_currency = data_listings.first  # Return the first currency
    #         first_currency  # You can return specific details like the price here
    #       else
    #         Rails.logger.error "No data found for the given currency ID."
    #         nil
    #       end
    #     else
    #       Rails.logger.error "Failed to fetch latest data: #{response_listings.body}"
    #       nil
    #     end
    #   else
    #     Rails.logger.error "No data found for the given symbol."
    #     nil
    #   end
    # else
    #   Rails.logger.error "Failed to fetch currency ID: #{response_map.body}"
    #   nil
    # end
    #

    url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
    api_key = "f16a154a-06e1-4277-8a0f-1b0ca183cf38"
    cur_symbol = Currency.where(slug: self.slug).pluck(:currency_symbol).first  # Assuming this is stored in your database

    query = { symbol: cur_symbol }  # Use symbol as a query parameter here

    headers = {
      "X-CMC_PRO_API_KEY" => api_key,
      "Accept" => "application/json"
    }

    # Send the API request
    response = HTTParty.get(url, query: query, headers: headers)

    if response.success?
      data = JSON.parse(response.body)["data"][cur_symbol]
      if data
        data["quote"]["USD"]["price"] # Return the entire response for the symbol, or just the price: data["quote"]["USD"]["price"]
      else
        Rails.logger.error "No data found for the given symbol."
        nil
      end
    else
      Rails.logger.error "Failed to fetch data: #{response.body}"
      nil
    end
  end

  def calculate_value(amount)
    Rails.logger.debug "Current Price: #{current_price.inspect}, Amount: #{amount}"
    current_price = self.current_price.to_f
    amount = amount.to_f
    (current_price* amount).round
  end
end
