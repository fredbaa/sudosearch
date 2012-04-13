class SearchController < ActionController::Base
  layout 'main'
  
  def index
    @site_categories = SiteListCategory.all
  end
  
  def search
    query = params[:q]
    site_categs = SiteListCategory.find(:all, :conditions => ["code in (?)", params[:category].split(",")])
    sites = SiteList.find(:all, :conditions => ["site_list_category_id in (?)", site_categs.map(&:id)]).group_by(&:site_list_category_id)

    log_it({:path => params[:category], :query => params[:q], :date => Time.now.strftime("%H:%M %p, %B %d, %Y")})
    
    render :update do |page|
      page.replace_html("results_frame", render(:partial => "search/search_results", :locals => {:query => query, :site_categs => site_categs, :sites => sites}))
      page << "jQuery('#results_link').click();"
      page << "hideLoader();"
    end
  end
  
  private
  
  def log_it(data)
    logger.info ""
    logger.info "==============================================================="
    logger.info "Search categories: " + data[:path]
    logger.info "Parameters: " + data[:query]
    logger.info "Time: " + data[:date]
    logger.info "==============================================================="
    logger.info ""
  end

end
