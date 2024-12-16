class ServiceRequestsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_service_request, only: [:show, :update, :destroy]

    def index
        @service_requests = policy_scope(ServiceRequest)
        render json: @service_requests
    end

    def show
        authorize @service_request
        render json: @service_request
    end
      
    def create
        @service_request = current_user.service_requests.build(service_request_params)
        authorize @service_request
      
        if @service_request.save
          render json: @service_request, status: :created
        else
          render json: @service_request.errors, status: :unprocessable_entity
        end
    end
      
    def update
        authorize @service_request
      
        if @service_request.update(service_request_params)
          render json: @service_request
        else
          render json: @service_request.errors, status: :unprocessable_entity
        end
    end   

    def destroy
        authorize @service_request
        @service_request.destroy
        head :no_content
    end    

    private

    def set_service_request
        @service_request = ServiceRequest.find(params[:id])
    end

    def service_request_params
        params.require(:service_request).permit(:citizen_name, :address, :category, :description, :status)
    end
end
