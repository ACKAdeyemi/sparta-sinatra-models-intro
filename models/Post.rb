class Post

  attr_accessor :id, :title, :body

  def self.open_connection # open the connection to the database
    conn = PG.connect( dbname: 'blog' )
  end

  def self.all # method to get all instance from our database

    # calling the open_connection method
    conn = self.open_connection

    # creating a SQL string
    sql = "SELECT * FROM post ORDER BY id"

    # execute the connection with SQL string, stored in results variable
    results = conn.exec(sql) # controller will be able to access the data stored in results

    posts = results.map do |tuple| # tuple will become post_data, tuple = key value pair, look at tuple as each iteration through the loop
      self.hydrate tuple
    end
  end

  # find one instance/post using the ID that'll give it when we all it
  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM post WHERE id=#{id} LIMIT 1" # SQL to find using ID, limit provides very first one

    posts = conn.exec(sql) # get raw results

    post = self.hydrate posts[0] # clean up array

    post # return cleaned first post
  end

  def save
    conn = Post.open_connection

    if (!self.id) # if instance doesn't have an ID, create new isntance
      sql = "INSERT INTO post (title, body) VALUES ('#{self.title}','#{self.body}')"
    else
      sql = "UPDATE post SET title='#{self.title}', body='#{self.body}' WHERE id='#{self.id}'"
    end

    conn.exec(sql)
  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM post WHERE id=#{id}"

    conn.exec(sql)
  end

  def self.hydrate post_data # HYDRATION - cleaning up raw data pulled from database to turn it into a readable hash for the controller
    post = Post.new # new isntance of post

    # saves data from database into related variables on new post instance
    post.id = post_data['id']
    post.title = post_data['title']
    post.body = post_data['body']

    post # return post
  end
end
