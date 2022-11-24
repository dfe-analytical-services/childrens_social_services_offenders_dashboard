createAvgRevTimeSeries <- function(dfRevenueBalance,inputArea){

ggplot(dfRevenueBalance, aes(x=year,y=average_revenue_balance,color=area_name)) + 
  geom_line(size = 1.2) +       
  theme_classic() +
  theme(
    text = element_text(size = 12),
    axis.title.x = element_text(margin = margin(t = 12)),
    axis.title.y = element_text(margin = margin(r = 12)),
    axis.line = element_line( size = 1.0),
    legend.position = 'top'
  ) +
  scale_y_continuous(
    labels = scales::number_format(accuracy = 1, big = ',', prefix='£')) +
  xlab("Academic year end") +
  ylab("Average revenue balance") +
  scale_color_manual(
    "Area",
    breaks = unique(c("England",inputArea)),
    values = c("#f47738", "#1d70b8")
  )     
}

plotAvgRevBenchmark <- function(dfRevenueBalance,inputArea){
  
  ggplot(dfRevenueBalance, aes(x=area_name,
                               y=average_revenue_balance,
                               fill=area_name)) + 
    geom_col() +       
    theme_classic() +
    theme(
      text = element_text(size = 12),
      axis.text.x = element_text(angle = 300),
      axis.title.x = element_blank(),
      axis.title.y = element_text(margin = margin(r = 12)),
      axis.line = element_line( size = 1.0),
      legend.position = "none"
    ) +
    scale_y_continuous(
      labels = scales::number_format(accuracy = 1, big = ',', prefix='£')) +
    xlab("Area") +
    ylab("Average revenue balance") +
    scale_fill_manual(
      "Area",
      breaks = unique(dfRevenueBalance$area_name),
      values = gss_colour_pallette
    )     
}

createGenderPlot <- function(data, LAchoice){
  
  title1 <- paste0("Gender breakdown for ", LAchoice)
  
  ggplot(data, aes(fill = Gender, x = group, y = perc)) +
    geom_bar(stat = "identity") +
    labs(x=NULL, y="% male/female", title = title1) +
    geom_text(aes(label = paste0(perc, "%"), group = Gender), color = "white", position = position_stack(vjust = 0.5), size=6) +
    theme_classic() +
    theme(legend.position = "bottom", 
          legend.title = element_blank(), 
          axis.text = element_text(color = "black", size = 15),
          text = element_text(size = 15), 
          legend.text = element_text(size = 15),
          axis.title.y = element_text(angle = 0, size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), labels = c("Female", "Male")) +
    scale_x_discrete(labels = c("All Pupils","Any\nOffence", "Serious\nViolence\nOffence"))

}

createEthPlot <- function(data, LAchoice){
  
  title1 <- paste0("Ethnicity breakdown for ", LAchoice)
  
  ggplot(data, aes(x=perc, y=EthnicGroupMajor, fill = EthnicGroupMajor )) +
    geom_bar(stat = "identity") +
    labs(x = "% of ethnic group major", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), vjust = 0, hjust=-0.1, size=6) +
    theme_classic() +
    theme(legend.position = "none", axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#08519c", "#2171b5", "#4292c6", "#6baed6", "#9ecae1", "#c6dbef")) +
    facet_wrap(~group) + 
    theme(strip.background = element_blank()) +
    xlim(0,105) +
    scale_y_discrete(labels = c("Any other\nethnic group","Asian","Black", "Chinese", "Mixed", "Unclassified", "White")) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) + 
    annotate("segment",x=0,xend=100,y=Inf,yend=Inf,color="black",lwd=1)
}

createFSMPlot <- function(data, LAchoice){
  
  title1 <- paste0("Free school meals (FSM) for ", LAchoice)
  
  ggplot(data, aes(x=perc, y=group, fill = group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x="% eligible for FSM", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), hjust =-0.1, position = position_dodge(width = 1), size=6) +
    theme_classic() +
    theme(legend.position = "none", axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#08306b", "#08306b")) +
    xlim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20))
}

