class StatementsController < ApplicationController
	def index
		statements = Statement.all
		p statements, 'statements!'
		render json: statements
	end
end
