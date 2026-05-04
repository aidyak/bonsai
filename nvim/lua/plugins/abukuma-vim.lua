if vim.env.NVIM_ABUKUMA_ENABLED ~= "1" then
  return {}
end

return {
    {
        "giftee/abukuma-vim",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
          require("abukuma-css").setup()  -- Remote mode by default
        end,
    },
}
