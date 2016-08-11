
alcOpts <- structure(
    levels(esoph$alcgp), 
    names=c("0-3 drinks/day", 
            "3-6 drinks/day", 
            "6-9 drinks/day", 
            "9+ drinks/day"))

tobOpts <- structure(
    levels(esoph$tobgp),
    names=c("0-9 cigarettes/day",
            "10-19 cigarettes/day",
            "20-29 cigarettes/day",
            "30+ cigarettes/day"))

getName <- function(val, opts) {
    names(opts[opts==val])[1]
}
