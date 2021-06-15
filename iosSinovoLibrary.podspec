#
# Be sure to run `pod lib lint iosSinovoLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iosSinovoLibrary'
  s.version          = '0.2.0'
  s.summary          = 'iosSinovoLibrary for ble and mqtt'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/konewu/iosSinovoLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'konewu' => '379301272@qq.com' }
  s.source           = { :git => 'https://github.com/konewu/iosSinovoLibrary.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'iosSinovoLibrary/Classes/**/*'
  
  s.vendored_frameworks = 'iosSinovoLibrary/Frameworks/iosSinovoLib.framework'
  
  # s.resource_bundles = {
  #   'iosSinovoLibrary' => ['iosSinovoLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'IotLinkKit', '~> 1.2.1'
  
  s.static_framework = true

end
