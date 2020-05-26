# ChesapeakeMicrobiome


0. Formally write up how to extract OEU, Taxa, and Function Tables in a script
.5. Make "Taxa Plots" for functions and taxa
1. Copy over OEU script
2. Read in different OEUs formations
3. Pick your favorite? Make consensus? 
4. Repeat decorrelation but retain
5. Create an alterantive OTU table that has taxonomy, function, OEU
5. Ready in environmental data
6. Create all possible times and places
7. Create 1000 permutaitons 
8. Fit and tune ridge for all possible combinations ( try one first )
    - save average coefficients (positive to 1, negative to foil) 
    - save tuning parameters
    - NOTE: manually test all 1s and if is impossible, add a little noise
9. repeat on permutations to determine if fit is significantly better
    - save 1000 coefficients from a few permutations
10. Characterize # positive coefficients per regression and their sum 
11. Summarize the most valid times and places and their scores via a histogram
12. Create a few examples of large (wide) and small (tall) sets and plot their coefficient histograms
13. change lm to rlm when writing up alpha diversity 


