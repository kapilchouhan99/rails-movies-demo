require "rails_helper"

RSpec.describe MoviesController, :type => :controller do
  describe "GET index" do
    login_user

    context "when params tab value is equle to Movie" do
      let(:movie_1) { FactoryBot.create(:movie) }
      let(:movie_2) do
        FactoryBot.create(
          :movie,
          title: "second movie",
          description: "send movie des",
          image: "https://m.media-amazon.com/images/M/MV5BYWYxMjBlZjEtY2ZkYS00OWE1LWEzNTAtNDlkZWE5NzI1NDE1XkEyXkFqcGdeQXVyMTA5NzIyMDY5._V1_UY98_CR0,0,67,98_AL_.jpg"
        )
      end

      it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
      end

      it "has return movies" do
        get :index
        expect(assigns(:movies)).to match_array([movie_1, movie_2])
      end
    end

    context "when params tab value is equle to Genre" do
      let(:genre_1) { FactoryBot.create(:genre) }
      let(:genre_2) { FactoryBot.create(:genre, name: "second genre") }

      it "has a 200 status code" do
        get :index, params: { tab: "Genre" }
        expect(response.status).to eq(200)
      end

      it "has return Genres" do
        get :index, params: { tab: "Genre" }
        expect(assigns(:genres)).to match_array([genre_1, genre_2])
      end
    end

    context "when params tab value is equle to Star" do
      let(:star_1) { FactoryBot.create(:star) }
      let(:star_2) { FactoryBot.create(:star, name: "second star name") }

      it "has a 200 status code" do
        get :index, params: { tab: "Star" }
        expect(response.status).to eq(200)
      end

      it "has return Genres" do
        get :index, params: { tab: "Star" }
        expect(assigns(:stars)).to match_array([star_1, star_2])
      end
    end

    context "when params tab value is equle to Suggest" do
      let(:movie_1) { FactoryBot.create(:movie) }
      let(:movie_2) do
        FactoryBot.create(
          :movie,
          title: "second movie",
          description: "send movie des",
          image: "https://m.media-amazon.com/images/M/MV5BYWYxMjBlZjEtY2ZkYS00OWE1LWEzNTAtNDlkZWE5NzI1NDE1XkEyXkFqcGdeQXVyMTA5NzIyMDY5._V1_UY98_CR0,0,67,98_AL_.jpg"
        )
      end

      it "has a 200 status code" do
        get :index, params: { tab: "Suggest" }
        expect(response.status).to eq(200)
      end

      context "when user is not followed any Movie, Star and Genre yet" do
        it "has return empty movies array" do
          get :index, params: { tab: "Suggest" }
          expect(assigns(:movies)).to match_array([])
        end
      end

      context "when user is followed any Movie or Star or Genre" do
        let(:movie) { FactoryBot.create(:movie, :movie_genres, :movie_stars) }
        
        context "when user is followed Movie" do
          it "has return empty movies array" do
            subject.current_user.follow(movie)
            expect(Follow.count).to eql(1)
            get :index, params: { tab: "Suggest" }
            expect(assigns(:movies)).to match_array([movie])
          end
        end

        context "when user is followed Genre" do
          let(:genre) { movie.genres.first }
          it "has return empty movies array" do
            subject.current_user.follow(genre)
            expect(Follow.count).to eql(1)
            get :index, params: { tab: "Suggest" }
            expect(assigns(:movies)).to match_array([movie])
          end
        end

        context "when user is followed Star" do
          let(:star) { movie.stars.first }
          it "has return empty movies array" do
            subject.current_user.follow(star)
            expect(Follow.count).to eql(1)
            get :index, params: { tab: "Suggest" }
            expect(assigns(:movies)).to match_array([movie])
          end
        end
      end
    end
  end

  describe "GET follow" do
    login_user

    context "when user follow a movie" do
      let(:movie) { FactoryBot.create(:movie) }
      it "follow a movie" do
        expect{
          get :follow, xhr: true, params: { type: "Movie", id: movie.id }
        }.to change{Follow.count}.by(1)
        expect(subject.current_user.following?(movie)).to eql(true)
      end
    end

    context "when user follow a genre" do
      let(:genre) { FactoryBot.create(:genre) }
      it "follow a genre" do
        expect{
          get :follow, xhr: true, params: { type: "Genre", id: genre.id }
        }.to change{Follow.count}.by(1)
        expect(subject.current_user.following?(genre)).to eql(true)
      end
    end

    context "when user follow a star" do
      let(:star) { FactoryBot.create(:star) }
      it "follow a genre" do
        expect{
          get :follow, xhr: true, params: { type: "Star", id: star.id }
        }.to change{Follow.count}.by(1)
        expect(subject.current_user.following?(star)).to eql(true)
      end
    end
  end

  describe "GET unfollow" do
    login_user

    context "when user unfollow a movie" do
      let(:movie) { FactoryBot.create(:movie) }
      it "unfollow a movie" do
        subject.current_user.follow(movie)
        expect(Follow.count).to eql(1)

        expect{
          get :unfollow, xhr: true, params: { type: "Movie", id: movie.id }
        }.to change{Follow.count}.by(-1)
        expect(subject.current_user.following?(movie)).to eql(false)
      end
    end

    context "when user unfollow a genre" do
      let(:genre) { FactoryBot.create(:genre) }
      it "follow a genre" do
        subject.current_user.follow(genre)
        expect(Follow.count).to eql(1)

        expect{
          get :unfollow, xhr: true, params: { type: "Genre", id: genre.id }
        }.to change{Follow.count}.by(-1)
        expect(subject.current_user.following?(genre)).to eql(false)
      end
    end

    context "when user unfollow a star" do
      let(:star) { FactoryBot.create(:star) }
      it "follow a genre" do
        subject.current_user.follow(star)
        expect(Follow.count).to eql(1)

        expect{
          get :unfollow, xhr: true, params: { type: "Star", id: star.id }
        }.to change{Follow.count}.by(-1)
        expect(subject.current_user.following?(star)).to eql(false)
      end
    end
  end
end
