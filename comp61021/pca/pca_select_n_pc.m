function n_pc = pca_select_n_pc(var_vector)

% Find the appropriate number of PC using proportion of variance.
% A variance vector is given.

threshold = 0.95;
total_var = sum(var_vector);
numerator = 0;
pov = 0;
n_pc = 0;

while pov < threshold
    n_pc = n_pc + 1;
    numerator = numerator + var_vector(n_pc);
    pov = numerator / total_var;
end % while
