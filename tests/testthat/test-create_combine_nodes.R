context("Creating and combining node data frames")

test_that("a correct node data frame is generated", {

  # Create 'nodes_1' node data frame
  nodes_1 <-
    create_nodes(nodes = c("a", "b", "c", "d"),
                 label = FALSE,
                 type = "lower",
                 style = "filled",
                 color = "aqua",
                 shape = c("circle", "circle",
                           "rectangle", "rectangle"),
                 data = c(3.5, 2.6, 9.4, 2.7))

  # Result
  #>   nodes label  type  style color     shape data
  #> 1     a       lower filled  aqua    circle  3.5
  #> 2     b       lower filled  aqua    circle  2.6
  #> 3     c       lower filled  aqua rectangle  9.4
  #> 4     d       lower filled  aqua rectangle  2.7

  # Create 'nodes_2' node data frame
  nodes_2 <-
    create_nodes(nodes = c("e", "f", "g", "h"),
                 label = FALSE,
                 type = "upper",
                 style = "filled",
                 color = "red",
                 shape = "triangle",
                 data = c(0.5, 3.9, 3.7, 8.2))

  # Result
  #>   nodes label  type  style color    shape data
  #> 1     e       upper filled   red triangle  0.5
  #> 2     f       upper filled   red triangle  3.9
  #> 3     g       upper filled   red triangle  3.7
  #> 4     h       upper filled   red triangle  8.1

  # Expect that each of the node data frames has 4 rows
  expect_equal(nrow(nodes_1), 4L)
  expect_equal(nrow(nodes_2), 4L)

  # Expect that each of the node data frames has 7 columns
  expect_equal(ncol(nodes_1), 7L)
  expect_equal(ncol(nodes_2), 7L)

  # Expect that 'label = FALSE' produces blank label columns
  expect_true(all(nodes_1$label == rep(" ", 4)))
  expect_true(all(nodes_2$label == rep(" ", 4)))

  # Expect that a single value repeats across rows
  expect_true(all(nodes_1$type == rep("lower", 4)))
  expect_true(all(nodes_2$color == rep("red", 4)))

  # Expect that the numeric 'data' values are numeric
  expect_true(class(nodes_1$data) == "numeric")
  expect_true(class(nodes_2$data) == "numeric")
})

test_that("node data frames can be successfully combined", {

  # Create 'nodes_1' node data frame
  nodes_1 <-
    create_nodes(nodes = c("a", "b", "c", "d"),
                 label = FALSE,
                 type = "lower",
                 style = "filled",
                 color = "aqua",
                 shape = c("circle", "circle",
                           "rectangle", "rectangle"),
                 data = c(3.5, 2.6, 9.4, 2.7))

  # Create 'nodes_2' node data frame
  nodes_2 <-
    create_nodes(nodes = c("e", "f", "g", "h"),
                 label = FALSE,
                 type = "upper",
                 style = "filled",
                 color = "red",
                 shape = "triangle",
                 data = c(0.5, 3.9, 3.7, 8.2))

  # Combine the 2 node data frames
  all_nodes <- combine_nodes(nodes_1, nodes_2)

  # Result
  #>   nodes label  type  style color     shape data
  #> 1     a       lower filled  aqua    circle  3.5
  #> 2     b       lower filled  aqua    circle  2.6
  #> 3     c       lower filled  aqua rectangle  9.4
  #> 4     d       lower filled  aqua rectangle  2.7
  #> 5     e       upper filled   red  triangle  0.5
  #> 6     f       upper filled   red  triangle  3.9
  #> 7     g       upper filled   red  triangle  3.7
  #> 8     h       upper filled   red  triangle  8.2

  # Expect that the combined node data frame has 8 rows
  expect_equal(nrow(all_nodes), 8L)

  # Expect that the combined node data frame has 7 columns
  expect_equal(ncol(all_nodes), 7L)

  # Expect that the 'label' columns has spaces for labels
  expect_true(all(all_nodes$label == rep(" ", 8)))

  # Expect that the rows combined correctly
  expect_true(all(c(nodes_1[,1], nodes_2[,1]) ==
                    all_nodes[,1]))
  expect_true(all(c(nodes_1[,2], nodes_2[,2]) ==
                    all_nodes[,2]))
  expect_true(all(c(nodes_1[,3], nodes_2[,3]) ==
                    all_nodes[,3]))
  expect_true(all(c(nodes_1[,4], nodes_2[,4]) ==
                    all_nodes[,4]))
  expect_true(all(c(nodes_1[,5], nodes_2[,5]) ==
                    all_nodes[,5]))
  expect_true(all(c(nodes_1[,6], nodes_2[,6]) ==
                    all_nodes[,6]))
  expect_true(all(c(nodes_1[,7], nodes_2[,7]) ==
                    all_nodes[,7]))
})
