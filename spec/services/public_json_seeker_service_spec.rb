# frozen_string_literal: true

require 'rails_helper'

describe PublicJsonSeekerService do
  let(:seeker) { PublicJsonSeekerService.new('data.json') }

  it 'gets all data if params[:search] is nil' do
    expect(seeker.seek.size).to eq(97)
  end

  it 'matches with precision' do
    expect(seeker.seek('Yukihiro Matsumoto')).to eq([
                                                      { 'Name' => 'Ruby',
                                                        'Type' => 'Imperative, Interpreted,'\
                                                                  ' Metaprogramming, Object-oriented'\
                                                                  ' class-based, Reflective,'\
                                                                  ' Scripting, Interactive mode',
                                                        'Designed by' => 'Yukihiro Matsumoto' }
                                                    ])
  end

  it 'seeks the exact match' do
    expect(seeker.seek('Lisp Common')).to eq([
                                               { 'Designed by' => 'Scott Fahlman,'\
                                                                  ' Richard P. Gabriel,'\
                                                                  ' Dave Moon, Guy Steele,'\
                                                                  ' Dan Weinreb',
                                                 'Name' => 'Common Lisp',
                                                 'Type' => 'Compiled,'\
                                                           ' Interactive mode,'\
                                                           ' Object-oriented class-based,'\
                                                           ' Reflective' }
                                             ])
  end

  it 'seeks in different fields' do
    seeker.seek('Scripting Microsoft')
    expect(seeker.result.map { |hsh| hsh['Name'] }).to eq(['JScript', 'VBScript', 'Windows PowerShell'])
  end

  it 'supports negative searces' do
    seeker.seek('john -array')
    expect(seeker.result.map { |hsh| hsh['Name'] }).to eq(%w[BASIC Haskell Lisp S-Lang])
  end
end
