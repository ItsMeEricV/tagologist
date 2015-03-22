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

  def find_word_until_space(string, index = 0)
    string.match(/[^\s]+/,index)
  end

  def convert_tags(string)
    string.gsub!(/(<\/*)/,'&lt;')
    string.gsub!(/>/,'&gt;')
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