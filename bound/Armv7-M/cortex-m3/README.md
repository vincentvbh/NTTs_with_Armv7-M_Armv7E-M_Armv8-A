
`saberBound.hs` calculates the bounds of NTT-related functions in the `MatrixVectorMul` of `firesaber`.
This is the worst case among the Saber's parameters.

# Explanations
We calculate the bounds defined over the coefficient ring $\mathbb{Z}_{7681}$ (`Q1`). This is the worst case of the two 16-bit NTTs.
- `getBigBound`: Bound of `NTT_forward1` with input coefficients in $\\{ -4096, ..., 0, ..., 4095 \\}$.
- `getSmallBound`: Bound of `NTT_forward1` with input coefficients in $\\{ -5, ..., 0, ..., 5 \\}$ ($\frac{\mu}{2} = 5$ in `firesaber`).
- `getBasemulBound`: Bound of `NTT_mul1`.
- `getiNTTBound`: Bound of `NTT_inv1`.