createWaffle_FSM <- function(data, LAchoice){
  title <- paste0("Free school meals (FSM) for ", LAchoice)
  
   # automated text for waffle - LHS
  FSM_LHS_text <- data.frame(x1 = paste0(data$sv_prop_count_FSM, "%\nEligible\nfor FSM"),
                             x2 = paste0(data$prop_sv_not_FSM, "%\nNot eligible\nfor FSM"))
  
  FSM_LHS_waffle <- waffle(data[3:4], rows=10, size=0.6, flip=TRUE, 
                           colors=c("#08306b", "#2171b5"), 
                           title="Children who were cautioned\nor sentenced for a\nserious violence offence",  
                           xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), 
                      labels = c(FSM_LHS_text$x1, 
                                 FSM_LHS_text$x2)) +
    theme(text=element_text(size=12), 
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12)) 
  
  # automated text for waffle - RHS
  FSM_RHS_text <- data.frame(x1 = paste0(data$also_sv_prop_count_FSM, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                             x2 = paste0(data$not_also_sv_prop_count_FSM, "%\nAll other\npupils"))
  
  FSM_RHS_waffle <- waffle(data[5:6], rows=10, size=0.6, flip=TRUE,
                           colors=c("#08306b", "#6BACE6"), 
                           title="All pupils\neligible for FSM",
                           xlab="1 square = 1 %") + 
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"), 
                      labels = c(FSM_RHS_text$x1, 
                                 FSM_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12))  
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(FSM_LHS_waffle, FSM_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createAgeOffence <- function(data, LAchoice){
  
  title1 <- paste0("Age at first offence for ", LAchoice)
  
  ggplot(data, aes(x=OffenceStartAge, y=perc, group=group)) + 
    geom_line(aes(color=group), size=1.5) + 
    labs(x = "Age at first offence", y="% at age", title = title1) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_color_manual(values = c("#08306b", "#2171b5")) +
    theme(axis.title.y=element_text(angle=0, size=15)) +
    theme(text=element_text(size=15), 
          legend.text=element_text(size=15),
          plot.title = element_text(hjust = 0.5, size = 20))
}

createKS2plot <- function(data, LAchoice){
  
  title1 <- paste0("KS2 attainment for ", LAchoice)
  
  ggplot(data, aes(fill=Subject, x=perc, y=group)) + 
    geom_bar(position='dodge', stat='identity') +
    labs(x="% at level 4 or above", y=NULL, title=title1) +
    geom_text(aes(label = paste0(perc, "%")), vjust = 0, hjust=-0.15, position = position_dodge(width = 1), size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank()) +
    scale_fill_manual(values = c("#08306b", "#2171b5")) +
    xlim(0,100) +
    theme(text=element_text(size=15), 
          axis.text=element_text(size = 15, color="black"), 
          axis.title=element_text(size = 15), 
          plot.title=element_text(hjust = 0.5, size = 20), 
          legend.text=element_text(size = 15)) 
  
}

createKS4plot <- function(data, LAchoice){
  
  title1 <- paste0("KS4 attainment for ", LAchoice)
  
  ggplot(data, aes(fill=group, y=perc, x=Subject)) + 
    geom_bar(position='dodge', stat='identity') +
    labs(y="% at KS4\nbenchmark", x=NULL, title=title1) +
    geom_text(aes(label = paste0(perc, "%")), vjust = -0.2, hjust = 0.25, position = position_dodge(width = 1), size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank()) +
    scale_fill_manual(values = c("#08306b", "#2171b5","#4292c6")) +
    ylim(0,105) +
    theme(text=element_text(size=15), 
          axis.text=element_text(size=15, color="black"), 
          axis.title=element_text(size = 15), 
          plot.title=element_text(size = 20, hjust = 0.5), 
          legend.text=element_text(size = 15),
          axis.title.y=element_text(angle = 0)) +
    scale_x_discrete(labels = c("Achieved any pass at GCSE\nor equiv.",
                                "Achieved 5 or more GCSE\n(or equiv.) passes A* - G\nincl. English and Maths",
                                "Achieved 5 or more GCSE\n(or equiv.) passes A* - C\nincl. English and Maths"))

}

createPAPlot <- function(data, LAchoice){
  
  title1 <- paste0("Persistent absence for ", LAchoice)
  
  ggplot(data, aes(x=Absence, y=perc, fill = group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x=NULL, y="% persistently\nabsent", title = title1) +
    geom_text(aes(label = paste0(perc, "%")), vjust =-0.4, position = position_dodge(width = 1), size=6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5","#4292c6")) +
    scale_x_discrete(labels = c("Persistent absence", "Persistent absence\n(unauthorised other)")) +
    ylim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20), 
          axis.title.y=element_text(angle=0))
}

createWaffle_PA <- function(data, LAchoice){
  title <- paste0("Persistent absence for ", LAchoice)
  
  # automated text for waffle - LHS
  PA_LHS_text <- data.frame(x1 = paste0(data$sv_prop_count_PA, "%\nPersistently\nabsent"),
                             x2 = paste0(data$prop_sv_not_PA, "%\nNot persistently\nabsent"))
  
  PA_LHS_waffle <- waffle(data[c(3,5)], rows=10, size=0.6, flip=TRUE, 
                           colors=c("#08306b", "#2171b5"), 
                           title="Children who were cautioned\nor sentenced for a\nserious violence offence",  
                           xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), 
                      labels = c(PA_LHS_text$x1, 
                                 PA_LHS_text$x2)) +
    theme(text=element_text(size=12), 
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12)) 

  # automated text for waffle - RHS
  PA_RHS_text <- data.frame(x1 = paste0(data$also_sv_prop_count_PA, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                             x2 = paste0(data$not_also_sv_prop_count_PA, "%\nAll other\npupils"))
  
  PA_RHS_waffle <- waffle(data[c(4,6)], rows=10, size=0.6, flip=TRUE,
                           colors=c("#08306b", "#6BACE6"), 
                           title="All pupils who were\npersistenly absent",
                           xlab="1 square = 1 %") + 
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"), 
                      labels = c(PA_RHS_text$x1, 
                                 PA_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12))  
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(PA_LHS_waffle, PA_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createPATimingPlot <- function(data, LAchoice){
  
  title1 <- paste0("Persistent absence timing for ", LAchoice)
  
  ggplot(data, aes(x=perc, y=Absence, fill = Timing )) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% with persistent absence timing", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-5.5, hjust=0) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6"), 
                      labels = c("Before the first\nserious violence\noffence", 
                                 "In the same term as the\nfirst serious violence\noffence", 
                                 "After the first\nserious violence\noffence")) +
    xlim(0,105) +
    scale_y_discrete(labels = c("Persistent\nabsence\n(unauthorised\nother) timing","Persistent\nabsence\ntiming")) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}

