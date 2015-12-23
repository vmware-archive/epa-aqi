class User
  include ::RSpec::Matchers
  include Capybara::DSL

  def goes_to_home_page
    visit '/'
    expect(find('#page-title')).to have_text('Home Page')
  end

  def enters_her_zipcode
    expect(page).to have_field('zipcode')
    fill_in 'zipcode', with: 90401
  end

  def rates_local_air_quality
    expect(page).to have_content('What does the air feel like today?')
    choose('C')
  end

  def clicks_see_what_the_epa_says
    click_on 'Submit'
    expect(find('#page-title')).to have_text('City Detail')
  end

  def sees_her_air_quality_grade_vs_the_epas_air_quality_grade
    expect(page).to have_css('#user-aqg')
    expect(find('#user-aqg')).to have_content(/[A-F]/)

    expect(page).to have_css('#aqi-grade')
    expect(find('#aqi-grade')).to have_content(/[A-F]/)
  end
end


describe 'Pam gets perspective', :type => :feature do
  let(:pam) { User.new }
  it 'by specifying her location and seeing what the actual air quality is' do
    pam.goes_to_home_page
    pam.enters_her_zipcode
    pam.rates_local_air_quality
    pam.clicks_see_what_the_epa_says

    pam.sees_her_air_quality_grade_vs_the_epas_air_quality_grade
  end
end