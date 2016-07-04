## list of css defaults
#

module YardThemeDefaults

  def defaults
    @css ||= {}

    # covers table text, paragraph text
    @css["body {color}"] ||= "#000000"


    # #main background (middle doc)
    @css["#main {background}"] ||= "#ffffff" #ffffff
 
    # background for full list.  the even/odd backgrounds cover top, this is bottom.   
    @css["body {background-color}"] ||= "#ffffff" #"#ffffff"
    @css["body {font-size}"] ||= "13px"
    @css["#main p {width}"] ||= "65%"

    # colors full list links, method summary links
    @css["#main a, #main a:visited {color}"] ||= "#600" #05a; }
    # yellow hilight hover for list items, show all, collapse, view source
    @css["#main a:hover {background}"] ||= "#ffffa5" #ffffa5

    # colors item summary links, collapse, show all, view source
#    @css[".summary_desc .object_link a, .docstring .object_link a {color}"] ||= "#0055aa" #0055aa

    # full list backgrounds
    @css[".object_link a {color}"] ||= "#0055aa"
    @css["li.odd {background}"] ||= "#f0f0f0"  #f0f0f0 
    @css["li.even {background}"] ||= "#fafafa" #fafafa
    @css[".item:hover {background}"] ||= "#dddddd" #ddd

    # background color of the selected item in list
    @css["li.clicked > .item {background}"] ||= "#0055aa" #05a;
    @css["li.clicked > .item {color}"] ||= "#fafafa" 


    # colors text below method summary and changes gray object names in full_list, don't set it.
    # @css["li {color}"] = "#ca0"





    # gray superclass in list
    #@css["li.clicked > .item {color}"] = "#00ffff" #ccc; 


    # controls background of expand/collapse.  don't use.
    #@css["h2 small a {background}"] ||= "#fbb" #"#f8f8f8"
    


    # unknown
#    @css["h2 small a {background}"] ||=  "#ffa" # "#f8f8f8"
#    @css[".docstring p > code, .docstring p > tt, .tags p > code, .tags p > tt{color}"] = "#7a7" # "#c7254e" 
#    @css[".docstring p > code, .docstring p > tt, .tags p > code, .tags p > tt{background}"] = "#6f0" # "#f9f2f4" 
#    @css["a, a:visited {color}"] = "#c7a"  #05a;

#    @css["h2 small a {background}"] ||= "#bbf" #"#f8f8f8"


    # headline page
    @css["h1 {font-family}"] ||= "Assistant"
    @css["h2 {font-family}"] ||= "Raleway"
    @css["h3 {font-family}"] ||= "Rubik One" #"Anonymous Pro"
    @css["h1 {font-weight}"] ||= "200"
    @css["h2 {font-weight}"] ||= "300"
    @css["h3 {font-weight}"] ||= ""
    @css["h1 {font-size}"] ||= "3em"
    @css["h2 {font-size}"] ||= "1.4em"
    @css["h3 {font-size}"] ||= "1.4em"
    @css["h1 {color}"] ||= "#662211"
    @css["h2 {color}"] ||= "#000000"
    @css["h3 {color}"] ||= "#000000"
    @css["h1 {background}"] ||= "#fff"
    @css["h2 {background}"] ||= "#fff"
    @css["h3 {background}"] ||= "#fff"



    # table of contents
    @css["#toc {background-color}"] ||= "#fee"

 #   @css[".summary .summary_signature {background}"] = "#faf"  # summary of instance methods titles
    @css["p.signature, h3.signature {background}"] = "#0a6"  #tit
    
  # List of links:
  # class = "summary_toggle" is class used for "collapse"
  end

  def maps
    # summary of instance methods titles
    @css[".summary .summary_signature {background}"] = @css["h3 {background}"]
    # titles over instance method, attr details 
    @css["p.signature, h3.signature {background}"] = @css["h3 {background}"]
    #maps the hilighted color of the method, class or file to the same color as object in parentasis
    @css["li.clicked > .item a, li.clicked > .item a:visited {color}"] = @css["li.clicked > .item {color}"] 
  end


end
