
class YardTheme

  include GladeGUI
  include YardThemeDefaults

  attr_accessor :clone_name

  def defaults
    @css ||= {}
    @defaults.each do |key, val|
      @css[key] = val if @css[key].nil?
    end
    @headline = "<big>Editing Theme:  #{File.basename(@vr_yaml_file, '.*')}</big>" 
  end

  def maps
    @css[".summary .summary_signature:background"] = @css["h3:background"] # summary of instance methods titles
    @css["p.signature, h3.signature:background"] = @css["h3:background"]  # titles over instance method, attr details
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
    if clone = alert("This will make a clone of this theme and exit the editor.  " +
        "Enter the name of the new theme without any extension (only letters and underscores).  " +
        "To edit the cloned copy, just select it in my_yard, and click the <b>Edit</b> button.",
        headline: "Clone Theme",
        button_no: "Cancel",
        input_text: "",
        width: 350,
        parent: self)
      @clone_name = clone # todo lowercase, strip, replace everything except letters, numbers and underscores.
      dir = File.dirname(@vr_yaml_file)
      path = File.join(dir, @clone_name + ".yaml")
      if File.exists?(path) 
        alert "The file, <b>#{name}</b> already exists.", parent: self
      else
        FileUtils.cp(@vr_yaml_file, path)
      end
    end 
  end

  def window1__destroy(*a)
    save_state
    super
  end
  
  def save_state
    get_glade_variables
    VR::save_yaml(self)
  end
       
end


