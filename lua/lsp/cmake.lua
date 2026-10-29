vim.lsp.config("cmake", {
    init_options = {
        buildDirectory = "build"
    },
    root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" }
})
vim.lsp.enable("cmake")
