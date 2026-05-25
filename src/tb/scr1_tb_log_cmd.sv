module scr1_tb_log_cmd();

    logic signed [31:0] jal_imm;
    logic [31:0] jal_target;

    always_comb begin
        jal_imm = {
            scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[31],     // imm[20]
            scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[19:12],  // imm[19:12]
            scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[20],     // imm[11]
            scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[30:21],  // imm[10:1]
            1'b0
        };

        jal_target =
            scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.curr_pc +
            $signed(jal_imm);
    end

    always_ff @(posedge scr1_top_tb_ahb.i_top.i_imem_ahb.clk) begin
        if (scr1_top_tb_ahb.i_top.i_imem_ahb.imem_resp == 2'b01) begin

            // detect JAL command
            if (scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[6:0] == 7'b1101111) begin

                $display("=========== JAL DETECTED ===========");

                $display("instr = 0x%08h",
                    scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata);
                $display("imem_addr = 0x%08h",
                    scr1_top_tb_ahb.i_top.i_imem_ahb.imem_addr);
                $display("pc = 0x%08h",
                    scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.curr_pc);
                $display("rd = x%0d",
                    scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[11:7]);
                $display("imm = %0d (0x%08h)",jal_imm, jal_imm);
                $display("target_pc = 0x%08h", jal_target);
                $display("link(pc+4) = 0x%08h", 
                    scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.curr_pc + 32'd4);
                $display("csr = %h",
                    scr1_top_tb_ahb.i_top.i_core_top.i_pipe_top.csr2exu_r_data);

            end
        end
    end

endmodule