Gem::Specification.new do |s|
  s.name = 'striptease'
  s.version = '0.0.7'
  s.date = '2016-10-10'
  s.summary = 'Whitespace stripper dance party!'
  s.description = 'A simple library for stripping whitespace from model attributes'
  s.authors = ['Uncommon Branch']
  s.email = 'nick@uncommonbranch.com'
  s.files = `git ls-files | grep lib`.split("\n")
  s.homepage = 'https://github.com/UncommonBranch/striptease'
  s.license = 'MIT'
  s.add_runtime_dependency 'activerecord'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'sqlite3'
end
