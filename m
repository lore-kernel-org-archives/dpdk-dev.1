Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6176AC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:55:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC7E402BA;
	Tue, 22 Sep 2026 11:55:40 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2294270A
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:55:35 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F216B200019;
 Tue, 22 Sep 2026 11:55:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BC5A1200007;
 Tue, 22 Sep 2026 11:55:34 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6270818000BA;
 Tue, 22 Sep 2026 17:55:33 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4-S2 03/13] net/dpaa2: support larger burst size
Date: Tue, 22 Sep 2026 15:25:18 +0530
Message-ID: <20260922095528.2469885-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Make burst size checks and MC command fields SoC-aware,
enabling bursts larger than 64K on LX2160A with dpni version 8.7+.

The max_burst_size field in dpni_tx_shaping_cfg is widened to uint32_t
and the MC command struct is updated to split the value across two
16-bit fields using the new DPNI_BURST_LO/HI macros.

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h    |  2 ++
 drivers/net/dpaa2/dpaa2_tm.c        | 17 ++++++++++++-----
 drivers/net/dpaa2/mc/dpni.c         | 11 +++++++++--
 drivers/net/dpaa2/mc/fsl_dpni.h     |  5 +++--
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  6 +++++-
 5 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 149954fb6b..bec1096850 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -462,6 +462,8 @@ struct dpaa2_dev_priv {
 
 #define DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR	8
 #define DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR	6
+#define DPNI_TX_BURST_LARGE_VER_MAJOR		8
+#define DPNI_TX_BURST_LARGE_VER_MINOR		7
 
 static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
 					 uint16_t ver_major, uint16_t ver_minor)
diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index 36e815c356..0275c2a010 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2024 NXP
+ * Copyright 2020-2026 NXP
  */
 
 #include <rte_ethdev.h>
@@ -10,14 +10,21 @@
 #include "dpaa2_pmd_logs.h"
 #include <dpaa2_hw_dpio.h>
 
-#define DPAA2_BURST_MAX	(64 * 1024)
-
 #define DPAA2_SHAPER_MIN_RATE 0
 #define DPAA2_SHAPER_MAX_RATE 107374182400ull
 #define DPAA2_WEIGHT_MAX 24701
 #define DPAA2_PKT_ADJUST_LEN_MIN 0
 #define DPAA2_PKT_ADJUST_LEN_MAX 0x7ff
 
+static inline uint32_t dpaa2_get_burst_max(struct dpaa2_dev_priv *priv)
+{
+	if (dpaa2_dev_cmp_dpni_ver(priv, DPNI_TX_BURST_LARGE_VER_MAJOR,
+				   DPNI_TX_BURST_LARGE_VER_MINOR) >= 0)
+		return (dpaa2_svr_family == SVR_LX2160A) ? 0x37FFF : 0xF7FF;
+
+	return 0xF7FF;
+}
+
 int
 dpaa2_tm_init(struct rte_eth_dev *dev)
 {
@@ -283,7 +290,7 @@ dpaa2_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 				RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_RATE,
 				NULL, "committed rate is out of range\n");
 
-	if (params->committed.size > DPAA2_BURST_MAX)
+	if (params->committed.size > dpaa2_get_burst_max(priv))
 		return -rte_tm_error_set(error, EINVAL,
 				RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_SIZE,
 				NULL, "committed size is out of range\n");
@@ -293,7 +300,7 @@ dpaa2_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 				RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_RATE,
 				NULL, "Peak rate is out of range\n");
 
-	if (params->peak.size > DPAA2_BURST_MAX)
+	if (params->peak.size > dpaa2_get_burst_max(priv))
 		return -rte_tm_error_set(error, EINVAL,
 				RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_SIZE,
 				NULL, "Peak size is out of range\n");
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index d0a9fefd31..17275b7195 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -1106,6 +1106,7 @@ int dpni_set_tx_shaping(struct fsl_mc_io *mc_io,
 {
 	struct dpni_cmd_set_tx_shaping *cmd_params;
 	struct mc_command cmd = { 0 };
+	uint32_t tx_cr_burst, tx_er_burst;
 	int coupled, lni_shaper;
 	uint8_t channel_id;
 	uint16_t oal;
@@ -1115,10 +1116,16 @@ int dpni_set_tx_shaping(struct fsl_mc_io *mc_io,
 					  cmd_flags,
 					  token);
 	cmd_params = (struct dpni_cmd_set_tx_shaping *)cmd.params;
+	tx_cr_burst = tx_cr_shaper->max_burst_size;
+	tx_er_burst = tx_er_shaper->max_burst_size;
 	cmd_params->tx_cr_max_burst_size =
-		cpu_to_le16(tx_cr_shaper->max_burst_size);
+		cpu_to_le16(DPNI_BURST_LO(tx_cr_burst));
 	cmd_params->tx_er_max_burst_size =
-		cpu_to_le16(tx_er_shaper->max_burst_size);
+		cpu_to_le16(DPNI_BURST_LO(tx_er_burst));
+	cmd_params->tx_cr_max_burst_size_hi =
+		cpu_to_le16(DPNI_BURST_HI(tx_cr_burst));
+	cmd_params->tx_er_max_burst_size_hi =
+		cpu_to_le16(DPNI_BURST_HI(tx_er_burst));
 	cmd_params->tx_cr_rate_limit =
 		cpu_to_le32(tx_cr_shaper->rate_limit);
 	cmd_params->tx_er_rate_limit =
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 42d633eaf8..7bcbad6859 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -833,11 +833,12 @@ int dpni_get_link_state(struct fsl_mc_io *mc_io,
 /**
  * struct dpni_tx_shaping - Structure representing DPNI tx shaping configuration
  * @rate_limit:		Rate in Mbits/s
- * @max_burst_size:	Burst size in bytes (up to 64KB)
+ * @max_burst_size:	Burst size in bytes. Limits depend on the SoC (0x37FFF
+ *		for LX2160A, 0xF7FF for all others)
  */
 struct dpni_tx_shaping_cfg {
 	uint32_t rate_limit;
-	uint16_t max_burst_size;
+	uint32_t max_burst_size;
 };
 
 /**
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index bb4939031b..cc7bf42a4e 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -391,10 +391,14 @@ struct dpni_rsp_get_link_state {
 #define DPNI_LNI_SHAPER_SHIFT	1
 #define DPNI_LNI_SHAPER_SIZE	1
 
+#define DPNI_BURST_LO(burst)	((burst) & GENMASK(15, 0))
+#define DPNI_BURST_HI(burst)	((burst) >> 16)
+
 struct dpni_cmd_set_tx_shaping {
 	uint16_t tx_cr_max_burst_size;
 	uint16_t tx_er_max_burst_size;
-	uint32_t pad;
+	uint16_t tx_cr_max_burst_size_hi;
+	uint16_t tx_er_max_burst_size_hi;
 	uint32_t tx_cr_rate_limit;
 	uint32_t tx_er_rate_limit;
 	/* from LSB: coupled:1, lni_shaper: 1*/
-- 
2.43.0

