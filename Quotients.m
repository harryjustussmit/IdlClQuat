/* vim: set syntax=magma :*/

freeze;

//////////////////////
// AlgQuatOrd
//////////////////////

intrinsic Quotient(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl) -> GrpAb, Map
{ given fractional ideals J subset I, returns the abelian group Q=I/J together with the quotient map q:I->J } 
    // if J is not inside I, an error occurs while forming Q. so no need to check in advance
    A:=Algebra(I);
	zbI := ZBasis(I);
	N := #zbI;
	F := FreeAbelianGroup(N);
    mat_num:=Matrix(ZBasis(I));
    mat_num_inv:=mat_num^-1;
    mat_den:=Matrix(ZBasis(J));
    rel:=[F ! Eltseq(x) : x in Rows(mat_den*mat_num_inv)];
	mFI := map<F->A| x:->&+[Eltseq(x)[i]*zbI[i] : i in [1..N]]>;
	mIF := map<A->F| x:-> F ! Eltseq(Rows(Matrix([Coordinates(x)])*mat_num_inv)[1])>;
	Q,qFQ := quo<F|rel>; //q:F->Q. Q is an "abstract" abelian group isomorphic to I/J.
    q:=map< A->Q | x:->qFQ(mIF(x)) , y:-> mFI(y@@qFQ) >; 
    return Q,q;
end intrinsic;

//////////////////////
// AlgAssVOrd
//////////////////////

intrinsic Quotient(I::AlgAssVOrdIdl, J::AlgAssVOrdIdl) -> GrpAb, Map
{ given fractional ideals J subset I, returns the abelian group Q=I/J together with the quotient map q:I->J } 
    // if J is not inside I, an error occurs while forming Q. so no need to check in advance
    A:=Algebra(I);
	zbI := ZBasis(I);
	N := #zbI;
	F := FreeAbelianGroup(N);
    mat_num:=Matrix(ZBasis(I));
    mat_num_inv:=mat_num^-1;
    mat_den:=Matrix(ZBasis(J));
    rel:=[F ! Eltseq(x) : x in Rows(mat_den*mat_num_inv)];
	mFI := map<F->A| x:->&+[Eltseq(x)[i]*zbI[i] : i in [1..N]]>;
	mIF := map<A->F| x:-> F ! Eltseq(Rows(Matrix([Coordinates(x)])*mat_num_inv)[1])>;
	Q,qFQ := quo<F|rel>; //q:F->Q. Q is an "abstract" abelian group isomorphic to I/J.
    q:=map< A->Q | x:->qFQ(mIF(x)) , y:-> mFI(y@@qFQ) >; 
    return Q,q;
end intrinsic;

/* TEST
 
*/

