
`ntrup1013Bound.hs` calculates the bounds of NTT-related functions used in the size-2048 convolution for the "big by small" polynomial multiplication in `ntrulpr1013/sntrup1013`.

# Explanations
We calculate the bounds defined over the coefficient ring $\mathbb{Z}_{14533633}$.
- `getBigBound`: Bound of `NTT_forward` with input coefficients in $\\{ -3588, ..., 0, ..., 3588 \\}$.
- `getSmallBound`: Bound of `NTT_forward_small` with input coefficients in $\\{ -1, 0, 1 \\}$.
- `getBasemulBound`: Bound of `NTT_mul`.
- `getiNTTBound`: Bound of `NTT_inv`.
