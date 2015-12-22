describe 'City Detail Page', :type => :feature do
  it 'shows Pam the AQI score for her location' do
    zipcode = 90401
    visit "/city_detail?zipcode=#{zipcode}"

    expect(page).to have_css('#aqi-score')
    expect(find('#aqi-score')).to have_content(/\d{1,3}/)
  end
end