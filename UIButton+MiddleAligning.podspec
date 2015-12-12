#
# Be sure to run `pod lib lint UIButton+MiddleAligning.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "UIButton+MiddleAligning"
  s.version          = "1.1.0"
  s.summary          = "An UIButton category for middle aligning imageView and titleLabel"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
#     s.description      = <<-DESC
#                          DESC

  s.homepage         = "https://github.com/hcbarry/MiddleAlignedButton"
  s.screenshots     = "https://raw.githubusercontent.com/hcbarry/MiddleAlignedButton/master/Demo.gif"
  s.license          = 'MIT'
  s.author           = { "Barry Lee" => "hcbarry@gmail.com" }
  s.source           = { :git => "https://github.com/hcbarry/MiddleAlignedButton.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.public_header_files = 'Pod/Classes/**/*.h'
end
