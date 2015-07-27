var Y_US PIE_US RESN_YY_US PIE4_US E_PIE4_US RS_US RR_US
    RR_BAR_US RR4_US RR4_BAR_US LRR_US LRR_BAR_US RS4_US LRS_US
    E_US E2_US BLT_GAP_US dRS_US ;

varexo RES_RR_BAR_US RES_Y_US RES_PIE_US RES_BLT_GAP_US
@#if optimal == 0
 RES_RS_US
@#endif 
;

parameters beta1_US beta2_US beta3m_US beta3_US zetay_US zetayy_US
kappa1_US theta_US gamma1_US gamma2_US gamma4_US zetars_US rs_floor_US
rs_delta rho_US rr_bar_ss_US lrrw01_US lrrw04_US lrrw12_US lrrw20_US
lambda1x_US lambda2x_US zetax_US pietar_ss_US
@#if optimal == 1
w_pie
w_y
w_drs
w_pgap
disc
@#endif
;

model;
// IS curve
Y_US = + beta1_US*Y_US(-1)
       + beta2_US*Y_US(+1)
       - beta3m_US*(LRR_US(-1)-LRR_BAR_US(-1))
       - beta3_US*(RR_US(-1)-RR_BAR_US(-1))
       - E2_US
       + RESN_YY_US ;	 

RESN_YY_US = zetayy_US*RESN_YY_US(-1) + RES_Y_US;

// bank lending tightening equations
BLT_GAP_US = - kappa1_US *Y_US(+4) - RES_BLT_GAP_US  ;
E2_US      = + theta_US *(0.04*(E_US(-1) +E_US(-9) )
       	     + 0.08*(E_US(-2) +E_US(-8) )
             + 0.12*(E_US(-3) +E_US(-7) )
             + 0.16*(E_US(-4) +E_US(-6) )
             + 0.2*E_US(-5) );
E_US       = - RES_BLT_GAP_US  ;

// interest rate equations

// Taylor-type equation for short-term nominal interest rate
@#if optimal == 0
[mcp = 'RS_US > 0']
@#if   ifbrule == 1
          RS_US = + gamma1_US*RS_US(-1)
             + (1-gamma1_US)*(RR_BAR_US + PIE4_US(+3) + gamma2_US*(PIE4_US(+3) - pietar_ss_US) + gamma4_US*Y_US)
             + RES_RS_US;
@#else
          RS_US = RR_BAR_US + PIE4_US + 0.5*(PIE4_US - pietar_ss_US) + 0.5*Y_US + RES_RS_US;
@#endif
@#endif

RR_US      = RS_US - E_PIE4_US;
RR_BAR_US  = (1-rho_US)*RR_BAR_US(-1)
             + rho_US*(rr_bar_ss_US)
             + RES_RR_BAR_US  ;
RR4_US     = (RR_US + RR_US(+1) + RR_US(+2) + RR_US(+3))/4;
RR4_BAR_US = (RR_BAR_US + RR_BAR_US(+1) + RR_BAR_US(+2) + RR_BAR_US(+3))/4;
LRR_US     = + lrrw01_US *RR_US
             + lrrw04_US *RR4_US
             + lrrw12_US *(RR4_US +RR4_US(+4) +RR4_US(+8) )/3
             + lrrw20_US *(RR4_US +RR4_US(+4) +RR4_US(+8) +RR4_US(+12) +RR4_US(+16) )/5;
LRR_BAR_US = + lrrw01_US *RR_BAR_US
             + lrrw04_US *RR4_BAR_US
             + lrrw12_US *(RR4_BAR_US +RR4_BAR_US(+4) +RR4_BAR_US(+8) )/3
             + lrrw20_US *(RR4_BAR_US +RR4_BAR_US(+4) +RR4_BAR_US(+8) +RR4_BAR_US(+12) +RR4_BAR_US(+16) )/5;

// inflation equations
// PIE4_US 
PIE4_US	  = (PIE_US + PIE_US(-1) + PIE_US(-2) + PIE_US(-3))/4;
// PIE_US
PIE_US    =  + lambda1x_US*E_PIE4_US
             + (1-lambda1x_US)*PIE4_US(-1)
             + lambda2x_US * Y_US(-1)
             - RES_PIE_US;
E_PIE4_US = PIE4_US(+4);

RS4_US     = (RS_US + RS_US(+1) + RS_US(+2) + RS_US(+3))/4;
LRS_US     = + lrrw01_US *RS_US
             + lrrw04_US *RS4_US
             + lrrw12_US *(RS4_US +RS4_US(+4) +RS4_US(+8) )/3
             + lrrw20_US *(RS4_US +RS4_US(+4) +RS4_US(+8) +RS4_US(+12) +RS4_US(+16) )/5;

dRS_US = RS_US - RS_US(-1);
end;

@#if optimal == 1
  planner_objective w_pie*(PIE4_US - pietar_ss_US)^2 + w_y*Y_US^2 + w_drs*dRS_US^2;
  ramsey_model(planner_discount = 1.0);
@#endif


