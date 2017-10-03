class PostsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  # Turn on Sinatra Reloader
  configure :development do
      register Sinatra::Reloader
  end

  $posts = [{
      id: 0,
      title: "Post 1",
      body: "This is the first post"
  },
  {
      id: 1,
      title: "Post 2",
      body: "This is the second post"
  },
  {
      id: 2,
      title: "Post 3",
      body: "This is the third post"
  }];

  get '/' do

      @title = "Blog posts"

      @posts = Post.all
  
      erb :'posts/index'
  
  end

  get '/new'  do

    # create an empty post
    @post = Post.new 

    erb :'posts/new'
    
  end
    
  get '/:id' do
    id = params[:id] 
    @post = Post.find(id)
  erb :"posts/show"
    
  end
    
  post '/' do
    
    post = Post.new
    post.title = params[:title]
    post.body = params[:body]
    post.save
    redirect "/"
    
  end
    
  put '/:id'  do
    
    # data is gathered in the params object
    id = params[:id].to_i
      
    # get the post object from our data store
    post = Post.find(id)
      
    # update the values of the object with data from the request
    post.title = params[:title]
    post.body = params[:body]
      
    # save the post back to our data store ( at the spot it came from this time )
    post.save
      
    # redirect the user to a GET route. We'll go back to the INDEX.
    redirect "/";
    
  end
    
  delete '/:id'  do
    
    # get the ID
    id = params[:id].to_i

    # delete the post from the array
    post.destroy(id)

    # redirect back to the homepage
    redirect "/"
    
  end
    
  get '/:id/edit'  do

    
    # get the ID and turn it in to an integer
    id = params[:id].to_i

    # make a single post object available in the template
    @post = Post.find(id)

    erb :'posts/edit'
    
  end

end