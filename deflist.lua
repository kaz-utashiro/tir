-- Convert bullet list items with bold-starting terms to definition lists.
-- Expects "loose" bullet lists (blank line between term and description):
--
--   - **term**
--
--     Description text.
--
function BulletList(el)
  local defs = {}

  for _, item in ipairs(el.content) do
    if #item < 2 then
      return nil
    end

    local first = item[1]
    if first.t ~= "Para" and first.t ~= "Plain" then
      return nil
    end

    if #first.content == 0 or first.content[1].t ~= "Strong" then
      return nil
    end

    local def_blocks = {}
    for i = 2, #item do
      table.insert(def_blocks, item[i])
    end

    table.insert(defs, {
      first.content,
      {def_blocks}
    })
  end

  if #defs > 0 then
    return pandoc.DefinitionList(defs)
  end
end
