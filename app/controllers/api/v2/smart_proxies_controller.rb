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

      api :GET, "/smart_proxies/:id/import_all_environments/", "Import environments and puppetclasses from smart proxy"
      param :id, :integer, :required => true, :desc => "smart proxy id"
      def import_all_environments
        opts = { :url => SmartProxy.find(params[:id]).url }
        @importer = PuppetClassImporter.new(opts)
        @changed  = @importer.changes 
        if @changed["new"].size > 0 or @changed["obsolete"].size > 0 or @changed["updated"].size > 0
                @changed.delete_if {|k,v| v.empty?}
                @changed.each {|e,i| i.each {|k,v| i[k]=v.to_json }}
                ::PuppetClassImporter.new.obsolete_and_new(@changed)
                render :json => @changed
        else
        render :json => @changed.to_json
        end
      end

    end
  end
end
