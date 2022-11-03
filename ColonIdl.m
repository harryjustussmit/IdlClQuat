/* vim: set syntax=magma :*/

freeze;


hnf:=function(M)
//input: a matrix over the Integers()
//output: the matrix in HNF
  N:=Rank(M);
  H:=HermiteForm(M);
  H:=Matrix(Rows(H)[1..N]);
  return H;
end function;

//////////////////////
// AlgQuatOrd
//////////////////////

intrinsic RightColonIdeal(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
{
    Given two lattices I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.
}
  A:=Algebra(I);
  // based on jv code
  O:=RightOrder(I);
  N:=Dimension(A);
  zbI:=ZBasis(I);
  mIinv:=Matrix(ZBasis(I))^-1;
  zbJ:=ZBasis(J);
  bas:=Basis(A);
  M:=VerticalJoin([ Transpose( Matrix([zj*bas[i] : i in [1..N]])*mIinv) : zj in zbJ] );
  d:=Denominator(M);
  P:=(1/d)*ChangeRing(hnf(ChangeRing(d*M,Integers())),Rationals());
  P:=Transpose(P)^-1;
  zbIJ:=[A!Eltseq(r) : r in Rows(P)];
  IJ:=rideal<O|zbIJ>;
  assert forall{z : z in zbIJ, w in ZBasis(J) | w*z in I};
  return IJ;
end intrinsic;

intrinsic LeftColonIdeal(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
{
    Given two lattices I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.
}
  A:=Algebra(I);
  O:=LeftOrder(I);
  N:=Dimension(A);
  zbI:=ZBasis(I);
  mIinv:=Matrix(ZBasis(I))^-1;
  zbJ:=ZBasis(J);
  bas:=Basis(A);
  M:=VerticalJoin([ Transpose( Matrix([bas[i]*zj : i in [1..N]])*mIinv) : zj in zbJ] );
  d:=Denominator(M);
  P:=(1/d)*ChangeRing(hnf(ChangeRing(d*M,Integers())),Rationals());
  P:=Transpose(P)^-1;
  zbIJ:=[A!Eltseq(r) : r in Rows(P)];
  IJ:=lideal<O|zbIJ>;
  assert forall{z : z in zbIJ, w in ZBasis(J) | z*w in I};
  return IJ;
end intrinsic;

intrinsic RightColonIdeal(I::AlgQuatOrd,J::AlgQuatOrd) -> AlgQuatOrdIdl
{ Given two orders I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I. }
  return RightColonIdeal(ideal<I|1>,ideal<J|1>);
end intrinsic;

intrinsic LeftColonIdeal(I::AlgQuatOrd,J::AlgQuatOrd) -> AlgQuatOrdIdl
{ Given two orders I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I. }
  return LeftColonIdeal(ideal<I|1>,ideal<J|1>);
end intrinsic;

intrinsic RightColonIdeal(I::AlgQuatOrdIdl,J::AlgQuatOrd) -> AlgQuatOrdIdl
{ Given a lattice I and an order J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I. }
  return RightColonIdeal(I,ideal<J|1>);
end intrinsic;

intrinsic LeftColonIdeal(I::AlgQuatOrdIdl,J::AlgQuatOrd) -> AlgQuatOrdIdl
{ Given a lattice I and an order J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I. }
  return LeftColonIdeal(I,ideal<J|1>);
end intrinsic;

intrinsic RightColonIdeal(I::AlgQuatOrd,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
{ Given an order I and a lattice J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I. }
  return RightColonIdeal(ideal<I|1>,J);
end intrinsic;

intrinsic LeftColonIdeal(I::AlgQuatOrd,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
{ Given an order I and a lattice J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I. }
  return LeftColonIdeal(ideal<I|1>,J);
end intrinsic;

//////////////////////
// AlgAssVOrd
//////////////////////

intrinsic RightColonIdeal(I::AlgAssVOrdIdl,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
{
    Given two lattices I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.
}
  A:=Algebra(I);
  // based on jv code
  O:=RightOrder(I);
  N:=Dimension(A);
  zbI:=ZBasis(I);
  mIinv:=Matrix(ZBasis(I))^-1;
  zbJ:=ZBasis(J);
  bas:=Basis(A);
  M:=VerticalJoin([ Transpose( Matrix([zj*bas[i] : i in [1..N]])*mIinv) : zj in zbJ] );
  d:=Denominator(M);
  P:=(1/d)*ChangeRing(hnf(ChangeRing(d*M,Integers())),Rationals());
  P:=Transpose(P)^-1;
  zbIJ:=[A!Eltseq(r) : r in Rows(P)];
  IJ:=rideal<O|zbIJ>;
  assert forall{z : z in zbIJ, w in ZBasis(J) | w*z in I};
  return IJ;
end intrinsic;

intrinsic LeftColonIdeal(I::AlgAssVOrdIdl,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
{
    Given two lattices I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.
}
  A:=Algebra(I);
  O:=LeftOrder(I);
  N:=Dimension(A);
  zbI:=ZBasis(I);
  mIinv:=Matrix(ZBasis(I))^-1;
  zbJ:=ZBasis(J);
  bas:=Basis(A);
  M:=VerticalJoin([ Transpose( Matrix([bas[i]*zj : i in [1..N]])*mIinv) : zj in zbJ] );
  d:=Denominator(M);
  P:=(1/d)*ChangeRing(hnf(ChangeRing(d*M,Integers())),Rationals());
  P:=Transpose(P)^-1;
  zbIJ:=[A!Eltseq(r) : r in Rows(P)];
  IJ:=lideal<O|zbIJ>;
  assert forall{z : z in zbIJ, w in ZBasis(J) | z*w in I};
  return IJ;
end intrinsic;

intrinsic RightColonIdeal(I::AlgAssVOrd,J::AlgAssVOrd) -> AlgAssVOrdIdl
{ Given two orders I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I. }
  return RightColonIdeal(ideal<I|1>,ideal<J|1>);
end intrinsic;

intrinsic LeftColonIdeal(I::AlgAssVOrd,J::AlgAssVOrd) -> AlgAssVOrdIdl
{ Given two orders I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I. }
  return LeftColonIdeal(ideal<I|1>,ideal<J|1>);
end intrinsic;

intrinsic RightColonIdeal(I::AlgAssVOrdIdl,J::AlgAssVOrd) -> AlgAssVOrdIdl
{ Given a lattice I and an order J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I. }
  return RightColonIdeal(I,ideal<J|1>);
end intrinsic;

intrinsic LeftColonIdeal(I::AlgAssVOrdIdl,J::AlgAssVOrd) -> AlgAssVOrdIdl
{ Given a lattice I and an order J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I. }
  return LeftColonIdeal(I,ideal<J|1>);
end intrinsic;

intrinsic RightColonIdeal(I::AlgAssVOrd,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
{ Given an order I and a lattice J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I. }
  return RightColonIdeal(ideal<I|1>,J);
end intrinsic;

intrinsic LeftColonIdeal(I::AlgAssVOrd,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
{ Given an order I and a lattice J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I. }
  return LeftColonIdeal(ideal<I|1>,J);
end intrinsic;
