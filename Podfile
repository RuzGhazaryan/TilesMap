# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'
 
use_frameworks!

workspace 'TilesMap'

target 'TilesMap' do
  # Pods for TilesMap
  pod 'Mapbox-iOS-SDK', '~> 6.3.0'
  
  target 'TilesMapTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TilesMapUITests' do
    # Pods for testing
  end

end

target 'DataSource' do
  project 'DataSource/DataSource.project'
end

target 'NetworkLayer' do
  project 'NetworkLayer/NetworkLayer.project'
end
