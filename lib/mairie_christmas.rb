#require 'pry'
require 'nokogiri' 
require 'open-uri'  

def get_townhall_email(townhall_url)
	townhall_page = Nokogiri::HTML(open(townhall_url))
	townhall_page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |node|
	  return node.text
	end
end

def get_townhall_list_and_url
	townhall_list_page = Nokogiri::HTML(open("https://annuaire-des-mairies.com/val-d-oise.html"))
	town_list = townhall_list_page.xpath("//td/p/a").map{|node| node.text}
	town_url = townhall_list_page.xpath("//td/p/a/@href").map{|node| "https://annuaire-des-mairies.com/#{node.text[2..-1]}"}
	return town_list.zip(town_url)
end

def get_email_list
	return get_townhall_list_and_url.map{|town, url| {town => get_townhall_email(url)}}
end

def perform	
 puts get_email_list
end

perform
