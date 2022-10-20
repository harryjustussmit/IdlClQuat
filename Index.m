/* vim: set syntax=magma :*/

freeze;

intrinsic Index(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> RngElt
{
    Returns the index [I:J].
}
  require Type(BaseField(Algebra(I))) eq FldRat : "Only for Rational Quaternion Algebras";
  zbI:=Abs(Determinant(Matrix(ZBasis(I))));
  zbJ:=Abs(Determinant(Matrix(ZBasis(J))));
  ind:=zbJ/zbI;
  return ind;
end intrinsic;
