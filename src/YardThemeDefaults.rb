## list of css defaults
#

module YardThemeDefaults

  def defaults
    @css ||= {}

    # body page
    @css["p:width"] ||= "65%"
    @css["body:font-size"] ||= "16px"
    @css["body:background-color"] ||= "#aff"

    # headline page
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

    # table of contents
    @css["#toc:background-color"] ||= "#fee"

    @css[".summary .summary_signature:background"] = "#faf"  # summary of instance methods titles
  #    @css["p.signature, h3.signature:background"] = "#fa6"  #tit
    
  # List of links:
  # class = "summary_toggle" is class used for "collapse"
  end

  def maps
    @css[".summary .summary_signature:background"] = @css["h3:background"] # summary of instance methods titles
    @css["p.signature, h3.signature:background"] = @css["h3:background"]  # titles over instance method, attr details
  end


end
