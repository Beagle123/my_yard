## list of css defaults
#

module YardThemeDefaults

  @defaults ||= {}

# body page
  @defaults["p:width"] ||= "65%"
  @defaults["body:font-size"] ||= "16px"
  @defaults["body:background-color"] ||= "#aff"

# headline page
  @defaults["h1:font-size"] ||= "2em"
  @defaults["h2:font-size"] ||= "1.5em"
  @defaults["h3:font-size"] ||= "1.2em"
  @defaults["h1:color"] ||= "#621"
  @defaults["h2:color"] ||= "#555"
  @defaults["h3:color"] ||= "#555"
  @defaults["h1:background"] ||= "#fff"
  @defaults["h2:background"] ||= "#fff"
  @defaults["h3:background"] ||= "#fff"
  @defaults["h1:font-family"] ||= "Ubuntu"
  @defaults["h2:font-family"] ||= "Monospace"
  @defaults["h3:font-family"] ||= "Monospace"

# table of contents
  @defaults["#toc:background-color"] ||= "#fee"

  @defaults[".summary .summary_signature:background"] = "#faf"  # summary of instance methods titles
#    @css["p.signature, h3.signature:background"] = "#fa6"  #tit
  
# List of links:
# class = "summary_toggle" is class used for "collapse"

end
