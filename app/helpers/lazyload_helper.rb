# frozen_string_literal: true

module LazyloadHelper
  def lazy_image_tag(source, options = {})
    options['data-src'] = source
    if options[:class].blank?
      options[:class] = 'lozad'
    else
      options[:class] = "lozad #{options[:class]}"
    end

    dummy_path = asset_pack_path('media/images/lazy-dummy.jpg')
    image_tag(dummy_path, options)
  end

  def lazy_image_pack_tag(source, options = {})
    options['data-src'] = asset_pack_path("media/images/#{source}")
    if options[:class].blank?
      options[:class] = 'lozad'
    else
      options[:class] = "lozad #{options[:class]}"
    end

    dummy_path = asset_pack_path('media/images/lazy-dummy.jpg')
    image_tag(dummy_path, options)
  end
end
