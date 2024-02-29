
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name digital_clock -dir "C:/Users/Ali/Downloads/digital_clock/digital_clock/planAhead_run_2" -part xc3s400pq208-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Ali/Downloads/digital_clock/digital_clock/DCLOCK.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Ali/Downloads/digital_clock/digital_clock} }
set_property target_constrs_file "constraints.ucf" [current_fileset -constrset]
add_files [list {constraints.ucf}] -fileset [get_property constrset [current_run]]
link_design
