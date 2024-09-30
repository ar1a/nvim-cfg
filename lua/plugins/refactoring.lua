return {
  "ThePrimeagen/refactoring.nvim",
  opts = {
    printf_statements = {
      cs = {
        'GD.Print(@"%s");',
      },
    },
    print_var_statements = {
      cs = {
        'GD.Print($"%s {%s}");',
      },
    },
  },
}
