class Api::V1::RegistrationsController < Api::V1::BaseController
  before_filter :check_admin, :except => [ :show, :index, :by_faction ]
  #respond_to :json

  api! 'A specific registration'
  def show
    registrations = Registration.find(params[:id])
    render_registrations registrations
  end

  api! 'List of registrations'
  def index
    registrations = Registration.all
    render_registrations registrations
  end

  api! 'Get all registrations that are part of a certain faction'
  def by_faction
    def render_error
      render json: {
        error: { "Unknown faction name or id": params[:faction] },
        known_factions: {
          human: {id: Registration::HUMAN_FACTION, name: "human"},
          zombie: {id: Registration::ZOMBIE_FACTION, name: "zombie"},
          deceased: {id: Registration::DECEASED_FACTION, name: "deceased"}
        }
      }
    end
    if !params.has_key?(:faction)
      render_error
    end

    faction = params[:faction]
    if (faction == Registration::HUMAN_FACTION.to_s or faction.downcase == "human")
      registrations = Registration.where(faction_id: Registration::HUMAN_FACTION)
      render_registrations registrations

    elsif (faction == Registration::ZOMBIE_FACTION.to_s or faction.downcase == "zombie")
      registrations = Registration.where(faction_id: Registration::ZOMBIE_FACTION)
      render_registrations registrations

    elsif (faction == Registration::DECEASED_FACTION.to_s or faction.downcase == "deceased")
      registrations = Registration.where(faction_id: Registration::DECEASED_FACTION)
      render_registrations registrations
    else
      render_error
    end
  end

  def render_registrations (registrations)
    render(
      json: ActiveModel::ArraySerializer.new(
        registrations,
        each_serializer: Api::V1::RegistrationSerializer,
        root: 'registrations',
        #meta: meta_attributes(games)
      )
    )
  end
end
