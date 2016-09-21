class Ability < ActiveRecord::Base
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :fosterer
      # can :manage, :all
    elsif user.role? :manager
      # can :manage, [Product, Asset, Issue]
    elsif user.role? :admin
      # can :read, [Product, Asset]
      # manage products, assets he owns
      # can :manage, Product do |product|
        # product.try(:owner) == user
      # end
      # can :manage, Asset do |asset|
        # asset.assetable.try(:owner) == user
      # end
    end

    if user.role? :active
    end

    if user.role? :deactive
    end
  end
end
