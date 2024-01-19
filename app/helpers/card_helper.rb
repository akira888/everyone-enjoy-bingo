module CardHelper
  CHECKED_MARK = 'x'.freeze

  def numbers_cell(key, number, url, emit_numbers)
    content_tag :div do
      return content_tag :span, CHECKED_MARK, class: 'marked--cell w-12 bg-accent text-accent' if number == CHECKED_MARK

      button_to number,
                url,
                method: :patch,
                params: {card: {number: number, key: key}},
                disabled: emit_numbers.exclude?(number),
                class: %(btn btn-accent w-12 ) + (emit_numbers.include?(number) ? 'emit-numbers': 'numbers')
    end
  end
end
