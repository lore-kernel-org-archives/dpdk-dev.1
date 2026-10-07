Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDC4CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 06:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC7AC41143;
	Wed,  7 Oct 2026 08:02:43 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 268334027B
 for <dev@dpdk.org>; Wed,  7 Oct 2026 08:02:38 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07ED720007D;
 Wed,  7 Oct 2026 08:02:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CB4A20008F;
 Wed,  7 Oct 2026 08:02:37 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1CB46180023D;
 Wed,  7 Oct 2026 14:02:35 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v7-S2 05/13] net/dpaa2: support meter and policing
Date: Wed,  7 Oct 2026 11:32:19 +0530
Message-ID: <20261007060227.219835-6-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007060227.219835-1-prashant.gupta_3@nxp.com>
References: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
 <20261007060227.219835-1-prashant.gupta_3@nxp.com>
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

Add support for the traffic metering and policing (rte_mtr) API.
Meters map one-to-one to Rx TCs and are programmed via
dpni_set_rx_tc_policing().

Additional corrections over the initial implementation --
- byte-mode rates converted correctly: bytes/s / 125 = Kbps
- packet-mode rates passed unchanged to firmware
- hardware programmed at create/update; policing disabled at destroy
- mtr_id validated against num_rx_tc before use
- color_aware capability cleared (FD[DROPP] not handled)
- duplicate-ID check and insertion both under meter_lock
- removed misleading "Rate limitation" entry from features/dpaa2.ini

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/dpaa2.rst              |   1 +
 doc/guides/rel_notes/release_26_11.rst |   5 +
 drivers/net/dpaa2/dpaa2_ethdev.c       |   2 +
 drivers/net/dpaa2/dpaa2_ethdev.h       |  29 +
 drivers/net/dpaa2/dpaa2_meter.c        | 758 +++++++++++++++++++++++++
 drivers/net/dpaa2/mc/fsl_dpni.h        |  23 +-
 drivers/net/dpaa2/meson.build          |   1 +
 7 files changed, 815 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 2928575208..69d111e3ab 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -407,6 +407,7 @@ Features of the DPAA2 PMD are:
 - Link flow control
 - Scattered and gather for TX and RX
 - Rx queue interrupts
+- Traffic metering and policing
 - :ref:`dpaa2_dptmapi`
 
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 934efaaf93..b1ebd508fd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -20,6 +20,11 @@ DPDK Release 26.11
       ninja -C build doc
       xdg-open build/doc/guides/html/rel_notes/release_26_11.html
 
+* **Updated NXP DPAA2 net driver.**
+
+  * Added Tx queue based flow control and confirmation queue handling.
+  * Added software parser based packet dump for debugging.
+  * Added support for traffic metering and policing (rte_mtr API).
 
 New Features
 ------------
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f88ecb88aa..5f1e832ce3 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3317,6 +3317,7 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
+	.mtr_ops_get	      = dpaa2_mtr_ops_get,
 #if defined(RTE_LIBRTE_IEEE1588)
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
@@ -3540,6 +3541,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->num_channels = attr.num_channels;
 	priv->channel_inuse = 0;
 	rte_spinlock_init(&priv->lpbk_qp_lock);
+	rte_spinlock_init(&priv->meter_lock);
 
 	/* only if the custom CG is enabled */
 	if (attr.options & DPNI_OPT_CUSTOM_CG)
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 149954fb6b..e329111c0b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -385,6 +385,30 @@ struct extract_s {
 	uint8_t *tc_extract_param[MAX_TCS];
 };
 
