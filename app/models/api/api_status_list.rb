module Api
  module ApiStatusList 
    OK = { 'status' => 'OK', 'message' => 'success'}
    UNKNOWN_ERROR = { 'status' => 'UNKNOWN_ERROR', 'message' => 'An error occurred. Please retry.'}
    ZERO_RESULTS = { 'status' => 'ZERO_RESULTS', 'message' => 'No matching results were found'}
    OVER_QUERY_LIMIT = { 'status' => 'OVER_QUERY_LIMIT', 'message' => 'You have exhausted your api quota'}
    REQUEST_DENIED = { 'status' => 'REQUEST_DENIED', 'message' => 'You are not authorised to make this request.'}
    INVALID_REQUEST = { 'status' => 'INVALID_REQUEST', 'message' => 'The request you sent is invalid'}
    NOT_FOUND = { 'status' => 'NOT_FOUND', 'message' => 'The requested resource could not be found.'}
    INACTIVE_LISTING = { 'status' => 'INACTIVE_LISTING', 'message' => 'The requested listing has expired'}
    INVALID_CAPTCHA = { 'status' => 'INVALID_CAPTCHA', 'message' => 'Captcha validation failed.'}
    INVALID_API_KEY = { 'status' => 'INVALID_API_KEY', 'message' => 'Your API key is invalid.'}
  end
end