Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF221C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 12:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AF0C40A7F;
	Mon,  7 Jul 2025 13:59:00 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2016B406FF
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:58:55 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-01 (Coremail) with SMTP id qwCowAAXBqpetmtosYbMAQ--.21604S12;
 Mon, 07 Jul 2025 19:58:52 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 11/14] net/sxe: add custom cmd led ctrl
Date: Mon,  7 Jul 2025 07:58:16 -0400
Message-ID: <20250707115819.12826-11-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707115819.12826-1-liujie5@linkdatatechnology.com>
References: <20250704025401.301617-1-liujie5@linkdatatechnology.com>
 <20250707115819.12826-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAXBqpetmtosYbMAQ--.21604S12
X-Coremail-Antispam: 1UD129KBjvJXoW3CFy3tF4UZr1ktF15GryfWFg_yoWDAw45pF
 4rCr15Wa1fJF4Ska1fJF4DZF1rCa1qqFyUGF9F93ySvas2yr1UJr4qgF4qy34FvrW8GryI
 va12vFy5Gwn5Jw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
 CY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
 WUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
 Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
 WUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
 JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUfHUPUUUUU==
X-Originating-IP: [60.29.3.194]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Add custom cmd led ctrl.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/Makefile                |   2 +
 drivers/net/sxe/include/sxe/sxe_cli.h   | 218 ++++++++++++++++++++++++
 drivers/net/sxe/include/sxe/sxe_ioctl.h |  21 +++
 drivers/net/sxe/meson.build             |   2 +
 drivers/net/sxe/pf/sxe_main.c           |   3 +
 drivers/net/sxe/sxe_testpmd.c           |  65 +++++++
 6 files changed, 311 insertions(+)
 create mode 100644 drivers/net/sxe/include/sxe/sxe_cli.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_ioctl.h
 create mode 100644 drivers/net/sxe/sxe_testpmd.c

