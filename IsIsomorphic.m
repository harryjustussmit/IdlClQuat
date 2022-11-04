/* vim: set syntax=magma :*/

freeze;

intrinsic IsRightIsomorphic(I::AlgQuatOrdIdl[RngInt], J::AlgQuatOrdIdl[RngInt]) -> BoolElt,AlgQuatElt
{ Returns whether there exists x such that xI=J. The inbuilt IsRightIsomorphic gives false positives for non-invertible ideals :-( }
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
end intrinsic;

/* TEST
 
*/

