# frozen_string_literal: true

# Makes the json data searchable
class PublicJsonSeekerService
  attr_reader :result

  def initialize(file_name)
    @file = file_name
  end

  # returns an arr of hashes that matches the query or all hashes
  def seek(query = nil)
    @result = (@query = query) ? parsed.select { |hsh| present_in?(hsh.values) } : parsed
  end

  private

  # parses json from public file
  def parsed
    JSON.parse(File.read("#{Rails.root}/public/#{@file}"))
  end

  # returns boolean if the search request is present in modified hash values
  def present_in?(values)
    formatted_search_params.all? do |seek_for|
      search_str = format(values)

      if seek_for.start_with?('-') # supports negative search
        search_str.exclude? seek_for[1..-1]
      else
        search_str.include? seek_for
      end
    end
  end

  def format(values)
    values.join(' ').downcase
  end

  def formatted_search_params
    @query.downcase.split
  end
end
