
class YardTheme

  include GladeGUI

  attr_accessor :clone_name
 
  def defaults
    @css ||= {}
    @css["h1:font-size"] ||= "2em"
    @css["h2:font-size"] ||= "1.5em"
    @css["h3:font-size"] ||= "1.2em"
    @css["h1:color"] ||= "#621"
    @css["h2:color"] ||= "#555"
    @css["h3:color"] ||= "#555"
    @css["h1:background"] ||= "#fff"
    @css["h2:background"] ||= "#fff"
    @css["h3:background"] ||= "#fff"
    @css["h1:font-family"] ||= "Ubuntu"
    @css["h2:font-family"] ||= "Monospace"
    @css["h3:font-family"] ||= "Monospace"
    @css["p:width"] ||= "65%"
    @css["body:font-size"] ||= "16px"
    @css["#toc:background-color"] ||= "#fee"
    @css["body:background-color"] ||= "#aff"
    @css[".summary .summary_signature:background"] = "#faf"  # summary of instance methods titles
#    @css["p.signature, h3.signature:background"] = "#fa6"  #tit
    @headline = "<big>Editing Theme:  #{File.basename(@vr_yaml_file, '.*')}</big>" 

# List of links:
# class = "summary_toggle" is class used for "collapse"

# todo link color, hilight link color

# todo invert color

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


