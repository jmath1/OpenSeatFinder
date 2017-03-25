require 'json'
require 'sinatra'
require_relative 'elections'

DATA = Elections.new('elections.csv')

not_found do
  { error: 'Not found' }.to_json
end

get '/api/candidates' do
  DATA.all.to_json
end

get '/api/candidates/:ward' do
  if ward = DATA.find_ward(params[:ward])
    ward.to_json
  else
    not_found
  end
end

get '/api/candidates/:ward/divisions/:division' do
  if division = DATA.find_division(params[:ward], params[:division])
    division.to_json
  else
    not_found
  end
end
