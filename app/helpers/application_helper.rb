module ApplicationHelper
  def default_meta_tags
    {
      title: 'Prep',
      description: '面接上手く話せないのは、自分の印象や話の分かりやすさなど、複数のことを同時に意識してマルチタスクとなっているからと仮定して、まずはPREP法を通して話し方をトレーニングしようというサービスです。',
      keywords: 'prep法,就活,面接,話し方',
      noindex: !Rails.env.production?, # production環境以外はnoindex
      canonical: request.original_url, # 優先されるurl
      charset: 'UTF-8',
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        site_name: 'Prep',
        locale: 'ja_JP'
      },
      twitter: {
        creator: '@yamarin_shu',
        card: 'summary_large_image'
      }
    }
  end
end
