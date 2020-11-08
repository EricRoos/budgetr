class User < ApplicationRecord
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects


  def add_project(project)
    UserProject.transaction do
      project.save unless project.persisted?
      return false unless project.persisted?
      user_projects.build(project: project).save
    end
  end
end
