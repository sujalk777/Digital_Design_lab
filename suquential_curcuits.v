module SR_latch_NAND(
  input S,R
  output Q,Qn
);

  assign Q=~(R&Qn);
  assign Qn=~(S&Q);
endmodule

module
