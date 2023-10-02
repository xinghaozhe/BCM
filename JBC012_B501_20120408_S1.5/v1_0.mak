# ST Visual Debugger Generated MAKE File, based on v1_0.stp

ifeq ($(CFG), )
CFG=Debug
$(warning ***No configuration specified. Defaulting to $(CFG)***)
endif

ToolsetRoot=D:\PROGRA~1\COSMIC\CXSTM8
ToolsetBin=D:\Program Files\COSMIC\CXSTM8
ToolsetInc=D:\Program Files\COSMIC\CXSTM8\Hstm8
ToolsetLib=D:\Program Files\COSMIC\CXSTM8\Lib
ToolsetIncOpts=-i"D:\Program Files\COSMIC\CXSTM8\Hstm8" 
ToolsetLibOpts=-l"D:\Program Files\COSMIC\CXSTM8\Lib" 
ObjectExt=o
OutputExt=elf
InputName=$(basename $(notdir $<))


# 
# Debug
# 
ifeq "$(CFG)" "Debug"


OutputPath=Debug
ProjectSFile=v1_0
TargetSName=$(ProjectSFile)
TargetFName=$(ProjectSFile).elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  +mods0 +debug -pxp -pp -l -isouces\user_src -isouces\inc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  -xx -l $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) $(ProjectSFile).elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Debug\can_nm_osek.$(ObjectExt) : souces\user_src\can_nm_osek.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\can_nm_osek.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\domelamp_drv.$(ObjectExt) : souces\user_src\domelamp_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\share.h souces\inc\stm8_type.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\gpio_macro.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\domelamp_drv.h souces\user_src\warm_drv.h souces\user_src\lock_drv.h souces\user_src\rke_drv.h souces\inc\timer2_3.h souces\user_src\main.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\rke_key.$(ObjectExt) : souces\user_src\rke_key.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\rke_key.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\main.$(ObjectExt) : souces\user_src\main.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\main.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\share.h souces\user_src\can_nm_osek.h souces\user_src\gpio_macro.h souces\user_src\adc_drv.h souces\user_src\st79_it.h souces\inc\timer2_3.h souces\user_src\domelamp_drv.h souces\user_src\turnlamp_drv.h souces\user_src\lock_drv.h souces\user_src\warm_drv.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\rke_drv.h souces\user_src\window_drv.h souces\user_src\defrost_drv.h souces\user_src\sys_init.h souces\user_src\can_nm_osek.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\timer2_3.$(ObjectExt) : souces\user_src\timer2_3.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\timer2_3.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_clk.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_adc.$(ObjectExt) : souces\src\stm8_adc.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_adc.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\adc_drv.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_awu.$(ObjectExt) : souces\src\stm8_awu.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_awu.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_clk.$(ObjectExt) : souces\src\stm8_clk.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_clk.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\lin.$(ObjectExt) : souces\user_src\lin.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\lin.h souces\inc\stm8_linuart.h souces\user_src\can.h souces\user_src\turnlamp_drv.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\lock_drv.h souces\user_src\rke_drv.h souces\user_src\beam_drv.h souces\user_src\defrost_drv.h souces\user_src\warm_drv.h souces\user_src\gpio_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_exti.$(ObjectExt) : souces\src\stm8_exti.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_exti.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_flash.$(ObjectExt) : souces\src\stm8_flash.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_flash.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_gpio.$(ObjectExt) : souces\src\stm8_gpio.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_gpio.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_itc.$(ObjectExt) : souces\src\stm8_itc.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_itc.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_iwdg.$(ObjectExt) : souces\src\stm8_iwdg.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_iwdg.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_linuart.$(ObjectExt) : souces\src\stm8_linuart.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_linuart.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_clk.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_rst.$(ObjectExt) : souces\src\stm8_rst.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_rst.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_spi.$(ObjectExt) : souces\src\stm8_spi.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_spi.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_usart.$(ObjectExt) : souces\src\stm8_usart.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_usart.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_clk.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_wwdg.$(ObjectExt) : souces\src\stm8_wwdg.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_wwdg.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\adc_drv.$(ObjectExt) : souces\user_src\adc_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\adc_drv.h souces\user_src\share.h souces\inc\stm8_type.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\gpio_macro.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\can.$(ObjectExt) : souces\user_src\can.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\can.h souces\user_src\turnlamp_drv.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\lock_drv.h souces\user_src\rke_drv.h souces\user_src\defrost_drv.h souces\user_src\warm_drv.h souces\user_src\gpio_macro.h souces\user_src\horn_drv.h souces\user_src\main.h souces\user_src\window_drv.h souces\user_src\domelamp_drv.h souces\user_src\lin.h souces\user_src\can_nm_osek.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\defrost_drv.$(ObjectExt) : souces\user_src\defrost_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\gpio_macro.h souces\inc\stm8_gpio.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\defrost_drv.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\adc_drv.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\horn_drv.$(ObjectExt) : souces\user_src\horn_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\main.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\share.h souces\user_src\can_nm_osek.h souces\user_src\gpio_macro.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\domelamp_drv.h souces\user_src\rke_drv.h souces\user_src\window_drv.h souces\user_src\warm_drv.h souces\user_src\turnlamp_drv.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\lock_drv.$(ObjectExt) : souces\user_src\lock_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\gpio_macro.h souces\inc\stm8_gpio.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\lock_drv.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\turnlamp_drv.h souces\user_src\warm_drv.h souces\user_src\adc_drv.h souces\user_src\window_drv.h souces\user_src\main.h souces\user_src\beam_drv.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\rke_drv1.$(ObjectExt) : souces\user_src\rke_drv1.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\share.h souces\inc\stm8_type.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\gpio_macro.h souces\user_src\rke_drv.h souces\user_src\window_drv.h souces\user_src\st79_it.h souces\inc\timer2_3.h souces\user_src\lock_drv.h souces\user_src\turnlamp_drv.h souces\user_src\warm_drv.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\beam_drv.h souces\user_src\sys_init.h souces\user_src\rke_key.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\st79_it.$(ObjectExt) : souces\user_src\st79_it.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\st79_it.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\inc\timer2_3.h souces\user_src\main.h souces\user_src\share.h souces\user_src\can_nm_osek.h souces\user_src\adc_drv.h souces\user_src\rke_drv.h souces\user_src\gpio_macro.h souces\user_src\can.h souces\user_src\st79_tim4.h souces\user_src\can_nm_osek.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\st79_tim4.$(ObjectExt) : souces\user_src\st79_tim4.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\st79_tim4.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_clk.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_interrupt_vector.$(ObjectExt) : souces\user_src\stm8_interrupt_vector.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\st79_it.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\inc\timer2_3.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\sys_init.$(ObjectExt) : souces\user_src\sys_init.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\gpio_macro.h souces\inc\stm8_gpio.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\sys_init.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\rke_drv.h souces\user_src\st79_it.h souces\inc\timer2_3.h souces\user_src\adc_drv.h souces\user_src\can.h souces\user_src\lin.h souces\user_src\lock_drv.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\turnlamp_drv.$(ObjectExt) : souces\user_src\turnlamp_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\turnlamp_drv.h souces\user_src\share.h souces\inc\stm8_type.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\rke_drv.h souces\user_src\adc_drv.h souces\user_src\defrost_drv.h souces\user_src\lock_drv.h souces\user_src\gpio_macro.h souces\user_src\warm_drv.h souces\user_src\horn_drv.h souces\user_src\can.h souces\user_src\main.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\warm_drv.$(ObjectExt) : souces\user_src\warm_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\gpio_macro.h souces\inc\stm8_gpio.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_type.h souces\inc\stm8_macro.h souces\user_src\horn_drv.h souces\user_src\share.h souces\inc\stm8_lib.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\can.h souces\user_src\warm_drv.h souces\user_src\defrost_drv.h souces\user_src\foglamp_drv.h souces\user_src\beam_drv.h souces\user_src\turnlamp_drv.h souces\user_src\rke_drv.h souces\user_src\main.h souces\user_src\adc_drv.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\window_drv.$(ObjectExt) : souces\user_src\window_drv.c d:\PROGRA~1\cosmic\cxstm8\hstm8\mods0.h souces\user_src\share.h souces\inc\stm8_type.h souces\inc\stm8_lib.h souces\inc\stm8_map.h souces\user_src\stm8_conf.h souces\inc\stm8_macro.h souces\inc\stm8_adc.h souces\inc\stm8_awu.h souces\inc\stm8_tim3.h souces\inc\stm8_clk.h souces\inc\stm8_beep.h souces\inc\stm8_flash.h souces\inc\stm8_exti.h souces\inc\stm8_gpio.h souces\inc\stm8_itc.h souces\inc\stm8_iwdg.h souces\inc\stm8_rst.h souces\inc\stm8_spi.h souces\inc\stm8_tim4.h souces\inc\stm8_usart.h souces\inc\stm8_linuart.h souces\inc\stm8_wwdg.h souces\user_src\can_nm_osek.h souces\user_src\gpio_macro.h souces\user_src\window_drv.h souces\user_src\adc_drv.h souces\user_src\rke_drv.h souces\user_src\beam_drv.h souces\user_src\can.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

