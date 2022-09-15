#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Members
    decorator RemoveReferences
    decorator UnspanAllTables
    decorator WikidataIdsDecorator::Links

    def member_container
      noko.xpath("//h2[.//span[contains(.,'Ministers')]]//following-sibling::ul[1]//li")
    end
  end

  class Member
    field :id do
      noko.css('a/@wikidata').first
    end

    field :name do
      noko.css('a').map(&:text).map(&:tidy).first
    end

    field :positionID do
    end

    field :position do
      noko.text.split(',', 2).last.tidy
    end

    field :startDate do
    end

    field :endDate do
    end

    private
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url).csv
