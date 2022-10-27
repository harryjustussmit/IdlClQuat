/* vim: set syntax=magma :*/

freeze;

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
            return false,_,_;
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
          zb_Ij := ZBasis(Ij);
          zb_nIj:=[ n*z : z in zb_Ij ];
          Js:=[* *];
          F:=FreeAbelianGroup(Degree(Algebra(O)));
          mat_num:=Matrix(zb_Ij);
          mat_den:=Matrix(zb_nIj);
          rel:=[F ! Eltseq(x) : x in Rows(mat_den*mat_num^-1)];
          Q,q:=quo<F|rel>;

          /*        
          // LowIndexProcess seems to produce more subgroups than Subgroups, and it is slower. This is very weird.
          QP,f:=FPGroup(Q);
          subg:=LowIndexProcess(QP,<n^2,n^2>);
          iH:=0;
          while not IsEmpty(subg) do
            iH +:=1;
            H := ExtractGroup(subg);
            NextSubgroup(~subg);
            geninF:=[(f(QP ! x))@@q : x in Generators(H)];
            coeff:=[Eltseq(x) : x in geninF];
            J:=rideal<O| [&+[zb_Ij[i]*x[i] : i in [1..#zb_Ij]] : x in coeff] cat zb_nIj>;
            if Index(Ij,J) eq n^2 then //this means that the lift of H is actually equal to J.
                if IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) then
                    Append(~Js,J);
                end if;
            end if;
          end while;
          */
          // with Subgroups, much slower because we need to generate all subgroups and then sieve out the ones that have the Index = n^2
          subg:=Subgroups(Q);
          for H in subg do
            if Index(Q,H`subgroup) eq n^2 then
                gensinF:=[(Q!g)@@q : g in Generators(H`subgroup)];
                coeff:=[Eltseq(x) : x in gensinF];
                J:=rideal<O| [&+[zb_Ij[i]*x[i] : i in [1..#zb_Ij]] : x in coeff] cat zb_nIj>;
                if Index(Ij,J) eq n^2 then //this means that the lift of H is actually equal to J.
                    if IsWeaklyEquivalent(J,Ii : Side:="Right") and MyIsRightIsomorphic(J,Ii) then
                        Append(~Js,J);
                    end if;
                end if;
            end if;
          end for;
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

