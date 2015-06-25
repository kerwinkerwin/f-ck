class SongWord < ActiveRecord::Base
  belongs_to :song
  belongs_to :word
end
