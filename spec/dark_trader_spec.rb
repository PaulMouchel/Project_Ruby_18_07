require_relative '../lib/dark_trader'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "the get names method" do
  it "should return the list of crypto names" do
    expect(get_names(page)).not_to be_nil
    expect(get_names(page)).class == Array
    #expect(get_names(page)).length > 10
  end
end