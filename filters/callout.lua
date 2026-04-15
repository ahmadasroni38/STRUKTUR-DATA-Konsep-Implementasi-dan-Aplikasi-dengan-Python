-- callout.lua — Pandoc Lua filter for:
--   1. Style mapping: Pandoc built-in styles → custom reference.docx styles
--   2. Callout/admonition boxes from fenced divs and blockquotes
--
-- STYLE MAPPING (Pandoc → my-reference.docx):
--   "# BAB N" (first H1)     → "Chapter Number" custom style
--   "# Title" (second H1)    → Heading 1 (already handled by Pandoc)
--   Code blocks (```python)  → "Code Block" custom style
--   "Kode X.Y: ..." labels   → "Code Label" custom style
--
-- CALLOUT USAGE in Markdown:
--   ::: definisi
--   Struktur data adalah cara sistematis ...
--   :::
--
-- Or with blockquote syntax:
--   > [!CATATAN]
--   > Ini adalah catatan penting.
--
-- Supported types: definisi, teorema, contoh, catatan, perhatian, tips, analogi, ringkasan

----------------------------------------------------------------------
-- PART 1: Style mapping — H1 "BAB N" → CHAPTER style
----------------------------------------------------------------------

-- Track whether we've seen the first H1 (BAB N) in the document
local seen_first_h1 = false

function Header(el)
  if el.level == 1 and not seen_first_h1 then
    -- First H1 is always "BAB N" — apply "Chapter Number" style
    seen_first_h1 = true
    return pandoc.Div(
      { pandoc.Para(el.content) },
      pandoc.Attr("", {}, { ["custom-style"] = "Chapter Number" })
    )
  end
  return el
end

----------------------------------------------------------------------
-- PART 2: Code blocks → "Code Block" style + "Code Label" for labels
----------------------------------------------------------------------

function CodeBlock(el)
  -- Apply "Code Block" custom style
  el.attributes["custom-style"] = "Code Block"
  return el
end

----------------------------------------------------------------------
-- PART 3: Detect "Kode X.Y: ..." paragraphs → "Code Label" style
----------------------------------------------------------------------

function Para(el)
  local text = pandoc.utils.stringify(el)
  -- Match patterns like "Kode 1.1: ..." or "Kode 3.2: ..."
  if text:match("^Kode%s+%d+%.%d+") then
    local div = pandoc.Div({ el })
    div.attributes["custom-style"] = "Code Label"
    return div
  end
  return el
end

----------------------------------------------------------------------
-- PART 4: Callout/admonition boxes
----------------------------------------------------------------------

-- Map callout types to their display labels and icons
local callout_map = {
  definisi  = { label = "DEFINISI",  icon = "\u{1F4D6}" },  -- 📖
  teorema   = { label = "TEOREMA",   icon = "\u{2211}"  },  -- ∑
  contoh    = { label = "CONTOH",    icon = "\u{270E}"  },  -- ✎
  catatan   = { label = "CATATAN",   icon = "\u{26A0}"  },  -- ⚠
  perhatian = { label = "PERHATIAN", icon = "\u{26D4}"  },  -- ⛔
  tips      = { label = "TIPS",      icon = "\u{1F4A1}" },  -- 💡
  analogi   = { label = "ANALOGI",   icon = "\u{1F50D}" },  -- 🔍
  ringkasan = { label = "RINGKASAN", icon = "\u{2714}"  },  -- ✔
}

-- Custom style names matching the reference.docx styles
-- Style names: "Callout Definisi", "Callout Definisi Label", etc.
local function get_custom_style(callout_type)
  return "Callout " .. callout_type:sub(1,1):upper() .. callout_type:sub(2)
end

local function get_label_style(callout_type)
  return "Callout " .. callout_type:sub(1,1):upper() .. callout_type:sub(2) .. " Label"
end

-- Handle fenced divs: ::: definisi ... :::
function Div(el)
  for ctype, info in pairs(callout_map) do
    if el.classes:includes(ctype) then
      -- Create header with label style
      local label_div = pandoc.Div(
        { pandoc.Para({ pandoc.Strong({ pandoc.Str(info.icon .. " " .. info.label) }) }) },
        pandoc.Attr("", {}, { ["custom-style"] = get_label_style(ctype) })
      )

      -- Wrap body content in the callout style
      local body_div = pandoc.Div(
        el.content,
        pandoc.Attr("", {}, { ["custom-style"] = get_custom_style(ctype) })
      )

      return { label_div, body_div }
    end
  end
  return el
end

-- Handle blockquote-based callouts: > [!CATATAN] ...
function BlockQuote(el)
  if #el.content == 0 then return el end

  local first = el.content[1]
  if first.t ~= "Para" then return el end

  local text = pandoc.utils.stringify(first)

  for ctype, info in pairs(callout_map) do
    local pattern = "^%[!" .. ctype:upper() .. "%]"
    if text:match(pattern) then
      -- Remove the [!TYPE] marker from the first paragraph
      local cleaned = text:gsub("^%[!" .. ctype:upper() .. "%]%s*", "")

      local blocks = {}

      -- Add styled header
      table.insert(blocks, pandoc.Para({
        pandoc.Strong({ pandoc.Str(info.icon .. " " .. info.label) })
      }))

      -- Add cleaned first paragraph if it has content
      if cleaned ~= "" then
        table.insert(blocks, pandoc.Para({ pandoc.Str(cleaned) }))
      end

      -- Add remaining content
      for i = 2, #el.content do
        table.insert(blocks, el.content[i])
      end

      -- Wrap label in label style, body in callout style
      local label_div = pandoc.Div(
        { blocks[1] },
        pandoc.Attr("", {}, { ["custom-style"] = get_label_style(ctype) })
      )
      local body_blocks = {}
      for i = 2, #blocks do
        table.insert(body_blocks, blocks[i])
      end
      local body_div = pandoc.Div(
        body_blocks,
        pandoc.Attr("", {}, { ["custom-style"] = get_custom_style(ctype) })
      )
      return { label_div, body_div }
    end
  end

  return el
end
