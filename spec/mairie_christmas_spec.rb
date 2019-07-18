require_relative '../lib/mairie_christmas'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

describe "the get townhall list and url method" do
  it "should return the list of townhalls and the url of there pages" do
    expect(get_townhall_list_and_url).not_to be_nil
    expect(get_townhall_list_and_url).to be_an_instance_of(Array)
    expect(get_townhall_list_and_url[0]).to be_an_instance_of(Array)
  end
end

describe "the get townhall email method" do
  it "should return the email of the townhall" do
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/ableiges.html")).to eq("mairie.ableiges95@wanadoo.fr")
  end
end

describe "the get email list method" do
  it "should return the list of towns and emails" do
    expect(get_email_list).not_to be_nil
    expect(get_email_list).to be_an_instance_of(Array)
    expect(get_email_list[1]).to be_an_instance_of(Hash)
  end
end
