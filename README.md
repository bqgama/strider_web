# README

* Planning
  I would ask to the Product Manager if do I have to create a new table to register all associations between posts and replies,
  or do I have to create a new column in posts table called reply_id?

  My plan was to create a new table called reply;
  This table would be a self join association;
  One post could have many replies, but a reply has to belong one post or reply;

* Critique
  I would like to habe time to do the Extra feature;
  I would like to improve my rspec controllers test;
  Talking about scaling, I think User profile page would fail first, because it has to load many informations about all models;
  
