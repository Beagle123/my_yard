
class GlobalSettings

  include GladeGUI

  attr_accessor :browser, :projects

  def defaults
    @browser ||= "firefox"
    @projects ||= []
  end

  def add_project(proj_path)
    unless @projects.include?(proj_path) 
      @projects << proj_path 
      VR::save_yaml(self)
    end 
  end

end
