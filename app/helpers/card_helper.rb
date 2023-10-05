module CardHelper
  def numbers_cell(key, number, url, emit_numbers)
    content_tag :div, class: emit_numbers.include?(number) ? 'emit-numbers': 'numbers' do
      button_to number, url, method: :patch, params: {card: {number: number, key: key}}, disable: emit_numbers.exclude?(number)
    end
  end
end
