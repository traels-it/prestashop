require_relative 'test_helper'

using Prestashop::Mapper::Refinement
describe 'String' do
  it "should not contains <>;=\#{}" do
    "<>st;r=i#n{g}".plain.must_equal "string"
  end

  it "should remove all html tags" do 
    "I'm <a>Link</a>".clean.must_equal "I'm Link"
  end

  it "should keep some tags" do 
    "I'm <a>Link</a> and <b>bold</b>".restricted.must_equal "I'm Link and <b>bold</b>"
  end

  it "should keep more tags" do 
    "I'm <a>Link</a> and <b>bold</b>".relaxed.must_equal "I'm <a>Link</a> and <b>bold</b>"
    "I'm <a>Link</a> and <b>bold</b><span onmouseover=\"_tipon(this)\" onmouseout=\"_tipoff()\">".relaxed.must_equal "I'm <a>Link</a> and <b>bold</b>"
    "I'm <a>Link</a> and <b>bold</b><iframe src=\"http://www.w3schools.com\"></iframe>".relaxed.must_equal "I'm <a>Link</a> and <b>bold</b>"
  end

  it "should determinate html enabled" do
    '<div class="composition"><span class="title">Složení</span>Obsah</div>'.html(false).must_equal ' SloženíObsah '
    '<div class="composition"><span class="title">Složení</span>Obsah</div>'.html(true).must_equal '<div class="composition"><span class="title">Složení</span>Obsah</div>'
  end
end