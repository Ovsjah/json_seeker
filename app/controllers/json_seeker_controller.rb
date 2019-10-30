# frozen_string_literal: true

# Makes the programming languages info searchable
class JsonSeekerController < ApplicationController
  # returns an array of hashes accordingly to search request
  def seek
    @found = PublicJsonSeekerService.new('data.json').seek(params[:search])
  end
end
