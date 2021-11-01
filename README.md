# Tree Traversal

## Learning Goals

- Understand what tree traversal is
- Understand breadth-first vs. depth-first traversal
- Implement breadth-first and depth-first traversal algorithms
- Discuss Big O considerations of tree traversal algorithms
- Use tree traversal to recreate the `getElementById` method

## Introduction

In the last lesson, we learned about different types of trees, how they're
constructed, and what they're used for. In this lesson, we'll learn two
different methods for visiting the nodes in a tree.

## Types of Tree Traversal

Tree traversal refers to the process of visitng each of the nodes in a tree in
some systematic way. There are several approaches that are commonly used, each
of which results in the nodes being visited in a particular order. These
approaches can be divided into two general categories: breadth-first and
depth-first.

### Breadth First

In breadth-first traversal, we start at the root, then visit the remaining nodes
level by level, left to right:

![bf-traversal](https://curriculum-content.s3.amazonaws.com/phase-4/phase-4-data-structures-tree-traversal/breadth-first.png)

In this example, the nodes would be visited in the following order:

```text
20 -> 50 -> 2 -> 11 -> 45 -> 8 -> 101 -> 39 -> 75 -> 57
```

Say we want to build a method on our `Tree` class that takes a node as input and
returns an array containing the values of the root node and all of its child
nodes in breadth-first order. How would we go about building this in code? We
will need to use a second array as a temporary holder; the order in which we add
nodes to the holder array will control the order of the elements in the output
array.

Let's start by writing some pseudocode:

```text
Initialize an empty output array
Initialize a holder array and add the root node to it
While there are nodes in the holder array
  Remove the first node from the holder array
  Add its value to the output array
  Add its children (if any) to the end of the holder array
Return the output array
```

Take a couple of minutes to walk through the pseudocode using the example tree
in the diagram above so you can visualize how it works.

So let's start by defining our method and creating our `holder` and `result`
array variables. We also want to set up our method to take a node as an
argument, and initialize `holder` with that variable:

```rb
def breadth_first_traversal(node)
  result = []
  holder = [node]

end
```

Next, we'll create our `while` loop:

```rb
def breadth_first_traversal(node)
  result = []
  holder = [node]

  while holder.length > 0
    # traverse our node
  end

end
```

Inside our `while` loop, we want to do three things:

1. Remove the first node from the holder array
2. Add its value to the result array, and
3. Add its children (if any) to the holder array

To add the node's children to the holder array, we will make use of Ruby's
`splat` operator (`*`), which is the Ruby equivalent of JavaScript's spread
operator. Finally, we will return the `result` array:

```rb
def breadth_first_traversal(node)
  result = []
  holder = [node]

  while holder.length > 0
    current = holder.shift
    result.push(current[:value])
    holder.push(*current[:children])
  end

  result
end
```

Let's call our method using the following very simple node as input:

![simple node](https://curriculum-content.s3.amazonaws.com/phase-4/phase-4-data-structures-tree-traversal/simple-tree.png)

We set up our variables, then call the method, passing the root node as an
argument:

```rb
child_1 = {
  value: 2,
  children: []
}

child_2 = {
  value: 3,
  children: []
}

child_3 = {
  value: 4,
  children: []
}

root = {
  value: 1,
  children: [child_1, child_2, child_3]
}

breadth_first_traversal(root)
# => [1, 2, 3, 4]
```

### Depth First

With depth-first traversal, rather than visiting nodes level by level, we
instead work our way down to the bottom of the tree first. Once we get to the
bottom, we backtrack until we get to a node that hasn't been fully explored yet,
work our way down to the bottom again, and so on until we're done:

![depth-first-gif](https://curriculum-content.s3.amazonaws.com/phase-4/phase-4-data-structures-tree-traversal/depth-first.gif)

This method of depth-first traversal is also known as **preorder traversal**.
Once we're done, we will have visited the nodes in the following order:

```text
20 -> 50 -> 45 -> 8 -> 2 -> 101 -> 39 -> 75 -> 11 -> 57
```

So how would we go about building this in code? Well the good news is that the
process is almost identical to the breadth-first traversal!

Let's think about what we did in that case. We started at the root (20), then
visited its left-most child (50). We added that node's children to the end of
the holder array then continued visiting the remaining children of the root node
(2 and 11). In this case, however, we want to visit the children of 50
**before** we visit its siblings. Doing that is just a matter of making one
small change to our earlier code.

Here's what our pseudocode would look like:

```text
Initialize an empty output array
Initialize a holder array and add the root node to it
While there are nodes in the holder array
  Remove the first node from the holder array
  Add its value to the output array
  Add its children (if any) to the BEGINNING of the holder array
Return the output array
```

Once again, spend a couple of minutes working through the process with our
example tree to see how it works.

The final code looks like this:

```rb
def depth_first_traversal(node)
  result = []
  holder = [node]

  while arr.length > 0
    current = holder.shift
    result.push(current[:value])
    holder.unshift(*current[:children])
  end

  result
end
```

Note that the only change in our method was to use `unshift` in place of `push`
to add the child nodes to the **beginning** of the holder array instead of the
end.

## When to Use Breadth-First vs. Depth-First Traversal Methods

Unfortunately, there are no hard and fast rules here — it really depends on the
circumstances. However, there are a couple of factors that can provide some
guidance.

### The Type of Output Needed

In some cases, the desired output will determine what method of traversal should
be used. Say, for example, we have a company organization chart that lists all
the employees hierarchically:

![Org chart](https://curriculum-content.s3.amazonaws.com/phase-4/phase-4-data-structures-tree-traversal/org-chart.png)

On occasion, we may need to print out all the employees. If we want to print
them in hierarchical order — the CEO first, followed by Vice Presidents,
Managers, etc. — we would use a breadth-first traversal. But if we want to print
out the employees by function or department — the head of the department or
function first, followed by all their direct reports, then all the employees who
report to _them_, etc. — we would use a depth-first approach.

### Big O Considerations

Setting aside binary search trees — which, as we discussed in the previous
lesson, are usually (but not always) more efficient — the time complexity of
traversing trees is the same regardless of the approach used. No matter which
way we proceed through the tree, we need to visit every node, giving a time
complexity of O(n). Therefore, time complexity will not help us pick one
approach over the other.

Space complexity considerations, however, _can_ help us choose. Because we use
an additional data structure to hold elements as we go (as we did in the
examples above with the holder array), we want to choose a method that minimizes
the storage requirements. To do this, we need to consider the **height** vs. the
**width** of our tree.

With breadth-first traversal, we work our way across each level, adding the
children of each node to our holder array as we go. With depth-first traversal,
on the other hand, we work our way down from each child node in turn, adding
children of that node at each successive level. As a result, if we have a very
wide tree, where there are not a lot of levels but there are many nodes on each
level, the storage requirements will be less if we use depth-first search.
Conversely, if we have a long skinny tree, where each node has many children and
grandchildren, but there aren't a lot of nodes within each level, breadth-first
traversal will be more efficient.

## Example Use of Tree Traversal

Let's get some practice using our traversal skills by recreating the
[`Document.getElementById` method][get-element-by-id] that's provided by Web
APIs.

In the `lib` folder, we having included an implementation of a `Tree` class. The
nodes in the `Tree` will be structured as follows:

```rb
{
  value: "some_value",
  children: []
}
```

You do not need to create nodes or a `Node` class yourself — the tests will
handle that part.

To pass the tests, you will need to add an instance method, `get_element_by_id`,
to the `Tree` class that uses the depth-first approach to traverse the `Tree`
and find the desired node. Like the native method, your method should take a
string value as an argument and return the node with that value. If a matching
node is not found, your method should return `nil`.

Once you have the tests passing, try modifying your method to use breadth-first
traversal instead; the tests should still pass.

[get-element-by-id]: https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById
