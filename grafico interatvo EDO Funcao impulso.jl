using Plots
using Interact

# Aproximação da delta de Dirac com função gaussiana normalizada.
delta(ε, x, a=0) = 1/(sqrt(pi)*ε) * exp.(-((x .- a)/ε).^2)

# Função teste f(x)
f(x) = sin(x) + 2

# Função para plotar os gráficos
function plot_delta(ε)
    x = -2:0.005:2
    fx = f.(x)
    δx = delta(ε, x, 0)
    prod = fx .* δx

    p1 = plot(x, fx, lw=2, label="f(x)=sin(x)+2", legend=:top, xlabel="x", ylabel="f(x)")
    plot!(p1, x, δx, lw=2, label="δₑ(x), ε=$(round(ε,digits=2))", xlabel="x", ylabel="δₑ(x)")

    p2 = plot(x, prod, lw=2, label="f(x)*δₑ(x)", legend=:top, xlabel="x", ylabel="f(x)*δₑ(x)")

    plot(p1, p2, layout = (2,1), size=(600,600), title="Propriedade seletora da delta de Dirac")
end

@manipulate for ε in 0.05:0.05:0.5
    plot_delta(ε)
end
