
# Computer-Vision
# Assignment 1 Topics: frame differencing, connecting components, thresholding, bounding boxes.

Tasks 1 (40 points)

![alt text](http://vlm1.uta.edu/~athitsos/courses/cse4310_spring2019/assignments/assignment1/bbox0062.jpg)

Figure 1: Bounding box of the person in frame 62 of the "walkstraight" sequence.

Write a Matlab function called find_bounding_box that takes in as argument the name of an image file from the "walkstraight" sequence, and computes the bounding box of the person. The function should RETURN the bounding box, as a matrix of four numbers: [top row, bottom row, left column, right column]. Furthermore, as a side effect, the function should display a figure that shows the original image, with a yellow (color code: [255 255 0]) rectangle superimposed, representing the detected bounding box. Your function can use data from any frame of the sequence in order to determine the bounding box for the frame in question.

Your function should be named find_bounding_box, and should take a single argument, i.e., the filename specifying a frame of the sequence. For example:

> find_bounding_box('walkstraight/frame0052.tif');

Don't worry about how the function works when the person is not visible, or is only partially visible.
Task 2 (40 points)
Write a Matlab function called person_present that can tell when no person is present. Don't worry about how your algorithm performs on borderline cases, like frames 5-32 when the person is not fully visible. However, your algorithm should be able to tell, for example, that there is no person at frame 3, and that there is a person at frame 62. The function should return 1 if the person is present, and 0 otherwise.
Your function should be named person_present, and should take a single argument, i.e., the filename specifying a frame of the sequence. For example:

> person_present('walkstraight/frame0052.tif');

Task 3 (20 points)
Write a Matlab function called person_speed that returns the average velocity of the person, between two frames. The function should return a 1x2 matrix [rows_per_frame, cols_per_frame], that specifies, in pixels, the velocity of the person along the vertical direction (rows, increasing from top to bottom) and the horizontal direction (columns, increasing from left to right).
Your solution can be built on top of your find_bounding_box function: call find_bounding_box twice, to find the person in both frames, and calculate the velocity based (somehow) on the results of the find_bounding_box function. Notice that your function must return the velocity, which specifies the direction of motion (and that is why it needs to be a 2D vector), NOT the speed, which is a single number.

Your function should be named person_speed, and should take two arguments, i.e., the filenames specifying two frames of the sequence. For example:

> person_speed('walkstraight/frame0052.tif', 'walkstraight/frame0062.tif');

Again, don't worry about how the function works when the person is not visible, or is only partially visible.
