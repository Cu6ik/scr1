module scr1_tb_log_cmd();

always_ff @(posedge scr1_top_tb_ahb.i_top.i_imem_ahb.clk) begin
    if (scr1_top_tb_ahb.i_top.i_imem_ahb.imem_resp == 2'b01) begin
        // valid data from ahb router
        if (
            (scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[6 : 0] == 7'b1101111)
        ) begin
            // detect and command
            $display("Detect jal command");
            $display("csr = ", scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.csr2exu_r_data[31:0]);
            
            // Выводим информацию об инструкции
            $display("imem_rdata = 0x%h", scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata);
            $display("imem_addr = 0x%h", scr1_top_tb_ahb.i_top.i_imem_ahb.imem_addr);
        end
    end
end

endmodule