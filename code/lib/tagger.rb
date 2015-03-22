module Tagger

  def urlify(url)
    if(url.match(/^(?!.*www.).*$/))
      url.insert 0, "www."
    end
    if(url.match(/^(?!.*http:\/\/).*$/))
      url.insert 0, "http://"
    end
    url
  end

  def find_opening_tag(string, index = 0)
    string.index(/</,index)
  end

  def find_ending_tag(string, index = 0)
    string.index(/>/,index)
  end

  def find_ending_script_tag(string, index = 0)
    string.index(/<\/script>/,index)
  end

  def find_tag_name(string, index = 0)
    string.match(/[^\s>]+/,index)[0]
  end

  def convert_tags(string)
    string.gsub!(/(<\/*)/,'&lt;')
    string.gsub!(/>/,'&gt;')
  end

  def inspect_tags(string, index = 0)
    #hash to store stats about different tags. Using Hash.new(0) so that each tag defaults to 0 occurences
    tag_map = Hash.new(0)
    while index < string.length do
      index = find_opening_tag(string, index)
      (index.nil?) ? break : index += 1 #advance past < if it exists. If it doesn't exist then no more code to inspect
      
      tag = find_tag_name(string,index)
      tag_map[tag] += 1 unless tag[0] == '/'
      #special case: if inside a <script> tag then skip to the end of the <script> so we don't count < > in Javascript
      if(tag == "script")
        index = find_ending_script_tag(string,index)
      end
      
      index = find_ending_tag(string, index)
      index += 1 #advance past >
    end
    tag_map
  end

  def insert_highlight_around_tag(string, index = 0, beginning_tag = '<span style="color:red">', ending_tag = '</span>')
    #find the length of the actual tag text
    tag_length = string.match(/[^\s]+/,index)[0].length
    #insert an ending tag after the tag text
    string.insert index+tag_length+1, ending_tag
    #insert a beginning tag before the tag text
    string.insert index+1, beginning_tag
    #this is the new position to keep seeking at
    new_length = beginning_tag.length + tag_length + ending_tag.length

    return string, new_length + index
  end

end