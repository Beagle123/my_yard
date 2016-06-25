
class YardTheme

  include GladeGUI

  def initialize()
    defaults
  end  

  def defaults
    @body ||= CSS.new "body", 
      "font-family" => "Comic Sans MS",
      "font-size" => "16px",
      "font-color" => "#faa",
      "background" => "#eff"
    @p ||= CSS.new "p",
      "width" => "60%"
    @h1 ||= CSS.new "h1",
      "color" => "#fff",
      "text-shadow" => "-2px 2px #000",
      "font-size" => "2.5em",
      "background" => "#722"
  end

  def export_to(file)
    File.open(file, "w") { |f| f.puts to_css }
  end

  def to_css
    @body.to_css + @p.to_css + @h1.to_css 
  end  
       
end

class CSS
  
  def initialize(tag, props)
    @tag = tag
    @props = props
  end

  def to_css
    str = "#{@tag} {"
    @props.each {|key, val| str = str + " #{key}: #{val};" }
    return str + "}\n"
  end

end
