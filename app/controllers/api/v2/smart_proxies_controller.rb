module Api
  module V2
    class SmartProxiesController < V1::SmartProxiesController

      include Api::Version2
      include Api::TaxonomyScope

      def index
        super
        render :template => "api/v1/smart_proxies/index"
      end

      def show
        super
        render :template => "api/v1/smart_proxies/show"
      end

      api :GET, "/smart_proxies/:id/import_all_environments", "Import puppetclasses from smart proxy"
      param :id, :number, :required => true, :desc => "smart proxy id"

      def import_all_environements
        opts = { :url => SmartProxy.find(:id).try(:url) }
        @importer = PuppetClassImporter.new(opts)
        @changed  = @importer.changes
        PuppetClassImporter.new.obsolete_and_new(@changed)
      end

    end
  end
end