createSusExclPlot <- function(data, LAchoice){
  
  title1 <- paste0("Suspensions and permanent exclusions for ", LAchoice)
  
  ggplot(data, aes(x=Absence, y=perc, fill = group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x=NULL, y="% suspended/\npermanently\nexcluded", title = title1) +
    geom_text(aes(label = paste0(perc, "%")), vjust =-0.4, position = position_dodge(width = 1), size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=12)) +
    scale_fill_manual(values = c("#08306b", "#2171b5","#4292c6")) +
    scale_x_discrete(labels = c("Suspended", "Permanently excluded")) +
    ylim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20), 
          axis.title.y=element_text(angle=0))
}

createWaffle_Sus <- function(data, LAchoice){
  title <- paste0("Suspensions for ", LAchoice)

  # automated text for waffle - LHS
  sus_LHS_text <- data.frame(x1 = paste0(data$sv_prop_count_Sus, "%\nSuspended"),
                            x2 = paste0(data$prop_sv_not_Sus, "%\nNot suspended"))

  sus_LHS_waffle <- waffle(data[c("sv_prop_count_Sus","prop_sv_not_Sus")], rows=10, size=0.6, flip=TRUE,
                          colors=c("#08306b", "#2171b5"),
                          title="Children who were cautioned\nor sentenced for a\nserious violence offence",
                          xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"),
                      labels = c(sus_LHS_text$x1,
                                 sus_LHS_text$x2)) +
    theme(text=element_text(size=12),
          axis.title=element_text(size=12),
          plot.title=element_text(size=12),
          legend.text=element_text(size=12))

  # automated text for waffle - RHS
  sus_RHS_text <- data.frame(x1 = paste0(data$also_sv_prop_count_Sus, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                            x2 = paste0(data$not_also_sv_prop_count_Sus, "%\nAll other\npupils"))

  sus_RHS_waffle <- waffle(data[c("also_sv_prop_count_Sus","not_also_sv_prop_count_Sus")], rows=10, size=0.6, flip=TRUE,
                          colors=c("#08306b", "#6BACE6"),
                          title="All pupils who were\nsuspended",
                          xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"),
                      labels = c(sus_RHS_text$x1,
                                 sus_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12),
          legend.text=element_text(size=12))
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(sus_LHS_waffle, sus_RHS_waffle), top=title, ncol=2, widths=c(1,2))

}

