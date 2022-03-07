class OrdersController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    
    def index 
        @orders = Order.where("order_id" => nil).limit(10)
    end
    
    def new
        user = current_user
        @order = user.orders.new
    end

    def new_params 
        user = current_user
        @order = user.orders.new
        if params[:origin_order_id]
            origin_order = Order.find(params[:origin_order_id])

            position = Order.where("user": current_user.id,"order_id": params[:origin_order_id])
            unless position.empty?
                flash[:alert] = "You already trade this order"
                redirect_to position.first
            end
            @order.process = origin_order.process == "sell" ? "buy" : "sell"
            @order.count = origin_order.count 
            @order.currency = origin_order.currency
            @order.order_id = origin_order.id
        end
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
        @partner_orders = Order.where("order_id": @order.id)
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
        params.require(:order).permit(:process,:currency_id,:status,:count,:order_id)
    end
end