diff --git a/drivers/net/sxe/Makefile b/drivers/net/sxe/Makefile
index 4aa202e46d..fd46ce5456 100644
--- a/drivers/net/sxe/Makefile
+++ b/drivers/net/sxe/Makefile
@@ -55,6 +55,8 @@ $(shell cp $(SRCDIR)/include/*.h $(SRCDIR))
 $(shell cp $(SRCDIR)/include/sxe/*.h $(SRCDIR))
 $(warning "file copy done")
 
+SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_testpmd.c
+
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_common.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_hw.c
 SRCS-$(CONFIG_RTE_LIBRTE_SXE_PMD) += sxe_offload_common.c
diff --git a/drivers/net/sxe/include/sxe/sxe_cli.h b/drivers/net/sxe/include/sxe/sxe_cli.h
new file mode 100644
index 0000000000..8ffb14f68b
--- /dev/null
+++ b/drivers/net/sxe/include/sxe/sxe_cli.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_CLI_H__
+#define __SXE_CLI_H__
+
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+
+#define SXE_VERION_LEN				  (32)
+#define SXE_MAC_NUM					 (128)
+#define SXE_PORT_TRANSCEIVER_LEN		(32)
+#define SXE_PORT_VENDOR_LEN			 (32)
+#define SXE_CHIP_TYPE_LEN			   (32)
+#define SXE_VPD_SN_LEN				  (16)
+#define SXE_SOC_RST_TIME				(0x93A80)
+#define SXE_SFP_TEMP_THRESHOLD_INTERVAL (3)
+#define MGC_TERMLOG_INFO_MAX_LEN		(12 * 1024)
+#define SXE_REGS_DUMP_MAX_LEN		   (12 * 1024)
+#define SXE_PRODUCT_NAME_LEN		(32)
+
+typedef enum sxe_led_mode {
+	SXE_IDENTIFY_LED_BLINK_ON   = 0,
+	SXE_IDENTIFY_LED_BLINK_OFF,
+	SXE_IDENTIFY_LED_ON,
+	SXE_IDENTIFY_LED_OFF,
+	SXE_IDENTIFY_LED_RESET,
+} sxe_led_mode_s;
+
+typedef struct sxe_led_ctrl {
+	U32	mode;
+	U32	duration;
+
+} sxe_led_ctrl_s;
+
+typedef struct sxe_led_ctrl_resp {
+	U32	ack;
+} sxe_led_ctrl_resp_s;
+
+typedef enum port_link_speed {
+	PORT_LINK_NO			= 0,
+	PORT_LINK_100M		  = 1,
+	PORT_LINK_1G			= 2,
+	PORT_LINK_10G		   = 3,
+} port_link_speed_e;
+
+typedef struct sys_soc_info {
+	S8	 fw_ver[SXE_VERION_LEN];
+	S8	 opt_ver[SXE_VERION_LEN];
+	U8	 soc_status;
+	U8	 pad[3];
+	S32	soc_temp;
+	U64	chipid;
+	S8	 chip_type[SXE_CHIP_TYPE_LEN];
+	S8	 pba[SXE_VPD_SN_LEN];
+	S8	 product_name[SXE_PRODUCT_NAME_LEN];
+} sys_soc_info_s;
+
+typedef struct sys_port_info {
+	U64	mac[SXE_MAC_NUM];
+	U8	 is_port_abs;
+	U8	 link_stat;
+	U8	 link_speed;
+
+
+	U8	 is_sfp:1;
+	U8	 is_get_info:1;
+	U8	 rvd:6;
+	S8	 optical_mod_temp;
+	U8	 pad[3];
+	S8	 transceiver_type[SXE_PORT_TRANSCEIVER_LEN];
+	S8	 vendor_name[SXE_PORT_VENDOR_LEN];
+	S8	 vendor_pn[SXE_PORT_VENDOR_LEN];
+} sys_port_info_s;
+
+typedef struct sys_info_resp {
+	sys_soc_info_s	 soc_info;
+	sys_port_info_s	port_info;
+} sys_info_resp_s;
+
+typedef enum sfp_temp_td_mode {
+	SFP_TEMP_THRESHOLD_MODE_ALARM   = 0,
+	SFP_TEMP_THRESHOLD_MODE_WARN,
+} sfp_temp_td_mode_e;
+
+typedef struct sfp_temp_td_set {
+	U8	 mode;
+	U8	 pad[3];
+	S8	 hthreshold;
+	S8	 lthreshold;
+} sfp_temp_td_set_s;
+
+typedef struct sxe_log_export_resp {
+	U16	cur_log_len;
+	U8	 is_end;
+	U8	 pad;
+	S32	session_id;
+	S8	 data[0];
+} sxe_log_export_resp_s;
+
+typedef enum sxe_log_export_type  {
+	SXE_LOG_EXPORT_REQ	= 0,
+	SXE_LOG_EXPORT_FIN,
+	SXE_LOG_EXPORT_ABORT,
+} sxe_log_export_type_e;
+
+typedef struct sxe_log_export_req {
+	U8	 is_all_log;
+	U8	 cmdtype;
+	U8	 is_begin;
+	U8	 pad;
+	S32	session_id;
+	U32	log_len;
+} sxe_log_export_req_s;
+
+typedef struct soc_rst_req {
+	U32	time;
+} soc_rst_req_s;
+
+typedef struct regs_dump_resp {
+	U32	curdw_len;
+	U8	 data[0];
+} regs_dump_resp_s;
+
+enum {
+	SXE_MFG_PART_NUMBER_LEN   = 8,
+	SXE_MFG_SERIAL_NUMBER_LEN = 16,
+	SXE_MFG_REVISION_LEN	  = 4,
+	SXE_MFG_OEM_STR_LEN	   = 64,
+	SXE_MFG_SXE_BOARD_ASSEMBLY_LEN  = 32,
+	SXE_MFG_SXE_BOARD_TRACE_NUM_LEN = 16,
+	SXE_MFG_SXE_MAC_ADDR_CNT		= 2,
+};
+
+typedef struct sxe_mfg_info {
+	U8 part_number[SXE_MFG_PART_NUMBER_LEN];
+	U8 serial_number[SXE_MFG_SERIAL_NUMBER_LEN];
+	U32 mfg_date;
+	U8 revision[SXE_MFG_REVISION_LEN];
+	U32 rework_date;
+	U8 pad[4];
+	U64 mac_addr[SXE_MFG_SXE_MAC_ADDR_CNT];
+	U8 board_trace_num[SXE_MFG_SXE_BOARD_TRACE_NUM_LEN];
+	U8 board_assembly[SXE_MFG_SXE_BOARD_ASSEMBLY_LEN];
+	U8 extra1[SXE_MFG_OEM_STR_LEN];
+	U8 extra2[SXE_MFG_OEM_STR_LEN];
+} sxe_mfg_info_t;
+
+typedef struct sxe_lldp_info {
+	U8	  lldp_state;
+	U8	  pad[3];
+} sxe_lldp_info_t;
+
+typedef struct regs_dump_req {
+	U32	base_addr;
+	U32	dw_len;
+} regs_dump_req_s;
+
+typedef enum sxe_pcs_mode {
+	SXE_PCS_MODE_1000BASE_KX_WO = 0,
+	SXE_PCS_MODE_1000BASE_KX_W,
+	SXE_PCS_MODE_SGMII,
+	SXE_PCS_MODE_10GBASE_KR_WO,
+	SXE_PCS_MODE_AUTO_NEGT_73,
+	SXE_PCS_MODE_LPBK_PHY_TX2RX,
+	SXE_PCS_MODE_LPBK_PHY_RX2TX,
+	SXE_PCS_MODE_LPBK_PCS_RX2TX,
+	SXE_PCS_MODE_BUTT,
+} sxe_pcs_mode_e;
+
+typedef enum sxe_remote_fault_mode {
+	SXE_REMOTE_FALUT_NO_ERROR		= 0,
+	SXE_REMOTE_FALUT_OFFLINE,
+	SXE_REMOTE_FALUT_LINK_FAILURE,
+	SXE_REMOTE_FALUT_AUTO_NEGOTIATION,
+	SXE_REMOTE_UNKNOWN,
+} sxe_remote_fault_e;
+
+typedef struct sxe_phy_cfg {
+	sxe_pcs_mode_e mode;
+	U32 mtu;
+} sxe_pcs_cfg_s;
+
+typedef enum sxe_an_speed {
+	SXE_AN_SPEED_NO_LINK = 0,
+	SXE_AN_SPEED_100M,
+	SXE_AN_SPEED_1G,
+	SXE_AN_SPEED_10G,
+	SXE_AN_SPEED_UNKNOWN,
+} sxe_an_speed_e;
+
+typedef enum sxe_phy_pause_cap {
+	SXE_PAUSE_CAP_NO_PAUSE	= 0,
+	SXE_PAUSE_CAP_ASYMMETRIC_PAUSE,
+	SXE_PAUSE_CAP_SYMMETRIC_PAUSE,
+	SXE_PAUSE_CAP_BOTH_PAUSE,
+	SXE_PAUSE_CAP_UNKNOWN,
+} sxe_phy_pause_cap_e;
+
+typedef enum sxe_phy_duplex_type {
+	SXE_FULL_DUPLEX	= 0,
+	SXE_HALF_DUPLEX	= 1,
+	SXE_UNKNOWN_DUPLEX,
+} sxe_phy_duplex_type_e;
+
+typedef struct sxe_phy_an_cap {
+	sxe_remote_fault_e   remote_fault;
+	sxe_phy_pause_cap_e  pause_cap;
+	sxe_phy_duplex_type_e duplex_cap;
+} sxe_phy_an_cap_s;
+
+typedef struct sxe_an_cap {
+	sxe_phy_an_cap_s local;
+	sxe_phy_an_cap_s peer;
+} sxe_an_cap_s;
+#endif
diff --git a/drivers/net/sxe/include/sxe/sxe_ioctl.h b/drivers/net/sxe/include/sxe/sxe_ioctl.h
new file mode 100644
index 0000000000..4a4b0bc304
--- /dev/null
+++ b/drivers/net/sxe/include/sxe/sxe_ioctl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef _SXE_IOCTL_H_
+#define _SXE_IOCTL_H_
+
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+
+struct sxe_ioctl_sync_cmd {
+	U64   traceid;
+	void *in_data;
+	U32   in_len;
+	void *out_data;
+	U32   out_len;
+};
+
+#define SXE_CMD_IOCTL_SYNC_CMD _IOWR('M', 1, struct sxe_ioctl_sync_cmd)
+
+#endif
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index 71c4a9be92..0e89676375 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -30,6 +30,8 @@ sources = files(
         'base/sxe_hw.c',
 )
 
+testpmd_sources = files('sxe_testpmd.c')
+
 includes += include_directories('base')
 includes += include_directories('pf')
 includes += include_directories('include/sxe/')
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index bbee8035d6..85bd87d495 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -205,6 +205,9 @@ void sxe_hw_start(struct sxe_hw *hw)
 	sxe_hw_vlan_filter_array_clear(hw);
 
 	sxe_hw_stats_regs_clean(hw);
+
+	sxe_hw_no_snoop_disable(hw);
+
 	sxe_hw_dcb_rate_limiter_clear(hw, SXE_TXRX_RING_NUM_MAX);
 
 	sxe_fc_autoneg_localcap_set(hw);
diff --git a/drivers/net/sxe/sxe_testpmd.c b/drivers/net/sxe/sxe_testpmd.c
new file mode 100644
index 0000000000..253170df11
--- /dev/null
+++ b/drivers/net/sxe/sxe_testpmd.c
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include "sxe_ethdev.h"
+#include "rte_pmd_sxe.h"
+
+#include <cmdline_parse_etheraddr.h>
+#include <cmdline_parse_num.h>
+#include <cmdline_parse_string.h>
+
+#include "testpmd.h"
+
+struct led_ctrl_result {
+	cmdline_fixed_string_t port;
+	uint16_t port_id;
+	cmdline_fixed_string_t led;
+	cmdline_fixed_string_t action;
+};
+
+cmdline_parse_token_string_t cmd_led_ctrl_port =
+	TOKEN_STRING_INITIALIZER(struct led_ctrl_result, port, "port");
+cmdline_parse_token_num_t cmd_led_ctrl_port_id =
+	TOKEN_NUM_INITIALIZER(struct led_ctrl_result, port_id, RTE_UINT16);
+cmdline_parse_token_string_t cmd_led_ctrl_led =
+	TOKEN_STRING_INITIALIZER(struct led_ctrl_result, led, "led");
+cmdline_parse_token_string_t cmd_led_ctrl_action =
+	TOKEN_STRING_INITIALIZER(struct led_ctrl_result, action, "on#off");
+
+static void cmd_led_ctrl_parsed(void *parsed_result,
+			__rte_unused struct cmdline *cl,
+			__rte_unused void *data)
+{
+	struct led_ctrl_result *res = parsed_result;
+
+	if (strcmp(res->action, "on") == 0)
+		rte_eth_led_on(res->port_id);
+	else
+		rte_eth_led_off(res->port_id);
+}
+
+cmdline_parse_inst_t  cmd_led_ctrl = {
+	.f = cmd_led_ctrl_parsed,
+	.data = NULL,
+	.help_str = "port <port_id> led on|off",
+	.tokens = {
+		(void *)&cmd_led_ctrl_port,
+		(void *)&cmd_led_ctrl_port_id,
+		(void *)&cmd_led_ctrl_led,
+		(void *)&cmd_led_ctrl_action,
+		NULL,
+	},
+};
+
+static struct testpmd_driver_commands sxe_cmds = {
+	.commands = {
+		{
+			&cmd_led_ctrl,
+			"port <port_id> led on|off\n"
+			"	Set led on or off.\n",
+		},
+		{ NULL, NULL },
+	},
+};
+TESTPMD_ADD_DRIVER_COMMANDS(sxe_cmds)
-- 
2.18.4

