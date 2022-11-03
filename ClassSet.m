/* vim: set syntax=magma :*/

freeze;

function convert_to_AlgAssVOrd(O)
// Given an AlgQuatOrd O in an AlgQuat B over Rationals returns the re-definition of O as AlgAssVOrd over an AlgQuat over RationalAsNumberField together with the natural bijection between the algebras
    B:=Algebra(O);
    assert Type(BaseField(B)) eq FldRat;
    bas:=Basis(B); // 1,i,j,k
    a,b:=StandardForm(B);
    assert bas[1] eq 1 and bas[2]^2 eq a and bas[3]^2 eq b and bas[2]*bas[3] eq bas[4];
    QQ:=RationalsAsNumberField();
    BB:=QuaternionAlgebra(QQ,a,b);
    m:=map< B-> BB | x:->BB!Flat(x) , y:->B!Flat(y) >;
    assert forall{ x : x in bas | (m(x))@@m eq x };
    assert forall{ y : y in Basis(BB) | m(y@@m) eq y };
    OO:=Order([ m(z) : z in ZBasis(O) ]);
    return OO,m;
end function;


intrinsic LeftClassSet(O::Any) -> SeqEnum
{ Compute the left class set of a quaternion order O in a naive way. This code is originally by Voight (also
appears as commented out code in ideals-jv.m). Some small modifications have been made. We use this naive
version, because it works for any order.}
    require IsIntrinsic("RightClassSet") : "make sure that you have downloaded and attached https://github.com/dansme/hermite.";
    return [ Conjugate(I) : I in RightClassSet(O) ];
end intrinsic;

intrinsic LeftClassSet(O::AlgQuatOrd) -> SeqEnum
{ Compute the left class set of a quaternion order O in a naive way. This code is originally by Voight (also
appears as commented out code in ideals-jv.m). Some small modifications have been made. We use this naive
version, because it works for any order.}
OO,m:=convert_to_AlgAssVOrd(O); // m : O->OO
    cl:=LeftClassSet(OO);
    return [ lideal<O | [ z@@m : z in ZBasis(I) ]> : I in cl ] ;
end intrinsic;

intrinsic RightClassSet(O::AlgQuatOrd) -> SeqEnum
{ Compute the right class set of a quaternion order O in a naive way. This code is originally by Voight (also
appears as commented out code in ideals-jv.m). Some small modifications have been made. We use this naive
version, because it works for any order.}
    require IsIntrinsic("RightClassSet") : "make sure that you have downloaded and attached https://github.com/dansme/hermite.";
    OO,m:=convert_to_AlgAssVOrd(O); // m : O->OO
    cl:=RightClassSet(OO);
    return [ rideal<O | [ z@@m : z in ZBasis(I) ]> : I in cl ] ;
end intrinsic;

/* TEST
 
*/

