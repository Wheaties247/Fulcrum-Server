class ResultsController < ApplicationController
	# the entry method allows for server requests that send POSTs 
	# to use the endpoint makeEntry 


	# which created the post 
	# 
	def entry
		p 'IN  entry', params
		crown = params[:crown]
		third = params[:third]
		throat = params[:throat]
		heart = params[:heart]
		navel = params[:navel]
		root = params[:root]
		power = params[:power]
		user_id = params[:user_id]
		# pulls information from the body 
		# of the post request and save them to their respective variables 

		dailyRecordQuery = Result.where(user_id: user_id ,created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).first
		# create variable dailyRecordQuery and have it equal the return of
		# an activerecord query for any records created where
		# the posting user, between the start and end of the day
		p 'dailyRecordQuery', dailyRecordQuery

		if dailyRecordQuery.nil? 
		# if the value of dailyRecordQuery returns null
			p 'Record not created today'
			record = Result.create({crown: crown, third: third, throat: throat, heart: heart, navel: navel, root: root, power: power, user_id: user_id})
		# create new variable called record and set it equal to return of 
		# activerecord create query with respective variables and values

			render json: {message: record}
		# then send the client back a responce of the created record
		else
			# if the result of the query is not null
			p 'Record created today'
			dailyRecordQuery.update({crown: crown, third: third, throat: throat, heart: heart, navel: navel, root: root, power: power, user_id: user_id})
			# update the record recieved with the parameters passed into the body of the post request
			render json: {message: dailyRecordQuery}
			# then send the client back the record updated
		end

	end
	# the all method allows for server requests that send POSTs 
	# to the endpoint allRecords
	def all
		p '*****IN ALL***** with params', params
		p'user_id', params[:userInfo][:user_id]
		user_id = params[:userInfo][:user_id]
		# create variable user_id equal to the respective value 
		allUsersRecords = Result.where(user_id: user_id)
		# create variable allUsersRecords that is equal to 
		# the activerecord query where user_id is the user_id passed in from the POST requests body
		
		# ===============test for lastUserRecord=========
		# lastUserRecord = allUsersRecords.last.created_at.to_date

		lastUserRecord = allUsersRecords.order("created_at").last
		# create variable lastUserRecord equal to
		# the last created allUsersRecords entry
		
		# ===============test for lastUserRecord=========

		daysPassed = 0
		# create variable daysPassed equal to 0
		numberOfRecords = allUsersRecords.length
		# create variable numberOfRecords equal to the length of allUsersRecords array
		# ===============test for firstRecordDate=========
		# firstRecordDate = allUsersRecords.first.created_at.to_date

		firstRecordDate = allUsersRecords.order("created_at").first
		# create variable firstRecordDate equal to
		# first created allUsersRecords entry
		# ===============test for firstRecordDate=========

		
		p 'firstRecordDate', firstRecordDate
		updatedRecords = []
		i = 0
		# create variable updatedRecords equal to empty array
		# as well as variable i equal to 0

		p 'allUsersRecords', allUsersRecords
		p 'recordsMade', numberOfRecords
		loop do 
			# loop calculates time between record creation
		  p  'allUsersRecords at I', allUsersRecords[i]
	
		recordedFirstDate = allUsersRecords[i].created_at.to_date
	 	# create recordedFirstDate variable and set it equal to the array 
	 	# of allUsersRecords at the current loop iterations 
	 	# created time property converted to date

		  updatedRecords.push({record: allUsersRecords[i], recordDate: recordedFirstDate})
		# for each iteration of the loop add an object to the 
		# updatedRecords array with properties;
		# record, equal to the array of allUsersRecords at the current 
		# loop iteration 
		# and recordDate, equal to recordedFirstDate

		  
		  p 'recordedFirstDate', recordedFirstDate
			recordedSecondDate = allUsersRecords[ (i + 1) ].created_at.to_date
		# create variable recordedSecondDate equal to the following 
		# allUsersRecords index's created time property, converted to date
		  p 'updatedRecords', updatedRecords
			if recordedSecondDate.nil?
				p 'recordedSecondDate is nil'
				break
			# if recordedSecondDate is null then end the loop
			else	
			# if recordedSecondDate is not null 
			  p 'recordedSecondDate', recordedSecondDate
				difference = ( recordedSecondDate - recordedFirstDate ).to_i
			# create difference variable equal to 
			# calculated difference between the dates 
			# coverted to an integer 

			  p 'difference', difference
				daysPassed += difference
			# add difference to the value of daysPassed
			  p 'daysPassed (After loop Iteration)', daysPassed

			  
			end
		i += 1
		# then add one to the loop
		end
		if numberOfRecords <2
		# if numberOfRecords is less than 2
				p 'recordedSecondDate is nil Render'
			return render json: {message: {results: updatedRecords, daysMissed: 'First day', recordsMade: numberOfRecords, lastUserRecord: lastUserRecord, firstRecordDate: firstRecordDate} }
		# send responce object to client with properties;
		# results equal to updatedRecords
		# daysMissed equal to string 'First day'
		# recordsMade equal to numberOfRecords
		# lastUserRecord equal to lastUserRecord
		# and firstRecordDate equal to firstRecordDate
		else
		#  if numberOfRecords is greater than 2
		 dateOfLastRecord = lastUserRecord.created_at.to_date
		# create variable dateOfLastRecord equal to lastUserRecords 
		# created time converted to date

		 p 'lastUserRecordDate', dateOfLastRecord
		 todaysDate = DateTime.now.to_date
		# create variable todaysDate equal to the current time 
		# converted to date

		 p 'todays Date', todaysDate
		 differenceOfTodayAndLastRecord = (todaysDate - dateOfLastRecord).to_i
		# create variable differenceOfTodayAndLastRecord
		# equal to the difference between todaysDate and dateOfLastRecord
		# converted to an integer
		 p 'Difference of today and last user record', differenceOfTodayAndLastRecord
		daysMissed = ( daysPassed - allUsersRecords.length ) + differenceOfTodayAndLastRecord
		# create variable daysMissed
		# equal to difference between daysPassed and allUsersRecords
		# added to differenceOfTodayAndLastRecord 
		# to get total days records were not created

		 p 'daysMissed after today calc', daysMissed

		render json: {message: {results: updatedRecords, daysMissed: daysMissed, recordsMade: numberOfRecords, lastUserRecord: lastUserRecord, firstRecordDate: firstRecordDate} }
		# send responce object to client with properties;
		# results equal to updatedRecords
		# daysMissed equal to daysMissed
		# recordsMade equal to numberOfRecords
		# lastUserRecord equal to lastUserRecord
		# and firstRecordDate equal to firstRecordDate
		end
	end


end
