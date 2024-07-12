module GameExtensions
  refine String do
    def colored_with?(color_method)
      include?(send(color_method))
    end
  end

  refine Array do
    def win?
      all? { |number| number.colored_with?(:green) }
    end
  end
end
