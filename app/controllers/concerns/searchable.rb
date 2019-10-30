# frozen_string_literal: true

# Methods for reading from public files and searching in them
module Searchable
  include ActiveSupport::Concern

  # parses json from public file
  def search_in(file_name)
    JSON.parse(File.read("#{Rails.root}/public/#{file_name}"))
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
    params[:search].downcase.split
  end
end
