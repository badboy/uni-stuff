% Stirling-Zahlen erster Art
% s(n, k) := Anzahl der Permutationen aus S_n mit Zykelzahl k.
%
% Stirling-Zahlen zweiter Art
% S(n, k) := Anzahl der Partitionen von _n_ mit genau k Teilen.
%
-module(stirling).
-export([s1/2, s2/2]).

s1(N, K) when K > N -> 0;
s1(_N, 0) -> 0;
s1(0, _K) -> 1;
s1(1, 1) -> 1;
s1(N, K) ->
    s1(N-1, K-1) +
    (N-1) * s1(N-1, K).

s2(N, K) when K > N -> 0;
s2(_N, 0) -> 0;
s2(0, _K) -> 1;
s2(1, 1) -> 1;
s2(N, K) ->
    s2(N-1, K-1) +
    K * s2(N-1, K).
