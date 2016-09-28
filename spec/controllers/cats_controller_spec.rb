require "rails_helper"

RSpec.describe CatsController, :type => :controller do
  context "all users" do
    it "does not expose the show page" do
      valid_cat = FactoryGirl.create(:testcat)
      expect(:get => "/cats/#{valid_cat.id}").not_to be_routable
    end
  end

  context "anon users" do
    describe "GET #index" do
      it "redirects to login page" do
        get :index
        expect(response).to have_http_status(302)
        expect(response).to redirect_to :new_user_session
      end
    end

    describe "GET #new" do
      it "redirects to login page" do
        get :new
        expect(response).to have_http_status(302)
        expect(response).to redirect_to :new_user_session
      end
    end

    describe "GET #edit" do
      it "redirects to login page" do
        edit_cat = FactoryGirl.create(:testcat)
        get :edit, id: edit_cat.id
        expect(response).to have_http_status(302)
        expect(response).to redirect_to :new_user_session
      end
    end
  end

  context "auth users with lowest permissions" do
    login_user

    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "loads all of the cats into @cats" do
        cat1 = FactoryGirl.create(:testcat)
        cat2 = FactoryGirl.create(:testcat)

        get :index

        expect(assigns(@cats)[:cats].to_a).to match_array([cat1, cat2])
      end
    end

    describe "GET #new" do
      before(:each) do
        get :new
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the new template" do
        expect(response).to render_template("new")
      end

      it "loads an empty cat into @cat" do
        expect(assigns(@cat)[:rescue_id]).to be_nil
      end
    end

    describe "GET #edit" do
      before(:each) do
        @valid_cat = FactoryGirl.create(:testcat)
        get :edit, id: @valid_cat.id
      end

      it "responds successfully with an HTTP 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the edit template" do
        expect(response).to render_template("edit")
      end

      it "loads the cat into @cat" do
        expect(assigns(@cat)[:cat].id).to eq(@valid_cat.id)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        before(:each) do
          post :create, cat: FactoryGirl.attributes_for(:testcat)
        end

        it 'creates the cat' do
          expect(Cat.count).to eq(1)
        end

        it 'redirects to the "edit" action for the new cat' do
          expect(response).to redirect_to edit_cat_path(assigns(@cat)[:cat].id)
        end
      end

      context "With invalid attributes" do
        before(:each) do
          @invalid_cat = FactoryGirl.attributes_for(:testcat)
          @invalid_cat[:rescue_id] = nil
          post :create, cat: @invalid_cat
        end

        it 'does not create the cat' do
          expect(Cat.count).to eq(0)
        end

        it 'redirects to the new action' do
          expect(response).to render_template :new
        end
      end
    end

    describe "PATCH #update" do
      before(:each) do
        @new_cat = FactoryGirl.create(:testcat)
        @new_id = @new_cat.id
      end

      context "with valid attributes" do
        before(:each) do
          @new_cat[:name] = "New Cat!"
          patch :update, id: @new_id, cat: @new_cat.attributes
        end

        it "edits the cat" do
          expect(assigns(@cat)[:cat][:name]).to eq("New Cat!")
        end

        it "assigns the correct cat to @cat" do
          expect(assigns(@cat)[:cat].id).to eq(@new_id)
        end

        it "redirects to the edit action" do
          expect(response).to redirect_to edit_cat_path(@new_id)
        end

        it "does not create a new cat" do
          expect(Cat.count).to eq(1)
        end
      end

      context "with invalid attributes" do
        it "does not allow updating the cat" do
          @rescue_id = @new_cat[:rescue_id]
          @new_cat[:rescue_id] = "new_id"
          patch :update, id: @new_id, cat: @new_cat.attributes
          expect(response).to redirect_to edit_cat_path(@new_id)
          expect(assigns(@cat)[:cat][:rescue_id]).to eq(@rescue_id)
        end
      end
    end

    describe "DELETE #destroy" do
      before(:each) do
        @new_cat = FactoryGirl.create(:testcat)
        expect(Cat.count).to eq(1)
      end

      it "deletes the cat" do
        delete :destroy, id: @new_cat.id
        expect(Cat.count).to eq(0)
        expect(response).to redirect_to :index
    end

    # test upload function
  end
end