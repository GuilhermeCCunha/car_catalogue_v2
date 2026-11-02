module ApplicationHelper
  def nav_link_to(text, path)
    is_active = current_page?(path)
    css_class = "nav-link #{'active' if is_active}"
    aria_attrs = is_active ? { current: 'page' } : {}
    link_to text, path, class: css_class, aria: aria_attrs
  end

  def locale_link(locale)
    is_active = I18n.locale.to_s == locale.to_s
    css_class = "dropdown-item #{'active' if is_active}"
    link_to(
      t('locale_name', locale: locale),
      root_path(locale: locale),
      class: css_class
    )
  end
end
