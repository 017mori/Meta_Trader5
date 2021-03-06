//+------------------------------------------------------------------+
//|                                                        Color.mq5 |
//|                                                          Matheus |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Matheus"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window  //Ou indicator_separate_window (Aplica o indicador em uma janela separa)
#property indicator_buffers 9
#property indicator_plots   3
//--- plot Dentro
#property indicator_label1  "Dentro"
#property indicator_type1   DRAW_CANDLES
#property indicator_color1  clrYellow
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Fora
#property indicator_label2  "Fora"
#property indicator_type2   DRAW_CANDLES
#property indicator_color2  clrDodgerBlue
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
//--- plot Type_Candle
#property indicator_label3  "Type_Candle"
#property indicator_type3   DRAW_ARROW
#property indicator_color3  clrRed
#property indicator_style3  STYLE_SOLID
#property indicator_width3  1
//--- indicator buffers
double         DentroBuffer1[];
double         DentroBuffer2[];
double         DentroBuffer3[];
double         DentroBuffer4[];
double         ForaBuffer1[];
double         ForaBuffer2[];
double         ForaBuffer3[];
double         ForaBuffer4[];
double         Type_CandleBuffer[];

input int nada =0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,DentroBuffer1,INDICATOR_DATA);
   SetIndexBuffer(1,DentroBuffer2,INDICATOR_DATA);
   SetIndexBuffer(2,DentroBuffer3,INDICATOR_DATA);
   SetIndexBuffer(3,DentroBuffer4,INDICATOR_DATA);
   SetIndexBuffer(4,ForaBuffer1,INDICATOR_DATA);
   SetIndexBuffer(5,ForaBuffer2,INDICATOR_DATA);
   SetIndexBuffer(6,ForaBuffer3,INDICATOR_DATA);
   SetIndexBuffer(7,ForaBuffer4,INDICATOR_DATA);
   SetIndexBuffer(8,Type_CandleBuffer,INDICATOR_DATA);
//--- setting a code from the Wingdings charset as the property of PLOT_ARROW
   PlotIndexSetInteger(2,PLOT_ARROW,159);
   
   

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
//Definido as variavel q classifica se candle do periodo n-1 e de alta ou de baixa
   double can_anterior;

//Pintando os candles
   for(int i = 1; i<rates_total ; i++)
     {
      
      can_anterior = 0;
      can_anterior = close[i-1]-open[i-1];  //Classificando o Candle (se ele é de alta ou baixa)

      if(can_anterior >= 0) //Candle "preto" de alta
        {
         
         if(close[i] <= open[i] && close[i]>= open[i-1]) //Pintando os candles q estao dentro de amarelo se candle atual for de baixa
           {
            DentroBuffer1[i] = open[i];
            DentroBuffer2[i] = close[i];
            DentroBuffer3[i] = open[i];
            DentroBuffer4[i] = close[i];
            Type_CandleBuffer[i] = -1;
           }
         else  //Pintando os candles q estao fora de azul
           {
            ForaBuffer1[i] = open[i];
            ForaBuffer2[i] = close[i];
            ForaBuffer3[i] = open[i];
            ForaBuffer4[i] = close[i];
            Type_CandleBuffer[i] = 0;           
           }

        }
      else                  //Candle "branco" de baixa
        {
         
         if(close[i] >= open[i] && close[i] <= open[i-1]) //Pintando os candles q estao dentro de amarelo se o candle atual for de alta
           {
            DentroBuffer1[i] = open[i];
            DentroBuffer2[i] = close[i];
            DentroBuffer3[i] = open[i];
            DentroBuffer4[i] = close[i];
            Type_CandleBuffer[i] = 1;
           }
         else  //Pintando os candles q estao fora de azul
           {
            ForaBuffer1[i] = open[i];
            ForaBuffer2[i] = close[i];
            ForaBuffer3[i] = open[i];
            ForaBuffer4[i] = close[i];
            Type_CandleBuffer[i] = 0;
           }

        }

     }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
