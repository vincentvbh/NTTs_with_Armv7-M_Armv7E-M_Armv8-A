
`ntrup857Bound.hs` calculates the bounds of NTT-related functions used in the size-1728 convolution for the "big by small" polynomial multiplication in `ntrulpr857/sntrup857`.

# Explanations
We calculate the bounds defined over the coefficient ring $\mathbb{Z}_{8851393}$.
- `getBigBound`: Bound of `NTT_forward` with input coefficients in $\\{ 2583, ..., 0, ..., 2583 \\}$.
- `getSmallBound`: Bound of `NTT_forward_small` with input coefficients in $\\{ -1, 0, 1 \\}$.
- `getBasemulBound`: Bound of `NTT_mul`.
- `getiNTTBound`: Bound of `NTT_inv`.
