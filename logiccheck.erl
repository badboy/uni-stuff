% © Jan-Erik 2011
% Kleiner Tautologie-Checker in Erlang.
% Einige Beispielaufgaben sind dabei (six_*)
% Über jeder Aufgabe steht das richtige Ergebnis und die
% übliche Schreibweise.

-module(logiccheck).
-export([
        truth_table/1,
        gen_table/1,
        is_tautologie/1,
        six_one/0,
        six_two/0,
        six_three/0,
        six_five/0,
        six_four/0,
        do_all/0
    ]).


truth_table(1) -> [true, false];
truth_table(S) -> [[H,T] || H <- [true,false], T <- truth_table(S-1)].
gen_table(S) -> lists:map(fun(X) -> lists:flatten(X) end, truth_table(S)).

% A implies B. False if A but not B, otherwise true.
% =>
wenn_dann(true, false) -> false;
wenn_dann(_A, _B) -> true.

% True if A is equal to B <=> % not (True if A is not equal to B.)
% <=>
genau_dann(A, B) -> not (A xor B).

% generate table with N variables and apply function F.
make_calc(N, F) ->
    T = gen_table(N),
    lists:map(F, T).

% Check if all elements of the list are true.
is_tautologie(L) ->
    lists:foldl(fun(X, Total) -> Total and X end, true, L).


% the "real" tasks

% false
% (A => (B => C)) => (A => C)
six_one() ->
    is_tautologie(make_calc(3, fun([A, B, C]) ->
                wenn_dann(
                    wenn_dann(A, wenn_dann(B, C)),
                    wenn_dann(A, C)
                )
        end
    )).

% false
% ((¬A ^ B) v ¬(A ^ B)) => ¬A
six_two() ->
    is_tautologie(make_calc(2, fun([A, B]) ->
                    wenn_dann(
                        (
                            (not A and B) or not (A and B)
                        ), (not A)
                    )

            end
        )).

% false
% (A ^ ¬B) v (¬A ^ B)
six_three() ->
    is_tautologie(make_calc(2, fun([A, B]) ->
                    (A and not B) or (not A and B)
            end
        )).

% true
% (A ^ (B v C)) <=> ((A ^ B) v (A ^ C))
six_four() ->
    is_tautologie(make_calc(3, fun([A, B, C]) ->
                    genau_dann(
                        (A and (B or C)),
                        ((A and B) or (A and C))
                    )
        end
    )).

% false
% (A <=> B) v ((A => B) ^ (B => A))
six_five() ->
    is_tautologie(make_calc(2, fun([A, B]) ->
        genau_dann(A, B) or (
            wenn_dann(A,B) and (wenn_dann(B, A))
        )
            end)).

do_all() ->
    io:fwrite("1. false = ~s~n", [six_one()]),
    io:fwrite("2. false = ~s~n", [six_two()]),
    io:fwrite("3. false = ~s~n", [six_three()]),
    io:fwrite("4. true  = ~s~n", [six_four()]),
    io:fwrite("5. false = ~s~n", [six_five()]).
