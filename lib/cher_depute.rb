require 'dotenv'
require 'pry'
require 'nokogiri' 
require 'open-uri'  

def get_deputy_email(deputy_url)
	deputy_page = Nokogiri::HTML(open(deputy_url))
	deputy_page.xpath("//*[@id=\"b1\"]/ul[2]/li[1]/ul/li[1]/a").each do |node|
	  return node.text
	end
end

def get_deputy_list 
	deputy_list = []
	deputy_list_page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
	deputy_list_page.xpath("//tr/td/a/div/span[2][@class=\"list_nom\"]").each do |node|
		deputy = node.text.gsub("\n","")
		while deputy[0] == " "
			deputy[0] = ""
		end
		while deputy[deputy.length-1] == " "
			deputy[deputy.length-1] = ""
		end
		deputy_list << deputy
	end
	return deputy_list
end

def split_first_and_last_names (deputy_list)
	(0...deputy_list.length).each do |index|
		splitted_name = deputy_list[index].split(', ', 2)
		deputy_list[index] = {"first_name" => splitted_name[0], "last_name" => splitted_name[1]}
	end
	return deputy_list
end

def deputy_to_url (deputy)
	deputy_url = "https://www.nosdeputes.fr/#{deputy["last_name"]}-#{deputy["first_name"]}".downcase
	deputy_url = deputy_url.gsub(/[éèëê]/, "e").gsub("à", "a").gsub("ï", "i").gsub("ç", "c").gsub("ù", "u").gsub(/[ôö]/, "o").gsub(/[ ']/, "-")
	return deputy_url
end

def perform	
	deputy_list = split_first_and_last_names(get_deputy_list)

	deputy_list.each do |deputy|
		begin
			deputy["email"] = get_deputy_email(deputy_to_url(deputy))
		rescue => e
			puts "email page not found for #{deputy}" 
			deputy["email"] = "?"
		end
	end

 	puts deputy_list
end

perform

