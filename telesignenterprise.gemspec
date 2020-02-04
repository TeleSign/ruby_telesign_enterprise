Gem::Specification.new do |s|
  s.name = 'telesignenterprise'
  s.version = '2.2.0'
  s.add_runtime_dependency 'telesign', '~> 2.2.3'
  s.licenses = ['MIT']
  s.date = '2017-05-02'
  s.summary = 'TeleSign Enterprise Ruby SDK'
  s.description = 'TeleSign Enterprise Ruby SDK'
  s.authors = ['TeleSign']
  s.email = 'support@telesign.com'
  s.files = Dir['lib/**/*rb']
  s.homepage = 'http://rubygems.org/gems/telesign'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'uuid'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'codecov'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'test-unit'
end
