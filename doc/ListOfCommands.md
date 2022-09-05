# List of instrinsics in ./Norm.m:
--

<pre>
<b>contained AlgQuat/ideals.m which works only for invertible ideals!!!
intrinsic Norm</b>(I::AlgQuatOrdIdl) -> RngElt
</pre>

*Returns the reduced norm of the ideal I.
    Based on Voight - Quaternion Algebras 1.0.5 Lemma 16.3.2*


# List of instrinsics in ./IsCompatible.m:
--

<pre>
<b>IsCompatible</b>(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl) -> Bool
</pre>

*Given two lattices I and J, returns whether or not they are compatible, i.e. if O_R(I) = O_L(J).*


# List of instrinsics in ./ColonIdl.m:
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


# List of instrinsics in ./WkEqClasses.m:
--

<pre>
<b>IsWeaklyEquivalent</b>(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl : Side:="Both") -> Bool, Bool
</pre>

*Returns two booleans by default: firstly whether or not the lattices I and J are weakly left equivalent, secondly whether or not I and J are weakly right equivalent. When "Side" is set to "Left" or "Right", only one of these is returned.*

<pre>
<b>WeakEquivalenceClasses</b>(O::AlgQuatOrd : Side:="Left") -> List
</pre>

*Given an order in an algebra, compute representatives for the weak left/right equivalence classes of lattices with left/right multiplicator ring equal to O.*


# List of instrinsics in ./EqClasses.m:
--

<pre>
<b>EquivalenceClasses</b>(O::AlgQuatOrd : Side:="Left") -> List
</pre>

*Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.*


# List of instrinsics in ./BrandtMat.m:
--

<pre>
<b>BrandtMatrix</b>(n::RngIntElt, O::AlgQuatOrd : Side := "Right") -> AlgMatElt
</pre>

*Given an integer n and and order O, let I_1, ..., I_s be (full) list of left/right equivalence classes of ideals with equal left/right multiplicator ring O.
    It returnsthe nth Brandt matrix B(n), that is, the matrix in which the (i,j)th entry is the number of sublattices of I_j, left/right equivalent to I_i, with reduced norm equal to n * nrd(I_j).*


