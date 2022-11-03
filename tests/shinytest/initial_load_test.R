app <- ShinyDriver$new("../../")
app$snapshotInit("initial_load_test", screenshot = FALSE,load_timeout=6.4e4)

app$snapshot(items = list(
  input = c("bins"),
  output = c("box_info")
))
