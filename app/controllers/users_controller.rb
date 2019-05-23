class UsersController < ApplicationController
	# the login method allows for server requests that send POSTs 
	# to login endpoint
	def login
		p params, 'THE PARAMS FOR LOGIN'
		username = params[:usernameFixed]
		password = params[:password]
		# create variables username & password equal to respective 
		# post body parameters
		userExists = User.exists?(user_name: username)
		# create variable userExists 
		# equal to boolean value if current user exists
		if userExists == true
			# if userExists is true
			p 'User exists'
			user = User.exists?(user_name: username, password: password)
			# create variable user 
			# equal to boolean value and check if an active record exist
			# with respective user_name and password values

			if user === false
			p 'Incorrect password'
			render json: {message: 'Incorrect password'}
			# if user variable is false 
			# send responce to client of object with message property
			# equal to string 'Incorrect password'
			else
			# if user variable is true

			p 'USER PARAMS CORRECT', user
			user = User.find_by(user_name: username, password: password )
			# find the activeRecord with 
			# respective user_name and password values
			render json: {message: {username: user[:user_name], user_id: user[:id]}}
			# send responce to client of object with message property
			# equal to object with properties;
			# username, equal to the user_name property of user activerecord
			# and user_id, equal to the id property of user activerecord
			end
				
		else
			p 'User NOT Found'
				render json: {message: 'User Not Found'}
		# if userExists is false 
		# send responce to client of object with message property
		# equal to string 'User Not Found'

		end
		
	end
	# the register method allows for server requests that send POSTs 
	# to register endpoint
	def register
		username = params[:usernameFixed]
		password = params[:password]
		email = params[:email]
		# create variables username, password, and email
		# equal to respective post body parameters
		userExists = User.exists?(user_name: username)
		# create variable userExists
		# equal to boolean value if an active record exist
		# with respective user_name value 
		if userExists
			# if userExists is 'truthy'
			p 'USER ALREADY EXISTS'
			render json: {message: 'The inputed Username already exists'}
			# send responce to client of object with message property
			# equal to string 'The inputed Username already exists'
		else
			# if userExists is not 'truthy'

			user = User.create!({user_name: username, password: password, email: email})
			# create variable user equal to result of 
			# creating an activerecord with respective user_name, password, and email properties

			# @user = user
			# UserMailer.with(user: @user).welcome_email.deliver_now
			render json: {message: {username: username, user_id: user[:id]}}
			# send responce to client of object with message property
			# equal to ỏbject with properties
			# username and user_id equal to respective properties
		end

	end
	# the lostCreds method allows for server requests that send POSTs 
	# to lost endpoint
	def lostCreds
		p params, "lostCreds"
		render json: {message: "complete"}
		# send responce to client of object with message property
		# equal to string "complete"
	end
end
