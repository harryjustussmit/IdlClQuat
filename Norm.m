/* vim: set syntax=magma :*/

freeze;

// The next one overwrites the intrinsic contained AlgQuat/ideals.m which works only for invertible ideals!!!
intrinsic Norm(I::AlgQuatOrdIdl) -> RngElt
{
    Returns the reduced norm of the ideal I.
    Based on Voight - Quaternion Algebras 1.0.5 Lemma 16.3.2
}
  require Type(BaseField(Algebra(I))) eq FldRat : "Only for Rational Quaternion Algebras";
  zb:=ZBasis(I);
  seq:=[ Rationals()!(a*Conjugate(a)) : a in ZBasis(I) ] cat [ Rationals()!((a+b)*Conjugate(a+b)) : a,b in ZBasis(I) ];
  den:=LCM([ Denominator(x) : x in seq ] );
  num:=GCD([ Integers() ! (x*den) : x in seq ]);
  return num/den;
end intrinsic;
