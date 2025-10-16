Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD6FCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36A8A4278C;
	Thu, 16 Oct 2025 12:28:19 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2428F41104
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:28:11 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 04EBA1A270E;
 Thu, 16 Oct 2025 12:28:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C3671A270D;
 Thu, 16 Oct 2025 12:28:10 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 20381180007D;
 Thu, 16 Oct 2025 18:28:10 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 07/15] drivers: dpaa2 upgrade fslmc base FW to 10.39.0
Date: Thu, 16 Oct 2025 15:57:57 +0530
Message-ID: <20251016102805.2453687-8-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

This patch upgrades the MC firmware release API compatibility
to 10.39.0.
the main changes are:
dpni - dpmac stats APIs
RTC - default 1588 clock config support

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h |  1 +
 drivers/bus/fslmc/mc/dpbp.c          | 78 +++++++++++++++++++++++++++-
 drivers/bus/fslmc/mc/dprc.c          |  2 +
 drivers/bus/fslmc/mc/fsl_dpbp.h      | 41 ++++++++++++++-
 drivers/bus/fslmc/mc/fsl_dpmng.h     |  4 +-
 drivers/bus/fslmc/mc/fsl_dprc.h      |  1 +
 drivers/net/dpaa2/dpaa2_mux.c        |  8 +--
 drivers/net/dpaa2/mc/dpkg.c          |  7 ++-
 drivers/net/dpaa2/mc/dprtc.c         | 38 +++++++++++++-
 drivers/net/dpaa2/mc/fsl_dpdmux.h    | 13 +++--
 drivers/net/dpaa2/mc/fsl_dpkg.h      |  7 ++-
 drivers/net/dpaa2/mc/fsl_dpni.h      | 29 +++++++++--
 drivers/net/dpaa2/mc/fsl_dprtc.h     | 39 +++++++++++++-
 drivers/net/dpaa2/mc/fsl_dprtc_cmd.h |  7 ++-
 14 files changed, 249 insertions(+), 26 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 442de1a3fb..928193f0c0 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -81,6 +81,7 @@ enum rte_dpaa2_dev_type {
 	DPAA2_MPORTAL,  /**< DPMCP type device */
 	DPAA2_QDMA,     /**< DPDMAI type device */
 	DPAA2_MUX,	/**< DPDMUX type device */
+	DPAA2_SW,       /**< DPSW type device */
 	DPAA2_DPRTC,	/**< DPRTC type device */
 	DPAA2_DPRC,	/**< DPRC type device */
 	DPAA2_MAC,	/**< DPMAC type device */
diff --git a/drivers/bus/fslmc/mc/dpbp.c b/drivers/bus/fslmc/mc/dpbp.c
index 08f24d33e8..5529a1fe9c 100644
--- a/drivers/bus/fslmc/mc/dpbp.c
+++ b/drivers/bus/fslmc/mc/dpbp.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2017 NXP
+ * Copyright 2016-2017, 2025 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -362,3 +362,79 @@ int dpbp_get_num_free_bufs(struct fsl_mc_io *mc_io,
 
 	return 0;
 }
+
+/**
+ * dpbp_set_notifications() - Set notifications towards software
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPBP object
+ * @cfg:	notifications configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_set_notifications)
+int dpbp_set_notifications(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags,
+	uint16_t token,
+	struct dpbp_notification_cfg *cfg)
+{
+	struct dpbp_cmd_set_notifications *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPBP_CMDID_SET_NOTIFICATIONS,
+			cmd_flags, token);
+	cmd_params = (struct dpbp_cmd_set_notifications *)cmd.params;
+	cmd_params->depletion_entry = cpu_to_le32(cfg->depletion_entry);
+	cmd_params->depletion_exit = cpu_to_le32(cfg->depletion_exit);
+	cmd_params->surplus_entry = cpu_to_le32(cfg->surplus_entry);
+	cmd_params->surplus_exit = cpu_to_le32(cfg->surplus_exit);
+	cmd_params->options = cpu_to_le32(cfg->options);
+	cmd_params->message_ctx = cpu_to_le64(cfg->message_ctx);
+	cmd_params->message_iova = cpu_to_le64(cfg->message_iova);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpbp_get_notifications() - Get the notifications configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPBP object
+ * @cfg:	notifications configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_notifications)
+int dpbp_get_notifications(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags,
+	uint16_t token,
+	struct dpbp_notification_cfg *cfg)
+{
+	struct dpbp_rsp_get_notifications *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPBP_CMDID_GET_NOTIFICATIONS,
+			  cmd_flags,
+			  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpbp_rsp_get_notifications *)cmd.params;
+	cfg->depletion_entry = le32_to_cpu(rsp_params->depletion_entry);
+	cfg->depletion_exit = le32_to_cpu(rsp_params->depletion_exit);
+	cfg->surplus_entry = le32_to_cpu(rsp_params->surplus_entry);
+	cfg->surplus_exit = le32_to_cpu(rsp_params->surplus_exit);
+	cfg->options = le32_to_cpu(rsp_params->options);
+	cfg->message_ctx = le64_to_cpu(rsp_params->message_ctx);
+	cfg->message_iova = le64_to_cpu(rsp_params->message_iova);
+
+	return 0;
+}
diff --git a/drivers/bus/fslmc/mc/dprc.c b/drivers/bus/fslmc/mc/dprc.c
index 491081c7c8..5f04ead20c 100644
--- a/drivers/bus/fslmc/mc/dprc.c
+++ b/drivers/bus/fslmc/mc/dprc.c
@@ -8,6 +8,7 @@
 #include <fsl_mc_cmd.h>
 #include <fsl_dprc.h>
 #include <fsl_dprc_cmd.h>
+#include <eal_export.h>
 
 /** @addtogroup dprc
  * @{
@@ -90,6 +91,7 @@ int dprc_close(struct fsl_mc_io *mc_io,
  *
  * Return:     '0' on Success; -ENAVAIL if connection does not exist.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(dprc_get_connection)
 int dprc_get_connection(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
diff --git a/drivers/bus/fslmc/mc/fsl_dpbp.h b/drivers/bus/fslmc/mc/fsl_dpbp.h
index 8a021f55f1..c79b511715 100644
--- a/drivers/bus/fslmc/mc/fsl_dpbp.h
+++ b/drivers/bus/fslmc/mc/fsl_dpbp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2017 NXP
+ * Copyright 2016-2017, 2025 NXP
  *
  */
 #ifndef __FSL_DPBP_H
@@ -16,6 +16,34 @@
 
 struct fsl_mc_io;
 
+/**
+ * struct dpbp_notification_cfg - Structure representing DPBP notifications
+ *	towards software
+ * @depletion_entry: below this threshold the pool is "depleted";
+ *	set it to '0' to disable it
+ * @depletion_exit: greater than or equal to this threshold the pool exit its
+ *	"depleted" state
+ * @surplus_entry: above this threshold the pool is in "surplus" state;
+ *	set it to '0' to disable it
+ * @surplus_exit: less than or equal to this threshold the pool exit its
+ *	"surplus" state
+ * @message_iova: MUST be given if either 'depletion_entry' or 'surplus_entry'
+ *	is not '0' (enable); I/O virtual address (must be in DMA-able memory),
+ *	must be 16B aligned.
+ * @message_ctx: The context that will be part of the BPSCN message and will
+ *	be written to 'message_iova'
+ * @options: Mask of available options; use 'DPBP_NOTIF_OPT_<X>' values
+ */
+struct dpbp_notification_cfg {
+	uint32_t depletion_entry;
+	uint32_t depletion_exit;
+	uint32_t surplus_entry;
+	uint32_t surplus_exit;
+	uint64_t message_iova;
+	uint64_t message_ctx;
+	uint32_t options;
+};
+
 __rte_internal
 int dpbp_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
@@ -25,7 +53,18 @@ int dpbp_open(struct fsl_mc_io *mc_io,
 int dpbp_close(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token);
+__rte_internal
+int dpbp_set_notifications(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token,
+		struct dpbp_notification_cfg *cfg);
+__rte_internal
+int dpbp_get_notifications(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token,
+		struct dpbp_notification_cfg *cfg);
 
+#define DPBP_NOTIF_OPT_WRIOP               0x00010000
 /**
  * struct dpbp_cfg - Structure representing DPBP configuration
  * @options:	place holder
diff --git a/drivers/bus/fslmc/mc/fsl_dpmng.h b/drivers/bus/fslmc/mc/fsl_dpmng.h
index dfa51b3a86..a7578766e0 100644
--- a/drivers/bus/fslmc/mc/fsl_dpmng.h
+++ b/drivers/bus/fslmc/mc/fsl_dpmng.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2015 Freescale Semiconductor Inc.
- * Copyright 2017-2023 NXP
+ * Copyright 2017-2024 NXP
  *
  */
 #ifndef __FSL_DPMNG_H
@@ -20,7 +20,7 @@ struct fsl_mc_io;
  * Management Complex firmware version information
  */
 #define MC_VER_MAJOR 10
-#define MC_VER_MINOR 37
+#define MC_VER_MINOR 39
 
 /**
  * struct mc_version
diff --git a/drivers/bus/fslmc/mc/fsl_dprc.h b/drivers/bus/fslmc/mc/fsl_dprc.h
index 177210c2d4..8c9e482d26 100644
--- a/drivers/bus/fslmc/mc/fsl_dprc.h
+++ b/drivers/bus/fslmc/mc/fsl_dprc.h
@@ -37,6 +37,7 @@ struct dprc_endpoint {
 	uint16_t if_id;
 };
 
+__rte_internal
 int dprc_get_connection(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 1908d1e865..9bb1bbca38 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -524,10 +524,12 @@ dpaa2_create_dpdmux_device(int vdev_fd __rte_unused,
 				      __func__);
 			goto init_err;
 		}
-		skip_reset_flags = DPDMUX_SKIP_DEFAULT_INTERFACE
-			| DPDMUX_SKIP_UNICAST_RULES | DPDMUX_SKIP_MULTICAST_RULES;
+		skip_reset_flags = DPDMUX_SKIP_MODIFY_DEFAULT_INTERFACE
+			| DPDMUX_SKIP_UNICAST_RULES | DPDMUX_SKIP_MULTICAST_RULES |
+			DPDMUX_SKIP_RESET_DEFAULT_INTERFACE;
 	} else {
-		skip_reset_flags = DPDMUX_SKIP_DEFAULT_INTERFACE;
+		skip_reset_flags = DPDMUX_SKIP_MODIFY_DEFAULT_INTERFACE |
+			DPDMUX_SKIP_RESET_DEFAULT_INTERFACE;
 	}
 
 	ret = dpdmux_get_api_version(&dpdmux_dev->dpdmux, CMD_PRI_LOW,
diff --git a/drivers/net/dpaa2/mc/dpkg.c b/drivers/net/dpaa2/mc/dpkg.c
index 5db3d092c1..280c1b0764 100644
--- a/drivers/net/dpaa2/mc/dpkg.c
+++ b/drivers/net/dpaa2/mc/dpkg.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
- * Copyright 2017-2021, 2023 NXP
+ * Copyright 2017-2021, 2023-2024 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -20,8 +20,7 @@
  *	- dpkg_prepare_key_cfg()
  */
 int
-dpkg_prepare_key_cfg(const struct dpkg_profile_cfg *cfg,
-	void *key_cfg_buf)
+dpkg_prepare_key_cfg(const struct dpkg_profile_cfg *cfg, uint8_t *key_cfg_buf)
 {
 	int i, j;
 	struct dpni_ext_set_rx_tc_dist *dpni_ext;
@@ -30,7 +29,7 @@ dpkg_prepare_key_cfg(const struct dpkg_profile_cfg *cfg,
 	if (cfg->num_extracts > DPKG_MAX_NUM_OF_EXTRACTS)
 		return -EINVAL;
 
-	dpni_ext = key_cfg_buf;
+	dpni_ext = (struct dpni_ext_set_rx_tc_dist *)key_cfg_buf;
 	dpni_ext->num_extracts = cfg->num_extracts;
 
 	for (i = 0; i < cfg->num_extracts; i++) {
diff --git a/drivers/net/dpaa2/mc/dprtc.c b/drivers/net/dpaa2/mc/dprtc.c
index 36e62eb0c3..18f23e2fe3 100644
--- a/drivers/net/dpaa2/mc/dprtc.c
+++ b/drivers/net/dpaa2/mc/dprtc.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
- * Copyright 2019-2021 NXP
+ * Copyright 2019-2024 NXP
  */
 #include <fsl_mc_sys.h>
 #include <fsl_mc_cmd.h>
@@ -329,6 +329,42 @@ int dprtc_set_clock_offset(struct fsl_mc_io *mc_io,
 	return mc_send_command(mc_io, &cmd);
 }
 
+/**
+ * dprtc_get_clock_offset() - Gets the clock's offset
+ * (usually relative to another clock).
+ *
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPRTC object
+ * @offset:	Returned clock offset (in nanoseconds).
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dprtc_get_clock_offset(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   int64_t *offset)
+{
+	struct dprtc_rsp_get_clock_offset *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_GET_CLOCK_OFFSET,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dprtc_rsp_get_clock_offset *)cmd.params;
+	*offset = le64_to_cpu(rsp_params->offset);
+
+	return 0;
+}
+
 /**
  * dprtc_set_freq_compensation() - Sets a new frequency compensation value.
  *
diff --git a/drivers/net/dpaa2/mc/fsl_dpdmux.h b/drivers/net/dpaa2/mc/fsl_dpdmux.h
index 97b09e59f9..2db4abf234 100644
--- a/drivers/net/dpaa2/mc/fsl_dpdmux.h
+++ b/drivers/net/dpaa2/mc/fsl_dpdmux.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2018-2023 NXP
+ * Copyright 2018-2024 NXP
  *
  */
 #ifndef __FSL_DPDMUX_H
@@ -53,6 +53,9 @@ int dpdmux_close(struct fsl_mc_io *mc_io,
  */
 #define DPDMUX_IRQ_EVENT_LINK_CHANGED	0x0001
 
+/* DPDMUX_IRQ_EVENT_ENDPOINT_CHANGED - indicates a change in endpoint */
+#define DPDMUX_IRQ_EVENT_ENDPOINT_CHANGED	0x0002
+
 /**
  * enum dpdmux_manip - DPDMUX manipulation operations
  * @DPDMUX_MANIP_NONE:	No manipulation on frames
@@ -143,15 +146,15 @@ int dpdmux_reset(struct fsl_mc_io *mc_io,
 		 uint16_t token);
 
 /**
- *Setting 1 DPDMUX_RESET will not reset default interface
+ *Setting 1 DPDMUX_RESET will not modify default interface after reset
  */
-#define DPDMUX_SKIP_DEFAULT_INTERFACE	0x01
+#define DPDMUX_SKIP_MODIFY_DEFAULT_INTERFACE	0x01
 /**
- *Setting 1 DPDMUX_RESET will not reset unicast rules
+ *Setting 2 DPDMUX_RESET will not reset unicast rules
  */
 #define DPDMUX_SKIP_UNICAST_RULES	0x02
 /**
- *Setting 1 DPDMUX_RESET will not reset multicast rules
+ *Setting 3 DPDMUX_RESET will not reset multicast rules
  */
 #define DPDMUX_SKIP_MULTICAST_RULES	0x04
 /**
diff --git a/drivers/net/dpaa2/mc/fsl_dpkg.h b/drivers/net/dpaa2/mc/fsl_dpkg.h
index 834c765513..19fbae224b 100644
--- a/drivers/net/dpaa2/mc/fsl_dpkg.h
+++ b/drivers/net/dpaa2/mc/fsl_dpkg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  * Copyright 2013-2015 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2024 NXP
  *
  */
 #ifndef __FSL_DPKG_H_
@@ -180,8 +180,7 @@ struct dpni_ext_set_rx_tc_dist {
 	struct dpni_dist_extract extracts[DPKG_MAX_NUM_OF_EXTRACTS];
 };
 
-int
-dpkg_prepare_key_cfg(const struct dpkg_profile_cfg *cfg,
-	void *key_cfg_buf);
+int dpkg_prepare_key_cfg(const struct dpkg_profile_cfg *cfg,
+			 uint8_t *key_cfg_buf);
 
 #endif /* __FSL_DPKG_H_ */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 3a5fcfa8a5..e2b18f7468 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -296,6 +296,9 @@ int dpni_reset(struct fsl_mc_io *mc_io,
  */
 #define DPNI_IRQ_EVENT_LINK_CHANGED		0x00000001
 
+/* DPNI_IRQ_EVENT_ENDPOINT_CHANGED - indicates a change in endpoint */
+#define DPNI_IRQ_EVENT_ENDPOINT_CHANGED       0x00000002
+
 int dpni_set_irq_enable(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -574,8 +577,9 @@ int dpni_set_buffer_layout(struct fsl_mc_io *mc_io,
  * @DPNI_OFF_RX_L4_CSUM: Rx L4 checksum validation
  * @DPNI_OFF_TX_L3_CSUM: Tx L3 checksum generation
  * @DPNI_OFF_TX_L4_CSUM: Tx L4 checksum generation
- * @DPNI_OPT_FLCTYPE_HASH: flow context will be generated by WRIOP for AIOP or
- *			   for CPU
+ * @DPNI_OPT_FLCTYPE_HASH: flow context will be generated by WRIOP for AIOP or for CPU
+ * @DPNI_HEADER_STASHING: frame header will be stashed by WRIOP in core cache
+ * @DPNI_PAYLOAD_STASHING: frame payload will be stashed by WRIOP in core cache
  */
 enum dpni_offload {
 	DPNI_OFF_RX_L3_CSUM,
@@ -631,6 +635,7 @@ int dpni_get_tx_data_offset(struct fsl_mc_io *mc_io,
 			    uint16_t *data_offset);
 
 #define DPNI_STATISTICS_CNT		7
+#define DPNI_STATISTICS_32_CNT		14
 
 /**
  * union dpni_statistics - Union describing the DPNI statistics
@@ -986,7 +991,18 @@ struct dpni_tx_schedule_cfg {
  * struct dpni_tx_priorities_cfg - Structure representing transmission
  *					priorities for DPNI TCs
  * @channel_idx: channel to perform the configuration
- * @tc_sched:	An array of traffic-classes
+ * @tc_sched: An array of traffic-classes which should be used in the
+ * following way:
+ *   - If max_tx_tcs <= 8: the tc_sched[n] struct will host the configuration
+ *   requested for TC#n
+ *   - If max_tx_tcs > 8: the tc_sched[n] struct will host the configuration
+ *   requested for TC#(8 + n). In this case, the first 8 TCs are configured by
+ *   MC in strict priority order and cannot be changed.
+ *   The only accepted configuration in this case is:
+ *    - TCs [8-12) will be part of WEIGHTED_A group
+ *    - TCs [12-16) will be part of WEIGHTED_B group
+ *   Any other configuration will get rejected by the MC firmware. The
+ *   delta_bandwidth for each TC can be used as usual.
  * @prio_group_A: Priority of group A
  * @prio_group_B: Priority of group B
  * @separate_groups: Treat A and B groups as separate
@@ -1949,6 +1965,10 @@ int dpni_get_custom_tpid(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t t
  *	@peer_delay: For peer-to-peer transparent clocks add this value to the
  *		correction field in addition to the transient time update. The
  *		value expresses nanoseconds.
+ *	@ptp_onestep_reg_base: 1588 SINGLE_STEP register base address. This address
+ *			  is used to update directly the register contents.
+ *			  User has to create an address mapping for it.
+ *			  It's used  in dpni_get_single_step_cfg only.
  */
 struct dpni_single_step_cfg {
 	uint8_t en;
@@ -2014,4 +2034,7 @@ int dpni_set_sp_profile(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t to
 int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 		uint8_t type, uint8_t en);
 
+int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dprtc.h b/drivers/net/dpaa2/mc/fsl_dprtc.h
index 84ab158444..06ff8ecb19 100644
--- a/drivers/net/dpaa2/mc/fsl_dprtc.h
+++ b/drivers/net/dpaa2/mc/fsl_dprtc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
- * Copyright 2019-2021 NXP
+ * Copyright 2019-2024 NXP
  */
 #ifndef __FSL_DPRTC_H
 #define __FSL_DPRTC_H
@@ -11,6 +11,38 @@
 
 struct fsl_mc_io;
 
+/**
+ * Number of irq's
+ */
+#define DPRTC_MAX_IRQ_NUM			1
+#define DPRTC_IRQ_INDEX				0
+
+/**
+ * Interrupt event masks:
+ */
+
+/**
+ * Interrupt event mask indicating alarm event had occurred
+ */
+#define DPRTC_EVENT_ALARM			0x40000000
+/**
+ * Interrupt event mask indicating periodic pulse 1 event had occurred
+ */
+#define DPRTC_EVENT_PPS				0x08000000
+/**
+ * Interrupt event mask indicating periodic pulse 2 event had occurred
+ */
+#define DPRTC_EVENT_PPS2            0x04000000
+/**
+ * Interrupt event mask indicating External trigger 1 new timestamp sample event had occurred
+ */
+#define DPRTC_EVENT_ETS1			0x00800000
+/**
+ * Interrupt event mask indicating External trigger 2 new timestamp sample event had occurred
+ */
+#define DPRTC_EVENT_ETS2			0x00400000
+
+
 int dprtc_open(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       int dprtc_id,
@@ -61,6 +93,11 @@ int dprtc_set_clock_offset(struct fsl_mc_io *mc_io,
 			   uint16_t token,
 			   int64_t offset);
 
+int dprtc_get_clock_offset(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   int64_t *offset);
+
 int dprtc_set_freq_compensation(struct fsl_mc_io *mc_io,
 		  uint32_t cmd_flags,
 		  uint16_t token,
diff --git a/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h b/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
index 61aaa4daab..eaefe18460 100644
--- a/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dprtc_cmd.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
- * Copyright 2019-2021 NXP
+ * Copyright 2019-2024 NXP
  */
 #include <fsl_mc_sys.h>
 #ifndef _FSL_DPRTC_CMD_H
@@ -42,6 +42,7 @@
 #define DPRTC_CMDID_CLEAR_EXT_TRIGGER		DPRTC_CMD(0x1d9)
 #define DPRTC_CMDID_GET_EXT_TRIGGER_TIMESTAMP	DPRTC_CMD(0x1dA)
 #define DPRTC_CMDID_SET_FIPER_LOOPBACK	DPRTC_CMD(0x1dB)
+#define DPRTC_CMDID_GET_CLOCK_OFFSET		DPRTC_CMD(0x1dC)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPRTC_MASK(field)        \
@@ -78,6 +79,10 @@ struct dprtc_cmd_set_clock_offset {
 	uint64_t offset;
 };
 
+struct dprtc_rsp_get_clock_offset {
+	uint64_t offset;
+};
+
 struct dprtc_get_freq_compensation {
 	uint32_t freq_compensation;
 };
-- 
2.43.0

