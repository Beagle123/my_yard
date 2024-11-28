Gem::Specification.new do |s|
  s.name = "my_yard"  # i.e. visualruby.  This name will show up in the gem list.
  s.version = "0.0.8"  # i.e. (major,non-backwards compatable).(backwards compatable).(bugfix)
  s.add_dependency "visualruby", ">= 3.0.18"
  s.add_dependency "yard", "= 0.9.37"
  s.authors = ["Eric Cunningham"] 
  s.email = "Beagle4321_2000@yahoo.com" # optional
  s.summary = "Document your Ruby Scripts." # optional
  s.homepage = "http://www.yoursite.org/"  # optional
  s.description = "Full description here" # optional
  s.executables = ['my_yard']  # i.e. 'vr' (optional, blank if library project)
  s.bindir = ['.']    # optional, default = bin
  s.require_paths = ['lib']  # optional, default = lib 
  s.files = Dir.glob(File.join("**", "*.{rb,glade}"))
end