createWaffle_Excl <- function(data, LAchoice){
  title <- paste0("Permanent exclusions for ", LAchoice)
  
  # automated text for waffle - LHS
  sus_LHS_text <- data.frame(x1 = paste0(data$sv_prop_count_Excl, "%\nPermanently\nexcluded"),
                             x2 = paste0(data$prop_sv_not_Excl, "%\nNot permanently\nexcluded"))
  
  sus_LHS_waffle <- waffle(data[c("sv_prop_count_Excl","prop_sv_not_Excl")], rows=10, size=0.6, flip=TRUE,
                           colors=c("#08306b", "#2171b5"),
                           title="Children who were cautioned\nor sentenced for a\nserious violence offence",
                           xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"),
                      labels = c(sus_LHS_text$x1,
                                 sus_LHS_text$x2)) +
    theme(text=element_text(size=12),
          axis.title=element_text(size=12),
          plot.title=element_text(size=12),
          legend.text=element_text(size=12))
  
  # automated text for waffle - RHS
  sus_RHS_text <- data.frame(x1 = paste0(data$also_sv_prop_count_Excl, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                             x2 = paste0(data$not_also_sv_prop_count_Excl, "%\nAll other\npupils"))
  
  sus_RHS_waffle <- waffle(data[c("also_sv_prop_count_Excl","not_also_sv_prop_count_Excl")], rows=10, size=0.6, flip=TRUE,
                           colors=c("#08306b", "#6BACE6"),
                           title="All pupils who were\npermanently excluded",
                           xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"),
                      labels = c(sus_RHS_text$x1,
                                 sus_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12),
          legend.text=element_text(size=12))
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(sus_LHS_waffle, sus_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createSusTimePlot <- function(data, LAchoice, time){
  
  data <- data %>% filter(SusExcl=="Suspended", Time == time) %>% mutate(rank = as.factor(rank))

  
  title1 <- paste0(time," suspension timing for ", LAchoice)
  labels1 <- c(paste0(time, " suspension\nprior to first\nserious violence offence"),
               paste0(time, " suspension\non same day as first\nserious violence offence"),
               paste0(time, " suspension\nafter first\nserious violence offence"))
  
  ggplot(data, aes(x=rank, y=Perc, fill = time_group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x=NULL, y="% with\ntiming", title = title1) +
    geom_text(aes(label = paste0(Perc, "%")), vjust =-0.4, position = position_dodge(width = 1)) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), 
          axis.text = element_text(color="black", angle = 45, vjust = 1, hjust=1)) +
    scale_fill_manual(values = c("#08306b", "#2171b5","#4292c6"), 
                      labels=labels1) +
    scale_x_discrete(labels = c("Over 2 years", "1 - 2 years",  "180 -365 days", "90 - 179 days","60 - 80 days",  
                                "30 - 59 days","1 - 29 days", "On same day", "1 - 29 days",  "30 - 59 days", 
                                "60 - 89 days", "90 - 179 days", "180 -365 days", "1 - 2 years", "Over 2 years")) +
    geom_vline(xintercept ="8", linetype='dashed', color = 'grey') +
    ylim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20), 
          axis.title.y=element_text(angle=0))
}

