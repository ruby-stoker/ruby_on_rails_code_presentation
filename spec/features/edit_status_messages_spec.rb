require 'rails_helper'

feature 'Updates status message', js: true do
  let!(:user) { create(:user, club_id: club.id) }
  let(:club) { create(:club) }

  before do
    login_to_club(club, user)
    visit profile_path
  end

  context 'edit status message' do
    scenario 'success' do
      expect(find('h4.thirdheading')).to have_content(user.name)
      find_link('Edit status message').click
      expect(page).to have_css('div.modal-content')
      find('#user_status').set('New status')
      find('input[type=submit]').trigger(:click)
      expect(find('div.profile-description')).to have_content('New status')
    end
  end
end
