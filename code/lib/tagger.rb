module Tagger

  def urlify(url)
    #if no www and no http/https then add http to the url
    if(url.match(/^(?!.*http:\/\/).*$/) && url.match(/^(?!.*https:\/\/).*$/))
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
    string.gsub!(/</,'&lt;')
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

  def decorate_tags(string, index = 0)
    convert_tags(string)
    while index < string.length do
      index = string.index(/&lt;/,index)
      (index.nil?) ? break : index #advance past < if it exists. If it doesn't exist then no more code to inspect
      if(string[index+4] != '/')
        tag = find_tag_name(string,index)
        #if tag name has no space at the end (like  <head> ) then handle this case
        tag = tag.match(/.+?(?=&gt;)/)[0] if tag.match(/.+?(?=&gt;)/)
        tag.slice! '&lt;'
        tag.slice! '&gt;'
        beginning_decorate_tag = "<span data-tag-name=\"#{tag}\">"
        ending_decorate_tag = "</span>"

        #insert an ending tag after the tag text
        string.insert index+tag.length+4, ending_decorate_tag
        #insert a beginning tag before tag text
        string.insert index+4, beginning_decorate_tag
        #advance index
        index += beginning_decorate_tag.length + tag.length + ending_decorate_tag.length
        #special case: if inside a <script> tag then skip to the end of the <script> so we don't count < > in Javascript
        #p index
        if(tag == "script")
          #index = find_ending_script_tag(string,index)
          index = string.index(/&lt;\/script&gt;/,index)
        end

      end
      
      index = string.index(/&gt;/,index)
      (index.nil?) ? break : index #advance past > if it exists. If it doesn't exist then no more code to inspect
      index += 1 #advance past >
    end
    string
  end

end