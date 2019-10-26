class JsonSeekerController < ApplicationController
  def seek
    all = parse('data.json')  # instead of creating a model with db uses the public json file
    @found = params[:search] ? all.select { |hsh| present_in?(hsh) } : all  # seeks for result in collection of hashes or takes all if there are no params
  end

  private
    # parses json from public file
    def parse(file_name)
      JSON.parse(File.read("#{Rails.root}/public/#{file_name}"))
    end

    def present_in?(hsh)
      params[:search].downcase.split.all? do |seek_for|  # splits params[:search] into array of downcased words and checks for their presence
        search_str = hsh.values.join(' ').downcase  # in the search string
        if seek_for.start_with?('-')  # supports negative search
          search_str.exclude? seek_for[1..-1]
        else
          search_str.include? seek_for
        end
      end
    end
end
