class PodcastsController < ApplicationController
  def index
    @title = 'DojoCast'
    @desc  = 'Highlight people around CoderDojo communities by Podcast 📻✨'
    @episodes = Podcast.all.sort_by{|episode| episode.filename.rjust(3, '0')}
    @url      = request.url
    @next_live_date = ENV['NEXT_LIVE_DATE'] || '未定'
  end

  def show
    @episode  = Podcast.new(params[:id])
    redirect_to root_url unless @episode.exists?
    @title    = "#DojoCast " + @episode.title
    @filename = @episode.filename
    @content  = Kramdown::Document.new(@episode.content, input: 'GFM').to_html
    @url      = request.url
  end

  def feed
    @title        = "DojoCast"
    @description  = "Highlight people around CoderDojo communities by Podcast."
    @art_work_url = "https://coderdojo.jp/podcasts/cover.jpg"
    @author       = "一般社団法人 CoderDojo Japan"
    @copyright    = "Copyright © 2012-#{Time.current.year} #{@author}"

    @episodes     = Podcast.all.sort_by{|episode| episode.published_at}
    @base_url     = request.base_url
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end
