class ErrorSerializer
  def self.not_found(message)
    {
      "message": "No record found",
      "errors": [message]
    }
  end
  
  def self.missing_attributes(messages)
    {
      "message": "Record is missing one or more attributes",
      "errors": messages
    }
  end

  def self.already_exists
    {
      "message": "Record already exists",
      "errors": ["This strava activity has already been logged"]
    }
  end
end