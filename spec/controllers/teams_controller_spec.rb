require 'spec_helper'

describe TeamsController do
  describe "GET 'edit'" do
    it 'deveria renderizar a view edit' do
      get 'edit', "id" => "1"
      
      response.should render_template("edit")
    end
  end
end