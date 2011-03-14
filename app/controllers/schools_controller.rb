class SchoolsController < ApplicationController
  before_filter :find_school, :only => [:show]
  
  def index
    
  end
  
  def show
  end
  
  def new
    @school = School.new
  end
  
  def create
    @school = School.new(params[:school])
    if @school.save
      redirect_to(@school, :notice => "哇哦！ #{@school.name} 成功创建！")
    else
      render :new
    end
  end
  
  protected
    def find_school
      @school = School.find_by_abbr(params[:id])
    end
end
