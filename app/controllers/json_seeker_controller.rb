class JsonSeekerController < ApplicationController
  def seek
    all = parse('data.json')
    @found = params[:search] ? all.select { |hsh| seek_in(hsh) } : all
  end

  private

    def parse(file_name)
      JSON.parse(File.read("#{Rails.root}/public/#{file_name}"))
    end

    def seek_in(hsh)
      params[:search].downcase.split.all? do |seek_for|
        search_str = hsh.values.join(' ').downcase
        if seek_for.start_with?('-')
          search_str.exclude? seek_for[1..-1]
        else
          search_str.include? seek_for
        end
      end
    end
end
