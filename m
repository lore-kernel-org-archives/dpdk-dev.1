Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A62EF06E2
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 11:56:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 249564064E;
	Sun,  8 Feb 2026 12:55:39 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E0D25402E8
 for <dev@dpdk.org>; Sun,  8 Feb 2026 12:55:31 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-05 (Coremail) with SMTP id zQCowAD3iAyveYhp1svKBw--.57133S12;
 Sun, 08 Feb 2026 19:55:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v15 11/13] net/sxe: add custom cmd led ctrl
Date: Sun,  8 Feb 2026 19:55:24 +0800
Message-Id: <20260208115526.146104-11-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260208115526.146104-1-liujie5@linkdatatechnology.com>
References: <20260208093122.10329-13-liujie5@linkdatatechnology.com>
 <20260208115526.146104-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: zQCowAD3iAyveYhp1svKBw--.57133S12
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4rtrWruFykZF1kWF18AFb_yoWfXF48pF
 45Cr15W3WfJFyIka1fJF4DZF1rCa1jqFWDWF9F9w4Svas2yr1UJF4qgFsIy34Fv3y8Gry2
 va12vFy5Kwn5K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 kIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
 6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
 v_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
 c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
 v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
 0JUf739UUUUU=
X-Originating-IP: [221.238.36.162]
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add custom cmd led ctrl.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe/include/sxe/sxe_cli.h   | 218 ++++++++++++++++++++++++
 drivers/net/sxe/include/sxe/sxe_ioctl.h |  21 +++
 drivers/net/sxe/sxe_testpmd.c           |  66 +++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/net/sxe/include/sxe/sxe_cli.h
 create mode 100644 drivers/net/sxe/include/sxe/sxe_ioctl.h
 create mode 100644 drivers/net/sxe/sxe_testpmd.c

diff --git a/drivers/net/sxe/include/sxe/sxe_cli.h b/drivers/net/sxe/include/sxe/sxe_cli.h
new file mode 100644
index 0000000000..b278a67907
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
+#define SXE_CODE_VERSION_LEN			(32)
+#define SXE_MAC_NUM				(128)
+#define SXE_PORT_TRANSCEIVER_LEN		(32)
+#define SXE_PORT_VENDOR_LEN			(32)
+#define SXE_CHIP_TYPE_LEN			(32)
+#define SXE_VPD_SN_LEN				(16)
+#define SXE_SOC_RST_TIME			(0x93A80)
+#define SXE_SFP_TEMP_THRESHOLD_INTERVAL		(3)
+#define MGC_TERMLOG_INFO_MAX_LEN		(12 * 1024)
+#define SXE_REGS_DUMP_MAX_LEN			(12 * 1024)
+#define SXE_PRODUCT_NAME_LEN			(32)
+
+typedef enum sxe_led_mode {
+	SXE_IDENTIFY_LED_BLINK_ON = 0,
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
+	PORT_LINK_NO	= 0,
+	PORT_LINK_100M	= 1,
+	PORT_LINK_1G	= 2,
+	PORT_LINK_10G	= 3,
+} port_link_speed_e;
+
+typedef struct sys_soc_info {
+	S8	fw_ver[SXE_CODE_VERSION_LEN];
+	S8	opt_ver[SXE_CODE_VERSION_LEN];
+	U8	soc_status;
+	U8	pad[3];
+	S32	soc_temp;
+	U64	chipid;
+	S8	chip_type[SXE_CHIP_TYPE_LEN];
+	S8	pba[SXE_VPD_SN_LEN];
+	S8	product_name[SXE_PRODUCT_NAME_LEN];
+} sys_soc_info_s;
+
+typedef struct sys_port_info {
+	U64	mac[SXE_MAC_NUM];
+	U8	is_port_abs;
+	U8	link_stat;
+	U8	link_speed;
+
+
+	U8	is_sfp:1;
+	U8	is_get_info:1;
+	U8	rvd:6;
+	S8	optical_mod_temp;
+	U8	pad[3];
+	S8	transceiver_type[SXE_PORT_TRANSCEIVER_LEN];
+	S8	vendor_name[SXE_PORT_VENDOR_LEN];
+	S8	vendor_pn[SXE_PORT_VENDOR_LEN];
+} sys_port_info_s;
+
+typedef struct sys_info_resp {
+	sys_soc_info_s	soc_info;
+	sys_port_info_s	port_info;
+} sys_info_resp_s;
+
+typedef enum sfp_temp_td_mode {
+	SFP_TEMP_THRESHOLD_MODE_ALARM   = 0,
+	SFP_TEMP_THRESHOLD_MODE_WARN,
+} sfp_temp_td_mode_e;
+
+typedef struct sfp_temp_td_set {
+	U8	mode;
+	U8	pad[3];
+	S8	hthreshold;
+	S8	lthreshold;
+} sfp_temp_td_set_s;
+
+typedef struct sxe_log_export_resp {
+	U16	cur_log_len;
+	U8	is_end;
+	U8	pad;
+	S32	session_id;
+	S8	data[0];
+} sxe_log_export_resp_s;
+
+typedef enum sxe_log_export_type  {
+	SXE_LOG_EXPORT_REQ	= 0,
+	SXE_LOG_EXPORT_FIN,
+	SXE_LOG_EXPORT_ABORT,
+} sxe_log_export_type_e;
+
+typedef struct sxe_log_export_req {
+	U8	is_all_log;
+	U8	cmdtype;
+	U8	is_begin;
+	U8	pad;
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
+	U8	data[0];
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
+	U8	lldp_state;
+	U8	pad[3];
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
diff --git a/drivers/net/sxe/sxe_testpmd.c b/drivers/net/sxe/sxe_testpmd.c
new file mode 100644
index 0000000000..6974bfe002
--- /dev/null
+++ b/drivers/net/sxe/sxe_testpmd.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include "sxe_drv_type.h"
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
2.18.2

