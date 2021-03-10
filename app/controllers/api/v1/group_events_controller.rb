module Api
  module V1
    class GroupEventsController < ApplicationController
      before_action :set_group_event, except: %i(index create)

      #GET api/v1/group_events
      def index
        @group_events = GroupEvent.all
      end

      #GET api/v1/group_events/:id
      def show
      end

      #POST api/v1/group_events
      def create
        @group_event = GroupEvent.new(group_event_params.except(:id))
        respond_to do |format|
          if @group_event.save
            format.json { render :show, status: :created }
          else
            format.json { render json: @group_event.errors.full_messages, status: :unprocessable_entity }
          end
        end
      end

      #PATCH api/v1/group_events/:id
      def update
        respond_to do |format|
          if @group_event.update(group_event_params.except(:id))
            format.json { render :show, status: :created }
          else
            format.json { render json: @group_event.errors.full_messages, status: :unprocessable_entity }
          end
        end
      end

      #DELETE api/v1/group_events/:id
      def destroy
        @group_event.destroy!
        head :no_content
      end

      private

      def set_group_event
        @group_event = GroupEvent.find(group_event_params[:id])
      end

      def group_event_params
        params.permit(:id, :name, :description, :location, :start_date, :end_date, :duration, :published_at)
      end
    end
  end
end
