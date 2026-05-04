return {
  "aidyak/parthenon",
  config = function()
    require("parthenon").setup({
      schemes = {
        "tokusa",
        "habamax",
        "cyberdream",
        "hitotose-spring",
        "hitotose-summer",
      },
    })
  end,
}
