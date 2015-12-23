describe 'City Detail Page', :type => :feature do
  it 'shows Pam the AQI score for her location' do
    visit "/"
    expect(page).to have_field('zipcode')
    zipcode = 90401
    fill_in 'zipcode', with: zipcode
    click_on 'Submit'

    expect(page).to have_css('#aqi-grade')
    expect(find('#aqi-grade')).to have_content(/[A-F]/)
  end
end