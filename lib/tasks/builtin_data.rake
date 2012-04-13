namespace 'builtin_data' do

  task :db_connect => :environment do
    ActiveRecord::Base.establish_connection(Rails.env)
  end

  task :setup_sites => [:environment, :db_connect] do
    # Site Category Seeds
    puts "Updating Site List and Categories Info..."

    SiteListCategory.all.each{|c| c.destroy}
    SiteList.all.each{|s| s.destroy}

    site_categories = [
        {:code => "main", :name => "General Searches"},
        {:code => "torrents", :name => "Torrents"},
        {:code => "subtitles", :name => "Subtitles"},
        {:code => "music", :name => "Music"},
        {:code => "videos", :name => "Videos"},
        {:code => "images", :name => "Images"},
        {:code => "domain", :name => "Domain Check"},
        {:code => "news", :name => "News"},
        {:code => "apps", :name => "Applications"},
        {:code => "people", :name => "People"},
        {:code => "games", :name => "Games"},
        {:code => "food", :name => "Food and Booze"}
      ]

    site_categories.each do |cat|
      SiteListCategory.create(cat)
      puts "** Created site category: #{cat[:name]}"
    end

    # Site List Seeds
    site_cats = SiteListCategory.all

    sites = {}

    sites[:main] = [
        {:code => "google", :name => "Google", :url => "http://google.com/#q="},
        {:code => "stack_overflow", :name => "Stack Overflow", :url => "http://stackoverflow.com/search?q="},
        {:code => "yahoo", :name => "Yahoo!", :url => "http://search.yahoo.com/search;_ylt=As_inMYWdRFW4bN69tLNAI2bvZx4?p="},
        {:code => "wikipedia", :name => "Wikipedia", :url => "http://en.wikipedia.org/w/index.php?search="}
      ]

    sites[:torrents] = [
        {:code => "torrentz", :name => "Torrentz", :url => "http://torrentz.com/search?f="},
        {:code => "btjunkie", :name => "BTJunkie", :url => "http://btjunkie.org/search?q="},
        {:code => "thepiratebay", :name => "The Pirate Bay", :url => "http://thepiratebay.org/search/"},
        {:code => "isohunt", :name => "IsoHunt", :url => "http://isohunt.com/torrents/?ihq="},
        {:code => "kickasstorrents", :name => "KickAssTorrents", :url => "http://www.kickasstorrents.com/search/"}
      ]

    sites[:subtitles] = [
        {:code => "subscene", :name => "Subscene", :url => "http://subscene.com/filmsearch.aspx?q="},
        {:code => "opensubtitles", :name => "OpenSubtitles", :url => "http://www.opensubtitles.org/en/search2/sublanguageid-all/moviename-"},
        {:code => "addicted", :name => "Addic7ed", :url => "http://www.addic7ed.com/search.php?search="},
        {:code => "tvsubs", :name => "TVSubs", :url => "http://www.tvsubs.net/search.php?q="},
        {:code => "tvsubtitles", :name => "TVSubtitles", :url => "http://www.tvsubtitles.net/search.php?q="}
      ]

    sites[:music] = [
        {:code => "mp3codes", :name => "MP3-Codes", :url => "http://www.mp3-codes.com/library/search/"},
        {:code => "beemp3", :name => "Bee MP3", :url => "http://beemp3.com/index.php?st=all&q="},
        {:code => "4shared", :name => "4Shared", :url => "http://search.4shared.com/q/1/"},
        {:code => "aimini", :name => "Aimini", :url => "http://www.aimini.net/search/?q="},
        {:code => "emp3world", :name => "eMP3World", :url => "http://www.emp3world.com/search.php?type=mp3s&submit=Search&phrase="},
        {:code => "bombmp3", :name => "Bomb MP3", :url => "http://www.bomb-mp3.com/index.php?submit=Search&search="}
      ]

    sites[:videos] = [
        {:code => "youtube", :name => "Youtube", :url => "http://www.youtube.com/results?search_query="},
        {:code => "break", :name => "Break!", :url => "http://www.break.com/surfacevideo/"},
        {:code => "google_video", :name => "Google Videos", :url => "http://www.google.com/search?tbs=vid:1&q="},
        {:code => "rotten_tomatoes", :name => "Rotten Tomatoes", :url => "http://www.rottentomatoes.com/search/full_search.php?search="}
      ]

    sites[:news] = [
        {:code => "google_news", :name => "Google News", :url => "http://www.google.com/search?tbs=nws:1&q="},
        {:code => "cnn", :name => "CNN", :url => "http://edition.cnn.com/search/?query="},
        {:code => "bbc", :name => "BBC UK", :url => "http://www.bbc.co.uk/search/"},
        {:code => "espn", :name => "ESPN", :url => "http://search.espn.go.com/"}
      ]

    sites[:images] = [
        {:code => "google_images", :name => "Google Images", :url => "http://www.google.com/images?q="},
        {:code => "flickr", :name => "Flickr", :url => "http://www.flickr.com/search/?q="},
        {:code => "shutter_stock", :name => "Shutter Stock", :url => "http://www.shutterstock.com/cat.mhtml?searchterm="}
      ]

    sites[:domain] = [
        {:code => "ud", :name => "UD Domain Check", :url => "http://www.namecheck.com/search/"},
        {:code => "whois", :name => "Whois.Net", :url => "http://www.whois.net/search-domains/"}
      ]

    sites[:apps] = [
        {:code => "apple", :name => "Apple", :url => "http://www.apple.com/search/?q="},
        {:code => "cnet", :name => "CNET Download", :url => "http://download.cnet.com/1770-20_4-0.html?searchtype=downloads&query="},
        {:code => "getjar", :name => "GetJar (Mobile)", :url => "http://www.getjar.com/mobile-all-applications/"},
        {:code => "iphoneapplist", :name => "iPhone App List", :url => "http://iphoneapplicationlist.com/search/?type=all&s="},
        {:code => "softpedia", :name => "Softpedia", :url => "http://www.softpedia.com/dyn-search.php?search_term="}
      ]

    sites[:games] = [
        {:code => "gamehouse", :name => "GameHouse", :url => "http://www.gamehouse.com/search-results?q="},
        {:code => "gamepro", :name => "GamePRO", :url => "http://www.gamepro.com/search/?q="},
        {:code => "newgrounds", :name => "NewGrounds", :url => "http://www.newgrounds.com/portal/search/title/"},
        {:code => "miniclip", :name => "MiniClip", :url => "http://www.miniclip.com/games/en/search.php?query="},
        {:code => "yahoo_games", :name => "Yahoo! Games", :url => "http://search.yahoo.com/search?vs=games.yahoo.com,videogames.yahoo.com&fr=games_ss&ei=UTF-8&p="},
        {:code => "google_games", :name => "Google Games", :url => "http://www.google.com/search?sa=Google+Search&cat=gwd/Top/Games&hl=en&q="},
        {:code => "kongregate", :name => "Kongregate", :url => "http://www.kongregate.com/search?q="}

      ]

    sites[:people] = [
        {:code => "facebook", :name => "Facebook", :url => "http://www.facebook.com/search.php?q="},
        {:code => "myspace", :name => "MySpace", :url => "http://searchservice.myspace.com/index.cfm?fuseaction=sitesearch.results&type=people&orig=friend_finder-search&srchBy=All&qry="},
        {:code => "friendster", :name => "Friendster", :url => "http://www.friendster.com/search/user?stype=user&s=user&search=1&query="}
      ]

    sites[:food] = [
        {:code => "allrecipes", :name => "AllRecipes", :url => "http://allrecipes.com/Search/Recipes.aspx?WithTerm="},
        {:code => "recipe", :name => "Recipe.com", :url => "http://www.recipe.com/search/?searchTerm="},
        {:code => "bbc_food", :name => "BBC Food Search", :url => "http://www.bbc.co.uk/food/recipes/search?keywords="},
        {:code => "myrecipes", :name => "MyRecipes.com", :url => "http://search.myrecipes.com/search.html?Ntt="},
        {:code => "epicurious", :name => "Epicurious", :url => "http://www.epicurious.com/tools/searchresults?search="},
        {:code => "food_network", :name => "Food Network", :url => "http://www.foodnetwork.com/search/delegate.do?fnSearchType=site&fnSearchString="},
        {:code => "webtender", :name => "Webtender (Drinks and Liquors)", :url => "http://www.webtender.com/cgi-bin/search?what=drink&verbose=on&name="},
        {:code => "mrbooze", :name => "Mr. Booze", :url => "http://www.mr-booze.com/?s="}
      ]

    site_cats.each do |cat|
      sites[cat.code.to_sym].each do |site|
        site[:site_list_category_id] = cat.id
        SiteList.create(site)
        puts "** Created site info: #{site[:name]}"
      end
    end

    puts "** DONE **"
  end
end


