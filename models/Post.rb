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

  def self.hydrate post_data # HYDRATION - cleaning up raw data pulled from database to turn it into a readable hash for the controller
    post = Post.new # new isntance of post

    # saves data from database into related variables on new post instance
    post.id = post_data['id']
    post.title = post_data['title']
    post.body = post_data['body']

    post # return post
  end
end
