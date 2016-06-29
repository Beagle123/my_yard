class YardTheme

  include GladeGUI
  include YardThemeDefaults

  def initialize()
    defaults
  end

  def before_show
    theme = File.basename(@vr_yaml_file, ".*")
    if theme == "default"
      alert "The default theme can't be edited.  Make a clone of it, and edit the clone.", 
            parent: self, width: 300
    end
    @builder[:headline].label = "<big>Theme:  #{theme} </big>"
  end

  def export_to(file)
    File.open(file, "w") { |f| f.puts to_css }
  end

  def to_css
    maps
    out = ""
    @css.each do |key, val|
      tag, prop = key.split(":")
      out = out + "#{tag} { #{prop}: #{val}; }\n"
    end
    return out
  end

  def buttonClone__clicked(*a)
    if clone = alert("This will make a clone of this theme.  " +
        "Enter the name of the new theme without any extension (only letters and underscores).",
        headline: "Clone Theme",
        button_no: "Cancel",
        input_text: "",
        width: 350,
        parent: self)
# todo lowercase, strip, replace everything except letters, numbers and underscores.
      path = File.join($theme_root, clone + ".yaml")
      if File.exists?(path)
        alert "The file, <b>#{clone}</b> already exists.", parent: self
      else
        get_glade_variables
        VR::save_yaml(self, path)
        @builder[:headline].label = "Theme:  #{clone}"
      end
    end 
  end

  def window1__destroy(*a)
    save_state if File.exist?(@vr_yaml_file) # maybe deleted
    super
  end
  
  def save_state
    get_glade_variables
    VR::save_yaml(self)
  end
       
end
