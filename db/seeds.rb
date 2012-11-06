# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

State.create([
  { :fips => 53, :name => 'Washington', :abbr => 'WA' },
  { :fips => 33, :name => 'New Hampshire', :abbr => 'NH' }
])

County.create([
  { :fips => 53033, :name => 'King', :state => State.find_by_fips(53) },
  { :fips => 33019, :name => 'Sullivan', :state => State.find_by_fips(33) }
])

Report.create([
  {
    :domain => 'performance',
    :name => 'Single Condition, Single Measurement',
    :thumbnail => 'single.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/measure/hc_measures.php'
  },
  {
    :domain => 'performance',
    :name => 'Single Condition, Single Measurement (Map)',
    :thumbnail => 'single_map.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/gis2/Umap.html'
  },
  {
    :domain => 'performance',
    :name => 'Single Condition, All Measures',
    :thumbnail => 'all_measures.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/scoreboardmeasure/ScoreBoardMeasure.php'
  },
  {
    :domain => 'performance',
    :name => 'All Conditions, All Measures',
    :thumbnail => 'all_conditions.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/scoreboardmeasure/ScoreBoardMeasure.php'
  },
  {
    :domain => 'performance',
    :name => 'All Conditions, Aggregate Measures',
    :thumbnail => 'all_conditions_aggregate.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/scoreboardcondition/ScoreBoardCondition.php'
  },
  {
    :domain => 'hcahps',
    :name => 'Patient Satisfaction Survey Results',
    :thumbnail => 'hcahps.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/hcahps/HCHCAHPS.html'
  },
  {
    :domain => 'medicare',
    :name => 'Medicare Volumes',
    :thumbnail => 'medicare.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/mpv/mpv_Template.htm'
  },
  {
    :domain => 'mortality',
    :name => 'Mortality Measures',
    :thumbnail => 'mortality.png',
    :description => 'Dummy description text',
    :url => 'http://qups.org/demo/hc/mortality/HCMortality.html'
  }
])