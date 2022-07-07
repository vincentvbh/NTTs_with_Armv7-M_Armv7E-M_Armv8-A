
`ntruhrss701_1536Bound.hs` calculates the bounds of NTT-related functions used in the size-1536 convolution for the "big by small" polynomial multiplication in `ntruhrss701`.

# Explanations
We calculate the bounds defined over the coefficient ring $\mathbb{Z}_{11488513}$.
- `getBigBound`: Bound of `NTT_forward` with input coefficients in $\\{ 0, ..., 8191 \\}$.
- `getSmallBound`: Bound of `NTT_forward_small` with input coefficients in $\\{ -1, 0, 1 \\}$.
- `getBasemulBound`: Bound of `NTT_mul`.
- `getiNTTBound`: Bound of `NTT_inv`.
