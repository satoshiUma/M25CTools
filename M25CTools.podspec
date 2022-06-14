#
# Be sure to run `pod lib lint M25CTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'M25CTools'
  s.version          = '0.1.0'
  s.summary          = '制作工具'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO:在这里添加对pod的详细描述。
                       DESC

  s.homepage         = 'https://github.com/satoshiUma/M25CTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'M25C' => 'matsonga@163.com' }
  s.source           = { :git => 'https://github.com/satoshiUma/M25CTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'M25CTools/Classes/**/*'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'M25CTools' => ['M25CTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
