$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'fish0/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'fish0'
  s.version     = Fish0::VERSION
  s.authors     = ['Dmitry Zuev']
  s.email       = ['d.zuev@rambler-co.ru']
  s.homepage    = 'https://github.com/rambler-digital-solutions/fish0'
  s.summary     = 'Plugin for read-only content websites'
  s.description = 'Plugin for read-only content websites with MongoDB storage.
                   Works perfect with Rambler&Co CQRS projects'
  s.license     = 'MIT'
  s.required_ruby_version = '~> 2.0'

  s.post_install_message = %(
  WARNING starting from 0.1.0 coercion is disabled for Fish0::Model by default
  )

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_runtime_dependency 'activesupport', '>= 4.2'
  s.add_runtime_dependency 'activerecord', '>= 4.2'
  s.add_runtime_dependency 'mongo', '~> 2.2'
  s.add_runtime_dependency 'virtus', '~> 1.0'

  s.add_development_dependency 'rubocop', '>= 0.35'
  s.add_development_dependency 'rspec', '>= 3.4'
  s.add_development_dependency 'rspec-rails', '>= 3.4'
  s.add_development_dependency 'capybara', '>= 2.7'
  s.add_development_dependency 'factory_girl_rails', '>= 4.7'
  s.add_development_dependency 'ffaker', '>= 2.2'
end
