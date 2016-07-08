Pod::Spec.new do |s|
  s.name                  = "Safe"
  s.version               = "1.2.0"
  s.summary               = "Modern Concurrency and Synchronization for Swift."
  s.homepage              = "https://github.com/tidwall/Safe"
  s.license               = { :type => "Attribution License", :file => "LICENSE" }
  s.source                = { :git => "https://github.com/tidwall/Safe.git", :tag => "1.2.0" }
  s.authors               = { 'Josh Baker' => 'joshbaker77@gmail.com' }
  s.social_media_url      = "https://twitter.com/tidwall"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.source_files          = "Source/*.swift"
  s.requires_arc          = true
  s.libraries             = 'z'
end
