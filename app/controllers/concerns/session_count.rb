module SessionCount
	def increment_counter
		if session[:counter].nil?
        	session[:counter] = 0
      	end
      	session[:counter] += 1
      	if session[:counter] > 5
      		@counter = session[:counter]
        	return session[:counter]         
      	end
	end
end