require 'spec_helper'

PARENT_CONTENT = <<-EOS
before
<%= include('00000000-0000-0000-0000-000000000000') %>
after
EOS

describe Nanoc::Toolkit::Helpers::Layout, helper: true do
  before do
    ctx.create_item(PARENT_CONTENT, { id: '00000000-0000-0000-0000-000000000000' }, '/pages/some-page.md')
    ctx.create_item('in between', { id: '00000000-0000-0000-0000-000000000001' }, '/pages/_some-partial.md')
    ctx.create_item('useless', { id: '00000000-0000-0000-0000-000000000002' }, '/pages/some-other-page.md')
  end


end
