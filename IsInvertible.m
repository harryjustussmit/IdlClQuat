/* vim: set syntax=magma :*/

freeze;

//////////////////////
// AlgQuatOrd
//////////////////////

intrinsic IsRightInvertible(I::AlgQuatOrdIdl) -> BoolElt
{ Given a lattice I returns whether it is right invertible, that is, I*(OL(I):I)_R eq OL(I) and the product is compatible.}
  OL:=LeftOrder(I);
  ccR:=RightColonIdeal(OL,I);
  return IsCompatible(I,ccR) and I*ccR eq 1*OL;
end intrinsic;

intrinsic IsLeftInvertible(I::AlgQuatOrdIdl) -> BoolElt
{ Given a lattice I returns whether it is left invertible, that is, (OR(I):I)_L*I eq OR(I) and the product is compatible.}
  OR:=RightOrder(I);
  ccL:=LeftColonIdeal(OR,I);
  return IsCompatible(ccL,I) and ccL*I eq 1*OR;
end intrinsic;

//////////////////////
// AlgAssVOrd
//////////////////////

intrinsic IsRightInvertible(I::AlgAssVOrdIdl) -> BoolElt
{ Given a lattice I returns whether it is right invertible, that is, I*(OL(I):I)_R eq OL(I) and the product is compatible.}
  OL:=LeftOrder(I);
  ccR:=RightColonIdeal(OL,I);
  return IsCompatible(I,ccR) and I*ccR eq 1*OL;
end intrinsic;

intrinsic IsLeftInvertible(I::AlgAssVOrdIdl) -> BoolElt
{ Given a lattice I returns whether it is left invertible, that is, (OR(I):I)_L*I eq OR(I) and the product is compatible.}
  OR:=RightOrder(I);
  ccL:=LeftColonIdeal(OR,I);
  return IsCompatible(ccL,I) and ccL*I eq 1*OR;
end intrinsic;

