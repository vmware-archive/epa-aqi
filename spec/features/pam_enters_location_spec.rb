describe 'City Detail Page', :type => :feature do
  it 'shows Pam the AQI score for her location' do
    visit '/city_detail'
    expect(page).to have_css('#aqi-score')

    expect(find('#aqi-score')).to have_content(/\d{1,3}/)
  end
end