+struct dpaa2_dev_meter_profile {
+	LIST_ENTRY(dpaa2_dev_meter_profile) next;
+	uint32_t profile_id;
+	uint64_t cir;
+	uint64_t cbs;
+	uint64_t pir;
+	uint64_t pbs;
+	enum dpni_policer_mode mode;
+	enum dpni_policer_unit policer_unit;
+};
+
+struct dpaa2_dev_meter_policy {
+	LIST_ENTRY(dpaa2_dev_meter_policy) next;
+	uint32_t policy_id;
+	bool red_drop;
+};
+
+struct dpaa2_dev_meter {
+	LIST_ENTRY(dpaa2_dev_meter) next;
+	uint32_t meter_id;
+	uint32_t profile_id;
+	uint32_t policy_id;
+};
+
 struct dpaa2_dev_priv {
 	void *hw;
 	int32_t hw_id;
@@ -411,6 +435,7 @@ struct dpaa2_dev_priv {
 	uint8_t en_loose_ordered;
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
+	rte_spinlock_t meter_lock;
 
 	/* Current hash distribution size per RX TC, written by
 	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
@@ -456,6 +481,9 @@ struct dpaa2_dev_priv {
 
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
+	LIST_HEAD(, dpaa2_dev_meter_profile) profiles;
+	LIST_HEAD(, dpaa2_dev_meter_policy) policies;
+	LIST_HEAD(, dpaa2_dev_meter) meters;
 	LIST_HEAD(nodes, dpaa2_tm_node) nodes;
 	LIST_HEAD(shaper_profiles, dpaa2_tm_shaper_profile) shaper_profiles;
 };
@@ -548,6 +576,7 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 
 int dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev);
 int dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev);
+int dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops);
 int dpaa2_soft_parser_loaded(void);
 
 void
diff --git a/drivers/net/dpaa2/dpaa2_meter.c b/drivers/net/dpaa2/dpaa2_meter.c
new file mode 100644
index 0000000000..9ad796e8c5
--- /dev/null
+++ b/drivers/net/dpaa2/dpaa2_meter.c
@@ -0,0 +1,758 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025-2026 NXP
+ */
+
+#include <sys/queue.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <sys/mman.h>
+
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_flow_driver.h>
+#include <rte_tailq.h>
+#include <rte_mtr.h>
+#include <rte_mtr_driver.h>
+
+#include <fsl_dpni.h>
+#include <fsl_dpkg.h>
+
+#include <dpaa2_ethdev.h>
+#include <dpaa2_pmd_logs.h>
+
+static char s_err_msg[128];
+
+/*
+ * color_aware mode is not yet implemented: the firmware color input from
+ * FD[DROPP] is not read or acted upon.  Advertise only blind (non-aware)
+ * trTCM variants until color-aware handling is added.
+ */
+static struct rte_mtr_capabilities s_dpaa2_mtr_capa = {
+	.color_aware_trtcm_rfc2698_supported = false,
+	.color_aware_trtcm_rfc4115_supported = false,
+	.trtcm_rfc2698_byte_mode_supported = true,
+	.trtcm_rfc2698_packet_mode_supported = true,
+	.trtcm_rfc4115_byte_mode_supported = true,
+	.trtcm_rfc4115_packet_mode_supported = true
+};
+
+/*
+ * Program the DPNI policing HW for the given TC.
+ * profile->cir and profile->pir are stored in the rte_mtr units:
+ *   byte mode:   bytes/s  -> convert to Kbps (divide by 125)
+ *   packet mode: packets/s -> pass through unchanged
+ * cbs/pbs are in bytes or packets and fit in uint32_t; the caller must
+ * verify this before storing in the profile.
+ */
+static int
+dpaa2_mtr_hw_program(struct rte_eth_dev *dev,
+	uint32_t mtr_id,
+	const struct dpaa2_dev_meter_profile *profile,
+	const struct dpaa2_dev_meter_policy *policy)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpni_rx_tc_policing_cfg cfg;
+	int ret;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.mode = profile->mode;
+	cfg.units = profile->policer_unit;
+	cfg.default_color = DPNI_POLICER_COLOR_GREEN;
+
+	if (policy->red_drop)
+		cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+
+	if (profile->policer_unit == DPNI_POLICER_UNIT_BYTES_L3) {
+		/* rte_mtr rates are bytes/s; DPNI expects Kbps (1 Kbps = 125 B/s). */
+		cfg.cir = (uint32_t)(profile->cir / 125);
+		cfg.eir = (uint32_t)(profile->pir / 125);
+	} else {
+		/* Packet mode: rates are packets/s, passed directly. */
+		cfg.cir = (uint32_t)profile->cir;
+		cfg.eir = (uint32_t)profile->pir;
+	}
+	cfg.cbs = (uint32_t)profile->cbs;
+	cfg.ebs = (uint32_t)profile->pbs;
+
+	ret = dpni_set_rx_tc_policing(dpni, CMD_PRI_LOW, priv->token,
+				      (uint8_t)mtr_id, &cfg);
+	if (ret) {
+		DPAA2_PMD_ERR("TC[%u] policing set failed (%d)", mtr_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_capabilities_get(struct rte_eth_dev *dev,
+	struct rte_mtr_capabilities *capa,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	if (capa == NULL) {
+		return rte_mtr_error_set(error, EINVAL,
+				RTE_MTR_ERROR_TYPE_MTR_PARAMS, NULL,
+				"NULL input parameter");
+	}
+
+	rte_spinlock_lock(&priv->meter_lock);
+	s_dpaa2_mtr_capa.n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.n_shared_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.meter_trtcm_rfc2698_n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.meter_trtcm_rfc4115_n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.meter_policy_n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.shared_n_flows_per_mtr_max = priv->fs_entries;
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	*capa = s_dpaa2_mtr_capa;
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_profile_add(struct rte_eth_dev *dev,
+	uint32_t profile_id, struct rte_mtr_meter_profile *profile,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *dpaa2_profile;
+	struct dpaa2_dev_meter_profile *curr;
+	int ret = 0;
+
+	dpaa2_profile = rte_zmalloc(NULL,
+		sizeof(struct dpaa2_dev_meter_profile), 0);
+	if (dpaa2_profile == NULL) {
+		return rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Meter profile memory alloc failed!");
+	}
+	if (profile->alg == RTE_MTR_NONE) {
+		dpaa2_profile->mode = DPNI_POLICER_MODE_PASS_THROUGH;
+	} else if (profile->alg == RTE_MTR_TRTCM_RFC2698) {
+		dpaa2_profile->mode = DPNI_POLICER_MODE_RFC_2698;
+	} else if (profile->alg == RTE_MTR_TRTCM_RFC4115) {
+		dpaa2_profile->mode = DPNI_POLICER_MODE_RFC_4115;
+	} else {
+		DPAA2_PMD_ERR("Policer profile alg(%d) not supported!",
+			profile->alg);
+		rte_mtr_error_set(error, ENOTSUP,
+				RTE_MTR_ERROR_TYPE_METER_PROFILE, NULL,
+				"Policer profile alg not supported!");
+		ret = -ENOTSUP;
+		goto err;
+	}
+
+	if (profile->alg == RTE_MTR_TRTCM_RFC2698) {
+		dpaa2_profile->cir = profile->trtcm_rfc2698.cir;
+		dpaa2_profile->cbs = profile->trtcm_rfc2698.cbs;
+		dpaa2_profile->pir = profile->trtcm_rfc2698.pir;
+		dpaa2_profile->pbs = profile->trtcm_rfc2698.pbs;
+	} else if (profile->alg == RTE_MTR_TRTCM_RFC4115) {
+		dpaa2_profile->cir = profile->trtcm_rfc4115.cir;
+		dpaa2_profile->cbs = profile->trtcm_rfc4115.cbs;
+		dpaa2_profile->pir = profile->trtcm_rfc4115.eir;
+		dpaa2_profile->pbs = profile->trtcm_rfc4115.ebs;
+	}
+
+	/* Align with DPNI policy. */
+	if (!profile->packet_mode)
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_BYTES_L3;
+	else
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_FRAMES;
+
+	dpaa2_profile->profile_id = profile_id;
+
+	/* Check for duplicate ID and insert under lock to prevent TOCTOU. */
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->profiles);
+	while (curr != NULL) {
+		if (curr->profile_id == profile_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			rte_mtr_error_set(error, EEXIST,
+				RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
+				NULL, "Meter profile ID already exists!");
+			ret = -EEXIST;
+			goto err;
+		}
+		curr = LIST_NEXT(curr, next);
+	}
+
+	curr = LIST_FIRST(&priv->profiles);
+	if (curr == NULL) {
+		LIST_INSERT_HEAD(&priv->profiles, dpaa2_profile, next);
+	} else {
+		while (LIST_NEXT(curr, next) != NULL)
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, dpaa2_profile, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+err:
+	if (ret != 0)
+		rte_free(dpaa2_profile);
+
+	return ret;
+}
+
+static int
+dpaa2_mtr_policy_add(struct rte_eth_dev *dev,
+	uint32_t policy_id, struct rte_mtr_meter_policy_params *policy,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *dpaa2_policy;
+	struct dpaa2_dev_meter_policy *curr;
+	const struct rte_flow_action *red_action;
+	bool red_drop = false;
+
+	if (policy->actions[RTE_COLOR_GREEN] != NULL) {
+		return rte_mtr_error_set(error, ENOTSUP,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_GREEN, NULL,
+				"Meter green policy action not supported!");
+	}
+	if (policy->actions[RTE_COLOR_YELLOW] != NULL) {
+		return rte_mtr_error_set(error, ENOTSUP,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_YELLOW, NULL,
+				"Meter yellow policy action not supported!");
+	}
+
+	red_action = policy->actions[RTE_COLOR_RED];
+
+	if (red_action != NULL) {
+		if (red_action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+			red_drop = true;
+		} else if (red_action->type != RTE_FLOW_ACTION_TYPE_PASSTHRU) {
+			snprintf(s_err_msg, sizeof(s_err_msg),
+				"Meter red policy action(%d) NOT supported!",
+				red_action->type);
+			return rte_mtr_error_set(error, ENOTSUP,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_RED, NULL,
+				s_err_msg);
+		}
+	}
+
+	dpaa2_policy = rte_zmalloc(NULL,
+		sizeof(struct dpaa2_dev_meter_policy), 0);
+	if (dpaa2_policy == NULL) {
+		return rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Meter policy memory alloc failed!");
+	}
+
+	dpaa2_policy->policy_id = policy_id;
+	dpaa2_policy->red_drop = red_drop;
+
+	/* Check for duplicate ID and insert under lock to prevent TOCTOU. */
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->policies);
+	while (curr != NULL) {
+		if (curr->policy_id == policy_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			rte_free(dpaa2_policy);
+			return rte_mtr_error_set(error, EEXIST,
+				RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
+				NULL, "Meter policy ID already exists!");
+		}
+		curr = LIST_NEXT(curr, next);
+	}
+
+	curr = LIST_FIRST(&priv->policies);
+	if (curr == NULL) {
+		LIST_INSERT_HEAD(&priv->policies, dpaa2_policy, next);
+	} else {
+		while (LIST_NEXT(curr, next) != NULL)
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, dpaa2_policy, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return 0;
+}
+
+static struct rte_flow_meter_profile *
+dpaa2_mtr_profile_get(struct rte_eth_dev *dev,
+	uint32_t meter_profile_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *dpaa2_profile;
+
+	RTE_SET_USED(error);
+
+	rte_spinlock_lock(&priv->meter_lock);
+	dpaa2_profile = LIST_FIRST(&priv->profiles);
+	while (dpaa2_profile != NULL) {
+		if (dpaa2_profile->profile_id == meter_profile_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return (struct rte_flow_meter_profile *)dpaa2_profile;
+		}
+		dpaa2_profile = LIST_NEXT(dpaa2_profile, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return NULL;
+}
+
+static struct rte_flow_meter_policy *
+dpaa2_mtr_policy_get(struct rte_eth_dev *dev,
+	uint32_t policy_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *dpaa2_policy;
+
+	RTE_SET_USED(error);
+
+	rte_spinlock_lock(&priv->meter_lock);
+	dpaa2_policy = LIST_FIRST(&priv->policies);
+	while (dpaa2_policy != NULL) {
+		if (dpaa2_policy->policy_id == policy_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return (struct rte_flow_meter_policy *)dpaa2_policy;
+		}
+		dpaa2_policy = LIST_NEXT(dpaa2_policy, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return NULL;
+}
+
+static int
+dpaa2_mtr_profile_delete(struct rte_eth_dev *dev,
+	uint32_t profile_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *dpaa2_profile = NULL, *curr;
+	struct dpaa2_dev_meter *meter;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->profiles);
+	while (curr != NULL) {
+		if (curr->profile_id == profile_id) {
+			dpaa2_profile = curr;
+			break;
+		}
+		curr = LIST_NEXT(curr, next);
+	}
+	if (dpaa2_profile == NULL) {
+		rte_spinlock_unlock(&priv->meter_lock);
+		return rte_mtr_error_set(error, ENOENT,
+			RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
+			&profile_id, "Meter profile is invalid.");
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->profile_id == profile_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return rte_mtr_error_set(error, EBUSY,
+				RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
+				&profile_id, "Meter profile is in use.");
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+
+	LIST_REMOVE(dpaa2_profile, next);
+	rte_free(dpaa2_profile);
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_policy_delete(struct rte_eth_dev *dev,
+	uint32_t policy_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *dpaa2_policy = NULL, *curr;
+	struct dpaa2_dev_meter *meter;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->policies);
+	while (curr != NULL) {
+		if (curr->policy_id == policy_id) {
+			dpaa2_policy = curr;
+			break;
+		}
+		curr = LIST_NEXT(curr, next);
+	}
+	if (dpaa2_policy == NULL) {
+		rte_spinlock_unlock(&priv->meter_lock);
+		return rte_mtr_error_set(error, ENOENT,
+			RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
+			NULL, "Meter policy is invalid.");
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->policy_id == policy_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return rte_mtr_error_set(error, EBUSY,
+				RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
+				NULL, "Meter policy is in use.");
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+
+	LIST_REMOVE(dpaa2_policy, next);
+	rte_free(dpaa2_policy);
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_create(struct rte_eth_dev *dev,
+	uint32_t mtr_id, struct rte_mtr_params *params,
+	int shared, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter_policy *policy;
+	struct dpaa2_dev_meter *meter, *curr;
+	uint32_t profile_id, policy_id;
+	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
+	bool found = false;
+	int ret = 0;
+
+	RTE_SET_USED(shared);
+
+	/* mtr_id maps 1:1 to an Rx TC; validate the range. */
+	if (mtr_id >= priv->num_rx_tc) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Meter ID(%u) >= num_rx_tc(%u)!", mtr_id,
+			priv->num_rx_tc);
+		return rte_mtr_error_set(error, EINVAL,
+			RTE_MTR_ERROR_TYPE_MTR_ID, NULL, s_err_msg);
+	}
+
+	profile_id = params->meter_profile_id;
+	policy_id = params->meter_policy_id;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile != NULL) {
+		if (profile->profile_id == profile_id) {
+			found = true;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Meter profile ID(%d) not exist!", profile_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_PROFILE_ID;
+		goto quit;
+	}
+
+	found = false;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy != NULL) {
+		if (policy->policy_id == policy_id) {
+			found = true;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Meter policy ID(%d) not exist!", policy_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
+		goto quit;
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->meter_id == mtr_id) {
+			snprintf(s_err_msg, sizeof(s_err_msg),
+				"Meter ID(%d) exist!", mtr_id);
+			ret = EEXIST;
+			err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
+			goto quit;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	meter = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_meter), 0);
+	if (meter == NULL) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Meter memory alloc failed!");
+		ret = ENOMEM;
+		err_type = RTE_MTR_ERROR_TYPE_UNSPECIFIED;
+		goto quit;
+	}
+	meter->meter_id = mtr_id;
+	meter->profile_id = profile_id;
+	meter->policy_id = policy_id;
+
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	/* Program the hardware policing configuration for this TC. */
+	ret = dpaa2_mtr_hw_program(dev, mtr_id, profile, policy);
+	if (ret) {
+		rte_free(meter);
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"TC[%u] HW policing set failed (%d)!", mtr_id, ret);
+		return rte_mtr_error_set(error, -ret,
+			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL, s_err_msg);
+	}
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->meters);
+	if (curr == NULL) {
+		LIST_INSERT_HEAD(&priv->meters, meter, next);
+	} else {
+		while (LIST_NEXT(curr, next) != NULL)
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, meter, next);
+	}
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret != 0) {
+		if (meter != NULL && ret == ENOMEM)
+			rte_free(meter);
+		return rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_destroy(struct rte_eth_dev *dev,
+	uint32_t mtr_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_priv *priv_dev = dev->data->dev_private;
+	struct fsl_mc_io *dpni = priv_dev->hw;
+	struct dpaa2_dev_meter *meter;
+	struct dpni_rx_tc_policing_cfg cfg;
+	int ret;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->meter_id == mtr_id) {
+			LIST_REMOVE(meter, next);
+			rte_free(meter);
+			rte_spinlock_unlock(&priv->meter_lock);
+
+			/* Disable policing for this TC. */
+			memset(&cfg, 0, sizeof(cfg));
+			cfg.mode = DPNI_POLICER_MODE_NONE;
+			ret = dpni_set_rx_tc_policing(dpni, CMD_PRI_LOW,
+						      priv->token,
+						      (uint8_t)mtr_id, &cfg);
+			if (ret)
+				DPAA2_PMD_ERR("TC[%u] policing disable failed (%d)",
+					mtr_id, ret);
+
+			return 0;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	snprintf(s_err_msg, sizeof(s_err_msg),
+		"Meter ID(%d) does not exist!", mtr_id);
+	rte_spinlock_unlock(&priv->meter_lock);
+	return rte_mtr_error_set(error, ENOENT,
+		RTE_MTR_ERROR_TYPE_MTR_ID, NULL, s_err_msg);
+}
+
+static int
+dpaa2_mtr_meter_profile_update(struct rte_eth_dev *dev,
+	uint32_t mtr_id, uint32_t profile_id,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter_policy *policy;
+	struct dpaa2_dev_meter *meter;
+	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
+	bool found = false;
+	int ret = 0;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->meter_id == mtr_id) {
+			found = true;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Meter ID(%d) not found!", mtr_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
+		goto quit;
+	}
+
+	found = false;
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile != NULL) {
+		if (profile->profile_id == profile_id) {
+			found = true;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Profile ID(%d) not found!", profile_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_PROFILE_ID;
+		goto quit;
+	}
+
+	/* Find the current policy so we can reprogram HW. */
+	found = false;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy != NULL) {
+		if (policy->policy_id == meter->policy_id) {
+			found = true;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Current policy ID(%d) not found!", meter->policy_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
+		goto quit;
+	}
+
+	meter->profile_id = profile_id;
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret != 0)
+		return rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+
+	/* Reprogram hardware with the new profile. */
+	ret = dpaa2_mtr_hw_program(dev, mtr_id, profile, policy);
+	if (ret) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"TC[%u] HW reprogram failed (%d)!", mtr_id, ret);
+		return rte_mtr_error_set(error, -ret,
+			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL, s_err_msg);
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_policy_update(struct rte_eth_dev *dev,
+	uint32_t mtr_id, uint32_t policy_id,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *policy;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter *meter;
+	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
+	bool found = false;
+	int ret = 0;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->meter_id == mtr_id) {
+			found = true;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Meter ID(%d) not found!", mtr_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
+		goto quit;
+	}
+
+	found = false;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy != NULL) {
+		if (policy->policy_id == policy_id) {
+			found = true;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Policy ID(%d) not found!", policy_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
+		goto quit;
+	}
+
+	/* Find the current profile so we can reprogram HW. */
+	found = false;
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile != NULL) {
+		if (profile->profile_id == meter->profile_id) {
+			found = true;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"Current profile ID(%d) not found!", meter->profile_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_PROFILE_ID;
+		goto quit;
+	}
+
+	meter->policy_id = policy_id;
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret != 0)
+		return rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+
+	/* Reprogram hardware with the new policy. */
+	ret = dpaa2_mtr_hw_program(dev, mtr_id, profile, policy);
+	if (ret) {
+		snprintf(s_err_msg, sizeof(s_err_msg),
+			"TC[%u] HW reprogram failed (%d)!", mtr_id, ret);
+		return rte_mtr_error_set(error, -ret,
+			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL, s_err_msg);
+	}
+
+	return 0;
+}
+
+static const struct rte_mtr_ops dpaa2_meter_ops = {
+	.capabilities_get = dpaa2_mtr_capabilities_get,
+	.meter_profile_add = dpaa2_mtr_profile_add,
+	.meter_profile_delete = dpaa2_mtr_profile_delete,
+	.meter_policy_add = dpaa2_mtr_policy_add,
+	.meter_policy_delete = dpaa2_mtr_policy_delete,
+	.meter_profile_get = dpaa2_mtr_profile_get,
+	.meter_policy_get = dpaa2_mtr_policy_get,
+	.create = dpaa2_mtr_meter_create,
+	.destroy = dpaa2_mtr_meter_destroy,
+	.meter_profile_update = dpaa2_mtr_meter_profile_update,
+	.meter_policy_update = dpaa2_mtr_meter_policy_update,
+};
+
+int
+dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops)
+{
+	RTE_SET_USED(dev);
+
+	*(const void **)ops = &dpaa2_meter_ops;
+	return 0;
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 8913b408e7..d227025e01 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1111,6 +1111,11 @@ int dpni_set_rx_tc_dist(struct fsl_mc_io *mc_io,
  */
 #define DPNI_POLICER_OPT_DISCARD_RED	0x00000002
 
+/**
+ * Do NOT reset counters generally for policer update
+ */
+#define DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS	0x00000004
+
 /**
  * enum dpni_policer_mode - selecting the policer mode
  * @DPNI_POLICER_MODE_NONE: Policer is disabled
@@ -1127,12 +1132,17 @@ enum dpni_policer_mode {
 
 /**
  * enum dpni_policer_unit - DPNI policer units
- * @DPNI_POLICER_UNIT_BYTES: bytes units
+ * @DPNI_POLICER_UNIT_BYTES_L3: bytes units (for each frame takes into account
+ * FD length - L3 offset)
  * @DPNI_POLICER_UNIT_FRAMES: frames units
+ * @DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS: bytes units (for each frame takes
+ * into account FD length - L2 offset, which means L2 size without the 4 bytes
+ * for the FCS)
  */
 enum dpni_policer_unit {
-	DPNI_POLICER_UNIT_BYTES = 0,
-	DPNI_POLICER_UNIT_FRAMES
+	DPNI_POLICER_UNIT_BYTES_L3 = 0,
+	DPNI_POLICER_UNIT_FRAMES,
+	DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS,
 };
 
 /**
@@ -1173,13 +1183,18 @@ struct dpni_rx_tc_policing_cfg {
 	uint32_t ebs;
 };
 
-
 int dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
 			    uint32_t cmd_flags,
 			    uint16_t token,
 			    uint8_t tc_id,
 			    const struct dpni_rx_tc_policing_cfg *cfg);
 
+int dpni_set_rx_tc_policing_v1(struct fsl_mc_io *mc_io,
+			    uint32_t cmd_flags,
+			    uint16_t token,
+			    uint8_t tc_id,
+			    const struct dpni_rx_tc_policing_cfg *cfg);
+
 int dpni_get_rx_tc_policing(struct fsl_mc_io *mc_io,
 			    uint32_t cmd_flags,
 			    uint16_t token,
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index 4094ea02ba..808dad8112 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -11,6 +11,7 @@ sources = files(
         'base/dpaa2_hw_dpni.c',
         'base/dpaa2_tlu_hash.c',
         'dpaa2_tm.c',
+        'dpaa2_meter.c',
         'dpaa2_mux.c',
         'dpaa2_ethdev.c',
         'dpaa2_flow.c',
-- 
2.43.0

