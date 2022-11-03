/* vim: set syntax=magma :*/

freeze;

//////////////////////
// AlgQuatOrd
//////////////////////

intrinsic Index(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> RngElt
{
    Returns the index [I:J].
}
  zbI:=Determinant(Matrix(ZBasis(I)));
  zbJ:=Determinant(Matrix(ZBasis(J)));
  ind:=zbJ/zbI;
  return Abs(Norm(ind));
end intrinsic;

intrinsic Index(I::AlgQuatOrd,J::AlgQuatOrd) -> RngElt
{
    Returns the index [I:J].
}
  zbI:=Determinant(Matrix(ZBasis(I)));
  zbJ:=Determinant(Matrix(ZBasis(J)));
  ind:=zbJ/zbI;
  return Abs(Norm(ind));
end intrinsic;


//////////////////////
// AlgAssVOrd
//////////////////////

intrinsic Index(I::AlgAssVOrdIdl,J::AlgAssVOrdIdl) -> RngElt
{
    Returns the index [I:J].
}
  zbI:=Determinant(Matrix(ZBasis(I)));
  zbJ:=Determinant(Matrix(ZBasis(J)));
  ind:=zbJ/zbI;
  return Abs(Norm(ind));
end intrinsic;

intrinsic Index(I::AlgAssVOrd,J::AlgAssVOrd) -> RngElt
{
    Returns the index [I:J].
}
  zbI:=Determinant(Matrix(ZBasis(I)));
  zbJ:=Determinant(Matrix(ZBasis(J)));
  ind:=zbJ/zbI;
  return Abs(Norm(ind));
end intrinsic;

