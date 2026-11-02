-- fluoromono: monochrome take on fluoromachine for OLED screens.
-- Pure black background. What fluoromachine shows with hue is shown here with
-- brightness, weight (bold), slant (italic) and underline style:
--
--   keyword                 white  bold           def, if, case, do, end
--   function definition     white  bold underline
--   function call           white
--   macro                   white  italic
--   type / module           light  bold italic    MyApp.Repo, String.t
--   constant / @attribute   light  bold
--   number / boolean / nil  light  dotted underline
--   atom / symbol           light                 :ok, key:
--   variable                mid
--   parameter               mid    italic
--   field / property        dim
--   string                  dim    italic
--   escape / interpolation  white  italic
--   documentation           dimmer italic
--   comment                 dimmest italic
--   operator / punctuation  dark
--
-- Diagnostics use brightness plus a different underline per severity:
-- error = curly, warning = straight, info = dashed, hint = dotted.

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') == 1 then
	vim.cmd('syntax reset')
end
vim.o.background = 'dark'
vim.g.colors_name = 'fluoromono'

local c = {
	white = '#ffffff',
	light = '#e0e0e0',
	mid = '#c0c0c0',
	dim = '#9a9a9a',
	string = '#909090',
	op = '#808080',
	doc = '#707070',
	punct = '#606060',
	comment = '#5a5a5a',
	faint = '#484848',
	line = '#333333',
	visual = '#333333',
	diff_text = '#3a3a3a',
	raised = '#1e1e1e',
	diff_add = '#1f1f1f',
	cursorline = '#141414',
	diff_change = '#121212',
	float = '#0a0a0a',
	black = '#000000',
}

local function hl(name, spec)
	vim.api.nvim_set_hl(0, name, spec)
end

local function link(name, target)
	vim.api.nvim_set_hl(0, name, { link = target })
end

-- Editor --------------------------------------------------------------------

hl('Normal', { fg = c.mid })
hl('NormalNC', { fg = c.mid })
hl('NormalFloat', { fg = c.mid, bg = c.float })
hl('FloatBorder', { fg = c.punct, bg = c.float })
hl('FloatTitle', { fg = c.white, bg = c.float, bold = true })
hl('FloatFooter', { fg = c.op, bg = c.float })
hl('FloatShadow', { bg = c.raised, blend = 80 })
hl('FloatShadowThrough', { bg = c.raised, blend = 100 })
hl('PmenuShadow', { bg = c.raised, blend = 80 })
hl('PmenuShadowThrough', { bg = c.raised, blend = 100 })

hl('Cursor', { reverse = true })
link('lCursor', 'Cursor')
link('CursorIM', 'Cursor')
link('TermCursor', 'Cursor')
hl('CursorLine', { bg = c.cursorline })
hl('CursorColumn', { bg = c.cursorline })
hl('ColorColumn', { bg = c.cursorline })
hl('LineNr', { fg = c.faint })
link('LineNrAbove', 'LineNr')
link('LineNrBelow', 'LineNr')
hl('CursorLineNr', { fg = c.white, bold = true })
hl('SignColumn', {})
hl('CursorLineSign', {})
hl('FoldColumn', { fg = c.faint })
hl('CursorLineFold', { fg = c.white })
hl('Folded', { fg = c.op, bg = c.cursorline, italic = true })

hl('Visual', { bg = c.visual })
link('VisualNOS', 'Visual')
hl('Search', { fg = c.black, bg = c.mid })
hl('CurSearch', { fg = c.black, bg = c.white, bold = true })
link('IncSearch', 'CurSearch')
link('Substitute', 'CurSearch')
hl('MatchParen', { fg = c.white, bold = true, underline = true })
hl('QuickFixLine', { bg = c.raised, bold = true })

hl('NonText', { fg = c.line })
link('Whitespace', 'NonText')
link('SpecialKey', 'NonText')
hl('EndOfBuffer', { fg = c.line })
hl('Conceal', { fg = c.punct })
hl('Directory', { fg = c.white, bold = true })
hl('Title', { fg = c.white, bold = true })

