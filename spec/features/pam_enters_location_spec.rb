describe 'Home Page', :type => :feature do
  it 'allows Pam to enter her zipcode' do
    visit '/'
    expect(page).to have_css('#zipcode')
  end
end