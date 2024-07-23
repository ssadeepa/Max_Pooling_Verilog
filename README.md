This repository contains verilog implementation of max pooling operation using 2*2 filter. Max pooling is a crucial operation in convolutional neural networks (CNNs), commonly used for downsampling and feature extraction.

Key Components:
maxPooling Module: Implemented in Verilog, this module takes four 8-bit inputs and computes the maximum value among them, providing the result on the output port along with a done signal.

Testbench (maxPooling_tb): Simulates the maxPooling module with various input sets (image_data). It verifies functionality across multiple layers of pooling operations, aggregating results to demonstrate the effectiveness of the module.

![maxPooling_Simulation](https://github.com/user-attachments/assets/2f87a795-de74-4437-9474-6a2f19995224)
