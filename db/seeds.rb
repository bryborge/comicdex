# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

preacher_series = Series.find_or_create_by!(name: 'Preacher', start_date: DateTime.new(1995, 1, 1), end_date: DateTime.new(2000, 1, 1))
saga_series     = Series.find_or_create_by!(name: 'Saga', start_date: DateTime.new(2012))
trees_series    = Series.find_or_create_by!(name: 'Trees', start_date: DateTime.new(2014, 1, 1), end_date: DateTime.new(2020, 1, 1))

Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: preacher_series.id,
  issue_number: '1',
  synopsis: 'Jesse Custer, a reverend in a small Texas town, is possessed by the entity Genesis, which is the offspring of an angel and a demon. Genesis gives Jesse the Word of God and the ability to control people with his voice, but also causes his church to explode and kills its members. Jesse is the sole survivor and begins to hallucinate as he tries to understand the spirit that has entered him.',
  cover_date: Date.new(1995, 4),
  cover_price: '2.95'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: preacher_series.id,
  issue_number: '2',
  synopsis: 'Sheriff Root tells Agent Dinnings about the Saint of Killers.',
  cover_date: Date.new(1995, 5),
  cover_price: '2.50'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: preacher_series.id,
  issue_number: '3',
  cover_date: Date.new(1995, 6),
  cover_price: '2.50'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: saga_series.id,
  issue_number: '1'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: saga_series.id,
  issue_number: '2'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: saga_series.id,
  issue_number: '3'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: trees_series.id,
  issue_number: '1'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: trees_series.id,
  issue_number: '2'
)
Comicbook.find_or_create_by!(
  format: 'issue',
  series_id: trees_series.id,
  issue_number: '3'
)
