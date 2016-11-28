require 'rails_helper'

feature 'Updates profile', js: true do
  let!(:user) { create(:user, club_id: club.id) }
  let(:club) { create(:club) }

  background do
    login_to_club(club, user)
    visit edit_user_path(user)
  end

  context 'email and password' do
    before(:each) do
      find_link('Password/Email').click
    end

    scenario 'successful update' do
      find_link('Password/Email').click # change tab to Password/Email
      expect(page).to have_css('div.profile-form-title', text: 'Password / Email')
      find('#update_password_form_current_password').set('test1')
      find('#update_password_form_password').set('new_test')
      find('#update_password_form_password_confirmation').set('new_test')
      find('#update_password_form_email').set('new_email@mail.com')
      find('#update_password_form_email_confirmation').set('new_email@mail.com')
      find('input[type=submit]').trigger(:click)
      expect(page).to have_content('Successfully updated')
      user.reload
      expect(user.email).to eq('new_email@mail.com')
      expect(user.authenticate_field(:password, 'new_test')).to be_truthy
    end

    scenario 'fail' do
      message_text = "can't be blank, Current password is incorrect, You have to update at least one attribute"
      expect(page).to have_css('div.profile-form-title', text: 'Password / Email')
      find('input[type=submit]').trigger(:click)
      expect(page).to have_text(message_text)
    end
  end

  context 'general information' do
    scenario 'success' do
      expect(page).to have_css('div.profile-form-title', text: 'General')
      find('#update_user_general_information_form_first_name').set('New name')
      find('#update_user_general_information_form_last_name').set('New last name')
      find('input[type=submit]').trigger(:click)
      expect(page).to have_css('div.alert.alert-success')
      expect(find('div.alert.alert-success')).to have_content('Successfully updated')
      user.reload
      expect(user.first_name).to eq 'New name'
      expect(user.last_name).to eq 'New last name'
    end
  end

  context 'contacts' do
    scenario 'success' do
      find_link('Contacts').click
      expect(page).to have_css('div.profile-form-title', text: 'Contacts')
      find('#update_user_contact_information_form_address').set('new address')
      find('#update_user_contact_information_form_phone').set('123456789')
      find('#update_user_contact_information_form_website').set('http://google.com')
      find('input[type=submit]').trigger(:click)
      expect(page).to have_css('div.alert.alert-success')
      expect(find('div.alert.alert-success')).to have_content('Successfully updated')
      user.reload
      expect(user.address).to eq 'new address'
      expect(user.phone).to eq '123456789'
      expect(user.website).to eq 'http://google.com'
    end
  end
end
