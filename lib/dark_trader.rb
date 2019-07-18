#require 'pry'
require 'nokogiri' 
require 'open-uri'  

def get_names(page)
	return page.xpath("//tbody/tr/td[3]").map{|node| node.text}
end

def get_prices(page)
	return (page.xpath("//tbody/tr/td[5]/a").map {|node| node.text.delete("$").to_f})
end

def get_final_list(names, prices)
	return (names.zip(prices).map{|k, v| {k => v}})
end

def perform	
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	puts get_final_list(get_names(page), get_prices(page))
end

perform
