# List of instrinsics in Index.m:
--

<pre>
<b>Index</b>(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> RngElt
</pre>

*Returns the index [I:J].*

<pre>
<b>Index</b>(I::AlgQuatOrd,J::AlgQuatOrd) -> RngElt
</pre>

*Returns the index [I:J].*

<pre>
<b>Index</b>(I::AlgAssVOrdIdl,J::AlgAssVOrdIdl) -> RngElt
</pre>

*Returns the index [I:J].*

<pre>
<b>Index</b>(I::AlgAssVOrd,J::AlgAssVOrd) -> RngElt
</pre>

*Returns the index [I:J].*


# List of instrinsics in IsCompatible.m:
--

<pre>
<b>IsCompatible</b>(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl) -> Bool
</pre>

*Given two lattices I and J, returns whether or not they are compatible, i.e. if O_R(I) = O_L(J).*

<pre>
<b>IsCompatible</b>(I::AlgAssVOrdIdl, J::AlgAssVOrdIdl) -> Bool
</pre>

*Given two lattices I and J, returns whether or not they are compatible, i.e. if O_R(I) = O_L(J).*


# List of instrinsics in Norm.m:
--

<pre>
<b>Norm</b>(I::AlgQuatOrdIdl) -> RngElt
</pre>

*Returns the reduced norm of the ideal I.
    This intrinsic overwrites the one already implemented in MAGMA (see AlgQuat/ideals.m) which works only for invertible ideals.
    This code is based on Voight - Quaternion Algebras 1.0.5 Lemma 16.3.2*

<pre>
<b>Norm</b>(I::AlgAssVOrdIdl) -> RngElt
</pre>

*Returns the reduced norm of the ideal I.
    This intrinsic overwrites the one already implemented in MAGMA (see AlgAssV/ideals-jv.m) which works only for invertible ideals.
    This code is based on Voight - Quaternion Algebras 1.0.5 Lemma 16.3.2*


# List of instrinsics in IntermediateIdeals.m:
--

<pre>
<b>MinimalIntermediateRightIdeals</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
</pre>

*Given fractional right-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that J is not a minimal.*

<pre>
<b>IntermediateIdealsWithPrescribedRightOrder</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
</pre>

*Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J and right order O. They are produced recursively from the minimal right-O-ideals.*

<pre>
<b>MaximalIntermediateRightIdeals</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->SetIndx[AlgEtIdl]
</pre>

*Given fractional right-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that I is not a maximal.*

<pre>
<b>IntermediateIdealsWithTrivialExtensionAndPrescribedRightOrder</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl,O1::AlgAssVOrd)->SetIndx[AlgEtIdl]
</pre>

*Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J, right order O and such that K*O1=I*O1. They are produced recursively from the maximal right-O-ideals.*

<pre>
<b>MinimalIntermediateLeftIdeals</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
</pre>

*Given fractional left-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that J is not a minimal.*

<pre>
<b>IntermediateIdealsWithPrescribedLeftOrder</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->List
</pre>

*Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J and left order O. They are produced recursively from the minimal left-O-ideals.*

<pre>
<b>MaximalIntermediateLeftIdeals</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl)->SetIndx[AlgEtIdl]
</pre>

*Given fractional left-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that I is not a maximal.*

<pre>
<b>IntermediateIdealsWithTrivialExtensionAndPrescribedLeftOrder</b>(O::AlgAssVOrd,I::AlgAssVOrdIdl,J::AlgAssVOrdIdl,O1::AlgAssVOrd)->SetIndx[AlgEtIdl]
</pre>

*Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J, left order O and such that K*O1=I*O1. They are produced recursively from the maximal left-O-ideals.*

<pre>
<b>MinimalIntermediateRightIdeals</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
</pre>

*Given fractional right-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that J is not a minimal.*

<pre>
<b>IntermediateIdealsWithPrescribedRightOrder</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
</pre>

*Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J and right order O. They are produced recursively from the minimal right-O-ideals.*

<pre>
<b>MaximalIntermediateRightIdeals</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->SetIndx[AlgEtIdl]
</pre>

*Given fractional right-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional right-O-ideals K such that J subset K subset I. Note that I is not a maximal.*

<pre>
<b>IntermediateIdealsWithTrivialExtensionAndPrescribedRightOrder</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl,O1::AlgQuatOrd)->SetIndx[AlgEtIdl]
</pre>

