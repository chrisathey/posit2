# https://jbgruber.github.io/atrrr/articles/Basic_Usage.html
#install.packages("atrrr")

# functioning able to post skeet with plot
# next stage, enhance plot, create summary table
library(atrrr)
auth("christopherathey.bsky.social")

# get a list of followers 
myfollowers <- get_followers(actor="christopherathey.bsky.social",limit=4000)
#myfollows <- get_follows(actor="your-handle-without-the-@",limit=4000)

post(
  "good evening bsky",
  in_reply_to = NULL,
  quote = NULL,
  image = NULL,
  image_alt = NULL,
  #video = NULL,
  created_at = Sys.time(),
  labels = NULL,
  langs = NULL,
  tags = NULL,
  preview_card = TRUE,
  verbose = NULL,
  .token = NULL
)

post_skeet(
  "good evening bsky, a test skeet. Hello from #rstats with {atrrr}",
  in_reply_to = NULL,
  quote = NULL,
  image = NULL,
  image_alt = NULL,
  #video = NULL,
  created_at = Sys.time(),
  labels = NULL,
  langs = NULL,
  tags = NULL,
  preview_card = TRUE,
  verbose = NULL,
  .token = NULL
)

if (FALSE) { # \dontrun{
  search_post("rstats")
  # finds post with the hashtag rstats AND the word Bluesky somewhere in the
  # skeet (ignoring capitalisaion)
  search_post("#rstats Bluesky")
  
  # search for the exact phrase "new #rstats package"
  search_post("\"new #rstats package\"")
  # Use single quotes so you do not need to escape double quotes
  search_post('"new #rstats package"')
  
  # only search for skeets from one user
  search_post("from:jbgruber.bsky.social #rstats")
} # }
#install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("purrr")
library(purrr)
install.packages("tidyr")
library(tidyr)
install.packages("igraph")
library(igraph)
install.packages("ggraph")
library(ggraph)
install.packages("tidygraph")
library(tidygraph)

dev.off
# Retrieve the followers for the main user
some_followers <- get_followers(actor = "christopherathey.bsky.social", limit = 10)$actor_handle

# For each follower, retrieve their own set of followers.
# This provides a nested view of relationships.
followers_of_followers <- some_followers |>
  purrr::map_dfr(~{
    get_followers(actor = .x, limit = 200) |>
      mutate(from = .x)
  }) |>
  dplyr::rename(to = actor_handle) |>
  dplyr::select(from, to)



# Construct the network graph and plot
graph1 <- igraph::graph_from_data_frame(followers_of_followers, directed = TRUE)

# Use ggraph to visualize the network.
  ggraph(graph1, layout = "kk") +
  ggraph::geom_edge_link() +
 ggraph::geom_node_point(aes(size = tidygraph::centrality_pagerank())) 
  #ggraph::geom_node_point(aes(size = with_graph(), centrality_pagerank())) +
  ggplot2::theme_classic()
  
  
   ggraph(graph1, layout = "kk") +
  ggraph::geom_edge_link() +
     ggraph::geom_node_point(aes(size = tidygraph::centrality_closeness()))
  ggplot2::theme_light()
 # Con
  
   #ggraph(wghtdgraph, layout = 'fr') +
  #geom_edge_link() # +
 #geom_node_point(aes(size = with_graph(wghtdgraph, centrality_pagerank())))
#library(ggraph)
#library(tidygraph)

# Create graph of highschool friendships
#graph <- as_tbl_graph(highschool) |> 
 # ???#   mutate(Popularity = centrality_degree(mode = 'in'))

# plot using ggraph
graph(graph1, layout = 'kk') + 
geom_edge_fan(aes(alpha = after_stat(index)), show.legend = FALSE) + 
    geom_node_point(aes(size = Popularity)) + 
    facet_edges(~year) + 
    theme_graph(foreground = 'steelblue', fg_text_colour = 'white')
 # Construct the network graph and plot
#graph <- igraph::graph_from_data_frame(followers_of_followers, directed = TRUE)

#code incomplete
#automate save plot
#dev.off

#gcplot = gggraph:ggraph(graph1, layout = "kk"), geom_edge_link(), geom_node_point(aes(size = tidygraph::centrality_pagerank())), geom_node_point(aes(size = with_graph(wghtdgraph, centrality_pagerank())) 
#                            ggplot2::theme_classic()

v1plotimage <- ggsave(tempfile(pattern = "2", fileext = ".png"), plot = last_plot())
#ggsave('rplot12.png', plot = last_plot())
#ggsave('rplotexample.png', ggplot object)

#temporary fix
v1plotimage = "Rplot04.png"
 
 post_skeet(
  "good evening bsky, a skeet inluding a plot of my follower network. Created using #rstats with {atrrr}",
  in_reply_to = NULL,
  quote = NULL,
  image = v1plotimage,
  image_alt = 'plot of my network',
  #video = NULL,
  created_at = Sys.time(),
  labels = NULL,
  langs = NULL,
  tags = 'r',
  preview_card = TRUE,
  verbose = NULL,
  .token = NULL
)
 
install.packages('rsconnect')

rsconnect::setAccountInfo(name='vr7xr1-chris-athey',
			  token='4BC044F3B7829E2729EC5AB3927206BB',
			  secret='BTe4IYIx01ktm3EN7I+gugoAPVdIovRTg7NRawTf')

library(rsconnect)
    rsconnect::deployApp('path/to/your/app')
#library(rsconnect-python)
## 
# graphics.off()

plot(x=1:10, y=rep(5,10), pch=19, cex=3, col="dark red")





install.packages("igraphdata")
library(igraphdata)

rm(graph)
graph(edges,n,directed,isolates)
graph_from_literal

g2 <- graph( edges=c(1,2, 2,3, 3,1), n=10 ) # now with 10 vertices, and directed by default
plot(g2)

install.packages("bskyr")
library(bskyr)

set_bluesky_user('christopherathey.bsky.social')
set_bluesky_pass('dcjb-hgsd-4pvu-i2mh')
bs_post('hello fellow skeeters, a test post from R')
