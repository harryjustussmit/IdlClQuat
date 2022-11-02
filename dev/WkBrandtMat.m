/* vim: set syntax=magma :*/

freeze;

declare verbose BrandtMatr_naive,2;

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

