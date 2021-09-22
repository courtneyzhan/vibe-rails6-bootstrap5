class ChartsController < SecureController
  
  def index
    # database query
    @moods = Mood.where(:user_id => current_user.id).order("date ASC")
    mood_map = { "Very Positive": 5,  "Positive": 4,  "Neutral": 3, "Negative": 2, "Very Negative": 1 }
    @data = @moods.to_a.collect{|x| {"id":x.id, "date": x.date.strftime("%Y-%m-%d"), "y": mood_map[x.mood.to_sym]} }.to_json
  end
  
end