*Given an order O in a quaternion algebra, and two fractional right-O-ideals J subset I, it returns a list containing all right-O-ideals K with I subset K subset J, right order O and such that K*O1=I*O1. They are produced recursively from the maximal right-O-ideals.*

<pre>
<b>MinimalIntermediateLeftIdeals</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
</pre>

*Given fractional left-O-ideals J subset I, returns the minimal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that J is not a minimal.*

<pre>
<b>IntermediateIdealsWithPrescribedLeftOrder</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->List
</pre>

*Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J and left order O. They are produced recursively from the minimal left-O-ideals.*

<pre>
<b>MaximalIntermediateLeftIdeals</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl)->SetIndx[AlgEtIdl]
</pre>

*Given fractional left-O-ideals J subset I, returns the maximal (with respect to inclusion) fractional left-O-ideals K such that J subset K subset I. Note that I is not a maximal.*

<pre>
<b>IntermediateIdealsWithTrivialExtensionAndPrescribedLeftOrder</b>(O::AlgQuatOrd,I::AlgQuatOrdIdl,J::AlgQuatOrdIdl,O1::AlgQuatOrd)->SetIndx[AlgEtIdl]
</pre>

*Given an order O in a quaternion algebra, and two fractional left-O-ideals J subset I, it returns a list containing all left-O-ideals K with I subset K subset J, left order O and such that K*O1=I*O1. They are produced recursively from the maximal left-O-ideals.*


# List of instrinsics in Quotients.m:
--

<pre>
<b>Quotient</b>(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl) -> GrpAb, Map
</pre>

*given fractional ideals J subset I, returns the abelian group Q=I/J together with the quotient map q:I->J*

<pre>
<b>Quotient</b>(I::AlgAssVOrdIdl, J::AlgAssVOrdIdl) -> GrpAb, Map
</pre>

*given fractional ideals J subset I, returns the abelian group Q=I/J together with the quotient map q:I->J*


# List of instrinsics in ColonIdl.m:
--

<pre>
<b>RightColonIdeal</b>(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
</pre>

*Given two lattices I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgQuatOrdIdl,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
</pre>

*Given two lattices I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgQuatOrd,J::AlgQuatOrd) -> AlgQuatOrdIdl
</pre>

*Given two orders I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgQuatOrd,J::AlgQuatOrd) -> AlgQuatOrdIdl
</pre>

*Given two orders I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgQuatOrdIdl,J::AlgQuatOrd) -> AlgQuatOrdIdl
</pre>

*Given a lattice I and an order J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgQuatOrdIdl,J::AlgQuatOrd) -> AlgQuatOrdIdl
</pre>

*Given a lattice I and an order J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgQuatOrd,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
</pre>

*Given an order I and a lattice J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgQuatOrd,J::AlgQuatOrdIdl) -> AlgQuatOrdIdl
</pre>

*Given an order I and a lattice J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgAssVOrdIdl,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
</pre>

*Given two lattices I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgAssVOrdIdl,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
</pre>

*Given two lattices I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgAssVOrd,J::AlgAssVOrd) -> AlgAssVOrdIdl
</pre>

*Given two orders I and J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgAssVOrd,J::AlgAssVOrd) -> AlgAssVOrdIdl
</pre>

*Given two orders I and J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgAssVOrdIdl,J::AlgAssVOrd) -> AlgAssVOrdIdl
</pre>

*Given a lattice I and an order J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgAssVOrdIdl,J::AlgAssVOrd) -> AlgAssVOrdIdl
</pre>

*Given a lattice I and an order J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*

