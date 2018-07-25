require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  context do
    let(:user) { double }

    before { sign_in user }

    describe '#index.json' do
      before { get :index, format: :json }

      it { should render_template :index }

    end
  end

end