createExclTimePlot <- function(data, LAchoice, time){
  
  data <- data %>% filter(SusExcl=="Permanently excluded", Time == time) %>% mutate(rank = as.factor(rank))
  
  title1 <- paste0(time," permanent exclusion timing for ", LAchoice)
  labels1 <- c(paste0(time, " permanent exclusion\nprior to first\nserious violence offence"),
               paste0(time, " permanent exclusion\non same day as first\nserious violence offence"),
               paste0(time, " permanent exclusion\nafter first\nserious violence offence"))
  
  ggplot(data, aes(x=rank, y=Perc, fill = time_group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x=NULL, y="% with\ntiming", title = title1) +
    geom_text(aes(label = paste0(Perc, "%")), vjust =-0.4, position = position_dodge(width = 1)) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), 
          axis.text.x = element_text(color="black", angle = 45, vjust = 1, hjust=1)) +
    scale_fill_manual(values = c("#08306b", "#2171b5","#4292c6"), 
                      labels=labels1) +
    scale_x_discrete(labels = c("Over 2 years", "1 - 2 years",  "180 -365 days", "90 - 179 days","60 - 80 days",  
                                "30 - 59 days","1 - 29 days", "On same day", "1 - 29 days",  "30 - 59 days", 
                                "60 - 89 days", "90 - 179 days", "180 -365 days", "1 - 2 years", "Over 2 years")) +
    geom_vline(xintercept ="8", linetype='dashed', color = 'grey') +
    ylim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20), 
          axis.title.y=element_text(angle=0))
}

createAPPlot <- function(data, LAchoice){
  
  title1 <- paste0("Alternative provision for ", LAchoice)
  
  ggplot(data, aes(x=perc, y=group, fill = group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x="% ever attended AP", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), hjust =-0.1, position = position_dodge(width = 1), size = 6) +
    theme_classic() +
    theme(legend.position = "none", legend.title=element_blank(), axis.text = element_text(color="black", size = 15)) +
    scale_fill_manual(values = c("#08306b", "#08306b", "#08306b")) +
    scale_y_discrete(labels = c("All Pupils", "Any\nOffence", "Serious\nViolence\nOffence")) + 
    xlim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20), 
          axis.title.y=element_text(angle=0))
}

createWaffle_AP <- function(data, LAchoice){
  title <- paste0("Alternative provision for ", LAchoice)
  
  # automated text for waffle - LHS
  AP_LHS_text <- data.frame(x1 = paste0(data$sv_prop_count_AP, "%\nAttended AP"),
                            x2 = paste0(data$prop_sv_not_AP, "%\nDid not\nattend AP"))
  
  AP_LHS_waffle <- waffle(data[c("sv_prop_count_AP","prop_sv_not_AP")], rows=10, size=0.6, flip=TRUE, 
                          colors=c("#08306b", "#2171b5"), 
                          title="Children who were cautioned\nor sentenced for a\nserious violence offence",  
                          xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), 
                      labels = c(AP_LHS_text$x1, 
                                 AP_LHS_text$x2)) +
    theme(text=element_text(size=12), 
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12)) 
  
  # automated text for waffle - RHS
  AP_RHS_text <- data.frame(x1 = paste0(data$also_sv_prop_count_AP, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                            x2 = paste0(data$not_also_sv_prop_count_AP, "%\nAll other\npupils"))
  
  AP_RHS_waffle <- waffle(data[c("also_sv_prop_count_AP","not_also_sv_prop_count_AP")], rows=10, size=0.6, flip=TRUE,
                          colors=c("#08306b", "#6BACE6"), 
                          title="All pupils who had ever\nattended AP",
                          xlab="1 square = 1 %") + 
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"), 
                      labels = c(AP_RHS_text$x1, 
                                 AP_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12))  
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(AP_LHS_waffle, AP_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createAPTimingPlot <- function(data, LAchoice){
  
  title1 <- paste0("Alternative provision (AP) timing for ", LAchoice)
  
  data <- data %>% mutate(group="Serious Violence Offence")
  
  ggplot(data, aes(x=perc, y=group, fill = Timing )) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% with AP timing", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-9.5, hjust=0) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6"), 
                      labels = c("Before the first\nserious violence\noffence", 
                                 "In the same term as the\nfirst serious violence\noffence", 
                                 "After the first\nserious violence\noffence")) +
    xlim(0,105) +
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}

createSENPlot <- function(data, LAchoice){
  
  title1 <- paste0("Special Educational Needs (SEN) for ", LAchoice)
  
  data <- data %>% mutate(perc = abs(perc)) # REMOVE THIS WHEN USING REAL DATA
  
  ggplot(data, aes(x=perc, y=group, fill = SEN_type)) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% of SEN", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-2.5, hjust=0, size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size = 15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6")) +
    #xlim(0,105) +
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}

