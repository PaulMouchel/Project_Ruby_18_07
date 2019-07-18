require 'dotenv'
require 'pry'
require 'nokogiri' 
require 'open-uri'  

def get_townhall_email(townhall_url)
	townhall_page = Nokogiri::HTML(open(townhall_url))
	townhall_page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |node|
	  return node.text
	end
end

def get_townhall_urls 
	town_list = []
	townhall_list_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	townhall_list_page.xpath("//td/p/a").each do |node|
	  town_list << node.text
	end
	return town_list
end

def town_to_url (town)
	town = town.gsub(" ", "-").downcase
	return "https://www.annuaire-des-mairies.com/95/#{town}.html"
end

def perform	
	town_list = get_townhall_urls
	email_list = []

	town_list.each do |town|
		begin
			email_list << {town => get_townhall_email(town_to_url(town))}
		rescue => e
			binding.pry
			puts "Townhall page not found for #{town}" 
		end
	end

 puts email_list
	# ary_final = get_final(get_names(page), get_prices(page))

	# puts ary_final
end

perform
