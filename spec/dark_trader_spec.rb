require_relative '../lib/dark_trader'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "the get names method" do
  it "should return the list of crypto names" do
    expect(get_names(page)).not_to be_nil
    expect(get_names(page)).to be_an_instance_of(Array)
    expect(get_names(page)).to include ("BTC")
  end
end

describe "the get prices method" do
  it "should return the list of crypto prices" do
    expect(get_prices(page)).not_to be_nil
    expect(get_prices(page)).to be_an_instance_of(Array)
  end
end

describe "the get final list method" do
  it "should return the list of crypto money with there prices" do
    expect(get_final_list(["BTC", "AZE", "POI"], ["$55.01", "$0.001", "$40.1"])).to eq([{"BTC" => "$55.01"}, {"AZE" => "$0.001"}, {"POI" => "$40.1"}])
    expect(get_final_list(get_names(page), get_prices(page))).to be_an_instance_of(Array)
    expect(get_final_list(get_names(page), get_prices(page))[0]).to be_an_instance_of(Hash)
  end
end

