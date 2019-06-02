module Background
	class ApplicationPunditController < Background::ApplicationController

		load_and_authorize_resource 
		
		rescue_from CanCan::AccessDenied do |exception|
		  respond_to do |format|
		    format.json { head :forbidden, content_type: 'text/html', status: 401 }
		    format.html { render_error_page(401) }
		    format.js   { head :forbidden, content_type: 'text/html', status: 401  }
		  end
		end

	end
end