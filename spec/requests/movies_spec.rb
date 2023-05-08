require 'rails_helper'
require 'devise/jwt/test_helpers'


RSpec.describe "/movies", type: :request do

  let(:valid_attributes) {
    {
      name: "Resident Evil",
      release: 1995,
      publisher: "CAPCOM",
      rating: 9,
      genre: "Horror"
    }
  }

  let(:invalid_attributes) {
    {
      "book": {
        "name": 145,
        "release": "Test",
        "publisher": "CAPCOM",
        "rating": 9,
        "genre": "Horror"
      }
    }
  }

  let(:user) {
    User.create({ email: 'test@gmail.com', password: '12341234'})
  }

  let(:valid_headers) {
    Devise::JWT::TestHelpers.auth_headers({}, user)
  }

  let(:invalid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Movie.create! valid_attributes
      get movies_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      movie = Movie.create! valid_attributes
      get movie_url(movie), headers: valid_headers, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Movie" do
        expect {
          post movies_url,
               params: { movie: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Movie, :count).by(1)
      end

      it "renders a JSON response with the new movie" do
        post movies_url,
             params: { movie: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Movie" do
        expect {
          post movies_url,
               params: { movie: invalid_attributes }, as: :json
        }.to change(Movie, :count).by(0)
      end

      it "renders a JSON response with errors for the new movie" do
        post movies_url,
             params: { movie: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "Resident Evil23",
          release: 1995,
          publisher: "CAPCOM",
          rating: 9,
          genre: "Horror"
        }
      }

      it "updates the requested movie" do
        movie = Movie.create! valid_attributes
        patch movie_url(movie),
              params: { movie: new_attributes }, headers: valid_headers, as: :json
        movie.reload
        expect(response).to have_http_status(:ok)
      end

      it "renders a JSON response with the movie" do
        movie = Movie.create! valid_attributes
        patch movie_url(movie),
              params: { movie: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the movie" do
        movie = Movie.create! valid_attributes
        patch movie_url(movie),
              params: { movie: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested movie" do
      movie = Movie.create! valid_attributes
      expect {
        delete movie_url(movie), headers: valid_headers, as: :json
      }.to change(Movie, :count).by(-1)
    end
  end
end
