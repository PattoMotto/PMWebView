#
# Be sure to run `pod lib lint PMWebView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PMWebView'
  s.version          = '0.1.0'
  s.summary          = 'Full screen web view with touch through'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Full screen web view that popup only when DOM generated, does not block user due to while loading if user touch or got http error or timeout this web view will disappear'

  s.homepage         = 'https://github.com/PattoMotto/PMWebView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'PattoMotto'
  s.source           = { :git => 'https://github.com/PattoMotto/PMWebView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/PattoMotto'

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  s.source_files = 'PMWebView/Classes/**/*'

  # s.resource_bundles = {
  #   'PMWebView' => ['PMWebView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