$(ProjectSFile).elf :  $(OutputPath)\can_nm_osek.o $(OutputPath)\domelamp_drv.o $(OutputPath)\rke_key.o $(OutputPath)\main.o $(OutputPath)\timer2_3.o $(OutputPath)\stm8_adc.o $(OutputPath)\stm8_awu.o $(OutputPath)\stm8_clk.o $(OutputPath)\lin.o $(OutputPath)\stm8_exti.o $(OutputPath)\stm8_flash.o $(OutputPath)\stm8_gpio.o $(OutputPath)\stm8_itc.o $(OutputPath)\stm8_iwdg.o $(OutputPath)\stm8_linuart.o $(OutputPath)\stm8_rst.o $(OutputPath)\stm8_spi.o $(OutputPath)\stm8_usart.o $(OutputPath)\stm8_wwdg.o $(OutputPath)\adc_drv.o $(OutputPath)\can.o $(OutputPath)\defrost_drv.o $(OutputPath)\horn_drv.o $(OutputPath)\lock_drv.o $(OutputPath)\rke_drv1.o $(OutputPath)\st79_it.o $(OutputPath)\st79_tim4.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\sys_init.o $(OutputPath)\turnlamp_drv.o $(OutputPath)\warm_drv.o $(OutputPath)\window_drv.o 
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 -m$(OutputPath)\$(TargetSName).map $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8

	$(ToolsetBin)\chex  -o $(OutputPath)\$(TargetSName).s19 $(OutputPath)\$(TargetSName).sm8
