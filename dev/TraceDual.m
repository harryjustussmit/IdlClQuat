/* vim: set syntax=magma :*/

freeze;
// TODO

/*
intrinsic TraceDual(I::AlgAssVOrdIdl[RngOrd]) -> PMat
{
  Given an ideal I of an associative algebra A with standard involution over a Dedekind domain R, computes the trace dual consisting of x \in A such that trd(xI) \subseteq R.
  Note: this currently requires the underlying algebra to be a quaternion algebra.
};

O := Order(I);
A := Algebra(O);
//require Type(A) eq AlgQuat : "Algebra must be of type AlgQuat";
e := Basis(A);
PM := PseudoMatrix(I, A);
Is := CoefficientIdeals(PM);
M := Matrix(PM);

//Js := [K^{-1} : K in Is]; // Or ColonIdeal(R, I) or Inverse(I)
n := # Is; // Equals the dimension of A
Js := [];
for i in [1..n] do
  R :=  Order(Is[i]) * 1;
  K, d := IntegralSplit(Is[i]);
  Append(~Js, d * ColonIdeal(R, K));
end for;

x := [];
for i in [1..n] do
  Append(~x, A ! M[i]);
end for;

list := [];
for i in [1..n] do
  for j in [1..n] do
    Append(~list, Trace(x[i] * e[j])/2); // The reduced trace for AlgQuat is half of the trace for AlgAss. Needs fix.
  end for;
end for;

traceMatrix := Matrix(n, list);
// Perhaps also "cache" the trace dual.

Js, x, e, traceMatrix, traceMatrix ^ -1;

return PseudoMatrix(Js, Transpose(traceMatrix ^ -1));

end intrinsic;
*/

/* TEST
 
*/

