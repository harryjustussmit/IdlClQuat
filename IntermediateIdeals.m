/* vim: set syntax=magma :*/

freeze;

intrinsic MinimalIntermediateRightIdeals(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
{ Given fractional right-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that J is not a minimal. }
    if I eq J then 
        return {@ @};
    else
        zbJ:=ZBasis(J);
        Q,q:=Quotient(I,J);
        min_ideals:={@ @};
        // Following code is based on the following Lemma.
        // LEMMA: Let M be a finite right-O-module (eg I/J). Let N be a minimal right-sub-O-module of M. 
        // Then there exists a prime number p dividing #M such that pN=0.
        // In particular, N is a submodule of the kernel Mp of the multiplication-by-p map on M.
        // PROOF: pN is a submodule of N. Since N is minimal pN=N or pN=0. 
        // The first case occurs if p does not divide the order of N.
        // The second occurs if p divides the order of N.
        // QED
        
        for p in PrimeDivisors(#Q) do
            mp:=hom<Q->Q | x:->p*x>;
            Qp:=Kernel(mp);
            rk:=Ngens(Qp);
            assert #Qp eq p^rk;
            Fp:=FiniteField(p);
            // Note: Qp = Fp^rk as a vector space
            // So its right O-module structure can be realized over Fp.
            // More precisely, given generators ai of O over Z, 
            // to find the (minimal) sub-O-modules, it is enough to look at Qp as right module over Fp[ai]
            // In matrices we store the matrix representations of the action on the RIGHT of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(Qp!(q((Qp.j@@q)*zO))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            min_Rmod:=MinimalSubmodules(Qp_Rmod);
            min_ideals join:={@ rideal<O | zbJ cat 
                                    [(Q!(Qp!Eltseq(Qp_Rmod!b)))@@q : b in Basis(min)]> : min in min_Rmod @};
        end for;
        return min_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithPrescribedRightOrder(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
{ Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J and right order O. They are produced recursively from the minimal right-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in RightOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in RightOrder(I) };
    J:=rideal< O | ZBasis(J)>;
    I:=rideal< O | ZBasis(I)>;
    assert J subset I;
    queue:={@ J @};
    if RightOrder(J) eq O then
        output:={@ J @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MinimalIntermediateRightIdeals(O,I,elt) : elt in queue ];
        output join:={@ K : K in pot_new | not K in done and RightOrder(K) eq O @};
        done join:=queue;
//"pot_new=",pot_new;
//"done=",done;
        queue := pot_new diff done;
    end while;
    assert2 #output eq #[ rideal<O | ZBasis(I)> : I in output];
    return output;
end intrinsic;

/* TEST
 
*/