hl('WinSeparator', { fg = c.line })
link('VertSplit', 'WinSeparator')
hl('StatusLine', { fg = c.mid })
hl('StatusLineNC', { fg = c.punct })
hl('TabLine', { fg = c.op })
hl('TabLineFill', {})
hl('TabLineSel', { fg = c.white, bold = true, underline = true })
hl('WinBar', { fg = c.white, bold = true })
hl('WinBarNC', { fg = c.op })

hl('Pmenu', { fg = c.mid, bg = c.cursorline })
hl('PmenuSel', { fg = c.black, bg = c.light, bold = true })
hl('PmenuKind', { fg = c.dim, bg = c.cursorline })
hl('PmenuKindSel', { fg = c.black, bg = c.light })
hl('PmenuExtra', { fg = c.doc, bg = c.cursorline })
hl('PmenuExtraSel', { fg = c.black, bg = c.light })
hl('PmenuMatch', { fg = c.white, bg = c.cursorline, bold = true })
hl('PmenuMatchSel', { fg = c.black, bg = c.light, bold = true, underline = true })
hl('PmenuSbar', { bg = c.raised })
hl('PmenuThumb', { bg = c.punct })
link('WildMenu', 'PmenuSel')

hl('MsgArea', { fg = c.mid })
hl('MsgSeparator', { fg = c.line })
hl('ModeMsg', { fg = c.white, bold = true })
hl('MoreMsg', { fg = c.white, bold = true })
hl('Question', { fg = c.white })
hl('ErrorMsg', { fg = c.white, bold = true, underline = true })
hl('WarningMsg', { fg = c.mid, bold = true })
hl('OkMsg', { fg = c.dim })

hl('SpellBad', { undercurl = true, sp = c.white })
hl('SpellCap', { underdashed = true, sp = c.mid })
hl('SpellRare', { underdotted = true, sp = c.dim })
hl('SpellLocal', { underdotted = true, sp = c.op })

-- Diffs: added rows are brighter than changed rows, deleted rows are dimmed out.
hl('DiffAdd', { bg = c.diff_add })
hl('DiffChange', { bg = c.diff_change })
hl('DiffText', { bg = c.diff_text, bold = true })
hl('DiffDelete', { fg = c.faint, bg = c.float })
hl('Added', { fg = c.white })
hl('Changed', { fg = c.dim, italic = true })
hl('Removed', { fg = c.doc, strikethrough = true })

-- Syntax (legacy groups; treesitter falls back to these) ----------------------

hl('Comment', { fg = c.comment, italic = true })
hl('Constant', { fg = c.light, bold = true })
hl('String', { fg = c.string, italic = true })
link('Character', 'String')
hl('Number', { fg = c.light, underdotted = true, sp = c.op })
link('Boolean', 'Number')
link('Float', 'Number')
hl('Identifier', { fg = c.mid })
hl('Function', { fg = c.white })
hl('Statement', { fg = c.white, bold = true })
link('Conditional', 'Statement')
link('Repeat', 'Statement')
link('Label', 'Statement')
link('Keyword', 'Statement')
link('Exception', 'Statement')
hl('Operator', { fg = c.op })
hl('PreProc', { fg = c.white, bold = true })
link('Include', 'PreProc')
link('Define', 'PreProc')
hl('Macro', { fg = c.white, italic = true })
link('PreCondit', 'PreProc')
hl('Type', { fg = c.light, bold = true, italic = true })
link('StorageClass', 'Statement')
link('Structure', 'Type')
link('Typedef', 'Type')
hl('Special', { fg = c.white, italic = true })
link('SpecialChar', 'Special')
hl('Tag', { fg = c.white, bold = true })
hl('Delimiter', { fg = c.punct })
hl('SpecialComment', { fg = c.doc, italic = true })
hl('Debug', { fg = c.white, italic = true })
hl('Underlined', { underline = true })
hl('Ignore', { fg = c.faint })
hl('Error', { fg = c.white, bold = true, undercurl = true, sp = c.white })
hl('Todo', { fg = c.black, bg = c.light, bold = true })

