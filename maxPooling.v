`timescale 1ns / 1ps

module maxPooling(
    input clk,
    input enable,
    input [7:0] in1,
    input [7:0] in2,
    input [7:0] in3,
    input [7:0] in4,
    output reg [7:0] outMax,
    output reg outDone
);

    reg [7:0] initialMax = 8'd0;

    always @ (posedge clk) begin
        if (enable) begin
            if (initialMax < in1) begin
                if (in2 < in1) begin
                    if (in3 < in1) begin
                        if (in4 < in1) begin
                            outMax <= in1;
                            outDone <= 1;
                        end else begin
                            outMax <= in4;
                            outDone <= 1;
                        end
                    end else begin
                        if (in3 < in4) begin
                            outMax <= in4;
                            outDone <= 1;
                        end else begin
                            outMax <= in3;
                            outDone <= 1;
                        end
                    end
                end else begin
                    if (in3 < in2) begin
                        if (in4 < in2) begin
                            outMax <= in2;
                            outDone <= 1;
                        end else begin
                            outMax <= in4;
                            outDone <= 1;
                        end
                    end else begin
                        if (in3 < in4) begin
                            outMax <= in4;
                            outDone <= 1;
                        end else begin
                            outMax <= in3;
                            outDone <= 1;
                        end
                    end
                end
            end else begin
                outMax <= initialMax;
                outDone <= 1;
            end
        end else begin
            outMax <= 0;
            outDone <= 0;
        end
    end

endmodule
