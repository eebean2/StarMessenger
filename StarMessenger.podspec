#
# Be sure to run `pod lib lint StarMessenger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StarMessenger'
  s.version          = '0.1.0'
  s.summary          = 'Everything needed for a messaging app in one place.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Everything needed for a message app in one place. Inlcuding in-app notifications, view controller, message tracking, and more!
                        DESC

  s.homepage         = 'https://github.com/eebean2/StarMessenger'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Erik' => 'owner@yourrepairnow.com' }
  s.source           = { :git => 'https://github.com/eebean2/StarMessenger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'StarMessenger/Classes/**/*'

  s.resource_bundles = {
    'StarMessenger' => ['StarMessenger/**/*.{xib,png}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

