require_relative '../../lib/tagger.rb'

describe Tagger do
  include Tagger

  describe ".urlify" do
    let(:url) { "google.com" }
    it "should add www. and http:// to the head of the url" do
      expect(urlify(url)).to eq("http://www.google.com")
    end

    let(:url) { "www.google.com" }
    it "should only add http:// to the head" do
      expect(urlify(url)).to eq("http://www.google.com")
    end

    let(:url) { "http://www.google.com" }
    it "should not modify the url" do
      expect(urlify(url)).to eq("http://www.google.com")
    end
  end

  describe ".find_opening_tag" do
    let(:tag) { "slljl32 <input " }
    it "should return the index of a <" do
      expect(find_opening_tag(tag)).to eq(8)
    end
  end

  describe ".find_closing_tag" do
    let(:tag) { "row=3 cols=4> <textarea" }
    it "should return the index of the >" do
      expect(find_opening_tag(tag)).to eq(14)
    end
  end

  describe ".convert_tags" do
    let(:tag) { "some text <textarea row=3 cols=10>ljsdfl</textarea>"}
    it "should replace < and > with &lt; and &gt;" do
      convert_tags(tag)
      expect(tag).to eq("some text &lt;textarea row=3 cols=10&gt;ljsdfl&lt;textarea&gt;")
    end
  end

  # describe ".insert_highlight_around_tag" do
  #   pending "not needed on server side now"
  #   let(:tag) { "some text <textarea row=3 cols=10>ljsdfl</textarea>"}
  #   it "should insert the highlight spans around the tag name" do
  #     expect(insert_highlight_around_tag(tag,10)).to eq("sdf")
  #   end
  # end

end