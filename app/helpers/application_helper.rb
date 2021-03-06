module ApplicationHelper
  def app_title(page_title: '')
    if page_title.blank?
      ENV.fetch('APP_NAME')
    else
      "#{page_title} - #{ENV.fetch('APP_NAME')}"
    end
  end

  def all_songs_list_collapse_id(
    parent_id:, child_id: nil,
    is_parent_composer: nil,
    is_parent_composition: nil
  )
    unless parent_id
      raise ArgumentError, "parent_id: parent(composerまたはcomposition) のidを与えてください"
    end

    if !is_parent_composer && !is_parent_composition || is_parent_composer && is_parent_composition
      raise ArgumentError, "is_parent_composerとis_parent_compositionは、どちらか1つだけをtrueにしてください"
    end

    id = "allSongsListCollapse"
    if is_parent_composer
      id << "Composer#{parent_id}"
      id << "Composition#{child_id}" if child_id
    elsif is_parent_composition
      id << "Composition#{parent_id}"
      id << "Composer#{child_id}" if child_id
    end
    id
  end

  def bs_class_for_flash(type:)
    case type
    when 'alert'
      'danger'
    when 'notice'
      'info'
    else
      type
    end
  end
end
