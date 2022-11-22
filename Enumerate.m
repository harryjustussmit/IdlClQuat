/* vim: set syntax=magma :*/

freeze;

function convert_to_AlgQuatOrd(O)
// Given an AlgAssVOrd O in an AlgQuat B over RationalAsNumberField, returns the re-definition of O as AlgQuatOrd over an AlgQuat over Rationals together with the natural bijection between the algebras
    B:=Algebra(O);
    bas:=Basis(B); // 1,i,j,k
    a,b:=StandardForm(B);
    assert bas[1] eq 1 and bas[2]^2 eq a and bas[3]^2 eq b and bas[2]*bas[3] eq bas[4];
    BB:=QuaternionAlgebra(Rationals(),a,b);
    m:=map< B-> BB | x:->BB!Flat(x) , y:->B!Flat(y) >;
    assert forall{ x : x in bas | (m(x))@@m eq x };
    assert forall{ y : y in Basis(BB) | m(y@@m) eq y };
    OO:=QuaternionOrder([ m(z) : z in ZBasis(O) ]);
    return OO,m;
end function;

intrinsic Enumerate(I::AlgAssVOrdIdl, A::RngElt, B::RngElt) -> SeqEnum
{ Enumerates the elements in I of reduced norm between A and B, up to a sign.  }
    assert Degree(BaseField(Algebra(I))) eq 1;
    OO,m:=convert_to_AlgQuatOrd(RightOrder(I));
    II:=rideal<OO | [ m(z) : z in ZBasis(I) ]>;
    enum:=Enumerate(II,A,B);
    return [ a@@m : a in enum ];
end intrinsic;

/* TEST
 
*/

