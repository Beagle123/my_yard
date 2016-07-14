
class MyYard 
 
  include GladeGUI

  def initialize
    defaults
  end

  def defaults
    @project_root = $open_project
    @output_dir ||= "doc"
    @theme = "default" if @theme.nil? or !File.exist?(File.join($env.theme_root, @theme + ".yaml")) 
    @template ||= "default" 
    @files ||= "*/**/*.rb */**/*.c"
    @extra_files ||= "*/**/*.md"
    @exclude ||= ""
    @include_public = true if @include_public.nil? # ||= no good on this one  
    @include_private ||= false
    @include_protected ||= false
    @include_private_tag ||= false
    @title ||= "Generated with Yard 0.8.7.6"
    @main ||= "README.md"
    @export_db = true if @export_db.nil?
    @export_db_path ||= ".yardoc"
#    @format ||= "html"
  end

  def before_show()
    fill_combo_boxes
  end  

  def buttonGenerate__clicked(*args)
    save_state
    args = []
    @files.split.each { |glob| args << glob }
    if @extra_files.strip != ""
      args << "--files"
      args << @extra_files
    end
    args << "--private" if @include_private 
    args << "--no-public" if !@include_public 
    args << "--protected" if @include_protected
    args << "--no-private" if !@include_private_tag  
    args << "--output-dir"
    args << @output_dir 
    args << "--title" 
    args << @title 
    if @exclude.strip != ""
      args << "--exclude"
      args << @exclude 
    end
    if @main.strip != ""
      args << "--main"
      args << @main
    end
    if @template != "default"
      args << "--template-path"
      args << $env.template_root
      args << "--template"
      args << @template
    end
    if @export_db and @export_db_path.strip != ""
      args << "--db"
      args << @export_db_path
    else
      args << "--no-save"        
    end
#    args << "--format"
#    args << @format
    if File.directory?(@project_root) and @project_root != ENV["HOME"]
      YARD::Registry.clear
      YARD::Templates::ErbCache.clear!
      old_dir = Dir.pwd
      FileUtils.cd(@project_root)
      YARD::CLI::Yardoc.run(*args)
      FileUtils.cd(old_dir)
    else
      alert "Invalid Project Folder.", parent: self
    end
    if @theme != "default"
      css = VR::load_yaml(YardTheme, File.join($env.theme_root, @theme + ".yaml"))
      css.export_to(File.join(@project_root, @output_dir, "css", "common.css"))
#      $default_theme.export_to(File.join(@project_root, @output_dir, "css", "common.css"))
    else
      File.delete(File.join(@project_root, @output_dir, "css", "common.css"))
    end
  end

  def project_root__changed(*a)
    return unless @builder[:project_root].model.count == $env.projects.size 
    return if @builder[:project_root].active_text == $open_project 
    save_state
    $open_project = @builder[:project_root].active_text
    @builder[:window1].destroy  
  end

  def fill_combo_boxes()
    @builder[:template].append_text "default"
    glob = File.join($env.template_root, "*/")
    Dir.glob(glob).each do |path|
      @builder[:template].append_text File.basename(path)
    end
    fill_themes  
    $env.projects.each do |path|
      @builder[:project_root].append_text path 
    end
  end

  def fill_themes()
    @builder[:theme].model.clear
    glob = File.join($env.theme_root, "*.yaml")
    Dir.glob(glob).each do |path|
      @builder[:theme].append_text File.basename(path, ".*")
    end
  end

  def buttonEditTheme__clicked(*a)
    get_glade_variables
    file = File.join($env.theme_root, @theme + ".yaml")
    win = VR::load_yaml(YardTheme, file)
    win.show_glade(self)
    fill_themes
    set_glade_variables # select theme again      
  end

  def buttonOpenProject__clicked(*a)
    if folder = alert("Enter folder to open:",
        parent: self, input_text: Dir.home + "/",
        headline: "Open Folder", button_yes: "Open",
        button_no: "Cancel")
      if File.directory?(folder)
        save_state
        $open_project = folder
        @builder[:window1].destroy
      end  
    end
  end

  def buttonBrowse__clicked(*a)
    save_state
    begin
      IO.popen("#{$env.browser} #{File.join(@project_root, @output_dir, @main)}")  
    rescue
      if answer = alert("Enter command to start your browser:", parent: self, input_text: $env.browser)
        $env.browser = answer
        VR::save_yaml($env)
      end  
    end
  end

  def buttonDeleteProject__clicked(*a)
    if alert("This will delete this project:\n<b>#{@project_root}</b>\nDo you want to continue?",
        button_yes: "Delete",
        button_no: "Cancel",
        parent: self,
        headline: "Delete This Project?")
      $env.projects.delete(@project_root)
      VR::save_yaml($env)
      FileUtils.rm_rf File.join(@project_root, ".yardoc", "my_yard.yaml")
      $open_project = $env.projects.empty? ? :exit : $env.projects[0]
      @builder[:window1].destroy
    end
  end

  def buttonDeleteTheme__clicked(*a)
    get_glade_variables
    return if @theme == "default"
    if alert "Delete theme: <b>#{@theme}</b>?", parent:self, button_no: "Cancel"
      theme = File.join($env.theme_root, "#{@theme}.yaml")
      File.delete(theme)
      @theme = "default"
      fill_themes
      set_glade_variables
    end 
  end 

  def window1__delete_event(*a)
    save_state
    $open_project = :exit
    return false
  end

  def buttonCancel__clicked(*a)
    save_state
    $open_project = :exit
    super
  end
     

  def save_state
    get_glade_variables
    @project_root = $open_project
    VR::save_yaml(self)
  end

end

