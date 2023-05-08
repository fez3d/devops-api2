require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "/books", type: :request do

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
      Book.create! valid_attributes
      get books_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      book = Book.create! valid_attributes
      get book_url(book), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Book" do
        expect {
          post books_url,
               params: { book: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Book, :count).by(1)
      end

      it "renders a JSON response with the new book" do
        post books_url,
             params: { book: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book" do
        expect {
          post books_url,
               params: { book: invalid_attributes }, headers: invalid_headers, as: :json
        }.to change(Book, :count).by(0)
      end

      it "renders a JSON response with errors for the new book" do
        post books_url,
             params: { book: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "Resident Evil2",
          release: 1995,
          publisher: "CAPCOM",
          rating: 9,
          genre: "Horror"
        }
      }

      it "updates the requested book" do
        book = Book.create! valid_attributes
        patch book_url(book),
              params: { book: new_attributes }, headers: valid_headers, as: :json
        book.reload

        expect(response).to have_http_status(:ok)
      end

      it "renders a JSON response with the book" do
        book = Book.create! valid_attributes
        patch book_url(book),
              params: { book: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the book" do
        book = Book.create! valid_attributes
        patch book_url(book),
              params: { book: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested book" do
      book = Book.create! valid_attributes
      expect {
        delete book_url(book), headers: valid_headers, as: :json
      }.to change(Book, :count).by(-1)
    end
  end
end
