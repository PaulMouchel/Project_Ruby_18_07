require 'dotenv'
#require 'pry'
require 'nokogiri' 
require 'open-uri'  

def get_names(page)
	ary_names = []
	page.xpath("//tbody/tr/td[3]").each do |node|
	  ary_names << node.text
	end
	return ary_names
end

def get_prices(page)
	ary_prices = []
	page.xpath("//tbody/tr/td[5]/a").each do |node|
	  ary_prices << node.text
	end
	return ary_prices
end

def get_final(names, prices)
	ary_final = []
	(0...names.length).each do |index|
		begin
			ary_final [index] = {names[index] => prices[index]}
		rescue => e
			puts "Oups petite erreur, mais c'est pas grave" #résultat que tu veux voir en lieu et place d'une erreur terminal
		end
	end
	return ary_final
end

def perform	
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

	ary_final = get_final(get_names(page), get_prices(page))

	puts ary_final
end

perform
