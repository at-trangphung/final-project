class SearchServices
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def search_category
    unless params[:search] == ''
      @categoryList = Category.all
      @categories = Array.new
      @categoryList.map do |category|
        if (params[:search][ 0, params[:search].length ]).casecmp?(product.name[ 0, 
                                                          params[:search].length ])
          @categories << category
        end
      end
    end
    @categories
  end

end