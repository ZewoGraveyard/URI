Pod::Spec.new do |s|
  s.name = 'URI'
  s.version = '0.1'
  s.license = 'MIT'
  s.summary = 'URI (RFC 3986) for Swift 2 (Linux ready)'
  s.homepage = 'https://github.com/Zewo/URI'
  s.authors = { 'Paulo Faria' => 'paulo.faria.rl@gmail.com' }
  s.source = { :git => 'https://github.com/Zewo/URI.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'URI/**/*.swift'

  s.requires_arc = true
end