clean : 
	-@erase $(OutputPath)\can_nm_osek.o
	-@erase $(OutputPath)\domelamp_drv.o
	-@erase $(OutputPath)\rke_key.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\timer2_3.o
	-@erase $(OutputPath)\stm8_adc.o
	-@erase $(OutputPath)\stm8_awu.o
	-@erase $(OutputPath)\stm8_clk.o
	-@erase $(OutputPath)\lin.o
	-@erase $(OutputPath)\stm8_exti.o
	-@erase $(OutputPath)\stm8_flash.o
	-@erase $(OutputPath)\stm8_gpio.o
	-@erase $(OutputPath)\stm8_itc.o
	-@erase $(OutputPath)\stm8_iwdg.o
	-@erase $(OutputPath)\stm8_linuart.o
	-@erase $(OutputPath)\stm8_rst.o
	-@erase $(OutputPath)\stm8_spi.o
	-@erase $(OutputPath)\stm8_usart.o
	-@erase $(OutputPath)\stm8_wwdg.o
	-@erase $(OutputPath)\adc_drv.o
	-@erase $(OutputPath)\can.o
	-@erase $(OutputPath)\defrost_drv.o
	-@erase $(OutputPath)\horn_drv.o
	-@erase $(OutputPath)\lock_drv.o
	-@erase $(OutputPath)\rke_drv1.o
	-@erase $(OutputPath)\st79_it.o
	-@erase $(OutputPath)\st79_tim4.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\sys_init.o
	-@erase $(OutputPath)\turnlamp_drv.o
	-@erase $(OutputPath)\warm_drv.o
	-@erase $(OutputPath)\window_drv.o
	-@erase $(OutputPath)\v1_0.elf
	-@erase $(OutputPath)\v1_0.elf
	-@erase $(OutputPath)\v1_0.map
	-@erase $(OutputPath)\can_nm_osek.ls
	-@erase $(OutputPath)\domelamp_drv.ls
	-@erase $(OutputPath)\rke_key.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\timer2_3.ls
	-@erase $(OutputPath)\stm8_adc.ls
	-@erase $(OutputPath)\stm8_awu.ls
	-@erase $(OutputPath)\stm8_clk.ls
	-@erase $(OutputPath)\lin.ls
	-@erase $(OutputPath)\stm8_exti.ls
	-@erase $(OutputPath)\stm8_flash.ls
	-@erase $(OutputPath)\stm8_gpio.ls
	-@erase $(OutputPath)\stm8_itc.ls
	-@erase $(OutputPath)\stm8_iwdg.ls
	-@erase $(OutputPath)\stm8_linuart.ls
	-@erase $(OutputPath)\stm8_rst.ls
	-@erase $(OutputPath)\stm8_spi.ls
	-@erase $(OutputPath)\stm8_usart.ls
	-@erase $(OutputPath)\stm8_wwdg.ls
	-@erase $(OutputPath)\adc_drv.ls
	-@erase $(OutputPath)\can.ls
	-@erase $(OutputPath)\defrost_drv.ls
	-@erase $(OutputPath)\horn_drv.ls
	-@erase $(OutputPath)\lock_drv.ls
	-@erase $(OutputPath)\rke_drv1.ls
	-@erase $(OutputPath)\st79_it.ls
	-@erase $(OutputPath)\st79_tim4.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\sys_init.ls
	-@erase $(OutputPath)\turnlamp_drv.ls
	-@erase $(OutputPath)\warm_drv.ls
	-@erase $(OutputPath)\window_drv.ls
