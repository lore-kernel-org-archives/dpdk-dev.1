Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C5CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 07:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47D2342DBE;
	Thu,  1 Oct 2026 09:33:17 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 15746427B3
 for <dev@dpdk.org>; Thu,  1 Oct 2026 09:33:16 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E15392000FF;
 Thu,  1 Oct 2026 09:33:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA4352000F7;
 Thu,  1 Oct 2026 09:33:15 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 501941800068;
 Thu,  1 Oct 2026 15:33:14 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v5-S2 03/13] net/dpaa2: support larger burst size
Date: Thu,  1 Oct 2026 13:02:57 +0530
Message-ID: <20261001073307.1125305-4-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
References: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
 <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
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
 drivers/net/dpaa2/dpaa2_tm.c        | 16 +++++++++++-----
 drivers/net/dpaa2/mc/dpni.c         | 11 +++++++++--
 drivers/net/dpaa2/mc/fsl_dpni.h     |  8 ++++++--
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  3 ++-
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index 36e815c356..3057f4d031 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2024 NXP
+ * Copyright 2020-2026 NXP
  */
 
 #include <rte_ethdev.h>
@@ -10,14 +10,20 @@
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
+	if (dpaa2_dev_cmp_dpni_ver(priv, 8, 7) >= 0)
+		return (dpaa2_svr_family == SVR_LX2160A) ? 229375 : 0xF7FF;
+
+	return 0xF7FF;
+}
+
 int
 dpaa2_tm_init(struct rte_eth_dev *dev)
 {
@@ -283,7 +289,7 @@ dpaa2_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 				RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_RATE,
 				NULL, "committed rate is out of range\n");
 
-	if (params->committed.size > DPAA2_BURST_MAX)
+	if (params->committed.size > dpaa2_get_burst_max(priv))
 		return -rte_tm_error_set(error, EINVAL,
 				RTE_TM_ERROR_TYPE_SHAPER_PROFILE_PEAK_SIZE,
 				NULL, "committed size is out of range\n");
@@ -293,7 +299,7 @@ dpaa2_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
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
index 42d633eaf8..8913b408e7 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -830,14 +830,18 @@ int dpni_get_link_state(struct fsl_mc_io *mc_io,
 			uint16_t token,
 			struct dpni_link_state *state);
 
+#define DPNI_BURST_LO(burst)	((burst) & GENMASK(15, 0))
+#define DPNI_BURST_HI(burst)	((burst) >> 16)
+
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
index bb4939031b..6b396ca7cc 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -394,7 +394,8 @@ struct dpni_rsp_get_link_state {
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

