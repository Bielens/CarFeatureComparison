source("helper.R")

require(xtable)
require(ggplot2)
require(grid)

shinyServer(function(input,output) {
  
 xvar <- reactive({
   trim(input$x)
 })
 
 yvar <- reactive({
   trim(input$y)
 })
 
 data <- reactive({
   data.frame(b=rownames(mtcars),
              x=mtcars[,xvar()],
              y=mtcars[,yvar()])
 })
 
 dt <- reactive({
   temp <- data()
   colnames(temp) <- 
     c("Brand",varlabel(xvar()),varlabel(yvar()))
   temp <- temp[order(temp$Brand),]
   xtable(temp)
 })
 
 #output$p1.col   <- renderText(xvar())
 #output$p1.label <- renderText(varlabel(xvar())) 
 #output$p2.col   <- renderText(yvar()) 
 #output$p2.label <- renderText(varlabel(yvar()))
 
 ##browser()

 output$carplot <- renderPlot({
                                output$scm <- renderText("none")
                                df=data()
                                 x = xvar()
                                 y = yvar()
                                 xlabel = varlabel(x)
                                 ylabel = varlabel(y)
                                 plot <- NULL
                                 
                                 if (isfactor(x)) {
                                   if (!isfactor(y)) {
                                     plot <- ggplot(aes(x=x,y=y),data=df) +
                                       geom_boxplot(aes(fill=x))
                                   }
                                 } else {
                                   if (!isfactor(y)) {
                                     plot <- ggplot(aes(x=x,y=y),data=df) +
                                       geom_point(size=4,shape=19)
                                     if (input$rl) {
                                       #browser()
                                       l <- lm(df$y ~ df$x)
                                       plot <- plot + geom_abline(intercept=l$coeff[1],slope=l$coeff[2]) +
                                            geom_smooth(method=lm)
                                     }
                                     carmodel <- input
                                     if (!grepl("<Select",input$c)) {
                                       output$scm <- renderText(input$c)
                                       #browser()
                                       sr = df[df$b==input$c,]
                                       sx = sr$x
                                       sy = sr$y
                                       plot <- plot + annotate("point",x=sx, y=sy, colour="red",size=6) +
                                                      annotate("text",x=max(df$x),y=max(df$y),colour="red",label=input$c,hjust=1,size=6)+
                                                      annotate("segment",x=0.9*max(df$x),y=0.9*max(df$y),colour="red",xend=0.9*sx+0.09*max(df$x), yend=0.9*sy+0.09*max(df$y),
                                                               arrow=arrow(),size=2)
                                     } else {
                                       output$scm <- renderText("none")
                                     }
                                  
                                   } else {
                                     xlabel = varlabel(y)
                                     ylabel = varlabel(x)
                                     plot <- ggplot(aes(x=y,y=x),data=df) +
                                       geom_boxplot(aes(fill=y)) +
                                       coord_flip()
                                     
                                   }
                                 }
                                 plot <- plot + labs(title=paste(varlabel(x),"vs",varlabel(y)),x=xlabel,y=ylabel,fill=xlabel)
                                 plot
                               })
 
output$cartable <- renderDataTable({data = dt()
                                     
                                 ##browser()
                                 data},
                                 options = list(
                                 pageLength = 10))
 
})