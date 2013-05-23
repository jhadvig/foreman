module Api
	module V2
		class HostsController < V1::HostsController

			include Api::Version2
			include Api::TaxonomyScope

			before_filter :find_resource, :only => [:puppetrun]

			api :GET, "/hosts/:id/puppetrun", "Run puppet on host."
			param :id, :identifier, :required => true, :desc => "host id"
			def puppetrun
				@host.puppetrun! if Setting[:puppetrun]		
			end

		end
	end
end