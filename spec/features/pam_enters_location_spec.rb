describe 'City Detail Page', :type => :feature do
  it 'shows Pam the AQI score for her location' do
    visit '/city_detail'
    expect(page).to have_css('#aqi-score')
    # next: contains 1-3 digits.
  end
end