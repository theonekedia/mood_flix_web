module SessionsHelper

  def deny_access
    if session[:employee].nil?
      store_location
      redirect_to :controller => "/employees", :action => "employee_sign_in"
    else
      render :text => "You are not authorised to view this page", :status => 301
    end
  end

  def user_signed_in?
    return session[:user]
  end

  def current_user
    return session[:user]
  end

  def current_manager
    return session[:manager]
  end

  def loggedin_employee
    return session[:employee]
  end

  def create_user_session(id)
    session[:user] = id
    status = Hash.new
    status['redirect'] = clear_stored_location
    return status
  end
  
  def create_employee_session(id)
    session[:employee] = id
    status = Hash.new
    status['redirect'] = clear_stored_location 
    return status
  end

  def create_manager_session(id)
    session[:manager] = id
    status = Hash.new
    status['redirect'] = clear_stored_location
    return status
  end
  
  def destroy_employee_session
    clear_stored_location
    session[:employee] = nil
  end

  def destroy_manager_session
    clear_stored_location
    session[:manager] = nil
  end
  
  private

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_stored_location
    unless session[:return_to].nil?
      stored_location = session[:return_to]
      session[:return_to] = nil
      return stored_location
    else
      return nil
    end
  end

end
