require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#create.json' do
    before { @session = double }

    before { expect(Session).to receive(:new).with(email: 'kathy@hartlova.com', password: 'bigboobs').and_return(@session) }

    context do
      before { expect(@session).to receive(:save).and_return(true) }

      before { post :create, session: { email: 'kathy@hartlova.com', password: 'bigboobs' }, format: :json }

      it { should render_template :create }
    end

    context do
      before { expect(@session).to receive(:save).and_return(false) }

      before { post :create, session: { email: 'kathy@hartlova.com', password: 'bigboobs' }, format: :json }

      it { should render_template :errors }
    end
  end

  describe "#destroy.json" do
    before do
      @session_service = double "Session"
      sign_in User.new email: "bill@acme.com"
      controller.instance_variable_set :@session_service, @session_service
    end

    context "having existing user with token" do
      before do
        expect(@session_service).to receive(:sign_out).and_return true
      end

      before do
        delete :destroy
      end

      it "responds with a 200 OK" do
        expect(response).to have_http_status 200
      end
    end

    context "have no token for existing user" do
      before do
        expect(@session_service).to receive(:sign_out).and_return false
      end

      before do
        delete :destroy
      end

      it "responds with 406 Not Acceptable" do
        expect(response).to have_http_status :not_acceptable
      end
    end
  end
end
