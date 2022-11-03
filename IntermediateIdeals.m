/* vim: set syntax=magma :*/

freeze;

////////////////////////
// AlgAssVOrd Right
////////////////////////

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
        queue := pot_new diff done;
    end while;
    assert2 #output eq #[ rideal<O | ZBasis(I)> : I in output];
    return output;
end intrinsic;

intrinsic MaximalIntermediateRightIdeals(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->SetIndx[AlgEtIdl]
{ Given fractional right-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that I is not a maximal. }
    if J eq I then 
        return {@ @};
    else
        // If I c K c I is maximal then pI+K = K for any rational prime divinding #I/K.
        // Hence pI c K c I.
        // Note that I/pI is an Fp-vector space.
        Q,q:=Quotient(I,J);
        zbJ:=ZBasis(J);
        max_ideals:={@ @};
        for p in PrimeDivisors(#Q) do
            mp:=[ p*(Q.j) : j in [1..Ngens(Q)] ];
            mp_in_I:=[ x@@q : x in mp  ] cat zbJ;
            Qp,qp:=quo<Q|mp>;
            rk:=Ngens(Qp);
            assert #Qp eq p^rk;
            Fp:=FiniteField(p);
            // Note: Qp = Fp^rk as a vector space
            // So its right-O-module structure can be realized over Fp.
            // More precisely, given generators ai of O over Z, 
            // to find the (maximal) right-sub-O-modules, it is enough to look at Qp as module over Fp[ai]
            // In matrices we store the matrix representations of the RIGHT action of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(qp(q((Qp.j@@qp@@q)*zO))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            max_Rmod:=MaximalSubmodules(Qp_Rmod);
            max_ideals join:={@ rideal<O| mp_in_I cat [(Qp!Eltseq(Qp_Rmod!b))@@qp@@q : b in Basis(max)]> 
                                        : max in max_Rmod @};
        end for;
        return max_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithTrivialExtensionAndPrescribedRightOrder(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl,O1::AlgAssVOrd)->SetIndx[AlgEtIdl]
{ Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J, right order O and such that K*O1=I*O1. They are produced recursively from the maximal right-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in RightOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in RightOrder(I) };
    J:=rideal< O | ZBasis(J)>;
    I:=rideal< O | ZBasis(I)>;
    IO1:=rideal<O1 | ZBasis(I)>;
    queue:={@ I @};
    if RightOrder(I) eq O then
        output:={@ I @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MaximalIntermediateRightIdeals(O,elt,J) : elt in queue ];
        pot_new:={@ K : K in pot_new | rideal<O1 | ZBasis(K)> eq IO1 @}; //we keep only the ones with trivial extension
        output join:={@ K : K in pot_new | not K in done and RightOrder(K) eq O @};
        done join:=queue;
        // Note: if O1!!K is not IO1, then all the submodules of K will also not have trivial extension IO1.
        // Hence we don't need to continue the recursion on K.
        queue := pot_new diff done; 
    end while;
    return output;
end intrinsic;


////////////////////////
// AlgAssVOrd Left
////////////////////////

intrinsic MinimalIntermediateLeftIdeals(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
{ Given fractional left-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that J is not a minimal. }
    if I eq J then 
        return {@ @};
    else
        zbJ:=ZBasis(J);
        Q,q:=Quotient(I,J);
        min_ideals:={@ @};
        // Following code is based on the following Lemma.
        // LEMMA: Let M be a finite left-O-module (eg I/J). Let N be a minimal left-sub-O-module of M. 
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
            // In matrices we store the matrix representations of the action on the LEFT of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(Qp!(q(zO*(Qp.j@@q)))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            min_Rmod:=MinimalSubmodules(Qp_Rmod);
            min_ideals join:={@ lideal<O | zbJ cat 
                                    [(Q!(Qp!Eltseq(Qp_Rmod!b)))@@q : b in Basis(min)]> : min in min_Rmod @};
        end for;
        return min_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithPrescribedLeftOrder(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
{ Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J and left order O. They are produced recursively from the minimal left-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(I) };
    J:=lideal< O | ZBasis(J)>;
    I:=lideal< O | ZBasis(I)>;
    assert J subset I;
    queue:={@ J @};
    if LeftOrder(J) eq O then
        output:={@ J @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MinimalIntermediateLeftIdeals(O,I,elt) : elt in queue ];
        output join:={@ K : K in pot_new | not K in done and LeftOrder(K) eq O @};
        done join:=queue;
        queue := pot_new diff done;
    end while;
    assert2 #output eq #[ lideal<O | ZBasis(I)> : I in output];
    return output;
end intrinsic;

intrinsic MaximalIntermediateLeftIdeals(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->SetIndx[AlgEtIdl]
{ Given fractional left-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that I is not a maximal. }
    if J eq I then 
        return {@ @};
    else
        // If I c K c I is maximal then pI+K = K for any rational prime divinding #I/K.
        // Hence pI c K c I.
        // Note that I/pI is an Fp-vector space.
        Q,q:=Quotient(I,J);
        zbJ:=ZBasis(J);
        max_ideals:={@ @};
        for p in PrimeDivisors(#Q) do
            mp:=[ p*(Q.j) : j in [1..Ngens(Q)] ];
            mp_in_I:=[ x@@q : x in mp  ] cat zbJ;
            Qp,qp:=quo<Q|mp>;
            rk:=Ngens(Qp);
            assert #Qp eq p^rk;
            Fp:=FiniteField(p);
            // Note: Qp = Fp^rk as a vector space
            // So its right-O-module structure can be realized over Fp.
            // More precisely, given generators ai of O over Z, 
            // to find the (maximal) right-sub-O-modules, it is enough to look at Qp as module over Fp[ai]
            // In matrices we store the matrix representations of the LEFT action of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(qp(q(zO*(Qp.j@@qp@@q)))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            max_Rmod:=MaximalSubmodules(Qp_Rmod);
            max_ideals join:={@ lideal<O| mp_in_I cat [(Qp!Eltseq(Qp_Rmod!b))@@qp@@q : b in Basis(max)]> 
                                        : max in max_Rmod @};
        end for;
        return max_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithTrivialExtensionAndPrescribedLeftOrder(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl,O1::AlgAssVOrd)->SetIndx[AlgEtIdl]
{ Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J, left order O and such that K*O1=I*O1. They are produced recursively from the maximal left-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(I) };
    J:=lideal< O | ZBasis(J)>;
    I:=lideal< O | ZBasis(I)>;
    IO1:=lideal<O1 | ZBasis(I)>;
    queue:={@ I @};
    if LeftOrder(I) eq O then
        output:={@ I @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MaximalIntermediateLeftIdeals(O,elt,J) : elt in queue ];
        pot_new:={@ K : K in pot_new | lideal<O1 | ZBasis(K)> eq IO1 @}; //we keep only the ones with trivial extension
        output join:={@ K : K in pot_new | not K in done and LeftOrder(K) eq O @};
        done join:=queue;
        // Note: if O1!!K is not IO1, then all the submodules of K will also not have trivial extension IO1.
        // Hence we don't need to continue the recursion on K.
        queue := pot_new diff done; 
    end while;
    return output;
end intrinsic;

////////////////////////
// AlgQuatOrd Right
////////////////////////

intrinsic MinimalIntermediateRightIdeals(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
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

intrinsic IntermediateIdealsWithPrescribedRightOrder(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
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
        queue := pot_new diff done;
    end while;
    assert2 #output eq #[ rideal<O | ZBasis(I)> : I in output];
    return output;
end intrinsic;

intrinsic MaximalIntermediateRightIdeals(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->SetIndx[AlgEtIdl]
{ Given fractional right-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that I is not a maximal. }
    if J eq I then 
        return {@ @};
    else
        // If I c K c I is maximal then pI+K = K for any rational prime divinding #I/K.
        // Hence pI c K c I.
        // Note that I/pI is an Fp-vector space.
        Q,q:=Quotient(I,J);
        zbJ:=ZBasis(J);
        max_ideals:={@ @};
        for p in PrimeDivisors(#Q) do
            mp:=[ p*(Q.j) : j in [1..Ngens(Q)] ];
            mp_in_I:=[ x@@q : x in mp  ] cat zbJ;
            Qp,qp:=quo<Q|mp>;
            rk:=Ngens(Qp);
            assert #Qp eq p^rk;
            Fp:=FiniteField(p);
            // Note: Qp = Fp^rk as a vector space
            // So its right-O-module structure can be realized over Fp.
            // More precisely, given generators ai of O over Z, 
            // to find the (maximal) right-sub-O-modules, it is enough to look at Qp as module over Fp[ai]
            // In matrices we store the matrix representations of the RIGHT action of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(qp(q((Qp.j@@qp@@q)*zO))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            max_Rmod:=MaximalSubmodules(Qp_Rmod);
            max_ideals join:={@ rideal<O| mp_in_I cat [(Qp!Eltseq(Qp_Rmod!b))@@qp@@q : b in Basis(max)]> 
                                        : max in max_Rmod @};
        end for;
        return max_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithTrivialExtensionAndPrescribedRightOrder(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl,O1::AlgQuatOrd)->SetIndx[AlgEtIdl]
{ Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J, right order O and such that K*O1=I*O1. They are produced recursively from the maximal right-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in RightOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in RightOrder(I) };
    J:=rideal< O | ZBasis(J)>;
    I:=rideal< O | ZBasis(I)>;
    IO1:=rideal<O1 | ZBasis(I)>;
    queue:={@ I @};
    if RightOrder(I) eq O then
        output:={@ I @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MaximalIntermediateRightIdeals(O,elt,J) : elt in queue ];
        pot_new:={@ K : K in pot_new | rideal<O1 | ZBasis(K)> eq IO1 @}; //we keep only the ones with trivial extension
        output join:={@ K : K in pot_new | not K in done and RightOrder(K) eq O @};
        done join:=queue;
        // Note: if O1!!K is not IO1, then all the submodules of K will also not have trivial extension IO1.
        // Hence we don't need to continue the recursion on K.
        queue := pot_new diff done; 
    end while;
    return output;
end intrinsic;


////////////////////////
// AlgQuatOrd Left
////////////////////////

intrinsic MinimalIntermediateLeftIdeals(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
{ Given fractional left-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that J is not a minimal. }
    if I eq J then 
        return {@ @};
    else
        zbJ:=ZBasis(J);
        Q,q:=Quotient(I,J);
        min_ideals:={@ @};
        // Following code is based on the following Lemma.
        // LEMMA: Let M be a finite left-O-module (eg I/J). Let N be a minimal left-sub-O-module of M. 
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
            // In matrices we store the matrix representations of the action on the LEFT of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(Qp!(q(zO*(Qp.j@@q)))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            min_Rmod:=MinimalSubmodules(Qp_Rmod);
            min_ideals join:={@ lideal<O | zbJ cat 
                                    [(Q!(Qp!Eltseq(Qp_Rmod!b)))@@q : b in Basis(min)]> : min in min_Rmod @};
        end for;
        return min_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithPrescribedLeftOrder(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
{ Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J and left order O. They are produced recursively from the minimal left-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(I) };
    J:=lideal< O | ZBasis(J)>;
    I:=lideal< O | ZBasis(I)>;
    assert J subset I;
    queue:={@ J @};
    if LeftOrder(J) eq O then
        output:={@ J @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MinimalIntermediateLeftIdeals(O,I,elt) : elt in queue ];
        output join:={@ K : K in pot_new | not K in done and LeftOrder(K) eq O @};
        done join:=queue;
        queue := pot_new diff done;
    end while;
    assert2 #output eq #[ lideal<O | ZBasis(I)> : I in output];
    return output;
end intrinsic;

intrinsic MaximalIntermediateLeftIdeals(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->SetIndx[AlgEtIdl]
{ Given fractional left-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that I is not a maximal. }
    if J eq I then 
        return {@ @};
    else
        // If I c K c I is maximal then pI+K = K for any rational prime divinding #I/K.
        // Hence pI c K c I.
        // Note that I/pI is an Fp-vector space.
        Q,q:=Quotient(I,J);
        zbJ:=ZBasis(J);
        max_ideals:={@ @};
        for p in PrimeDivisors(#Q) do
            mp:=[ p*(Q.j) : j in [1..Ngens(Q)] ];
            mp_in_I:=[ x@@q : x in mp  ] cat zbJ;
            Qp,qp:=quo<Q|mp>;
            rk:=Ngens(Qp);
            assert #Qp eq p^rk;
            Fp:=FiniteField(p);
            // Note: Qp = Fp^rk as a vector space
            // So its right-O-module structure can be realized over Fp.
            // More precisely, given generators ai of O over Z, 
            // to find the (maximal) right-sub-O-modules, it is enough to look at Qp as module over Fp[ai]
            // In matrices we store the matrix representations of the LEFT action of the ZBasis of O on Qp
            matrices:=[Matrix(Fp,[ Eltseq(qp(q(zO*(Qp.j@@qp@@q)))) : j in [1..Ngens(Qp)]]) : zO in ZBasis(O) ];
            matrices:=Setseq(Seqset(matrices)); //possibly there are repetiions.
            Qp_Rmod:=RModule(matrices);
            max_Rmod:=MaximalSubmodules(Qp_Rmod);
            max_ideals join:={@ lideal<O| mp_in_I cat [(Qp!Eltseq(Qp_Rmod!b))@@qp@@q : b in Basis(max)]> 
                                        : max in max_Rmod @};
        end for;
        return max_ideals;
    end if;
end intrinsic;

intrinsic IntermediateIdealsWithTrivialExtensionAndPrescribedLeftOrder(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl,O1::AlgQuatOrd)->SetIndx[AlgEtIdl]
{ Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J, left order O and such that K*O1=I*O1. They are produced recursively from the maximal left-O-ideals. }
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(J) };
    assert forall{ z : z in ZBasis(O) | z in LeftOrder(I) };
    J:=lideal< O | ZBasis(J)>;
    I:=lideal< O | ZBasis(I)>;
    IO1:=lideal<O1 | ZBasis(I)>;
    queue:={@ I @};
    if LeftOrder(I) eq O then
        output:={@ I @};
    else
        output:={@  @};
    end if;
    done:={@ @};
    while #queue gt 0 do
        pot_new:=&join[MaximalIntermediateLeftIdeals(O,elt,J) : elt in queue ];
        pot_new:={@ K : K in pot_new | lideal<O1 | ZBasis(K)> eq IO1 @}; //we keep only the ones with trivial extension
        output join:={@ K : K in pot_new | not K in done and LeftOrder(K) eq O @};
        done join:=queue;
        // Note: if O1!!K is not IO1, then all the submodules of K will also not have trivial extension IO1.
        // Hence we don't need to continue the recursion on K.
        queue := pot_new diff done; 
    end while;
    return output;
end intrinsic;
/* TEST
 
*/

