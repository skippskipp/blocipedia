module WikisHelper

  def teaser(content, wiki)
    content.split[0..10].join(" ") + link_to(" Read More", wiki)
  end
end
