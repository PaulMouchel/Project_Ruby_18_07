require_relative '../lib/cher_depute'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "the get deputy_url_list method" do
  it "should return the list of urls of deputy pages" do
    expect(get_deputy_url_list).not_to be_nil
    expect(get_deputy_url_list).to be_an_instance_of(Array)
		expect(get_deputy_url_list).to include ("https://www.nosdeputes.fr/francois-ruffin")
		get_deputy_url_list.size { is_expected.to_be = 577}
  end
end

describe "the get deputy_data method" do
  it "should return the first name, last name and email" do
    expect(get_deputy_data("https://www.nosdeputes.fr/francois-ruffin")).to eq({"first_name" => "François", "last_name" => "Ruffin", "email" => "francois.ruffin@assemblee-nationale.fr"})
  end
end
