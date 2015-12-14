require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  before do
    FactoryGirl.create(:user)
  end
  
  let(:valid_attributes) {
        {name: 'Test', user_ids: [User.first.id]}
  }

  let(:invalid_attributes) {
    {name: ''}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all teams as @teams" do
      team = Team.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:teams)).to eq([team])
    end
  end

  describe "GET #show" do
    it "assigns the requested team as @team" do
      team = Team.create! valid_attributes
      get :show, {:id => team.to_param}, valid_session
      expect(assigns(:team)).to eq(team)
    end
  end

  describe "GET #new" do
    it "assigns a new team as @team" do
      get :new, {}, valid_session
      expect(assigns(:team)).to be_a_new(Team)
    end
  end

  describe "GET #edit" do
    it "assigns the requested team as @team" do
      team = Team.create! valid_attributes
      get :edit, {:id => team.to_param}, valid_session
      expect(assigns(:team)).to eq(team)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Team" do
        expect {
          post :create, {:team => valid_attributes}, valid_session
        }.to change(Team, :count).by(1)
      end

      it "assigns a newly created team as @team" do
        post :create, {:team => valid_attributes}, valid_session
        expect(assigns(:team)).to be_a(Team)
        expect(assigns(:team)).to be_persisted
      end

      it "redirects to the created team" do
        post :create, {:team => valid_attributes}, valid_session
        expect(response).to redirect_to(Team.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
        post :create, {:team => invalid_attributes}, valid_session
        expect(assigns(:team)).to be_a_new(Team)
      end

      it "re-renders the 'new' template" do
        post :create, {:team => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: 'Team changed', user_ids: [User.first.id]}
      }

      it "updates the requested team" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => new_attributes}, valid_session
        team.reload
      end

      it "assigns the requested team as @team" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        expect(assigns(:team)).to eq(team)
      end

      it "redirects to the team" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => valid_attributes}, valid_session
        expect(response).to redirect_to(team)
      end
    end

    context "with invalid params" do
      it "assigns the team as @team" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => invalid_attributes}, valid_session
        expect(assigns(:team)).to eq(team)
      end

      it "re-renders the 'edit' template" do
        team = Team.create! valid_attributes
        put :update, {:id => team.to_param, :team => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested team" do
      team = Team.create! valid_attributes
      expect {
        delete :destroy, {:id => team.to_param}, valid_session
      }.to change(Team, :count).by(-1)
    end

    it "redirects to the teams list" do
      team = Team.create! valid_attributes
      delete :destroy, {:id => team.to_param}, valid_session
      expect(response).to redirect_to(teams_url)
    end
  end
end
