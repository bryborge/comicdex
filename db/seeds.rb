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

Comic.find_or_create_by!(title: 'Preacher', issue_number: '1')
Comic.find_or_create_by!(title: 'Preacher', issue_number: '2')
Comic.find_or_create_by!(title: 'Preacher', issue_number: '3')
Comic.find_or_create_by!(title: 'Preacher', issue_number: '4')
Comic.find_or_create_by!(title: 'Preacher', issue_number: '5')
Comic.find_or_create_by!(title: 'Spider-Man', issue_number: '1')
Comic.find_or_create_by!(title: 'Spider-Man', issue_number: '2')
Comic.find_or_create_by!(title: 'Spider-Man', issue_number: '3')
Comic.find_or_create_by!(title: 'Spider-Man', issue_number: '4')
Comic.find_or_create_by!(title: 'Spider-Man', issue_number: '5')
Comic.find_or_create_by!(title: 'Saga', issue_number: '1')
Comic.find_or_create_by!(title: 'Saga', issue_number: '2')
Comic.find_or_create_by!(title: 'Saga', issue_number: '3')
Comic.find_or_create_by!(title: 'Saga', issue_number: '4')
Comic.find_or_create_by!(title: 'Saga', issue_number: '5')
Comic.find_or_create_by!(title: 'Trees', issue_number: '1')
Comic.find_or_create_by!(title: 'Trees', issue_number: '2')
Comic.find_or_create_by!(title: 'Trees', issue_number: '3')
Comic.find_or_create_by!(title: 'Trees', issue_number: '4')
Comic.find_or_create_by!(title: 'Trees', issue_number: '5')

# u.users_comics.create(comic: c)
