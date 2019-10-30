# frozen_string_literal: true

# Makes the programming languages info searchable
class JsonSeekerController < ApplicationController
  include Searchable

  # returns an array of hashes accordingly to search request
  def seek
    all = search_in('data.json')

    @found =
      if params[:search]
        all.select { |hsh| present_in?(hsh.values) }
      else
        all
      end
  end
end