-- Treesitter ------------------------------------------------------------------

hl('@variable', { fg = c.mid })
hl('@variable.builtin', { fg = c.mid, bold = true })
hl('@variable.parameter', { fg = c.mid, italic = true })
hl('@variable.parameter.builtin', { fg = c.mid, bold = true, italic = true })
hl('@variable.member', { fg = c.dim })

link('@constant', 'Constant')
link('@constant.builtin', 'Number') -- nil, true, false
link('@constant.macro', 'Constant')
link('@constant.html', 'Constant')

link('@module', 'Type')
hl('@module.builtin', { fg = c.light, bold = true, italic = true, underdashed = true, sp = c.punct })
hl('@label', { fg = c.white, bold = true })

link('@string', 'String')
hl('@string.documentation', { fg = c.doc, italic = true })
hl('@string.regexp', { fg = c.dim, italic = true, underdotted = true, sp = c.punct })
hl('@string.escape', { fg = c.white, italic = true })
hl('@string.special', { fg = c.white, italic = true })
hl('@string.special.symbol', { fg = c.light }) -- atoms and keyword keys
hl('@string.special.path', { fg = c.string, italic = true, underline = true, sp = c.punct })
hl('@string.special.url', { fg = c.dim, underline = true })
link('@character', 'String')
link('@character.special', '@string.escape')
link('@character.printf', '@string.escape')

link('@boolean', 'Number')
link('@number', 'Number')
link('@number.float', 'Number')

link('@type', 'Type')
hl('@type.builtin', { fg = c.light, bold = true, italic = true, underdashed = true, sp = c.punct })
hl('@type.definition', { fg = c.light, bold = true, italic = true, underline = true })
link('@type.qualifier', 'Statement')
link('@attribute', 'Constant')
link('@attribute.builtin', 'Constant')
link('@property', '@variable.member')

hl('@function', { fg = c.white, bold = true, underline = true }) -- definitions
hl('@function.builtin', { fg = c.white, underdashed = true, sp = c.punct })
hl('@function.call', { fg = c.white })
link('@function.macro', 'Macro')
link('@function.method', '@function')
link('@function.method.call', '@function.call')
hl('@constructor', { fg = c.light, bold = true, italic = true })
link('@operator', 'Operator')

link('@keyword', 'Statement')
link('@keyword.coroutine', 'Statement')
link('@keyword.function', 'Statement')
link('@keyword.operator', 'Statement')
link('@keyword.import', 'Statement')
link('@keyword.type', 'Statement')
link('@keyword.modifier', 'Statement')
link('@keyword.repeat', 'Statement')
link('@keyword.return', 'Statement')
link('@keyword.debug', 'Debug')
link('@keyword.exception', 'Statement')
link('@keyword.conditional', 'Statement')
link('@keyword.conditional.ternary', 'Operator')
link('@keyword.directive', 'PreProc')
link('@keyword.directive.define', 'PreProc')

link('@punctuation.delimiter', 'Delimiter')
link('@punctuation.bracket', 'Delimiter')
hl('@punctuation.special', { fg = c.white }) -- #{ } in strings, sigil markers

link('@comment', 'Comment')
hl('@comment.documentation', { fg = c.doc, italic = true })
hl('@comment.error', { fg = c.white, bold = true, underline = true })
hl('@comment.warning', { fg = c.light, bold = true })
link('@comment.todo', 'Todo')
hl('@comment.note', { fg = c.light, bold = true, italic = true })

hl('@markup.strong', { bold = true })
hl('@markup.italic', { italic = true })
hl('@markup.strikethrough', { strikethrough = true })
hl('@markup.underline', { underline = true })
hl('@markup.heading', { fg = c.white, bold = true, underline = true })
hl('@markup.quote', { fg = c.doc, italic = true })
hl('@markup.math', { fg = c.light, italic = true })
hl('@markup.environment', { fg = c.white, italic = true })
hl('@markup.link', { fg = c.mid, underline = true })
hl('@markup.link.label', { fg = c.white, underline = true })
hl('@markup.link.url', { fg = c.dim, underline = true })
hl('@markup.raw', { fg = c.string })
link('@markup.raw.block', '@markup.raw')
hl('@markup.list', { fg = c.white, bold = true })
hl('@markup.list.checked', { fg = c.doc, strikethrough = true })
hl('@markup.list.unchecked', { fg = c.white })

