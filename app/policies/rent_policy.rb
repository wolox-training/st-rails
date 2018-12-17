class RentPolicy
  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  def create?
    user.id == rent.user_id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.rented_by(user.id)
    end
  end
end