<pre>
<b>RightColonIdeal</b>(I::AlgAssVOrd,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
</pre>

*Given an order I and a lattice J, return (I:J)_R, that is, the lattice of elements x in the algebra such that Jx subseteq I.*

<pre>
<b>LeftColonIdeal</b>(I::AlgAssVOrd,J::AlgAssVOrdIdl) -> AlgAssVOrdIdl
</pre>

*Given an order I and a lattice J, return (I:J)_L, that is, the lattice of elements x in the algebra such that xJ subseteq I.*


# List of instrinsics in IsInvertible.m:
--

<pre>
<b>IsRightInvertible</b>(I::AlgQuatOrdIdl) -> BoolElt
</pre>

*Given a lattice I returns whether it is right invertible, that is, I*(OL(I):I)_R eq OL(I) and the product is compatible.*

<pre>
<b>IsLeftInvertible</b>(I::AlgQuatOrdIdl) -> BoolElt
</pre>

*Given a lattice I returns whether it is left invertible, that is, (OR(I):I)_L*I eq OR(I) and the product is compatible.*

<pre>
<b>IsRightInvertible</b>(I::AlgAssVOrdIdl) -> BoolElt
</pre>

*Given a lattice I returns whether it is right invertible, that is, I*(OL(I):I)_R eq OL(I) and the product is compatible.*

<pre>
<b>IsLeftInvertible</b>(I::AlgAssVOrdIdl) -> BoolElt
</pre>

*Given a lattice I returns whether it is left invertible, that is, (OR(I):I)_L*I eq OR(I) and the product is compatible.*


# List of instrinsics in WkEqClasses.m:
--

<pre>
<b>IsWeaklyEquivalent</b>(I::AlgAssVOrdIdl, J::AlgAssVOrdIdl : Side:="Both") -> Bool, Bool
</pre>

*Returns two booleans by default: firstly whether or not the lattices I and J are weakly left equivalent, secondly whether or not I and J are weakly right equivalent. When "Side" is set to "Left" or "Right", only one of these is returned.*

<pre>
<b>WeakEquivalenceClassesWithPrescribedOrder</b>(O::AlgAssVOrd : Side:="Left") -> List
</pre>

*Given an order in an algebra, compute representatives for the weak left/right equivalence classes of lattices with left/right multiplicator ring equal to O.*

<pre>
<b>IsWeaklyEquivalent</b>(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl : Side:="Both") -> Bool, Bool
</pre>

*Returns two booleans by default: firstly whether or not the lattices I and J are weakly left equivalent, secondly whether or not I and J are weakly right equivalent. When "Side" is set to "Left" or "Right", only one of these is returned.*

<pre>
<b>WeakEquivalenceClassesWithPrescribedOrder</b>(O::AlgQuatOrd : Side:="Left") -> List
</pre>

*Given an order in an algebra, compute representatives for the weak left/right equivalence classes of lattices with left/right multiplicator ring equal to O.*


# List of instrinsics in IsIsomorphic.m:
--

<pre>
<b>IsRightIsomorphic</b>(I::AlgQuatOrdIdl[RngInt], J::AlgQuatOrdIdl[RngInt]) -> BoolElt,AlgQuatElt
</pre>

*Returns whether there exists x such that xI=J. The inbuilt IsRightIsomorphic gives false positives for non-invertible ideals :-(*


# List of instrinsics in ClassSet.m:
--

<pre>
<b>LeftClassSet</b>(O::Any) -> SeqEnum
</pre>

*Compute the left class set of a quaternion order O in a naive way. This code is originally by Voight (also
appears as commented out code in ideals-jv.m). Some small modifications have been made. We use this naive
version, because it works for any order.*

<pre>
<b>LeftClassSet</b>(O::AlgQuatOrd) -> SeqEnum
</pre>

*Compute the left class set of a quaternion order O in a naive way. This code is originally by Voight (also
appears as commented out code in ideals-jv.m). Some small modifications have been made. We use this naive
version, because it works for any order.*

<pre>
<b>RightClassSet</b>(O::AlgQuatOrd) -> SeqEnum
</pre>

*Compute the right class set of a quaternion order O in a naive way. This code is originally by Voight (also
appears as commented out code in ideals-jv.m). Some small modifications have been made. We use this naive
version, because it works for any order.*


# List of instrinsics in EqClasses.m:
--

<pre>
<b>EquivalenceClassesWithPrescribedOrder</b>(O::AlgQuatOrd : Side:="Left") -> List
</pre>

*Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.*

<pre>
<b>EquivalenceClassesWithPrescribedOrder</b>(O::AlgAssVOrd : Side:="Left") -> List
</pre>

*Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.*


# List of instrinsics in Enumerate.m:
--

<pre>
<b>Enumerate</b>(I::AlgAssVOrdIdl, A::RngElt, B::RngElt) -> SeqEnum
</pre>

*Enumerates the elements in I of reduced norm between A and B, up to a sign.*


# List of instrinsics in BrandtMat.m:
--

<pre>
<b>BrandtMatrix</b>(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
</pre>

*Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes of ideals with equal left/right multiplicator ring O.
    It returnsthe nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).*

<pre>
<b>BrandtMatrix</b>(n::RngIntElt, O::AlgAssVOrd : Side := "Right") -> AlgMatElt
</pre>

*Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes of ideals with equal left/right multiplicator ring O.
    It returnsthe nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).*


