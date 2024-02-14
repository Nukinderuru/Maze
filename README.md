# Maze

![project_cover](/images/project_cover.jpg)

## Contents

0. [Introduction](#introduction)
1. [Part 1. Generation of a perfect maze](#part-1-generation-of-a-perfect-maze)
2. [Part 2. Solving the maze](#part-2-solving-the-maze)
3. [Part 3. Cave generation](#part-3-cave-generation)
4. [Maze description](#maze-description)
5. [Caves description](#caves-description)

## Introduction

This is a C++ program with Qt-based interface that can generate and render perfect mazes and caves.

- The program is built with Makefile which contains a standard set of targets for GNU-programs: all, install, uninstall, clean, dvi, dist, tests.
- The program has a button to load the maze from a file, which is set in the format described [below](#maze-description).
- Maximum size of the maze is 50x50.
- The loaded maze is rendered on the screen in a field of 500 x 500 pixels.

## Part 1. Generation of a perfect maze

- To generate an ideal maze the user enters only the dimensionality of the maze: the number of rows and columns. Eller's algorithm is used for ideal maze generation.
- The generated maze is automatically saved in the file format described [below](#maze-description).

## Part 2. Solving the maze

- The user sets the starting and ending points.
- The route, which is the solution, is displayed with a red line.

![generated_maze_with_solution](/images/maze.png)

## Part 3. Cave Generation

- The caves are generated using the cellular automaton.
- The user selects the file that describes the cave according to the format described [below](#caves-description).
- There is a separate tab in the user interface to display the caves.
- Maximum size of the cave is 50 x 50.
- The loaded cave is rendered on the screen in a field of 500 x 500 pixels.
- The user sets the limits for "birth" and "death" of a cell, as well as the chance for the starting initialization of the cell.
- The "birth" and "death" limits can have values from 0 to 7.
- Cells outside the cave are considered alive.
- There is a step-by-step mode for rendering the results of the algorithm in two variants:
    - Pressing the next step button will lead to rendering the next iteration of the algorithm
    - Pressing the automatic work button starts rendering iterations of the algorithm with a frequency of 1 step in `N` milliseconds, where the number of milliseconds `N` is set through a special field in the user interface.

![generated_cave](/images/cave.png)

## Maze description

The maze can be stored in a file as a number of rows and columns, as well as two matrices containing the positions of vertical and horizontal walls respectively.

The first matrix shows the wall to the right of each cell, and the second - the wall at the bottom.

An example of such a file:
```
4 4
0 0 0 1
1 0 1 1
0 1 0 1
0 0 0 1

1 0 1 0
0 0 1 0
1 1 0 1
1 1 1 1
```

The maze described in this file:  \
![maze4](/images/maze4.jpg)

## Caves description

A cave that has passed 0 simulation steps (only initialized) can be stored in the file as a number of rows and columns, as well as a matrix containing the positions of "live" and "dead" cells.

An example of such a file:
```
4 4
0 1 0 1
1 0 0 1
0 1 0 0
0 0 1 1
```

The cave described in this file: \
![cave3](/images/cave3.jpg)
