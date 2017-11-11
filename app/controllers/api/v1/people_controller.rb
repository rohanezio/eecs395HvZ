class Api::V1::PeopleController < ApplicationController
  before_filter :check_admin, :except => [ :show, :index ]
  #respond_to :json
  protect_from_forgery with: :null_session
  before_action :destroy_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def show
    people = Person.find(params[:id])
    render json: Api::V1::PersonSerializer.new(people).to_json
  end

  def index
    people = Person.all.order(created_at: :asc)
    render(
      json: ActiveModel::ArraySerializer.new(
        people,
        each_serializer: Api::V1::PersonSerializer,
        root: 'people',
        #meta: meta_attributes(people)
      )
    )
  end
end
