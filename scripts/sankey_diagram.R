# Library
library(networkD3)
library(dplyr)
 
# A connection data frame is a list of flows with intensity for each flow
links <- data.frame( source=c(), target=c(), value=c())

('OTU') -> 
('BOTH', 'WTEMP', 'SALINITY', 'NEITHER') -> 
(('PO4F'), ('PO4' & 'DO'), ('DO'), ('DO' & 'PO4F' & 'NO2F'), ('PO4' & 'NO2F'), ('DO' & 'NO2F'), ('NO2F'), ('NONE')) 
(('PO4Fr'), ('PO4Fr' & 'DOr'), ('DOr'), ('DOr' & 'PO4Fr' & 'NO2Fr'), ('PO4r' & 'NO2Fr'), ('DOr' & 'NO2Fr'), ('NO2Fr'), ('NONEr')) 

 
# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame( name=c(as.character(links$source), as.character(links$target)) %>% unique() )
 
# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1
 
# Make the Network
p <- sankeyNetwork(Links = links, Nodes = nodes,
              Source = "IDsource", Target = "IDtarget",
              Value = "value", NodeID = "name", 
              sinksRight=FALSE)
p

# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/sankeyBasic1.html"))