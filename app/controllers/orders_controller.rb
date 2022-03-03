class OrdersController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    
    def index 
    end
    
    def new
        user = current_user
        @order = user.orders.new
    end

    def create
        user = current_user
        @order = user.orders.new(order_params)

        if @order.save
            redirect_to @order 
        else 
            render :new
        end
    end

    def show
        @order = Order.find(params[:id])
    end

    def edit
        @order = Order.find(params[:id])
        if @order.user != current_user
            flash[:alert] = "You can`t edit this order"
            redirect_to root_path
        end
    end

    def update
        @order = Order.find(params[:id])

        if @order.update(order_params)
            redirect_to @order 
        else
            render :edit 
        end
    end 

    def destroy
        @order = Order.find(params[:id])
        if current_user == @order.user
            @order.destroy
        else  
            flash[:alert] = "You cant delete this order"      
        end 
        redirect_to root_path
    end

    private
    def order_params
        params.require(:order).permit(:process,:currency_id,:status,:count)
    end
end
