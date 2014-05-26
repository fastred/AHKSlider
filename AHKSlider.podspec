Pod::Spec.new do |s|
  s.name             = "AHKSlider"
  s.version          = "0.1.0"
  s.summary          = "UISlider subclass that improves the precision of selecting values."
  s.homepage         = "https://github.com/fastred/AHKSlider"
  s.license          = 'MIT'
  s.author           = { "Arkadiusz Holko" => "fastred@fastred.org" }
  s.source           = { :git => "https://github.com/fastred/AHKSlider.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.public_header_files = 'Classes/*.h'
end
