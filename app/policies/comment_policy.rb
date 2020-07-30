class CommentPolicy < ApplicationPolicy
  def destroy?
    record.user.id == user.id
  end
end
