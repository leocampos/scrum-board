require 'spec_helper'

describe ::ScrumBoard::Yml do

  it 'deveria ler um arquivo de config valido' do
    file_path = File.join(Rails.root,"spec/lib/scrum_board/test")
    File.expects(:join).with('config','test').returns(file_path)
    
    @yml = ::ScrumBoard::Yml.read_from_config('test')
    @yml.should == {:pessoa => {:nome => "zezinho", :atributo => { :idade => 12 }}}
  end

  it "deveria retornar nulo quando o arquivo nao existe" do
    lambda { ::ScrumBoard::Yml.read_from_config('invalid_file') }.should raise_error(Errno::ENOENT, "No such file or directory - config/invalid_file.yml")
  end
end