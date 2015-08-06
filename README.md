# 4Finance Home Assignment

A demo micro-lending app. It is a Ruby on Rails app, setup should be pretty straightforward.
I use RVM and MySQL, rbenv and SQLite might also work (haven't tested).

Some comments and assumptions:
- Annual percentage rate is set to 219%.
- There is no fixed commission component to loans - this is different from actual services provided in the market.
- Layout is optimized for mobile.
- App provides basic functionality without Javascript - loan can be taken out, extended and repaid.
- User creation and session managemenent is taken care of behind the scenes (devise gem). Full-fledged user management (signup, sign-in, sign-out, password recovery) is possibe with current approach but beyond the scope of this task.