link('@diff.plus', 'Added')
link('@diff.minus', 'Removed')
link('@diff.delta', 'Changed')

link('@tag', 'Tag')
hl('@tag.builtin', { fg = c.white, bold = true })
hl('@tag.attribute', { fg = c.dim, italic = true })
link('@tag.delimiter', 'Delimiter')

link('@property.json', '@variable.member')
link('@property.css', '@variable.member')
link('@property.scss', '@variable.member')

-- LSP -------------------------------------------------------------------------

link('@lsp.type.class', '@type')
link('@lsp.type.decorator', '@attribute')
link('@lsp.type.enum', '@type')
link('@lsp.type.enumMember', '@constant')
link('@lsp.type.interface', '@type')
link('@lsp.type.macro', '@function.macro')
link('@lsp.type.namespace', '@module')
link('@lsp.type.parameter', '@variable.parameter')
link('@lsp.type.property', '@property')
link('@lsp.type.struct', '@type')
link('@lsp.type.type', '@type')
link('@lsp.type.typeParameter', '@type.definition')
link('@lsp.type.variable', '@variable')
link('@lsp.typemod.variable.defaultLibrary', '@variable.builtin')
link('@lsp.typemod.variable.readonly', '@constant')
hl('@lsp.typemod.variable.global', { fg = c.mid, underline = true })
link('@lsp.typemod.keyword.documentation', '@comment.documentation')
link('@lsp.typemod.class.documentation', '@comment.documentation')
link('@lsp.typemod.property.readonly', '@constant')

hl('LspReferenceText', { bg = c.raised })
hl('LspReferenceRead', { bg = c.raised })
hl('LspReferenceWrite', { bg = c.raised, underline = true, sp = c.dim })
hl('LspReferenceTarget', { bg = c.raised, bold = true })
hl('LspInlayHint', { fg = c.comment, italic = true })
hl('LspCodeLens', { fg = c.comment })
hl('LspSignatureActiveParameter', { fg = c.white, bold = true, underline = true })

-- Diagnostics: severity = brightness + underline style ------------------------

hl('DiagnosticError', { fg = c.white, bold = true })
hl('DiagnosticWarn', { fg = c.mid, bold = true })
hl('DiagnosticInfo', { fg = c.dim })
hl('DiagnosticHint', { fg = c.doc })
hl('DiagnosticOk', { fg = c.dim })

hl('DiagnosticVirtualTextError', { fg = c.white, bold = true, italic = true })
hl('DiagnosticVirtualTextWarn', { fg = c.mid, italic = true })
hl('DiagnosticVirtualTextInfo', { fg = c.string, italic = true })
hl('DiagnosticVirtualTextHint', { fg = c.doc, italic = true })
hl('DiagnosticVirtualTextOk', { fg = c.string, italic = true })

hl('DiagnosticUnderlineError', { undercurl = true, sp = c.white })
hl('DiagnosticUnderlineWarn', { underline = true, sp = c.mid })
hl('DiagnosticUnderlineInfo', { underdashed = true, sp = c.dim })
hl('DiagnosticUnderlineHint', { underdotted = true, sp = c.doc })
hl('DiagnosticUnderlineOk', { underdotted = true, sp = c.punct })

hl('DiagnosticUnnecessary', { fg = c.punct })
hl('DiagnosticDeprecated', { strikethrough = true, sp = c.mid })

-- Plugins ---------------------------------------------------------------------

