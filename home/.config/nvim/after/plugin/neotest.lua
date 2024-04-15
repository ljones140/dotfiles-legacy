local neotest = require('neotest')

vim.keymap.set("n", "<leader>s", neotest.run.run) --run nearest test
vim.keymap.set("n", "<leader>t", function() --run file
  neotest.run.run(vim.fn.expand("%"));
end)
vim.keymap.set("n", "<leader>o", neotest.output.open) --run nearest test
vim.keymap.set("n", "<leader>to", neotest.summary.open) --open summary
