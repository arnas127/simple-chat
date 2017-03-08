# README

This is simple Chat application bases on ActionCable.

USE CASES:

 * user can enter his username select dialect and join general conversation

 * User can see other active users on sidebar at left

 * user can type message and press enter to send it

 * users can delete his messages by clicking red 'x' icon (Additional feature)



system details:

 * messages are processed in server side and translated to the dialect witch user has selected at the begging.

 * www.degraeve.com is used for message translation

 * multiple users with same user name will be counted as same one user.

 * after message deletion icon click message will be deleted on all users screens instantly


### Set up

  ```
    bundle install
    rake db:create db:migrate
    rails s
  ```
