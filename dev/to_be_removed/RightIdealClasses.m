/* vim: set syntax=magma :*/

freeze;

intrinsic RightIdealClassesGeneral(O::AlgQuatOrd) -> List
{
    Given an order O in a quaternion algebra returns the right ideal classes of invertible right-O-ideals.
}
    B:=Algebra(O);
    require Type(BaseField(B)) eq FldRat : "implemented only for orders in algebras over Q";
    require IsDefinite(B) : "at the moment only implemented for orders in (totally) definite quaternion algebras";
    discrd:=Discriminant(O); //the reduced dirscriminant
    zbO:=ZBasis(O);
    C:=Truncate((8*discrd)/(Pi(30)^2));
    // By Prop 17.5.6 in Voight's book on Quaternions: 
    // every invertible right ideal class of an order O in a totally definite quaternion algebra over Q is represented by
    // an integral ideal I with norm N(I) \leq C, with C as above. Here N(I)=#(O/I) is the abelian group index.
    
    pp:=[ n : n in [1..C] | IsPrimePower(n) ]; // prime powers up to C
    // We need to enumerate invertible integral right-O-ideals of norm p^e for each p^e in pp.
    // Then by taking intersections we get all ideals of norm up to C.
    pp_cand:=AssociativeArray(); 
    for P in pp do
        Q,q:=Quotient(1*O,P*O);
        candidates_P:={ rideal< O | [P*z : z in zbO ] cat [ (b@@q)*z : z in zbO ]> : b in Q };
        candidates_P:=[ I : I in candidates_P | IsWeaklyEquivalent(I,1*O : Side:="Right") ]; // only the ones with right order O which are right invertible
        pp_cand[P]:=candidates_P;
    end for;

    // now we take all the intersections
    candidates:=[];
    for norm in [1..C] do
        ppf:=[ g[1]^g[2] : g in Factorization(norm) ]; // factorization into prime powers of norm
        cc:=CartesianProduct([ pp_cand[P] : P in ppf ]);
        for c in cc do
            I:=&meet[ c[i] : i in [1..#c] ];
            assert IsWeaklyEquivalent(I,1*O : Side:="Right");

            


    end for;

    return ???;
end intrinsic;

/* TEST
 
*/