createWaffle_SEN <- function(data, LAchoice){
  title <- paste0("SEN support for ", LAchoice)
  
  # automated text for waffle - LHS
  SEN_LHS_text <- data.frame(x1 = paste0(data$prop_SEN_support_SV, "%\nSEN Support"),
                            x2 = paste0(data$prop_not_SEN_support_SV, "%\nNot\nSEN Support"))
  
  SEN_LHS_waffle <- waffle(data[c("prop_SEN_support_SV","prop_not_SEN_support_SV")], rows=10, size=0.6, flip=TRUE, 
                          colors=c("#08306b", "#2171b5"), 
                          title="Children who were cautioned\nor sentenced for a\nserious violence offence",  
                          xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), 
                      labels = c(SEN_LHS_text$x1, 
                                 SEN_LHS_text$x2)) +
    theme(text=element_text(size=12), 
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12)) 
  
  # automated text for waffle - RHS
  SEN_RHS_text <- data.frame(x1 = paste0(data$prop_also_SEN_support_SV, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                            x2 = paste0(data$not_also_SEN_support_SV, "%\nAll other\npupils"))
  
  SEN_RHS_waffle <- waffle(data[c("prop_also_SEN_support_SV","not_also_SEN_support_SV")], rows=10, size=0.6, flip=TRUE,
                          colors=c("#08306b", "#6BACE6"), 
                          title="All pupils who had ever\nhad SEN support",
                          xlab="1 square = 1 %") + 
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"), 
                      labels = c(SEN_RHS_text$x1, 
                                 SEN_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12))  
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(SEN_LHS_waffle, SEN_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createWaffle_EHCP <- function(data, LAchoice){
  title <- paste0("EHC plan for ", LAchoice)
  
  # automated text for waffle - LHS
  EHC_LHS_text <- data.frame(x1 = paste0(data$prop_EHCP_SV , "%\nEHC plan"),
                            x2 = paste0(data$prop_not_EHCP_SV, "%\nNo\nEHC plan"))
  
  EHC_LHS_waffle <- waffle(data[c("prop_EHCP_SV","prop_not_EHCP_SV")], rows=10, size=0.6, flip=TRUE, 
                          colors=c("#08306b", "#2171b5"), 
                          title="Children who were cautioned\nor sentenced for a\nserious violence offence",  
                          xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), 
                      labels = c(EHC_LHS_text$x1, 
                                 EHC_LHS_text$x2)) +
    theme(text=element_text(size=12), 
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12)) 
  
  # automated text for waffle - RHS
  EHC_RHS_text <- data.frame(x1 = paste0(data$prop_also_EHCP_SV, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                            x2 = paste0(data$not_prop_also_EHCP_SV, "%\nAll other\npupils"))
  
  EHC_RHS_waffle <- waffle(data[c("prop_also_EHCP_SV","not_prop_also_EHCP_SV")], rows=10, size=0.6, flip=TRUE,
                          colors=c("#08306b", "#6BACE6"), 
                          title="All pupils who had ever\nhad an EHC plan",
                          xlab="1 square = 1 %") + 
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"), 
                      labels = c(EHC_RHS_text$x1, 
                                 EHC_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12))  
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(EHC_LHS_waffle, EHC_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createSENTimingPlot <- function(data, LAchoice){
  
  title1 <- paste0("SEN timing for ", LAchoice)
  
  data <- data %>% mutate(group="Serious Violence Offence")
  
  ggplot(data, aes(x=perc, y=group, fill = Timing )) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% with timing", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-7.5, hjust=0, size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6")) +
    xlim(0,105) +
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}

createEHCPTimingPlot <- function(data, LAchoice){
  
  title1 <- paste0("EHC plan timing for ", LAchoice)
  
  data <- data %>% mutate(group="Serious Violence Offence")
  
  ggplot(data, aes(x=perc, y=group, fill = Timing )) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% with timing", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-7.5, hjust=0, size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6")) +
    xlim(0,105) +
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}

