class User
  include ::RSpec::Matchers
  include Capybara::DSL

  def goes_to_home_page
    visit '/'
    expect(page).to have_css('.choose-grade-section')
  end

  def enters_her_zipcode
    expect(page).to have_field('zipcode')
    fill_in 'zipcode', with: 90401
  end

  def rates_local_air_quality
    expect(page).to have_content('What does the air quality feel like today?')
    choose('user-aqg-F')
  end

  def clicks_see_what_the_epa_says
    click_on 'Compare Now'
    expect(page).to have_css('.compare-section')
  end

  def sees_her_city_name
    expect(find('#city-name')).to have_content(/[A-Za-z ]+/)
  end

  def sees_her_air_quality_grade_vs_the_epas_air_quality_grade
    expect(page).to have_css('#user-aqg')
    expect(find('.compare-you')).to have_css('.grade-a,.grade-b,.grade-c,.grade-d,.grade-e,.grade-f')

    expect(page).to have_css('#epa-aqg')
    expect(find('.compare-epa')).to have_css('.grade-a,.grade-b,.grade-c,.grade-d,.grade-e,.grade-f')
  end

  def sees_air_quality_grade_gradient_with_her_and_the_epas_grades
    within(:css, '#grade-gradient') do
      expect(find('.pins')).to have_css('.you-pin')
      expect(find('.pins')).to have_css('.epa-pin')
    end
  end

  def sees_top_pollutants_contributing_to_aqi_grade
    expect(find('.parameters-section')).to have_content('Ground-Level Ozone')
    expect(find('.parameters-section')).to have_content('Coarse Dust Particles')
    expect(find('.parameters-section')).to have_content('Fine Particles')
    expect(find('.parameters-section')).to have_content('Carbon Monoxide')
    expect(find('.parameters-section')).to have_content('Sulfur Dioxide')
    expect(find('.parameters-section')).to have_content('Nitrogen Dioxide')
  end
end


describe 'Pam gets perspective', :type => :feature do
  let(:pam) { User.new }
  it 'by specifying her location and seeing what the actual air quality is' do
    pam.goes_to_home_page
    pam.enters_her_zipcode
    pam.rates_local_air_quality
    pam.clicks_see_what_the_epa_says

    pam.sees_her_city_name
    pam.sees_her_air_quality_grade_vs_the_epas_air_quality_grade
    pam.sees_air_quality_grade_gradient_with_her_and_the_epas_grades
    pam.sees_top_pollutants_contributing_to_aqi_grade
  end
end