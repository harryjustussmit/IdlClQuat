/* vim: set syntax=magma :*/

freeze;

intrinsic BrandtMatrix(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
{
    Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes of ideals with equal left/right multiplicator ring O.
    It returnsthe nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=EquivalenceClassesWithPrescribedOrder(O : Side:=Side);

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
          norm:=n*Norm(Norm(Ij)/Norm(Ii));
          IjcolonIiq := LeftColonIdeal(Ij, Ii);
          M[i,j] := 2*#Enumerate(IjcolonIiq, norm, norm)/#Units(LeftOrder(Ii));
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
          norm:=n*Norm(Norm(Ij)/Norm(Ii));
          IjcolonIiq := RightColonIdeal(Ij, Ii);
          M[i,j] := 2*#Enumerate(IjcolonIiq, norm, norm)/#Units(RightOrder(Ii));
      end for;
      return M;
  end if;
end intrinsic;

/* TEST
 
*/

