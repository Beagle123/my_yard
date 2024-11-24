class YardTheme

  include GladeGUI
  include YardThemeDefaults

  attr_accessor :css

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
    maps()
    out = import_google_fonts()
    @css.each do |key, val|
      if val.strip != "" # and val != $default_theme.css[key]
        val = "'#{val}'" if key.include?("{font-family}") # quotes around font names
        out = out + key.gsub("}", ": #{val};" ) + "}\n"
      end
    end
    return out + "#search { position: static; } .fixed_header { position: static; height: auto;} #full_list {margin-top: 0px;}"
  end

  def import_google_fonts()
    lines = []
    ["h1", "h2", "h3", "#toc", ".object_link", "#main p"].each do |tag|
      font = @css["#{tag} {font-family}"] 
      weight = @css["#{tag} {font-weight}"].strip == "" ? "" : ":" + @css["#{tag} {font-weight}"]
      lines << "@import url('https://fonts.googleapis.com/css?family=#{font.gsub(' ', '+')}#{weight}');\n"
    end
    return lines.uniq!.join
  end
  
  def buttonClone__clicked(*a)
    clone = alert("This will make a clone of this theme.  " +
      "Enter the name of the new theme without any extension (only letters and underscores).",
      headline: "Clone Theme",
      data: "",
      width: 350,
      parent: self)
    alert clone
    if clone.is_a? String and clone != "default" and clone != ""
      # todo lowercase, strip, replace everything except letters, numbers and underscores.
      path = File.join(Dir.home, "my_yard", "themes", clone + ".yaml")
      if File.exists?(path)
        alert "The file, <b>#{clone}</b> already exists.", parent: self
      else
        get_glade_variables
        VR::save_yaml(self, path)
        @builder[:headline].label = "Theme:  #{clone}"
      end
    else
      
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
