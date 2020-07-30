class ArticlePolicy < ApplicationPolicy
  def update?
    record.user.id == user.id
  end

  def destroy?
    record.user.id == user.id
  end
end
