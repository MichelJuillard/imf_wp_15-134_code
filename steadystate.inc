steady_state_model;
Y_US = 0;
@#if optimal == 0
  RESN_Y_US = 0;
@#endif  
RESN_YY_US = 0;
RESN_GAP_US = 0;
E_US = 0;
E2_US = 0;
RR_BAR_US = rr_bar_ss_US;
RS_US = RR_BAR_US + pietar_ss_US;
RESN_RS_US = 0;
RS4_US = RS_US;
LRS_US = RS_US;
RR_US = RR_BAR_US;
LRR_US = RR_BAR_US;
RR4_US = RR_BAR_US;
RR4_BAR_US = RR_BAR_US;
LRR_US = RR_BAR_US;
LRR_BAR_US = RR_BAR_US;
PIE_US = pietar_ss_US;
PIE4_US = PIE_US;
RESN_PIE_US = 0;
E_PIE4_US = PIE4_US;
BLT_GAP_US = 0;
dRS_US = 0;
end;