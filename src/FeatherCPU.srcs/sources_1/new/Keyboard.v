module Keyboard(
  input            clk,
  input            rst,
  input      [3:0] row,                 // 矩阵键盘 行
  output reg kye_pressed_flag,
  output reg [3:0] value        // 键盘值     
);

reg [19:0] cnt;
 
always @ (posedge clk, posedge rst)
begin
  if (rst)
    cnt <= 0;
  else
    cnt <= cnt + 1'b1;
end 

wire key_clk = cnt[19];

reg [2:0] current_state, next_state;
// 0: not pressed
// 1 ~ 4 : pressed
// 7: found
 
always @ (posedge key_clk, posedge rst)
  if (rst)
    current_state <= NO_KEY_PRESSED;
  else
    current_state <= next_state;

// 根据条件转移状态
always @(*)
begin
    if(row != 4'b1111)
    begin
        next_state = (current_state==0)?3'b001:3'b111;
    end
    else
    begin
        next_state = ((current_state==1)or(current_state==2)or(current_state==3))?(next_state+3'b001):3'b000;
    end
end

reg [3:0] col, col_val, row_val;

always @ (posedge key_clk, posedge rst)
  if (rst)
  begin
    col <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)
      3'b000 :
      begin
        col <= 4'h0;
        key_pressed_flag <= 0;      
      end
      3'b001 :     
        col <= 4'b1110;
      3'b010 :     
        col <= 4'b1101;
      3'b011 :     
        col <= 4'b1011;
      3'b100 :
        col <= 4'b0111;
      3'b111 :
      begin
        col_val <= col;
        row_val <= row;
        key_pressed_flag <= 1;
      end
    endcase

always @ (posedge key_clk, posedge rst)
  if (rst)
    value <= 4'h0;
  else
    if (key_pressed_flag)
        case ({col_val, row_val})
            8'b1110_1110 : value <= 4'h1;
            8'b1110_1101 : value <= 4'h4;
            8'b1110_1011 : value <= 4'h7;
            8'b1110_0111 : value <= 4'hE;
            
            8'b1101_1110 : value <= 4'h2;
            8'b1101_1101 : value <= 4'h5;
            8'b1101_1011 : value <= 4'h8;
            8'b1101_0111 : value <= 4'h0;
            
            8'b1011_1110 : value <= 4'h3;
            8'b1011_1101 : value <= 4'h6;
            8'b1011_1011 : value <= 4'h9;
            8'b1011_0111 : value <= 4'hF;

            8'b0111_1110 : value <= 4'hA;
            8'b0111_1101 : value <= 4'hB;
            8'b0111_1011 : value <= 4'hC;
            8'b0111_0111 : value <= 4'hD;     
    endcase
endmodule

// 0 1 2 3 4 5 6 7 8 9 A B C D E F
// 0 1 2 3 4 5 6 7 8 9 A B C D * #