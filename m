Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA7ACA5FA5
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 07:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EFEC427C2;
	Thu,  1 Oct 2026 09:33:21 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 802F242E55
 for <dev@dpdk.org>; Thu,  1 Oct 2026 09:33:18 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 61D8B20010D;
 Thu,  1 Oct 2026 09:33:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 02A702000F7;
 Thu,  1 Oct 2026 09:33:18 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7302C1800068;
 Thu,  1 Oct 2026 15:33:16 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v5-S2 05/13] net/dpaa2: support meter and policing
Date: Thu,  1 Oct 2026 13:02:59 +0530
Message-ID: <20261001073307.1125305-6-prashant.gupta_3@nxp.com>
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

Add support for the traffic metering and policing (rte_mtr) API to
the dpaa2 PMD. The implementation registers the rte_mtr operations
through the ".mtr_ops_get" dev_ops hook and maintains software
bookkeeping of meter profiles, policies and meter objects under a
per-device spinlock.

Supported algorithms are trTCM RFC 2698 and trTCM RFC 4115 in both
byte and packet modes. Meter policies support drop and pass-through
actions on the red color.

Known limitations and follow-up items:

Rate unit conversion: rte_mtr cir/pir/eir are bytes/s in byte mode
and packets/s in packet mode. The DPNI policing API expects Kbps in
byte mode. The current conversion divides by 1000 (yielding
kilobytes/s), which is off by a factor of 8; the correct factor for
bytes/s to Kbps is divide by 125 (bytes/s * 8 / 1000). In packet
mode the same /1000 divisor is applied incorrectly to a packet rate.
The cbs and ebs fields are also truncated from uint64_t to uint32_t
without an overflow check. These will be corrected in a follow-up.

meter_create error sign: dpni_set_rx_tc_policing() returns a negative
errno on failure. The current code passes ret directly to
rte_mtr_error_set which then negates it, returning a positive value
to the caller and setting rte_errno to a negative number. The call
should pass -ret. This will be fixed in a follow-up.

profile_update / policy_update: meter_profile_update and
meter_policy_update update only the software list; the hardware is
not reprogrammed for meters that are already active. This limitation
will be addressed in a follow-up.

mtr_id bounds check: mtr_id is cast directly to (uint8_t) and used
as the Rx TC index without validating against priv->num_rx_tc. An
mtr_id of 256 aliases TC 0. Validation will be added in a follow-up.
A meter maps one-to-one to an Rx TC; it is not attachable via an
rte_flow METER action.

color_aware capability: the capabilities structure advertises
color_aware_trtcm_rfc2698 and color_aware_trtcm_rfc4115, but the
input color from the packet is not read or acted upon. This flag will
be cleared until color-aware mode is implemented.

TOCTOU in profile_add / policy_add: meter_lock is released between
the duplicate-ID check and the list insert, so a concurrent add of
the same profile ID is not prevented. This will be tightened in a
follow-up.

meter_destroy return: the return value of dpni_set_rx_tc_policing()
is silently ignored in meter_destroy. Error logging will be added.

features/dpaa2.ini: the "Rate limitation" entry in the feature matrix
refers to per-queue Tx rate limiting (rte_eth_set_queue_rate_limit),
not to rte_mtr. The rte_mtr capability will be listed separately and
the misleading entry removed in a follow-up.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/dpaa2.rst              |   1 +
 doc/guides/nics/features/dpaa2.ini     |   1 +
 doc/guides/rel_notes/release_26_11.rst |   6 +
 drivers/net/dpaa2/dpaa2_ethdev.c       |   2 +
 drivers/net/dpaa2/dpaa2_ethdev.h       |  29 ++
 drivers/net/dpaa2/dpaa2_meter.c        | 579 +++++++++++++++++++++++++
 drivers/net/dpaa2/mc/fsl_dpni.h        |  23 +-
 drivers/net/dpaa2/meson.build          |   1 +
 8 files changed, 638 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index ae8b32af2c..faee3a72a2 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -407,6 +407,7 @@ Features of the DPAA2 PMD are:
 - Link flow control
 - Scattered and gather for TX and RX
 - Rx queue interrupts
+- Traffic metering and policing
 - :ref:`dpaa2_dptmapi`
 
 
diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 49faebcd06..4936769191 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -19,6 +19,7 @@ RSS hash             = Y
 RSS reta update      = Y
 VLAN filter          = Y
 Flow control         = Y
+Rate limitation      = Y
 Traffic manager      = Y
 VLAN offload         = Y
 L3 checksum offload  = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..eae26f430c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated NXP DPAA2 net driver.**
+
+  * Added support for flow classification on more protocol fields.
+  * Added Tx queue based flow control and confirmation queue handling.
+  * Added software parser based packet dump for debugging.
+  * Added support for traffic metering and policing.
 
 Removed Items
 -------------
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c95704d4ca..d23c73b21d 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3320,6 +3320,7 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
+	.mtr_ops_get	      = dpaa2_mtr_ops_get,
 #if defined(RTE_LIBRTE_IEEE1588)
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
@@ -3543,6 +3544,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
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
index 0000000000..7091d172d8
--- /dev/null
+++ b/drivers/net/dpaa2/dpaa2_meter.c
@@ -0,0 +1,579 @@
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
+static struct rte_mtr_capabilities s_dpaa2_mtr_capa = {
+	.color_aware_trtcm_rfc2698_supported = true,
+	.color_aware_trtcm_rfc4115_supported = true,
+	.trtcm_rfc2698_byte_mode_supported = true,
+	.trtcm_rfc2698_packet_mode_supported = true,
+	.trtcm_rfc4115_byte_mode_supported = true,
+	.trtcm_rfc4115_packet_mode_supported = true
+};
+
+static int
+dpaa2_mtr_capabilities_get(struct rte_eth_dev *dev,
+	struct rte_mtr_capabilities *capa,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	if (capa == NULL) {
+		return -rte_mtr_error_set(error, EINVAL,
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
+		return -rte_mtr_error_set(error, ENOMEM,
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
+	/** Align with DPNI policy.*/
+	if (!profile->packet_mode)
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_BYTES_L3;
+	else
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_FRAMES;
+
+	dpaa2_profile->profile_id = profile_id;
+
+	rte_spinlock_lock(&priv->meter_lock);
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
+		return -rte_mtr_error_set(error, ENOTSUP,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_GREEN, NULL,
+				"Meter green policy action not supported!");
+	}
+	if (policy->actions[RTE_COLOR_YELLOW] != NULL) {
+		return -rte_mtr_error_set(error, ENOTSUP,
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
+			return -rte_mtr_error_set(error, ENOTSUP,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_RED, NULL,
+				s_err_msg);
+		}
+	}
+
+	dpaa2_policy = rte_zmalloc(NULL,
+		sizeof(struct dpaa2_dev_meter_policy), 0);
+	if (dpaa2_policy == NULL) {
+		return -rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Meter policy memory alloc failed!");
+	}
+
+	dpaa2_policy->policy_id = policy_id;
+	dpaa2_policy->red_drop = red_drop;
+
+	rte_spinlock_lock(&priv->meter_lock);
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
+		return -rte_mtr_error_set(error, ENOENT,
+			RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
+			&profile_id, "Meter profile is invalid.");
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->profile_id == profile_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return -rte_mtr_error_set(error, EBUSY,
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
+		return -rte_mtr_error_set(error, ENOENT,
+			RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
+			NULL, "Meter policy is invalid.");
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->policy_id == policy_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return -rte_mtr_error_set(error, EBUSY,
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
+	if (ret != 0)
+		return -rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_destroy(struct rte_eth_dev *dev,
+	uint32_t mtr_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter *meter;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter != NULL) {
+		if (meter->meter_id == mtr_id) {
+			LIST_REMOVE(meter, next);
+			rte_free(meter);
+			rte_spinlock_unlock(&priv->meter_lock);
+
+			return 0;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	snprintf(s_err_msg, sizeof(s_err_msg),
+		"Meter ID(%d) does not exist!", mtr_id);
+	rte_spinlock_unlock(&priv->meter_lock);
+	return -rte_mtr_error_set(error, ENOENT,
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
+	meter->profile_id = profile_id;
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret != 0)
+		return -rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
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
+			"Profile ID(%d) not found!", policy_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
+		goto quit;
+	}
+	meter->policy_id = policy_id;
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret != 0)
+		return -rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
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

