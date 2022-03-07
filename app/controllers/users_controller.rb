class UsersController < ApplicationController
    before_action :authenticate_user!
    def show
        user = current_user
        @orders = user.orders.where("order_id": nil)
        @poses = Order.where("user": current_user.id).where.not("order_id": nil)
    end
end
