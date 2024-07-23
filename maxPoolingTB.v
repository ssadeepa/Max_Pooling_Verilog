`timescale 1ns / 1ps

module maxPooling_tb;

    // Inputs
    reg clk;
    reg layer1_enable, layer2_enable, layer1_done, layer2_done;
    reg [7:0] input1_layer1, input2_layer1, input3_layer1, input4_layer1;
    reg [7:0] input1_layer2, input2_layer2, input3_layer2, input4_layer2;

    // Outputs
    wire [7:0] output_layer1, output_layer2;
    wire maxPoolingDone_layer1, maxPoolingDone_layer2;
	
    // Internal signals
    reg [7:0] image_data [0:63];
    reg [7:0] matrix_data [0:15];
    integer index_i = 0;
    integer index_j = 0;
    integer index_k = 0;
    integer index_l = 4;
    integer sum_result = 0;

    // Instantiate the Unit Under Test (UUT)
    maxPooling uut1 (
        .clk(clk),
        .enable(layer1_enable),
        .in1(input1_layer1),
        .in2(input2_layer1),
        .in3(input3_layer1),
        .in4(input4_layer1),
        .outMax(output_layer1),
        .outDone(maxPoolingDone_layer1)
    );
    maxPooling uut2 (
        .clk(clk),
        .enable(layer2_enable),
        .in1(input1_layer2),
        .in2(input2_layer2),
        .in3(input3_layer2),
        .in4(input4_layer2),
        .outMax(output_layer2),
        .outDone(maxPoolingDone_layer2)
    );
	
    initial begin
        clk = 0;
        sum_result = 0;
        layer1_enable = 0;
        layer2_enable = 0;
        input1_layer1 = 0;
        input2_layer1 = 0;
        input3_layer1 = 0;
        input4_layer1 = 0;

        input1_layer2 = 0;
        input2_layer2 = 0;
        input3_layer2 = 0;
        input4_layer2 = 0;
	
         //set 1
        image_data[0] = 80;
        image_data[1] = 30;
        image_data[2] = 0;
        image_data[3] = 255;
        
        //set 2
        image_data[4] = 145;
        image_data[5] = 55;
        image_data[6] = 58;
        image_data[7] = 30;
        
        //set 3
        image_data[8] = 54;
        image_data[9] = 67;
        image_data[10] = 62;
        image_data[11] = 29;
        
        //set 4
        image_data[12] = 39;
        image_data[13] = 54;
        image_data[14] = 145;
        image_data[15] = 72;
        
        //set 5
        image_data[16] = 110;
        image_data[17] = 18;
        image_data[18] = 72;
        image_data[19] = 39;
        
        //set 6
        image_data[20] = 31;
        image_data[21] = 18;
        image_data[22] = 0;
        image_data[23] = 39;
        
        //set 7
        image_data[24] = 39;
        image_data[25] = 40;
        image_data[26] = 145;
        image_data[27] = 54;
        
        //set 8
        image_data[28] = 50;
        image_data[29] = 77;
        image_data[30] = 24;
        image_data[31] = 103;
        
        //set 9
        image_data[32] = 181;
        image_data[33] = 58;
        image_data[34] = 18;
        image_data[35] = 84;
        
        //set 10
        image_data[36] = 70;
        image_data[37] = 255;
        image_data[38] = 39;
        image_data[39] = 145;
        
        //set 11
        image_data[40] = 50;
        image_data[41] = 18;
        image_data[42] = 210;
        image_data[43] = 37;
        
        //set 12
        image_data[44] = 94;
        image_data[45] = 113;
        image_data[46] = 115;
        image_data[47] = 145;
        
        //set 13
        image_data[48] = 67;
        image_data[49] = 39;
        image_data[50] = 18;
        image_data[51] = 18;
        
        //set 14
        image_data[52] = 72;
        image_data[53] = 126;
        image_data[54] = 113;
        image_data[55] = 103;
        
        //set 15
        image_data[56] = 0;
        image_data[57] = 67;
        image_data[58] = 145;
        image_data[59] = 54;
        
        //set 16
        image_data[60] = 47;
        image_data[61] = 18;
        image_data[62] = 0;
        image_data[63] = 103;
        

	end
	
	always #5 clk = ~clk;	
	
	always @ (posedge clk) begin
		if(index_i < 64) begin
			layer1_enable = 1;
            input1_layer1 = image_data[index_i];
            input2_layer1 = image_data[index_i+1];
            input3_layer1 = image_data[index_i+2];
            input4_layer1 = image_data[index_i+3];
			index_i = index_i + 4;
			#10;
            matrix_data[index_j]=output_layer1;
            index_j=index_j+1; 
	        #2;
        end else begin
            layer1_enable = 0;
            layer1_done = 1;
        end
	end

	always @(posedge clk) begin
		if(index_l <= 14 && index_k <= 10 && layer1_done == 1) begin
            layer2_enable = 1;
            #10;
            input1_layer2 = matrix_data[index_k];
            input2_layer2 = matrix_data[index_k+1];
            input3_layer2 = matrix_data[index_l];
            input4_layer2 = matrix_data[index_l+1];
            #10;
            sum_result = sum_result + output_layer2;
			#10;
            if (index_k == 2) begin
                index_k = 8;
                index_l = 12;
            end else begin
                index_k = index_k + 2;
                index_l = index_l + 2;
            end	
        end else begin
            #2;
            layer2_enable = 0;
            layer2_done = 1;
        end
	end

	always @(negedge layer2_enable) begin
		$display("Final sum = %d", sum_result);
		#10;	
	end

	always @(posedge clk) begin
		#1000
		$finish;		
	end     
endmodule