endif

# 
# Release
# 
ifeq "$(CFG)" "Release"


OutputPath=Release
ProjectSFile=v1_0
TargetSName=$(ProjectSFile)
TargetFName=$(ProjectSFile).elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  -isouces\inc -isouces\user_src +modsl -pp $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) $(ProjectSFile).elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Release\can_nm_osek.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\domelamp_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\rke_key.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\main.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\timer2_3.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_adc.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_awu.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_clk.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\lin.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_exti.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_flash.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_gpio.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_itc.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_iwdg.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_linuart.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_rst.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_spi.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_usart.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_wwdg.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\adc_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\can.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\defrost_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\horn_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\lock_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\rke_drv1.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\st79_it.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\st79_tim4.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_interrupt_vector.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\sys_init.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\turnlamp_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\warm_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\window_drv.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

$(ProjectSFile).elf :  $(OutputPath)\can_nm_osek.o $(OutputPath)\domelamp_drv.o $(OutputPath)\rke_key.o $(OutputPath)\main.o $(OutputPath)\timer2_3.o $(OutputPath)\stm8_adc.o $(OutputPath)\stm8_awu.o $(OutputPath)\stm8_clk.o $(OutputPath)\lin.o $(OutputPath)\stm8_exti.o $(OutputPath)\stm8_flash.o $(OutputPath)\stm8_gpio.o $(OutputPath)\stm8_itc.o $(OutputPath)\stm8_iwdg.o $(OutputPath)\stm8_linuart.o $(OutputPath)\stm8_rst.o $(OutputPath)\stm8_spi.o $(OutputPath)\stm8_usart.o $(OutputPath)\stm8_wwdg.o $(OutputPath)\adc_drv.o $(OutputPath)\can.o $(OutputPath)\defrost_drv.o $(OutputPath)\horn_drv.o $(OutputPath)\lock_drv.o $(OutputPath)\rke_drv1.o $(OutputPath)\st79_it.o $(OutputPath)\st79_tim4.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\sys_init.o $(OutputPath)\turnlamp_drv.o $(OutputPath)\warm_drv.o $(OutputPath)\window_drv.o 
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 -m$(OutputPath)\$(TargetSName).map $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8 

	$(ToolsetBin)\chex  -o $(OutputPath)\$(TargetSName).s19 $(OutputPath)\$(TargetSName).sm8
