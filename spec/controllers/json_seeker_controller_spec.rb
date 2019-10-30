# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonSeekerController, type: :controller do
  describe 'GET #seek' do
    render_views

    context 'with templates rendering' do
      before(:each) { get :seek }

      it 'renders the seek template' do
        expect(response).to render_template('seek')
      end

      it 'renders the seeker partial' do
        expect(response).to render_template(partial: '_seeker')
      end

      it 'renders the result table partial' do
        expect(response).to render_template(partial: '_result_table')
      end
    end
  end
end
