# -*- encoding: utf-8 -*-
# stub: js-routes 0.9.6 ruby lib

Gem::Specification.new do |s|
  s.name = "js-routes"
  s.version = "0.9.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bogdan Gusiev"]
  s.date = "2013-02-13"
  s.description = "Generates javascript file that defines all Rails named routes as javascript helpers"
  s.email = "agresso@gmail.com"
  s.extra_rdoc_files = ["LICENSE.txt"]
  s.files = [".document", ".gitignore", ".rspec", ".travis.yml", "Appraisals", "Gemfile", "Guardfile", "LICENSE.txt", "Rakefile", "Readme.md", "app/assets/javascripts/js-routes.js.erb", "gemfiles/rails32.gemfile", "gemfiles/rails40.gemfile", "js-routes.gemspec", "lib/js-routes.rb", "lib/js_routes.rb", "lib/js_routes/engine.rb", "lib/js_routes/version.rb", "lib/routes.js", "lib/routes.js.coffee", "lib/tasks/js_routes.rake", "spec/config/routes.rb", "spec/js_routes/generated_javascript_spec.rb", "spec/js_routes/options_spec.rb", "spec/js_routes/rails_routes_compatibility_spec.rb", "spec/js_routes/zzz_last_post_rails_init_spec.rb", "spec/spec_helper.rb", "temp"]
  s.homepage = "http://github.com/railsware/js-routes"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.0"
  s.summary = "Brings Rails named routes to javascript"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.2"])
      s.add_development_dependency(%q<rspec>, [">= 2.14.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-coffeescript>, [">= 0"])
      s.add_development_dependency(%q<appraisal>, [">= 0.5.2"])
      s.add_development_dependency(%q<therubyracer>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.2"])
      s.add_dependency(%q<rspec>, [">= 2.14.0"])
      s.add_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-coffeescript>, [">= 0"])
      s.add_dependency(%q<appraisal>, [">= 0.5.2"])
      s.add_dependency(%q<therubyracer>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.2"])
    s.add_dependency(%q<rspec>, [">= 2.14.0"])
    s.add_dependency(%q<bundler>, [">= 1.1.0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-coffeescript>, [">= 0"])
    s.add_dependency(%q<appraisal>, [">= 0.5.2"])
    s.add_dependency(%q<therubyracer>, [">= 0"])
  end
end
