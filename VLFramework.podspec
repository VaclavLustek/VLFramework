#
# Be sure to run `pod lib lint VLFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VLFramework"
  s.version          = "0.1.1"
  s.summary          = "Custom framework to simplify iOS programming. Contains UI, convenience and network classes."

  s.homepage         = "https://github.com/VaclavLustek/VLFramework"
  s.license          = 'MIT'
  s.author           = { "Václav Luštěk" => "lustek@email.cz" }
  s.source           = { :git => "https://github.com/VaclavLustek/VLFramework.git", :branch => "master", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'VLFramework' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
