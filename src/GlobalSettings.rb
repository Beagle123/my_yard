
class GlobalSettings

  include GladeGUI

  attr_accessor :browser, :projects, :theme_root, :template_root

  def defaults
    @browser ||= "firefox"
    @projects ||= []
    @theme_root = File.join(Dir.home, "my_yard", "themes")
    @template_root = File.join(Dir.home, "my_yard", "templates")
  end

  def add_project(proj_path)
    unless @projects.include?(proj_path) 
      @projects << proj_path 
      VR::save_yaml(self)
    end 
  end

end
