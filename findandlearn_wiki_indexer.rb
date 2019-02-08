module Dataspects

  class MediaWikiPage
    def hasEntityName
      "MY ENTITY NAME CUSTOMIZED AT INDEXING TIME"
    end
  end

  class FindAndLearnDocumentsIndexer < Indexer

    def initialize
      super(dataspects_indexing_service_url: "https://indexing.dataspects.com")
    end

    def execute
      mediawiki = MediaWiki.new(
        url: "https://cookbook.findandlearn.net/w",
        user: "",
        password: "",
        log_in: :must_log_in
      )
      mediawiki.originatedFromResourceSiloLabel = "FindAndLearn Cookbook"
      mediawiki.originatedFromResourceSiloID = "cookbook.findandlearn.net"
      mediawiki.resources_from_CATEGORY("Entity") do |resource|
        resource.entities.each do |entity|
          @escluster.index(
            body: entity.esdoc,
            index: "my_index"
          )
        end
      end
    end

  end
end

MediaWikiStandardIndexer.new.execute
