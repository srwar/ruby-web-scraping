require 'open-uri'
require 'nokogiri'
require 'csv'

  def scraping(url)
  	html = URI.open("#{url}").read
  	nokogiri_doc = Nokogiri::HTML(html)
  	final_array = []

  	nokogiri_doc.search(".v2-listing-card__info h3").each do |element|
  		element = element.text
  		final_array << element
  	end

  	final_array.each_with_index do |element, index|
  		puts "#{index + 1} - #{element}"
  	end
  end

 scraping = scraping('https://www.etsy.com/es/search?q=marvel')

 filepath = "test.csv"

 csv_options = {headers: :first_row, col_sep: ','}

 CSV.open(filepath, 'wb', **csv_options) do |csv|
 	csv << ['tittle', 'index']
 	scraping.each_with_index do |item, index|
 		csv << [item, index]
 	end
 end
