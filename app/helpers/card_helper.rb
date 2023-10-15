module CardHelper
  def numbers_cell(key, number, url, emit_numbers)
    content_tag :div do
      button_to number,
                url,
                method: :patch,
                params: {card: {number: number, key: key}},
                disabled: emit_numbers.exclude?(number),
                class: emit_numbers.include?(number) ? 'emit-numbers': 'numbers'
    end
  end
end
