% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rnvd3.R
\name{multiBarChart}
\alias{multiBarChart}
\title{Multibar chart}
\usage{
multiBarChart(
  data,
  formula,
  by,
  palette = "viridis",
  xAxisTitle = NULL,
  yAxisTitle = NULL,
  margins = list(b = 100, l = 70),
  duration = 1300,
  rotateLabels = 0,
  groupSpacing = 0.1,
  xAxisTitleDistance = 35,
  yAxisTitleDistance = -5,
  yAxisShowMaxMin = FALSE,
  yAxisTickFormat = ".0f",
  xLabelsFontSize = "1rem",
  yLabelsFontSize = "1rem",
  rightAlignYaxis = FALSE,
  reduceXticks = FALSE,
  staggerLabels = FALSE,
  wrapLabels = FALSE,
  useInteractiveGuideline = FALSE,
  tooltipFormatters = list(value = NULL, header = NULL, key = NULL),
  tooltipTransitions = TRUE,
  tooltipShadow = TRUE,
  radioButtonMode = FALSE,
  legendTitle = NULL,
  legendHjust = -20,
  width = "100\%",
  height = NULL,
  elementId = NULL
)
}
\arguments{
\item{data}{dataframe used for the chart}

\item{formula}{a two-sided formula like \code{y ~ x}, where \code{"x"} and
\code{"y"} are two column names of \code{data}}

\item{by}{string, the "by" variable; must be a column name of \code{data}}

\item{palette}{this can be either the name of a viridis color palette, e.g.
\code{"viridis"}, \code{"cividis"} or \code{"turbo"}
(see \code{\link[viridisLite]{viridis}}), or a vector of colors, or a
function that takes an integer argument (the required number of colors)
and returns a character vector of colors (e.g. you can use
\code{\link[grDevices]{colorRampPalette}})}

\item{xAxisTitle}{a title for the x-axis; if \code{NULL}, the title is
taken from the \code{formula} argument}

\item{yAxisTitle}{a title for the y-axis; if \code{NULL}, the title is
taken from the \code{formula} argument}

\item{margins}{a named list defining the margins, with names \code{"t"},
\code{"r"}, \code{"b"} and \code{"l"}, for "top", "right", "bottom"
and "left" respectively; you can specify only certain margins in the list
to change just those parts}

\item{duration}{duration of the transition, a number of milliseconds}

\item{rotateLabels}{a number, the angle of rotation of the labels of the
x-axis (in degrees)}

\item{groupSpacing}{a number, controls the distance between groups of bars}

\item{xAxisTitleDistance}{a number, controls the distance between the
x-axis and its title}

\item{yAxisTitleDistance}{a number, controls the distance between the
y-axis and its title}

\item{yAxisShowMaxMin}{Boolean, whether to show the min and the max on
the y-axis}

\item{yAxisTickFormat}{a d3 formatting string for the y-axis; see
\href{https://d3-wiki.readthedocs.io/zh_CN/master/Formatting/#d3_format}{d3.format}}

\item{xLabelsFontSize}{a CSS measure, the font size of the labels on the
x-axis}

\item{yLabelsFontSize}{a CSS measure, the font size of the labels on the
y-axis}

\item{rightAlignYaxis}{Boolean, whether to put the y-axis on the right side
instead of the left}

\item{reduceXticks}{Boolean, whether to reduce the ticks on the x-axis so
that the x-labels are less likely to overlap}

\item{staggerLabels}{Boolean, whether to make the x-labels stagger at
different distances from the axis so they're less likely to overlap}

\item{wrapLabels}{Boolean, whether to split long x-labels by new lines in
order to prevent overlapping}

\item{useInteractiveGuideline}{Boolean, other kind of tooltips: sets the
chart to use a guideline and floating tooltip instead of requiring the
user to hover over specific hotspots}

\item{tooltipFormatters}{formatters for the tooltip; each formatter must
be \code{NULL} for the default formatting, otherwise a JavaScript function
created with \code{\link{JS}}; there are three possible formatters
(see the example):
\describe{
  \item{value}{formatter for the y-value displayed in the tooltip}
  \item{header}{formatter for the tooltip header (this is the x-value)}
  \item{key}{formatter for the value of the 'by' variable}
}}

\item{tooltipTransitions}{Boolean, whether to style the tooltip with a
fade effect}

\item{tooltipShadow}{Boolean, whether to style the tooltip with a shadow}

\item{radioButtonMode}{Boolean, whether to authorize only one selection in
the legend (i.e. only one level of the '\code{by}' variable)}

\item{legendTitle}{a title for the legend, or \code{NULL} for no title}

\item{legendHjust}{horizontal adjustment of the legend title}

\item{width}{width of the chart container, must be a valid CSS measure}

\item{height}{height of the chart container, must be a valid CSS measure}

\item{elementId}{an id for the chart container; commonly useless}
}
\value{
A htmlwidget displaying a grouped/stacked bar chart.
}
\description{
HTMLwidget displaying a multibar chart.
}
\note{
In Shiny, you can style the axis titles with the help of CSS; see the
  \link[=rnvd3Output]{shiny example}. It is also possible outside of Shiny;
  see the second example below, where we set the CSS with the help of
  \code{\link[htmlwidgets:prependContent]{prependContent}}.
}
\examples{
library(Rnvd3)
# in this example we use the tooltip formatters for styling only; we could
# achieve the same result with the help of CSS
dat <- reshape2::melt(
  apply(HairEyeColor, c(1, 2), sum), value.name = "Count"
)
multiBarChart(
  dat, Count ~ Eye, "Hair",
  tooltipFormatters = list(
    value = JS(
      "function(x){",
      "  return '<span style=\"color:red;\">' + x + '</span>';",
      "}"
    ),
    header = JS(
      "function(x){",
      "  return '<span style=\"color:green;\">' + x + '</span>';",
      "}"
    ),
    key = JS(
      "function(x){",
      "  return '<i style=\"color:blue;\">' + x + '</i>';",
      "}"
    )
  )
)

# style axis titles with CSS ####
library(htmltools)

CSS <- HTML(
  ".nvd3 .nv-axis.nv-x text.nv-axislabel,
   .nvd3 .nv-axis.nv-y text.nv-axislabel {
     font-size: 2rem;
     fill: red;
  }"
)

widget <- multiBarChart(
  dat, Count ~ Eye, "Hair", palette = "turbo"
)
prependContent(
  widget,
  tags$style(CSS)
)
}
