
class MyYard 
 
  include GladeGUI

  def initialize
    defaults
  end

  def defaults
    @project_root ||= ENV["HOME"]
    @output_dir ||= "doc"
    @theme ||= "default"
    @template ||= "default" 
    @files ||= "*/**/*.rb"
    @extra_files ||= "README.*"
    @include_public = true if @include_public.nil?  
    @include_private ||= false
    @include_protected ||= false
    @title ||= "Get outta my yard!"
  end

  def before_show()
#    set_glade_all
    fill_combo_boxes
  end  

  def buttonGenerate__clicked(*args)
    args = []
    args << @files
    args << "-"
    args << @extra_files
    args << "--private" if @builder[:include_private].active?
    args << "--no-public" if !@builder[:include_public].active?
    args << "--protected" if @builder[:include_protected].active?
    args << "--output-dir"
    args << @builder[:output_dir].text
    if File.directory?(@project_root) and @project_root != ENV["HOME"]
      old_dir = Dir.pwd
      FileUtils.cd(@project_root) 
      YARD::CLI::Yardoc.run(*args)
      FileUtils.cd(old_dir)
    else
      alert "Invalid Project Folder."
    end
  end

  def window1__destroy(*a)
    get_glade_all
    VR::save_yaml(self)
    super
  end

  def fill_combo_boxes()
    @builder[:template].append_text "default"
    @builder[:theme].append_text "default"
    @builder[:template].append_text "four column"
    @builder[:theme].append_text "apples"
#    Dir.glob("./templates/*").each do |template|
  end
  
  # Just to test if private is included
  private def private_test
  end

end

