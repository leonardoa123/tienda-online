class ProductsController < ApplicationController
    skip_before_action :protect_pages, only: [:index, :show]

    def index
        @categories = Category.order(name: :asc).load_async
        @products = Product.with_attached_photo

        if params[:category_id]
            @products = @products.where(category_id: params[:category_id])
        end
        if params[:min_price].present?
            @products = @products.where("price >= ?", params[:min_price])
        end
        if params[:max_price].present?
            @products = @products.where("price <= ?", params[:max_price])
        end
        if params[:title].present?
            @products = @products.where(title: params[:title])
        end

        order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])  

        @products = @products.order(order_by).load_async

        @pagy, @products = pagy_countless(@products, items: 10)
    end

    def show
        product
    end
    def new
        @product = Product.new   
    end
    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: 'Tu producto ha sido creado correctamente'
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
        product
    end
    def update
        
        product
        if @product.update(product_params)
            redirect_to products_path, notice: 'Producto actualizado'
        else
            render :edit, status: :unprocessable_entity
        end

    end

    def destroy
        
        product.destroy
        redirect_to products_path, notice: 'producto eliminado', status: :see_other
        
    end
    


    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :photo, :category_id)
        
    end
    def product
        @product = Product.find(params[:id])
    end
      
end
