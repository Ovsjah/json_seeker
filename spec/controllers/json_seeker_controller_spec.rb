require 'rails_helper'

RSpec.describe JsonSeekerController, type: :controller do
  describe "GET #seek" do
    render_views

    context "with templates rendering" do
      before(:each) { get :seek }

      it "renders the seek template" do
        expect(response).to render_template('seek')
      end

      it "renders the seeker partial" do
        expect(response).to render_template(partial: '_seeker')
      end

      it "renders the result table partial" do
        expect(response).to render_template(partial: '_result_table')
      end
    end

    context "with data searching" do
      let(:found) { assigns(:found) }
      let(:found_names) { found.map { |hsh| hsh["Name"] } }

      it "gets all data by default" do
        get :seek
        expect(found.size).to eq(97)
      end

      it "seeks for exact match" do
        get :seek, params: {search: "Yukihiro Matsumoto"}
        expect(found).to eq([{"Name"=>"Ruby", "Type"=>"Imperative, Interpreted, Metaprogramming, Object-oriented class-based, Reflective, Scripting, Interactive mode", "Designed by"=>"Yukihiro Matsumoto"}])
      end

      it "seeks in different fields" do
        get :seek, params: {search: "Scripting Microsoft"}
        expect(found_names).to eq(["JScript", "VBScript", "Windows PowerShell"])
      end

      it "supports negative searces" do
        get :seek, params: {search: "john -array"}
        expect(found_names).to eq(["BASIC", "Haskell", "Lisp", "S-Lang"])
      end
    end
  end
end
