require 'nokogiri' 
require 'open-uri'  

def get_deputy_url_list
	deputy_list_page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
	return deputy_list_page.xpath("//tr/td/a/@href").map{|node| "https://www.nosdeputes.fr#{node.text}"} #A modifier pour avoir tous les deputés
end

def get_deputy_data(url)
	deputy_page = Nokogiri::HTML(open(url))
	full_name = deputy_page.xpath("//*[@id=\"corps_page\"]/div/div[1]/div[1]/h1")[0].text
	split_name = full_name.split(" ")
	first_name = split_name.delete_at(0)
	last_name = split_name.join(" ")
	begin
		email = deputy_page.xpath("//*[@id=\"b1\"]/ul[2]/li[1]/ul/li[1]/a")[0].text
	rescue => e
		email = "Non renseigné"
	end
	return {"first_name" => first_name, "last_name" => last_name,"email" => email}
end

def get_deputy_data_list
	return get_deputy_url_list.map {|url| get_deputy_data(url)}
end

def perform	
	puts get_deputy_data_list
end

perform

