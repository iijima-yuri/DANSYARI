module ApplicationHelper

  def default_meta_tags
    {
      site: 'DANSYARI',
      title: 'DANSYARI',
      reverse: true,
      separator: '|',
      description: '捨てようか迷っている品物を思い出と共に投稿して断捨離をサクサク進めるためのサービスです。',
      keywords: '断捨離,引越し,片付け',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('OGP.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('OGP.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@8PxQ1UeTNMVgn4K',
        image: image_url('OGP.png'),
      }
    }
  end
end
