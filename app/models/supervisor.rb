class Supervisor < User
  has_many :supervisor_volunteers, foreign_key: "supervisor_id"
  has_many :active_supervisor_volunteers, -> { where(is_active: true) }, class_name: "SupervisorVolunteer", foreign_key: "supervisor_id"
  has_many :unassigned_supervisor_volunteers, -> { where(is_active: false) }, class_name: "SupervisorVolunteer", foreign_key: "supervisor_id"

  has_many :volunteers, -> { includes(:supervisor_volunteer).order(:display_name) }, through: :active_supervisor_volunteers
  has_many :volunteers_ever_assigned, -> { includes(:supervisor_volunteer).order(:display_name) }, through: :supervisor_volunteers, source: :volunteer
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  display_name           :string           default("")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  casa_org_id            :bigint           not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_casa_org_id                        (casa_org_id)
#  index_users_on_email                              (email) UNIQUE
#  index_users_on_invitation_token                   (invitation_token) UNIQUE
#  index_users_on_invitations_count                  (invitations_count)
#  index_users_on_invited_by_id                      (invited_by_id)
#  index_users_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_users_on_reset_password_token               (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (casa_org_id => casa_orgs.id)
#
