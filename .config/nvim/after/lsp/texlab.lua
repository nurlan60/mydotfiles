local os_name = vim.loop.os_uname().sysname
local viewer, opt

if os_name == "Linux" then
  viewer = "zathura"
  opt = {"--synctex-forward", "%l:1:%f", "%p"}
elseif os_name == "Darwin" then
  viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
  opt = {"-b", "-g", "%l", "%p", "%f"}
elseif os_name == "Windows_NT" then
  viewer = ""
  opt = ""
end
return {
  settings = {
    texlab = {
      build = {
        onSave = true,
        args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "%f"},
      },
      forwardSearch = {
        executable = viewer,
        args = opt
      }
    }
  }
}