createSEMHTimingPlot <- function(data, LAchoice){
  
  title1 <- paste0("SEMH timing for ", LAchoice)
  
  data <- data %>% mutate(group="Serious Violence Offence")
  
  ggplot(data, aes(x=perc, y=group, fill = Timing )) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% with timing", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-7.5, hjust=0, size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6")) +
    xlim(0,105) +
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}

createCSCPlot <- function(data, LAchoice){
  
  title1 <- paste0("CIN/CLA for ", LAchoice)
  
  ggplot(data, aes(x=CINCLA, y=perc, fill = group)) +
    geom_bar(position = 'dodge', stat = 'identity') +
    labs(x=NULL, y="% recorded as\nCIN/CLA", title = title1) +
    geom_text(aes(label = paste0(perc, "%")), vjust =-0.4, hjust = 0.5, position = position_dodge(width = 1), size = 6) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size = 15), legend.text = element_text(size = 15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5","#4292c6")) +
    scale_x_discrete(labels = c("Children in need", "Children who are\nlooked after")) +
    ylim(0,100) + 
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20), 
          axis.title.y=element_text(angle=0))
}

createWaffle_CIN <- function(data, LAchoice){
  title <- paste0("CIN for ", LAchoice)
  
  # automated text for waffle - LHS
  CIN_LHS_text <- data.frame(x1 = paste0(data$propsv_count_CIN , "%\nCIN"),
                             x2 = paste0(data$propsv_count_not_CIN, "%\nNot\nCIN"))
  
  CIN_LHS_waffle <- waffle(data[c("propsv_count_CIN","propsv_count_not_CIN")], rows=10, size=0.6, flip=TRUE, 
                           colors=c("#08306b", "#2171b5"), 
                           title="Children who were cautioned\nor sentenced for a\nserious violence offence",  
                           xlab="1 square = 1 %") +
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#2171b5"), 
                      labels = c(CIN_LHS_text$x1, 
                                 CIN_LHS_text$x2)) +
    theme(text=element_text(size=12), 
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12)) 
  
  # automated text for waffle - RHS
  CIN_RHS_text <- data.frame(x1 = paste0(data$also_propsv_count_CIN, "%\nChildren cautioned or sentenced\nfor a serious violence offence"),
                             x2 = paste0(data$not_also_propsv_count_CIN, "%\nAll other\npupils"))
  
  CIN_RHS_waffle <- waffle(data[c("also_propsv_count_CIN","not_also_propsv_count_CIN")], rows=10, size=0.6, flip=TRUE,
                           colors=c("#08306b", "#6BACE6"), 
                           title="All pupils who had ever\nbeen CIN",
                           xlab="1 square = 1 %") + 
    theme_classic() +
    theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "bottom",
          legend.title = element_blank(),
          plot.title = element_text(hjust = 0.5, size=9)) +
    scale_fill_manual(values = c("#08306b", "#6BACE6"), 
                      labels = c(CIN_RHS_text$x1, 
                                 CIN_RHS_text$x2)) +
    theme(text=element_text(size=12), #change font size of all text
          axis.title=element_text(size=12),
          plot.title=element_text(size=12), 
          legend.text=element_text(size=12))  
  # Use grid.arrange to put plots in columns
  grid.arrange(grobs = list(CIN_LHS_waffle, CIN_RHS_waffle), top=title, ncol=2, widths=c(1,2))
  
}

createCSCTimingPlot <- function(data, LAchoice){
  
  title1 <- paste0("CSC timing for ", LAchoice)
  
  ggplot(data, aes(x = perc, y = CSC_subset, fill = Timing)) +
    geom_bar(position='stack', stat = "identity", width = 0.7) +
    labs(x = "% with timing", y=NULL, title = title1) +
    geom_text(aes(label = paste0(perc, "%")), position = position_stack(vjust = 0.5), vjust=-9.5, hjust=0) +
    theme_classic() +
    theme(legend.position = "bottom", legend.title=element_blank(), axis.text = element_text(color="black", size=15)) +
    scale_fill_manual(values = c("#08306b", "#2171b5", "#4292c6")) +
    xlim(0,105) +
    theme(text=element_text(size = 15),
          axis.text=element_text(size = 15),
          axis.title=element_text(size = 15), 
          legend.text=element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 20)) 
}
