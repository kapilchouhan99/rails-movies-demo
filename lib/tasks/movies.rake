require 'nokogiri'
require 'open-uri'
namespace :movies do
  desc 'Search for movies and import in DB'
  task :update  => :environment do
    0.upto(3) do |i|
      count = 150
      url = 'https://www.imdb.com/search/title/?title_type=feature&countries=in&languages=hi&count=250&start=' + (1 + i * count).to_s
      doc = Nokogiri::HTML(open(url))
      doc.xpath('//div[@class="lister-item mode-advanced"]').each do |div|
        image_url = div.css('div.lister-item-image a img').attr('loadlate').content
        movie_name = div.css('div.lister-item-image a img').attr('alt').content
        genres = div.css('div.lister-item-content p.text-muted span.genre').text
        stars_html = div.xpath('./div[@class="lister-item-content"]/p[position()=3]').inner_html.split('Stars:').last.strip
        stars_array = Nokogiri::HTML(stars_html).css('a').map(&:text)
        stars_name = stars_array.join(", ")
        genres = genres.split(",").map(&:strip).join(",")
        movie = Movie.where(title: movie_name, image: image_url)
        unless movie.any?
          movie = Movie.create!(title: movie_name, image: image_url)
          genres.split(",").each do |genre|
            object = Genre.where(name: genre)
            if object.any?
              movie.genres << object
            else
              movie.genres.where(name: genre).first_or_create
            end
          end
          stars_array.each do |star|
            object = Star.where(name: star)
            if object.any?
              movie.stars << object
            else
              movie.stars.where(name: star).first_or_create
            end
          end
        end
      end
    end
  end
end
