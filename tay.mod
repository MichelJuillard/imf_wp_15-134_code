@#define dozif = 1
@#define pgap = 0
@#define optimal = 0
@#define ifbrule = 0
@#include "modeqs.inc"
@#include "steadystate.inc"
@#include "us_setparams.inc"
steady;

histval;
 PIE_US(-2) = 2.00;
 PIE_US(-1) = 1.40;
 PIE_US(0) = 1.60;
 PIE4_US(0) = (1.20 + 2.00 + 1.40 + 1.60)/4;
 RS_US(0) = rs_floor_US;
 RR_BAR_US(0) = 0;
 Y_US(0) = -2;
end;

shocks;
 var RES_Y_US;
 periods 1,2,3;
 values -0.3,-0.2,-0.1;
end;

options_.periods = 12;
options_.periods = 1;
options_.ep.periods = 100;
options_.ep.replic_nbr = 1;
options_.ep.parallel_1 = false;
options_.ep.stack_solve_algo = 7;
options_.ep.innovation_distribution = 'calibrated';
options_.ep.init = 1;
options_.ep.solve_algo = 10;
options_.lmmcp.presteps = 2;

M_.unanticipated_det_shocks = M_.det_shocks;
M_.det_shocks = [];
[t,r] = extended_path([],25);
oo_.endo_simul = r{1};

