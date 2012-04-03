class UsersController < ApplicationController
   def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
   end
   def create
      @user = User.new(params[:user])
      respond_to do |format|
      if @user.save
        format.html { redirect_to "/", notice: 'Signed Up Succesfully!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
   end
   def index
      @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
   end
   def show
    @user = User.find(params[:id])
    posts = []
    @user.posts.each do |post|
       post_obj = {}
       post_obj[:id] = post.id
       post_obj[:comments] = []
       post.comments.each do |comment|
          post_obj[:comments].insert(-1,comment.id)
       end
       posts.insert(-1,post_obj)
       
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {:user => @user,:posts => posts} }
    end
   end
   def signin
      if params[:username] != nil
         
         @user = User.find_by_username(params[:username])
         if @user.password == params[:password]
            cookies[:user] = @user.id
            notice = "Welcome "+@user.name+" !!"
         
         else
            notice = "Unable to signin!"
         end
         
         respond_to do |format|
            format.html { redirect_to "/", notice: notice }
         end
      else
         respond_to do |format|
            format.html 
         end
      end
   end
end
