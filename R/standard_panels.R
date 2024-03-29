a11y_panel <- function() {
  tabPanel(
    "Accessibility",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h1("Accessibility statement"),
          br("This accessibility statement applies to the Education, children's social care and offending: local authority level dashboard.
            This application is run by the Department for Education. We want as many people as possible to be able to use this application,
            and have actively developed this application with accessibilty in mind."),
          h2("WCAG 2.1 compliance"),
          br("We follow the recommendations of the ", a(href = "https://www.w3.org/TR/WCAG21/", "WCAG 2.1 requirements. ", onclick = "ga('send', 'event', 'click', 'link', 'IKnow', 1)"), "This application has been checked using the ", a(href = "https://github.com/ewenme/shinya11y", "Shinya11y tool "), ", which did not detect accessibility issues.
             This application also fully passes the accessibility audits checked by the ", a(href = "https://developers.google.com/web/tools/lighthouse", "Google Developer Lighthouse tool"), ". This means that this application:"),
          tags$div(tags$ul(
            tags$li("uses colours that have sufficient contrast"),
            tags$li("allows you to zoom in up to 300% without the text spilling off the screen"),
            tags$li("has its performance regularly monitored, with a team working on any feedback to improve accessibility for all users")
          )),
          h2("Limitations"),
          br("We recognise that there are still potential issues with accessibility in this application, but we will continue
             to review updates to technology available to us to keep improving accessibility for all of our users. For example, these
            are known issues that we will continue to monitor and improve:"),
          tags$div(tags$ul(
            tags$li("This dashboard uses R-Shiny components that have some issues with badly formatted aria identifiers."),
            tags$li("Some header elements used as part of the R shinyGovstyle package do not meet accessibility requirements around proper alt-text provision.")
          )),
          h2("Feedback"),
          br(
            "If you have any feedback on how we could further improve the accessibility of this application, please contact us at",
            a(href = "mailto:SV.RESEARCH@EDUCATION.GOV.UK", "SV.RESEARCH@EDUCATION.GOV.UK")
          )
        )
      )
    )
  )
}

support_links <- function() {
  tabPanel(
    "Support and feedback",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h2("Give us feedback"),
          "This dashboard is a new service that we are developing. If you have any feedback or suggestions for improvements, please submit them using our ",
          a(
            href = "https://forms.office.com/e/F3ybcuKaTP",
            "feedback form", .noWS = c("after")
          ), ".", br(),
          "If you spot any errors or bugs while using this dashboard, please screenshot and email them to ",
          a(href = "mailto:statistics.development@education.gov.uk", "statistics.development@education.gov.uk", .noWS = c("after")), ".",
          br(),
          h2("Find more information on the data"),
          "The data used to produce the dashboard along with methodological information can be found in the accompanying",
          a(href = "https://explore-education-statistics.service.gov.uk/find-statistics/education-children-s-social-care-and-offending-local-authority-level-dashboard/2019-20", "EES publication", .noWS = c("after")),
          ".",
          br(),
          br(),
          "This dashboard uses the",
          a(href = "https://www.gov.uk/government/publications/local-authority-interactive-tool-lait", "Local Authority Interactive Tool"),
          "to find each local authority’s 10 nearest statistical neighbours (local authorities with similar characteristics). More information is
    available in appendix A of the",
          a(href = "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/975113/LAIT_User_Guide_2021.pdf", "Local authority interactive tool: user guide"),
          ".",
          br(),
          h2("Contact us"),
          "If you have questions about the dashboard or data within it, please contact us at ",
          a(href = "mailto:statistics.development@education.gov.uk", "statistics.development@education.gov.uk", .noWS = c("after")), br(),
          h2("See the source code"),
          "The source code for this dashboard is available in our ",
          a(href = "https://github.com/dfe-analytical-services/childrens_social_services_offenders_dashboard", "GitHub repository", .noWS = c("after")),
          ".",
          br(),
          br()
        ),
        column(
          12,
          h2("Use of cookies"),
          textOutput("cookie_status"),
          actionButton("remove", "Reset cookie consent"),
        )
      )
    )
  )
}
