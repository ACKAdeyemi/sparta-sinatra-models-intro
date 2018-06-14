class PostsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
      register Sinatra::Reloader
  end

  get '/' do

      @title = "Blog posts"

      @posts = Post.all

      erb :'posts/index'

  end

  get '/:id' do

    # get the ID and turn it in to an integer
    id = params[:id].to_i

    # make a single post object available in the template
    @post = Post.find id

    erb :'posts/show'

  end

  post '/' do

    "CREATE"

  end


  get '/new'  do

    "NEW"

  end

  put '/:id'  do

    "UPDATE: #{params[:id]}"

  end

  delete '/:id'  do

    "DELETE: #{params[:id]}"

  end

  get '/:id/edit'  do

    "EDIT: #{params[:id]}"

  end

end
