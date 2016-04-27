### evolving graphs with integer nodes and timestamps

g = evolving_graph()
add_edge!(g, 1, 2, 1)
add_edge!(g, 1, 3, 1)
add_edge!(g, 1, 4, 2)
add_edge!(g, 1, 2, 2)
add_edge!(g, 2, 1, 3)
add_edge!(g, 2, 3, 3)
add_edge!(g, 1, 2, 1)

@test is_directed(g)
ns = nodes(g)
@test rand(1:4) in ns
@test num_nodes(g) == 4
@test num_edges(g) == 6
@test rand(1:3) in timestamps(g)
@test num_timestamps(g) == 3

ug = undirected(g)
@test num_edges(ug) == 12
@test is_directed(g)
@test is_directed(ug) == false
display(g)
@test has_node(g, 1, 1)
@test has_node(g, 4, 1) == false
@test has_node(g, 4)


#### general evolving graphs

aa = ['a', 'b', 'c', 'c', 'a']
bb = ['b', 'a', 'a', 'b', 'b']
tt = ["t1", "t2", "t3", "t4", "t5"]
gg = evolving_graph(aa, bb, tt, is_directed = false)
display(gg)
nodes(gg)

@test forward_neighbors(gg, 'c', "t4") == [('b', "t4")]

@test num_nodes(gg) == 3
edges(gg)
edges(gg, "t1")
@test num_edges(gg) == 10
timestamps(gg)
@test num_timestamps(gg) == 5



# convert to matrix
@test matrix(gg, "t2") == full(spmatrix(gg, "t2"))

g2 = evolving_graph(Int, Char, is_directed = true)
add_edge!(g2, 1, 2, 'a')
add_edge!(g2, 2, 3, 'b')
@test num_nodes(g2) == 3
@test num_edges(g2) == 2
@test num_timestamps(g2) == 2

# remove edge
g = evolving_graph(Int, AbstractString)
add_edge!(g, 1, 2, "t1")
add_edge!(g, 2, 3, "t2")
add_edge!(g, 4, 2, "t2")
add_edge!(g, 4, 2, "t1")
add_edge!(g, 2, 1, "t3")

@test num_edges(g) == 5
@test has_edge(g, 1, 2, "t1")

rm_edge!(g, 1, 2, "t1")

@test !has_edge(g, 1, 2, "t1")
@test num_edges(g) == 4

add_edge!(g, [1,2,4], [3,4], "t1")

n = num_edges(g)

@test is_directed(g)

undirected!(g)

@test !is_directed(g)

@test num_edges(g) ==  n*2
