/* vim: set syntax=magma :*/

freeze;

declare verbose BrandtMatr,2;

////////////////////////
// AlgQuatOrd
////////////////////////

intrinsic BrandtMatrix(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
{
    Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes (right by default) of ideals with equal left/right multiplicator ring O.
    It returns the nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=EquivalenceClassesWithPrescribedOrder(O : Side:=Side);

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
          ind:=Index(Ij,Ii);
          test1,sqrt_num:=IsSquare(Numerator(ind));
          test2,sqrt_den:=IsSquare(Denominator(ind));
          assert test1 and test2;
          sqrt:=sqrt_num/sqrt_den;
          norm:=n/sqrt; 
          vprint BrandtMatr,2: i,j,ind;
          IjcolonIiq := LeftColonIdeal(Ij, Ii);
          enum:=Enumerate(IjcolonIiq, norm,norm); //elements of reduced norm = norm, up to a sign. Because of this we multiply by 2 in the definition of M[i,j].
          debug:=true;
          if debug then
              assert forall{ a : a in enum | Norm(a) eq norm };
              assert 2*#enum/#Units(LeftOrder(Ii)) eq #Seqset([ rideal<O|[a*z : z in ZBasis(Ii)]> : a in enum ]); 
              for a in enum do
                  assert forall{z : z in ZBasis(Ii) | a*z in Ij};
                  ind_a:=Index(Ij,rideal<O|[a*z : z in ZBasis(Ii)]>);
                  assert ind_a eq n^2;
              end for;
          end if;
          M[i,j] := 2*#enum/#Units(LeftOrder(Ii));
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
          ind:=Index(Ij,Ii);
          test1,sqrt_num:=IsSquare(Numerator(ind));
          test2,sqrt_den:=IsSquare(Denominator(ind));
          sqrt:=sqrt_num/sqrt_den;
          assert test1 and test2;
          norm:=n/sqrt; 
          IjcolonIiq := RightColonIdeal(Ij, Ii);
          enum:=Enumerate(IjcolonIiq, norm,norm);
          M[i,j] := 2*#enum/#Units(RightOrder(Ii));
      end for;
      return M;
  end if;
end intrinsic;

////////////////////////
// AlgAssVOrd
////////////////////////

intrinsic BrandtMatrix(n::RngIntElt, O::AlgAssVOrd : Side := "Right") -> AlgMatElt
{
    Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes (right by default) of ideals with equal left/right multiplicator ring O.
    It returns the nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=EquivalenceClassesWithPrescribedOrder(O : Side:=Side);

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
          ind:=Index(Ij,Ii);
          test1,sqrt_num:=IsSquare(Numerator(ind));
          test2,sqrt_den:=IsSquare(Denominator(ind));
          assert test1 and test2;
          sqrt:=sqrt_num/sqrt_den;
          norm:=n/sqrt; 
          vprint BrandtMatr,2: i,j,ind;
          IjcolonIiq := LeftColonIdeal(Ij, Ii);
          enum:=Enumerate(IjcolonIiq, norm, norm); //Elements of reduced norm = norm, up to a sign.
          debug:=true;
          if debug then
              assert forall{ a : a in enum | Norm(a) eq norm };
              assert #enum/#Units(LeftOrder(Ii)) eq #Seqset([ rideal<O|[a*z : z in ZBasis(Ii)]> : a in enum ]); 
              for a in enum do
                  assert forall{z : z in ZBasis(Ii) | a*z in Ij};
                  ind_a:=Index(Ij,rideal<O|[a*z : z in ZBasis(Ii)]>);
                  assert ind_a eq n^2;
              end for;
          end if;
          M[i,j] :=#enum/#Units(LeftOrder(Ii)); //Units is also up to a sign (missing from documentation).
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
          ind:=Index(Ij,Ii);
          test1,sqrt_num:=IsSquare(Numerator(ind));
          test2,sqrt_den:=IsSquare(Denominator(ind));
          sqrt:=sqrt_num/sqrt_den;
          assert test1 and test2;
          norm:=n/sqrt; 
          IjcolonIiq := RightColonIdeal(Ij, Ii);
          enum:=Enumerate(IjcolonIiq, norm,norm); //Elements of reduced norm = norm, up to a sign.
          M[i,j] :=#enum/#Units(RightOrder(Ii)); //Units is up to a sign.
      end for;
      return M;
  end if;
end intrinsic;

/* TEST
 
*/

