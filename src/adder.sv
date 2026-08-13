// sumador completo de 1 bit
module full_adder (
  input  logic a,
  input  logic b,
  input  logic cin,
  output logic sum,
  output logic cout
);

  assign sum  = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));

endmodule


// sumador de 4 bits, construido encadenando 4 full_adder de 1 bit
module adder (
  input  logic [3:0] a,
  input  logic [3:0] b,
  output logic [4:0] sum
);

  // carry intermedios entre cada full_adder (carry0..carry2) y el carry
  // final (carry3), que se convierte en el bit mas significativo de sum
  logic carry0, carry1, carry2, carry3;

  full_adder fa0 (
    .a    (a[0]),
    .b    (b[0]),
    .cin  (1'b0),      // el primer bit no recibe acarreo de entrada
    .sum  (sum[0]),
    .cout (carry0)
  );

  full_adder fa1 (
    .a    (a[1]),
    .b    (b[1]),
    .cin  (carry0),
    .sum  (sum[1]),
    .cout (carry1)
  );

  full_adder fa2 (
    .a    (a[2]),
    .b    (b[2]),
    .cin  (carry1),
    .sum  (sum[2]),
    .cout (carry2)
  );

  full_adder fa3 (
    .a    (a[3]),
    .b    (b[3]),
    .cin  (carry2),
    .sum  (sum[3]),
    .cout (carry3)
  );

  assign sum[4] = carry3;   // el acarreo final es el bit mas alto del resultado

endmodule
