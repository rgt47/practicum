-- In PDF output only, move Check answers and Solution callouts to an
-- 'Answers and solutions' section at the end of each chapter. The HTML
-- edition collapses them in place; print cannot, and printing every
-- answer inline roughly doubled the length of the exercise material.

local function is_pdf()
  return quarto.doc.is_format('pdf')
end

local function has_class(el, cls)
  for _, c in ipairs(el.classes) do
    if c == cls then return true end
  end
  return false
end

local function callout_title(el)
  if el.t ~= 'Div' then return nil end
  for _, c in ipairs(el.classes) do
    if c:match('^callout') then return el.attributes['title'] end
  end
  return nil
end

local function starts_with_answer(block)
  if block.t ~= 'Para' or #block.content == 0 then return false end
  local first = block.content[1]
  if first.t ~= 'Strong' then return false end
  return pandoc.utils.stringify(first):match('^Answer') ~= nil
end

local function pointer(text)
  return pandoc.Para({ pandoc.Emph({ pandoc.Str(text) }) })
end

function Pandoc(doc)
  if not is_pdf() then return doc end

  local out = pandoc.List()
  local collected = pandoc.List()
  local n_check, n_solution = 0, 0

  local function flush()
    if #collected == 0 then return end
    out:insert(pandoc.Header(2, 'Answers and solutions',
      pandoc.Attr('', { 'unnumbered', 'unlisted' })))
    out:extend(collected)
    collected = pandoc.List()
  end

  for _, block in ipairs(doc.blocks) do
    if block.t == 'Header' and block.level == 1 then
      flush()
      n_check, n_solution = 0, 0
      out:insert(block)
    else
      local title = callout_title(block)
      if title == 'Check' then
        local split
        for i, b in ipairs(block.content) do
          if starts_with_answer(b) then split = i break end
        end
        if split then
          n_check = n_check + 1
          local question = pandoc.List()
          local answer = pandoc.List()
          for i, b in ipairs(block.content) do
            if i < split then question:insert(b) else answer:insert(b) end
          end
          question:insert(pointer('Answer: Check ' .. n_check ..
            ', end of chapter.'))
          block.content = question
          collected:insert(pandoc.Para({ pandoc.Strong({
            pandoc.Str('Check ' .. n_check) }) }))
          collected:extend(answer)
        end
        out:insert(block)
      elseif title == 'Solution' then
        n_solution = n_solution + 1
        out:insert(pointer('Solution ' .. n_solution ..
          ' is at the end of the chapter.'))
        collected:insert(pandoc.Para({ pandoc.Strong({
          pandoc.Str('Solution ' .. n_solution) }) }))
        collected:extend(block.content)
      else
        out:insert(block)
      end
    end
  end
  flush()
  doc.blocks = out
  return doc
end