clean : 
	-@erase $(OutputPath)\can_nm_osek.o
	-@erase $(OutputPath)\domelamp_drv.o
	-@erase $(OutputPath)\rke_key.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\timer2_3.o
	-@erase $(OutputPath)\stm8_adc.o
	-@erase $(OutputPath)\stm8_awu.o
	-@erase $(OutputPath)\stm8_clk.o
	-@erase $(OutputPath)\lin.o
	-@erase $(OutputPath)\stm8_exti.o
	-@erase $(OutputPath)\stm8_flash.o
	-@erase $(OutputPath)\stm8_gpio.o
	-@erase $(OutputPath)\stm8_itc.o
	-@erase $(OutputPath)\stm8_iwdg.o
	-@erase $(OutputPath)\stm8_linuart.o
	-@erase $(OutputPath)\stm8_rst.o
	-@erase $(OutputPath)\stm8_spi.o
	-@erase $(OutputPath)\stm8_usart.o
	-@erase $(OutputPath)\stm8_wwdg.o
	-@erase $(OutputPath)\adc_drv.o
	-@erase $(OutputPath)\can.o
	-@erase $(OutputPath)\defrost_drv.o
	-@erase $(OutputPath)\horn_drv.o
	-@erase $(OutputPath)\lock_drv.o
	-@erase $(OutputPath)\rke_drv1.o
	-@erase $(OutputPath)\st79_it.o
	-@erase $(OutputPath)\st79_tim4.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\sys_init.o
	-@erase $(OutputPath)\turnlamp_drv.o
	-@erase $(OutputPath)\warm_drv.o
	-@erase $(OutputPath)\window_drv.o
	-@erase $(OutputPath)\v1_0.elf
	-@erase $(OutputPath)\v1_0.elf
	-@erase $(OutputPath)\v1_0.map
	-@erase $(OutputPath)\can_nm_osek.ls
	-@erase $(OutputPath)\domelamp_drv.ls
	-@erase $(OutputPath)\rke_key.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\timer2_3.ls
	-@erase $(OutputPath)\stm8_adc.ls
	-@erase $(OutputPath)\stm8_awu.ls
	-@erase $(OutputPath)\stm8_clk.ls
	-@erase $(OutputPath)\lin.ls
	-@erase $(OutputPath)\stm8_exti.ls
	-@erase $(OutputPath)\stm8_flash.ls
	-@erase $(OutputPath)\stm8_gpio.ls
	-@erase $(OutputPath)\stm8_itc.ls
	-@erase $(OutputPath)\stm8_iwdg.ls
	-@erase $(OutputPath)\stm8_linuart.ls
	-@erase $(OutputPath)\stm8_rst.ls
	-@erase $(OutputPath)\stm8_spi.ls
	-@erase $(OutputPath)\stm8_usart.ls
	-@erase $(OutputPath)\stm8_wwdg.ls
	-@erase $(OutputPath)\adc_drv.ls
	-@erase $(OutputPath)\can.ls
	-@erase $(OutputPath)\defrost_drv.ls
	-@erase $(OutputPath)\horn_drv.ls
	-@erase $(OutputPath)\lock_drv.ls
	-@erase $(OutputPath)\rke_drv1.ls
	-@erase $(OutputPath)\st79_it.ls
	-@erase $(OutputPath)\st79_tim4.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\sys_init.ls
	-@erase $(OutputPath)\turnlamp_drv.ls
	-@erase $(OutputPath)\warm_drv.ls
	-@erase $(OutputPath)\window_drv.ls
endif
