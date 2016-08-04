Gem::Specification.new do |s|
  s.name = "my_yard"  # i.e. visualruby.  This name will show up in the gem list.
  s.version = "0.0.3"  # i.e. (major,non-backwards compatable).(backwards compatable).(bugfix)
  s.add_dependency "visualruby", ">= 3.0.20"
  s.add_dependency "yard", "= 0.9.0"
  s.has_rdoc = false
  s.authors = ["Eric Cunningham"] 
  s.email = "beagle4321_2000@yahoo.com" # optional
  s.summary = "Great GUI for generating docs with Yard." # optional
  s.homepage = "http://visualruby.net/"  # optional
  s.description = "This program offers a great way to generate docs with yard.  " +
    "It has a GUI so you don't need to use all the command line parameters.  " +
    "To see an example of the output, visit http://visualruby.net" 
  s.executables = ['my_yard']  # i.e. 'vr' (optional, blank if library project)
  s.default_executable = 'my_yard'  # i.e. 'vr' (optional, blank if library project)
  s.bindir = ['.']    # optional, default = bin
#  s.require_paths = ['lib']  # optional, default = lib 
  s.files = Dir.glob("**/*")
  s.rubyforge_project = "nowarning" # supress warning message 
end
