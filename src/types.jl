type WienerProcess{T,T2,F,F2,inplace,S1,S2,RSWM}
  dist::F
  bridge::F2
  t::Vector{T}
  W::Vector{T2}
  Z::Vector{T2}
  curt::T
  curW::T2
  curZ::T2
  dt::T
  dW::T2
  dZ::T2
  dWtilde::T2
  dZtilde::T2
  dWtmp::T2
  dZtmp::T2
  S₁::S1
  S₂::S2
  rswm::RSWM
end
(W::WienerProcess)(t) = interpolate!(W,t)
adaptive_alg(W::WienerProcess) = StochasticDiffEq.adaptive_alg(W.rswm)

function WienerProcess(t0,W0,dist,bridge;iip=DiffEqBase.isinplace(dist,3),
                       rswm = StochasticDiffEq.RSWM())
  S₁ = DataStructures.Stack{}(Tuple{typeof(t0),typeof(W0),typeof(W0)})
  S₂ = ResettableStacks.ResettableStack{}(
                        Tuple{typeof(t0),typeof(W0),typeof(W0)})
  WienerProcess{typeof(t0),typeof(W0),
                typeof(dist),typeof(bridge),
                iip,typeof(S₁),typeof(S₂),typeof(rswm)}(
                dist,bridge,[t0],[W0],[W0],t0,
                W0,W0,t0,W0,W0,W0,W0,W0,W0,S₁,S₂,rswm)
end
