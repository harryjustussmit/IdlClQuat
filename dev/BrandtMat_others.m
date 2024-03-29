/* vim: set syntax=magma :*/

freeze;

// Here we collect a bunch of other versions of BrandMatrices that were produced during the developement and debug phases. They need to be optimized and checked carefully. Use at your own risk. 

declare verbose BrandtMatr_naive,2;

intrinsic MyIsRightIsomorphic(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl) -> BoolElt,AlgQuatElt
{ Returns whether there exists x such that xI=J. The inbuilt IsRightIsomorphic gives false positives for non-invertible ideals :-( }
    if IsRightInvertible(I) and IsRightInvertible(J) then
        test,_,x:=IsRightIsomorphic(I,J);
        if test then
            xI:=rideal<RightOrder(I)|[x*z : z in ZBasis(I)]>;
            assert forall{z : z in ZBasis(xI) | z in J } and forall{z : z in ZBasis(J) | z in xI};
            return true,x;
        else
            return false,_;
        end if;
    else
        if not IsWeaklyEquivalent(I,J : Side:="Right") then
            return false,_;
        else
            ccL:=LeftColonIdeal(J,I); // ccL*I = J
            assert IsRightInvertible(ccL) and IsLeftInvertible(ccL); //since they are right wk eq
            test,x:=IsPrincipal(ccL);
            if test then 
                xI:=rideal<RightOrder(I)|[x*z : z in ZBasis(I)]>;
                assert forall{z : z in ZBasis(xI) | z in J } and forall{z : z in ZBasis(J) | z in xI};
                return true,x;
            else
                return false,_;
            end if;
        end if;
    end if;
end intrinsic;

intrinsic BrandtMatrix_naive(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
{
    Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes of ideals with equal left/right multiplicator ring O.
    It returnsthe nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=EquivalenceClassesWithPrescribedOrder(O : Side:=Side);

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
// Using subgroups
//           zb_Ij := ZBasis(Ij);
//           zb_nIj:=[ n^2*z : z in zb_Ij ];
//           Js:=[* *];
//           F:=FreeAbelianGroup(Degree(Algebra(O)));
//           mat_num:=Matrix(zb_Ij);
//           mat_den:=Matrix(zb_nIj);
//           rel:=[F ! Eltseq(x) : x in Rows(mat_den*mat_num^-1)];
//           Q,q:=quo<F|rel>;
// 
//           /*        
//           // LowIndexProcess seems to produce more geninF:=[(f(QP ! x))@@q : x in Generators(H)];
//             coeff:=[Eltseq(x) : x in geninF];
//             J:=rideal<O| [&+[zb_Ij[i]*x[i] : i in [1..#zb_Ij]] : x in coeff] cat zb_nIj>;
//             if Index(Ij,J) eq n^2 then //this means that the lift of H is actually equal to J.
//                 if IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) then
//                     Append(~Js,J);
//                 end if;
//             end if;
//           end while;
//           */
//           // with Subgroups, much slower because we need to generate all subgroups and then sieve out the ones that have the Index = n^2
//           subg:=Subgroups(Q);
//           for H in subg do
//             if Index(Q,H`subgroup) eq n^2 then
//                 gensinF:=[(Q!g)@@q : g in Generators(H`subgroup)];
//                 coeff:=[Eltseq(x) : x in gensinF];
//                 J:=rideal<O| [&+[zb_Ij[i]*x[i] : i in [1..#zb_Ij]] : x in coeff] cat zb_nIj>;
//       if RightOrder(J) eq O then
//         assert exists{ I : I in classes | IsRightIsomorphic(I,J) };
//       end if;
//                 if Index(Ij,J) eq n^2 then //this means that the lift of H is actually equal to J.
//                     if IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) then
//                         Append(~Js,J);
//                     end if;
//                 end if;
//             end if;
//           end for;
          nIj:=rideal<O|[n^2*z: z in ZBasis(Ij)]>;
          candidates:=IntermediateIdealsWithPrescribedRightOrder(O,Ij,nIj);
          assert forall{ J : J in candidates | exists{ I : I in classes | MyIsRightIsomorphic(I,J) }};
          Js:=[* J : J in candidates | Index(Ij,J) eq n^2 and IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) *];
          M[i,j] := #Js;
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
        error "not implemented yet";
      end for;
      return M;
  end if;

end intrinsic;

intrinsic InvBrandtMatrix(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
{
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=RightClassSet(O);

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
          ind:=Index(Ij,Ii);
          test1,sqrt_num:=IsSquare(Numerator(ind));
          test2,sqrt_den:=IsSquare(Denominator(ind));
          sqrt:=sqrt_num/sqrt_den;
          assert test1 and test2;
          norm:=n/sqrt; 
          vprint BrandtMatr,2: i,j,ind;
          IjcolonIiq := LeftColonIdeal(Ij, Ii);
          enum:=Enumerate(IjcolonIiq, norm, norm); //elements of reduced norm = norm, up to a sign. Because of this we multiply by 2 in the definition of M[i,j].
          assert forall{ a : a in enum | Norm(a) eq norm };
          assert 2*#enum/#Units(LeftOrder(Ii)) eq #Seqset([ rideal<O|[a*z : z in ZBasis(Ii)]> : a in enum ]); 
          for a in enum do
              assert forall{z : z in ZBasis(Ii) | a*z in Ij};
              ind_a:=Index(Ij,rideal<O|[a*z : z in ZBasis(Ii)]>);
              //norm,ind_a;
              assert ind_a eq n^2;
          end for;
          M[i,j] := 2*#enum/#Units(LeftOrder(Ii));
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
          //norm:=n*Norm(Norm(Ij)/Norm(Ii));
          ind:=Index(Ij,Ii);
          test1,sqrt_num:=IsSquare(Numerator(ind));
          test2,sqrt_den:=IsSquare(Denominator(ind));
          sqrt:=sqrt_num/sqrt_den;
          assert test1 and test2;
          norm:=n/sqrt; 
          IjcolonIiq := RightColonIdeal(Ij, Ii);
          enum:=Enumerate(IjcolonIiq, norm, norm);
          M[i,j] := 2*#enum/#Units(RightOrder(Ii));
      end for;
      return M;
  end if;
end intrinsic;

intrinsic InvBrandtMatrix_naive(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
{
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=RightIdealClasses(O);

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
          nIj:=rideal<O|[n^2*z: z in ZBasis(Ij)]>;
          candidates:=IntermediateIdealsWithPrescribedRightOrder(O,Ij,nIj);
          candidates:=[ J : J in candidates | IsRightInvertible(J) ];
          assert forall{ J : J in candidates | exists{ I : I in classes | MyIsRightIsomorphic(I,J) }};
          Js:=[* J : J in candidates | Index(Ij,J) eq n^2 and IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) *];
          M[i,j] := #Js;
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
        error "not implemented yet";
      end for;
      return M;
  end if;
end intrinsic;

intrinsic WeakBrandtMatrix(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
{
    only with wk classes
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  classes:=WeakEquivalenceClassesWithPrescribedOrder(O : Side:="Right");

  M := ZeroMatrix(Integers(), #classes);

  if Side eq "Right" then
      for i -> Ii, j -> Ij in classes do
// Using subgroups
//           zb_Ij := ZBasis(Ij);
//           zb_nIj:=[ n^2*z : z in zb_Ij ];
//           Js:=[* *];
//           F:=FreeAbelianGroup(Degree(Algebra(O)));
//           mat_num:=Matrix(zb_Ij);
//           mat_den:=Matrix(zb_nIj);
//           rel:=[F ! Eltseq(x) : x in Rows(mat_den*mat_num^-1)];
//           Q,q:=quo<F|rel>;
// 
//           /*        
//           // LowIndexProcess seems to produce more geninF:=[(f(QP ! x))@@q : x in Generators(H)];
//             coeff:=[Eltseq(x) : x in geninF];
//             J:=rideal<O| [&+[zb_Ij[i]*x[i] : i in [1..#zb_Ij]] : x in coeff] cat zb_nIj>;
//             if Index(Ij,J) eq n^2 then //this means that the lift of H is actually equal to J.
//                 if IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) then
//                     Append(~Js,J);
//                 end if;
//             end if;
//           end while;
//           */
//           // with Subgroups, much slower because we need to generate all subgroups and then sieve out the ones that have the Index = n^2
//           subg:=Subgroups(Q);
//           for H in subg do
//             if Index(Q,H`subgroup) eq n^2 then
//                 gensinF:=[(Q!g)@@q : g in Generators(H`subgroup)];
//                 coeff:=[Eltseq(x) : x in gensinF];
//                 J:=rideal<O| [&+[zb_Ij[i]*x[i] : i in [1..#zb_Ij]] : x in coeff] cat zb_nIj>;
//                 if Index(Ij,J) eq n^2 then //this means that the lift of H is actually equal to J.
//                     if IsWeaklyEquivalent(J,Ii : Side:="Right") then
//                         Append(~Js,J);
//                     end if;
//                 end if;
//             end if;
//           end for;
          nIj:=rideal<O|[n^2*z: z in ZBasis(Ij)]>;
          candidates:=IntermediateIdealsWithPrescribedRightOrder(O,Ij,nIj);
          Js:=[* J : J in candidates | Index(Ij,J) eq n^2 and IsWeaklyEquivalent(J,Ii : Side:="Right") *];
          M[i,j] := #Js;
      end for;
      return M;
  end if;

  if Side eq "Left" then
      for i -> Ii, j -> Ij in classes do
        error "not implemented yet";
      end for;
      return M;
  end if;

end intrinsic;

/* TEST
 
*/

