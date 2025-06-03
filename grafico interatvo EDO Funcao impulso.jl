using Plots

# parametros do sistema massa-mola
# 
m = 1      # massa (kg)
k = 2       # constante da mola (N/m)
c = 3        # coeficiente de amortecimento (N·s/m)
Δt = 0.01   # passo de tempo (s)
t_final = 10 # tempo total de simulacao (s)
# condicoes iniciais
x0 = 0.0      # posicao inicial (m)
v0 = 0.0      # velocidade inicial (m/s)

# impulso aplicado
impulso_magnitude = 1.0 / Δt  # amplitude ajustada para o impulso
N = Int(t_final / Δt) + 1      # numero de passos de tempo
t = 0.0:Δt:t_final             # vetor de tempo
F = zeros(N)                   # forca aplicada no sistema
F[200] = impulso_magnitude       # impulso aplicado em t = 0

# inicializacao de variaveis
x = zeros(N)  # posicao da massa
v = zeros(N)  # velocidade da massa
a = zeros(N)  # aceleracao da massa

# condicoes iniciais
x[1] = x0
v[1] = v0

# simulacao numerica (metodo de Euler)
for n in 1:(N-1)
    a[n] = (F[n] - k * x[n] - c * v[n]) / m  # aceleracao: F = ma = F(t) - kx - cv
    v[n+1] = v[n] + a[n] * Δt                # atualizacao da velocidade
    x[n+1] = x[n] + v[n] * Δt                # atualizacao da posicao
end
a[N] = (F[N] - k * x[N] - c * v[N]) / m      # aceleracao no ultimo passo

# plotando os resultados
eixoy = 50 

plot(t, x, label="deslocamento (x)", xlabel="tempo (s)", ylabel="magnitude", linewidth=2, color=:blue)
#plot!(t, v, label="velocidade (v)", linewidth=2, color=:red, xlims=(0, t_final), ylims=(-eixoy, eixoy))
#plot!(t, a, label="aceleracao (a)", linewidth=2, color=:green, xlims=(0, t_final), ylims=(-eixoy, eixoy))

title!("impulso δ(t) num sistema massa-mola")


#= aumentar k faz o sistema oscilar mais rápido e com menos deslocamento. 
é como trocar uma mola macia por uma mola dura, o movimento fica mais "tenso" e menos "esticado"=#
