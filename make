#
# (C) Copyright 2000-2007
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#
# See file CREDITS for list of people who contributed to this
# project.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#
include $(TOPDIR)/config.mk
LIB	:= $(obj)libusb_gadget.o
# new USB gadget layer dependencies
ifdef CONFIG_USB_ETHER
COBJS-y += ether.o epautoconf.o config.o usbstring.o
COBJS-$(CONFIG_USB_ETH_RNDIS) += rndis.o
else
# Devices not related to the new gadget layer depend on CONFIG_USB_DEVICE
ifdef CONFIG_USB_DEVICE
COBJS-y += core.o
COBJS-y += ep0.o
COBJS-$(CONFIG_OMAP1510) += omap1510_udc.o
COBJS-$(CONFIG_OMAP1610) += omap1510_udc.o
COBJS-$(CONFIG_MPC885_FAMILY) += mpc8xx_udc.o
COBJS-$(CONFIG_PXA27X) += pxa27x_udc.o
COBJS-$(CONFIG_SPEARUDC) += spr_udc.o
endif
endif
COBJS	:= $(COBJS-y)
SRCS	:= $(COBJS:.o=.c)
OBJS	:= $(addprefix $(obj),$(COBJS))
all:	$(LIB)
$(LIB):	$(obj).depend $(OBJS)
	$(call cmd_link_o_target, $(OBJS))
#########################################################################
# defines $(obj).depend target
include $(SRCTREE)/rules.mk
sinclude $(obj).depend
#########################################################################
