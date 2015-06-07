require 'rapgenius'

class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy

  # RapGenius::Client.access_token = 'Q6RjOeRCD8S3720jq5frKI-YGMDTX0YYHniz5B7RYpQUsfr3uNDdNDlI0_6gq61k'

  def self.get_songs!(artist)
    # songs =RapGenius.search(artist)
    # artist_songs=[]
    # songs.each do |song|
    #   artist_songs << RapGenius::Song.find(song.id)
    # end
    #
    # song = artist_songs.first.lines.map{|line|line.lyric}
    # song.map!{|line| line if [""," [?]",nil,["Intro"],["Verse 1"],["Verse 2"],"[]"].include?(line)!=true}
    string_song = "[Produced by DP Beats],,[Intro],,Niggas gon' get ASAP poppied, nigga\nRocky, nigga\nBang! Bang! Bang!,,[Hook],,Nigga where my money? Need it ASAP Rocky\nAnd we got them pistols, get it ASAP poppin'\nNigga want beef, then it's ASAP Rocky\nPull up on 'em, shhh, get to ASAP sparkin'\nNigga, we can do this ASAP doggy\nPull up on your ass with this ASAP doggy,,I remember selling ASAP Rocky, now I be getting ASAP guapy,,[Verse 1],,Shawty wanna talk, ASAP Rock\nAnd she from Hawaii, we just started talkin'\nBut I don't give a fuck, back to the money,,Walked up in the bank, walk out, laugh, and it's funny,,I remember serving junkies, now I'm getting Rocky,,ASAP Rocky, pull up on 'em, getting poppied,,This bitch pull up on me, treat my dick like I was Sochi,,Cuz I be counting guapy, ballin' is my hobby,Runnin' round the lobby, ,ASAP Rocky,Pullin' all the thotties, the thotties with the bodies,,Gold teeth, white diamonds, ASAP Rocky,I been getting money, 'member running from this squally,,[Hook],,[Verse 2],,I be by pesos, ASAP Rocky,Nigga wanna send shots, nigga SWAT me, nigga,,Got my gun, got bullets for everybody\nWe can do this ASAP Rocky\nWe can do this ASAP Ferg,,Nigga I got ASAP birds,,I ain't talkin' bricks, I'm talking Lugers,If you want it, I pull up, do you the worst,What you want? I gotta pull up on the curb,Street slanging, straight birds, so absurd,You missed yourself, and it's you pussy you get stirred,,Pistols bangin', we don't talk, we don't,,,[Hook],"
    string_song.gsub!(/\n/, " ").gsub!(/,/, " ")
    num_hooks = (string_song.scan(/\[Hook]/).length)-1

    # p num_hooks
    # p string_song
    hook = string_song[/(?<=\[Hook\])(.*)(?=\[Verse 1\])/]
    string_song.gsub!(/\[Hook]*/, " ")
    string_song << hook*num_hooks
    string_song.gsub!(/\[(.*?)\]/, " ")
    p string_song
  end
end
