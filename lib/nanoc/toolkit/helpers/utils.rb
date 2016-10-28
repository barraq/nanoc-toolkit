module Nanoc::Toolkit::Helpers
  # Contains util functions
  module Utils
    # Split a file `extension` into a two parts `ext` and `kind` where
    # `ext` is the output file extension (e.g. html, xml, etc.) and `kind`
    # is the input file extension (e.g. md, html, etc.).
    #
    # @param [String] extension File extension, e.g. `html.md`, `xml`.
    # @param [String] default Default output extension if none is specified.
    # @return [Array] Couplet [ext, kind]
    def split_ext(extension, default: nil)
      ext, kind = extension.split('.')
      [kind ? ext : default, kind || ext]
    end
  end
end
