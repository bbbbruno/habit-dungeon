# frozen_string_literal: true

# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                     letter_opener_web        /letter_opener                                                                           LetterOpenerWeb::Engine
#                                  root GET    /                                                                                        home#index
#                      new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                       PUT    /users/password(.:format)                                                                devise/passwords#update
#                                       POST   /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                       PUT    /users(.:format)                                                                         devise/registrations#update
#                                       DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                       POST   /users(.:format)                                                                         devise/registrations#create
#                 new_user_confirmation GET    /users/confirmation/new(.:format)                                                        devise/confirmations#new
#                     user_confirmation GET    /users/confirmation(.:format)                                                            devise/confirmations#show
#                                       POST   /users/confirmation(.:format)                                                            devise/confirmations#create
#                              dungeons GET    /dungeons(.:format)                                                                      dungeons#index
#                                       POST   /dungeons(.:format)                                                                      dungeons#create
#                           new_dungeon GET    /dungeons/new(.:format)                                                                  dungeons#new
#                          edit_dungeon GET    /dungeons/:id/edit(.:format)                                                             dungeons#edit
#                               dungeon GET    /dungeons/:id(.:format)                                                                  dungeons#show
#                                       PATCH  /dungeons/:id(.:format)                                                                  dungeons#update
#                                       PUT    /dungeons/:id(.:format)                                                                  dungeons#update
#                                       DELETE /dungeons/:id(.:format)                                                                  dungeons#destroy
#                    challenge_attacked GET    /challenges/:challenge_id/attacked(.:format)                                             challenges/attacked#show
#                            challenges GET    /challenges(.:format)                                                                    challenges#index
#                                       POST   /challenges(.:format)                                                                    challenges#create
#                         new_challenge GET    /challenges/new(.:format)                                                                challenges#new
#                        edit_challenge GET    /challenges/:id/edit(.:format)                                                           challenges#edit
#                             challenge GET    /challenges/:id(.:format)                                                                challenges#show
#                                       PATCH  /challenges/:id(.:format)                                                                challenges#update
#                                       PUT    /challenges/:id(.:format)                                                                challenges#update
#                                       DELETE /challenges/:id(.:format)                                                                challenges#destroy
#                    api_dungeon_levels GET    /api/dungeons/:dungeon_id/levels(.:format)                                               api/dungeons/levels#index {:format=>/json/}
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for LetterOpenerWeb::Engine:
# clear_letters DELETE /clear(.:format)                 letter_opener_web/letters#clear
# delete_letter DELETE /:id(.:format)                   letter_opener_web/letters#destroy
#       letters GET    /                                letter_opener_web/letters#index
#        letter GET    /:id(/:style)(.:format)          letter_opener_web/letters#show
#               GET    /:id/attachments/:file(.:format) letter_opener_web/letters#attachment

Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: "home#index"

  devise_for :users

  resources :dungeons
  resources :challenges do
    resource :attacked, only: :show, controller: "challenges/attacked"
  end

  namespace :api, format: "json" do
    resources :dungeons, only: %i[] do
      resources :levels, only: %i[index], controller: "dungeons/levels"
    end
  end
end