-- gitsigns: add and change share a glyph, so they differ in brightness
hl('GitSignsAdd', { fg = c.white })
hl('GitSignsChange', { fg = c.string })
hl('GitSignsDelete', { fg = c.white, bold = true })
hl('GitSignsTopdelete', { fg = c.white, bold = true })
hl('GitSignsChangedelete', { fg = c.string, bold = true })
hl('GitSignsUntracked', { fg = c.punct })
link('GitSignsAddPreview', 'DiffAdd')
link('GitSignsDeletePreview', 'DiffDelete')
hl('GitSignsAddInline', { bg = c.diff_text, bold = true })
hl('GitSignsChangeInline', { bg = c.diff_text, italic = true })
hl('GitSignsDeleteInline', { fg = c.doc, bg = c.float, strikethrough = true })
hl('GitSignsDeleteVirtLn', { fg = c.doc, bg = c.float, strikethrough = true })

-- telescope
link('TelescopeNormal', 'NormalFloat')
link('TelescopeBorder', 'FloatBorder')
link('TelescopeTitle', 'FloatTitle')
hl('TelescopePromptPrefix', { fg = c.white, bg = c.float })
hl('TelescopeSelection', { bg = c.raised, bold = true })
hl('TelescopeSelectionCaret', { fg = c.white, bg = c.raised, bold = true })
hl('TelescopeMultiSelection', { fg = c.white, italic = true })
hl('TelescopeMatching', { fg = c.white, bold = true, underline = true })

-- which-key
hl('WhichKey', { fg = c.white, bold = true })
hl('WhichKeyGroup', { fg = c.light, italic = true })
hl('WhichKeyDesc', { fg = c.mid })
hl('WhichKeySeparator', { fg = c.punct })
link('WhichKeyNormal', 'NormalFloat')
link('WhichKeyFloat', 'NormalFloat')
link('WhichKeyBorder', 'FloatBorder')
link('WhichKeyTitle', 'FloatTitle')
hl('WhichKeyValue', { fg = c.doc })

-- treesitter-context
hl('TreesitterContext', { bg = c.float })
hl('TreesitterContextBottom', { underline = true, sp = c.line })
link('TreesitterContextLineNumber', 'LineNr')

-- nvim-dap / dap-ui
hl('DapBreakpoint', { fg = c.white, bold = true })
hl('DapBreakpointCondition', { fg = c.white, italic = true })
hl('DapLogPoint', { fg = c.dim })
hl('DapStopped', { fg = c.black, bg = c.white, bold = true })
hl('DapStoppedLine', { bg = c.raised })
hl('DapBreakpointRejected', { fg = c.punct, strikethrough = true })
hl('DapUIScope', { fg = c.white, bold = true })
hl('DapUIType', { fg = c.light, italic = true })
hl('DapUIValue', { fg = c.mid })
hl('DapUIModifiedValue', { fg = c.white, bold = true, italic = true })
hl('DapUIDecoration', { fg = c.punct })
hl('DapUIThread', { fg = c.white })
hl('DapUIStoppedThread', { fg = c.white, bold = true, underline = true })
hl('DapUISource', { fg = c.mid })
hl('DapUILineNumber', { fg = c.punct })
link('DapUIFloatBorder', 'FloatBorder')
hl('DapUIWatchesEmpty', { fg = c.doc, italic = true })
hl('DapUIWatchesValue', { fg = c.mid })
hl('DapUIWatchesError', { fg = c.white, bold = true, undercurl = true, sp = c.white })
hl('DapUIBreakpointsPath', { fg = c.white, bold = true })
hl('DapUIBreakpointsInfo', { fg = c.mid })
hl('DapUIBreakpointsCurrentLine', { fg = c.white, bold = true, underline = true })
hl('DapUIBreakpointsDisabledLine', { fg = c.punct, strikethrough = true })
hl('DapUIWinSelect', { fg = c.white, bold = true })
for _, name in ipairs({ 'DapUIStop', 'DapUIRestart', 'DapUIPlayPause', 'DapUIStepOver', 'DapUIStepInto', 'DapUIStepBack', 'DapUIStepOut' }) do
	hl(name, { fg = c.white })
	hl(name .. 'NC', { fg = c.dim })
end
hl('DapUIUnavailable', { fg = c.faint })
hl('DapUIUnavailableNC', { fg = c.faint })
