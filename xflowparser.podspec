#
# Be sure to run `pod lib lint xflowparser.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "xflowparser"
  s.version          = "0.0.1"
  s.summary          = "A short description of xflowparser."
  s.description      = <<-DESC
                       An optional longer description of xflowparser

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/xflowapp/xflowparser"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Mohammed O. Tillawy" => "tillawy@gmail.com" }
  s.source           = { :git => "https://github.com/xflowapp/xflowparser.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/xflowapp'

  s.platform     = :osx
  s.osx.deployment_target = '10.9'

  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*.png'

  #s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'RegExCategories', '~> 1.0'
end
