using Colors
using Plots
using DataFrames
using DelimitedFiles
using LinearAlgebra
#using LinearAlgebra.LAPACK
using IterativeSolvers
using Distributions
using Statistics
using SparseArrays


samples = readdlm("/Users/brunawundervald/Desktop/GIT/jubs/code/ml/samples.txt")
X = [[samples[setdiff(1:end, 1), 2]];
         [samples[setdiff(1:end, 1), 3]]]

pi = [0.34518140, 0.6066179 ,  0.04820071]         # The priors for the mixture proportions
mu = [[-0.7133619    0.90635089];
      [0.7662367   0.8260541];
      [ -1.3236828 -1.7524445]]         # The start values for \mu_c
sigma = cat(
       [1.004904 1.899802; 1.899802 4.183546],
       [1.9686781 0.7841534; 0.7841534 1.8331994],
       [0.1931634 -0.1164864; -0.1164864 1.9839597],
        dims = 3)   # Covariance matrix between the clusters

# plot it
plot(X[1], X[2],
    seriestype=:scatter, label = "", title = "EM data")

#---------------------------------------------------------------------
function E_step(X, pi, mu, sigma)
N = size(X[1])[1]
C = size(pi)[1]
d = size(mu)[2]
gamma = zeros(Float64, N, C)
x = zeros(Float64, N, d)

for c in 1:C
    # Normalization constant of a biv. Normal distribution
    cst = ((2 * 3.141592)^d * det(sigma[:, :, c]))^0.5
    # Subtracts mu's of the observations
    for i in 1:d
        x[:, i] = [X[i] .- mu[c, i]][1]
    end

    # Calculating the core of the biv. Normal distribution
    # with the inverse of Sigma * X being found with
    # since (SS^-1 = I):
    # invS = inv(sigma[:, :, c])

    xt = LinearAlgebra.transpose(x)[:, :]
    xinvSxt = x * inv(sigma[:, :, c]) .* x
    xinvSx = (sum(sum(xinvSxt, dims = 2), dims = N)) .* -1/2
    dens = exp.(xinvSx)/cst
    gamma[:, c] = pi[c] * dens
end
gamma_div = sum(gamma, dims = 2)
final_gamma = gamma ./ gamma_div
return final_gamma
end

gamma = E_step(X, pi, mu, sigma)

#---------------------------------------------------------------------
function M_step(X, gamma)

    N = size(X[1])[1] # number of objects
    C = size(gamma)[2] # number of clusters
    d = size(X)[1] # dimension of each object
    mu = zeros(Float64, C, d)
    sigma = zeros(Float64, d, d, C)
    gamma_sum = sum(gamma, dims=1)
    pi = gamma_sum/N
    x = zeros(Float64, N, d)

    for c in 1:C
        mu[c] = sum(gamma[:, c] .* X[1, :][1])/gamma_sum[c]
        for i in 1:d
            x[:, i] = [X[i] .- mu[c, i]][1]
        end
        sigma[:, :, c] = (transpose(x) * Diagonal(gamma[:, c]) * x)/gamma_sum[c]
    end
return pi, mu, sigma
end


m_res = M_step(X, gamma)

#---------------------------------------------------------------------
function compute_vlb(X, pi, mu, sigma, gamma, C = 3)
    N = size(X[1])[1]
    #C = size(pi)[1]

    d = size(mu)[2]
    loss = zeros(Float64, 1)
    for c in 1:C
        for n in 1:N
            mv_norm = MvNormal(mu_var[c, :], Symmetric(sigma_var[:, :, c]))
            logd = logpdf(mv_norm, [X[1][n], X[2][n]])
            gamma_c = gamma[n, c]
            loss_here   = gamma_c * ((log(pi_var[c]) + logd) - log(gamma_c))
            loss[1] = loss[1] + loss_here[1]
        end
    end
return loss
end


gamma = E_step(X, pi, mu, sigma)
M_res = M_step(X, gamma)
vlb = compute_vlb(X, pi, mu, sigma, gamma)

#--------------------------------------------------------------------------

function train_EM(X, C, rtol = 1e-3, max_iter = 25, restarts = 10)
    '''
    Starts with random initialization *restarts* times
    Runs optimization until saturation with *rtol* reached
    or *max_iter* iterations were made.

    X: (N, d), data points
    C: int, number of clusters
    '''
    N = size(X[1])[1] # number of objects
    d = size(mu)[2] # dimension of each object

    best_loss = -Inf
    best_pi = nothing
    best_mu = nothing
    best_sigma = nothing

    for _ in 1:restarts
            pi = rand(C)
            pi = pi/sum(pi)
            mu = reshape(randn(C * d), (C, d))
            sigma = zeros(Float64, (d, d, C))
            for c in 1:C
                sigma[:, :, c] = Diagonal(ones(d))
            end
            lloss = -Inf

            not_saturated = true
            iteration = 0
            for i in 1:10
                former_loss = copy(lloss)
                gamma = E_step(X, pi, mu, sigma)
                pi, mu, sigma = M_step(X, gamma)
                lloss = compute_vlb(X, pi, mu, sigma, gamma)
                print(size(mu))
                if(former_loss[1] > lloss[1])
                    print("bug")
                end
                not_saturated = abs((lloss[1]/former_loss[1]) - 1) > rtol
                iteration = iteration + 1
            end
            #if(lloss > best_loss)
            #    best_loss = copy(lloss)
        #        best_pi = pi
    #            best_mu = mu
    #            best_sigma = sigma
    #        end
    end
    #return est_loss, best_pi, best_mu, best_sigma
    return lloss
end
