
class MyYard 
 
  include GladeGUI

  def initialize
    defaults
  end

  def defaults
    @project_root = $open_project
    @output_dir ||= "doc"
    @theme ||= "default"
    @template ||= "default" 
    @files ||= "*/**/*.rb */**/*.c"
    @extra_files ||= "*/**/*.md */**/*.rdoc"
    @exclude ||= "*.glade"
    @include_public = true if @include_public.nil? # ||= no good on this one  
    @include_private ||= false
    @include_protected ||= false
    @no_private ||= false
    @export_db ||= false
    @title ||= "Get outta my yard!"
    @main ||= "README.md"
  end

  def before_show()
    fill_combo_boxes
  end  

  def buttonGenerate__clicked(*args)
    save_state
    args = []
    @files.split.each { |glob| args << glob }
    if @extra_files.strip != ""
      args << "-"
      args << @extra_files
    end
    args << "--private" if @include_private 
    args << "--no-public" if !@include_public 
    args << "--protected" if @include_protected 
    args << "--output-dir"
    args << @output_dir 
    args << "--no-save" unless @export_db 
    args << "--title" 
    args << @title 
    if @exclude.strip != ""
      args << "--exclude"
      args << @exclude 
    end
    args << "--no-private" if @no_private 
    if @main.strip != ""
      args << "--main"
      args << @main
    end
    if @template != "default"
      args << "--template-path"
      args << File.join(Dir.home,"my_yard","templates")
      args << "--template"
      args << @template
    end
#oinspect args
    if File.directory?(@project_root) and @project_root != ENV["HOME"]
      old_dir = Dir.pwd
      FileUtils.cd(@project_root)
#      YARD::Registry.clear
#      YARD::Templates::ErbCache.clear!
      YARD::CLI::Yardoc.run(*args)
      FileUtils.cd(old_dir)
    else
      alert "Invalid Project Folder.", parent: self
    end
#    css = VR::load_yaml(YardTheme, File.join(Dir.home, "my_yard", "themes", @theme + ".yaml"))
#    css.export_to(File.join(@project_root, @output_dir, "css", "common.css"))
  end

  def project_root__changed(*a)
    return unless @builder[:project_root].model.count == $env.projects.size 
    return if @builder[:project_root].active_text == $open_project 
    @builder[:window1].destroy  
  end

  def fill_combo_boxes()
    @builder[:template].append_text "default"
    glob = File.join(ENV["HOME"], "my_yard", "templates", "*/")
    Dir.glob(glob).each do |path|
      @builder[:template].append_text File.basename(path)
    end
    @builder[:theme].append_text "default"
    glob = File.join(ENV["HOME"], "my_yard", "themes", "*.yaml")
    Dir.glob(glob).each do |path|
      @builder[:theme].append_text File.basename(path, ".*")
    end
    $env.projects.each do |path|
      @builder[:project_root].append_text path 
    end
  end

  def buttonEditTheme__clicked(*a)
    get_glade_variables
    file = File.join(Dir.home, "my_yard", "themes", @theme + ".yaml")
    win = VR::load_yaml(YardTheme, file)
    win.show_glade(self)
    if win.clone_name
      @builder[:theme].prepend_text win.clone_name
    end        
  end

  def toolBrowser__clicked(*a)
    IO.popen("#{$env.browser} #{File.join(@project_root, @output_dir, @main)}")  
  end

  def toolDeleteMe__clicked(*a)
    if alert("This will delete this project:\n<b>#{@project_root}</b>\nDo you want to continue?",
        button_yes: "Delete",
        button_no: "Cancel",
        parent: self,
        headline: "Delete This Project?")
      $env.projects.delete(@project_root)
      VR::save_yaml($env)
      FileUtils.rm_rf File.join(@project_root, "my_yard.yaml")
      @builder[:window1].destroy
    end
  end
      
  def window1__destroy(*a)
    root = @builder[:project_root].active_text
    if !File.exist?(File.join(@project_root, "my_yard.yaml")) # deleted!
      $open_project = $env.projects.empty? ? :exit : $env.projects[0]
    elsif root != $open_project # user changed root
      save_state
      $open_project = root
    else # same root, not deleted => exit
      save_state
      $open_project = :exit
    end  
    super
  end

  def save_state
    get_glade_all
    @project_root = $open_project
    VR::save_yaml(self)
  end

end

