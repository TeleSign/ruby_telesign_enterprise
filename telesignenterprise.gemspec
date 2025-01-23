Gem::Specification.new do |s|
  s.name =                  'telesignenterprise'
  s.version =               '2.3.1'
  s.add_runtime_dependency  'telesign', '~> 2.2.3'
  s.licenses =              ['MIT']
  s.date =                  '2017-05-02'
  s.summary =               'TeleSign Enterprise Ruby SDK'
  s.description =           'TeleSign Enterprise Ruby SDK'
  s.authors =               ['TeleSign']
  s.email =                 'support@telesign.com'
  s.files =                 Dir['lib/**/*rb']
  s.homepage =              'http://rubygems.org/gems/telesign'

  s.add_development_dependency 'rake',      '~> 13.2'
  s.add_development_dependency 'uuid',      '~> 2.3'
  s.add_development_dependency 'mocha',     '~> 2.7'
  s.add_development_dependency 'webmock',   '~> 3.24'
  s.add_development_dependency 'codecov',   '~> 0.6.0'
  s.add_development_dependency 'simplecov', '~> 0.22.0'
  s.add_development_dependency 'test-unit', '~> 3.6'
end
