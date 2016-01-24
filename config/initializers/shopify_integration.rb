api_key = ENV['SHOPIFY_API_KEY']
password = ENV['SHOPIFY_PASSWORD']
shop_name = ENV['SHOPIFY_SHOP_NAME']
shop_url = "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin"

ShopifyAPI::Base.site = shop_url
