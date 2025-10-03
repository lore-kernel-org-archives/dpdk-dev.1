Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD4ACCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31BAA40668;
	Fri,  3 Oct 2025 13:02:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D3CFE402BB
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489353; x=1791025353;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g77kpGhPiAAeq7IE65ZA0MWTS8RuLkznLUQ/UFDiiaU=;
 b=nXCOYG15atwrsNWKZ1nLZ31lk5PERNuy7ANyvL6zXPIzBi2Ju88F3TdR
 d/3GkIQtngwN2JOpnJS58Fl5OZij4zxYLCOwAyp4+zVxHvvRW6HzzPgWL
 8iQ+R0pJeUPMdnVSl0UQ+OQmndEFDkXK2sLFcXE1H268qvcSHIS2sPJlb
 fejqHK0BVj0p8FfvgcOwI/8H4nSMoOSAawTQWx00c73eqicVnSFBvD+Hs
 UOEJOm9ZkiQ88vFnJd8L0IBV56pRchTAirEtw3pKb46+Yz4xr9qyr0V5F
 y86GzdI/ObWfV5A/IgeVAHg5xPyPqyL6U2KemVpwPUoBUvYMGlCIR4l/b g==;
X-CSE-ConnectionGUID: O+e8iQnkQTq3+EVym1lGTA==
X-CSE-MsgGUID: 3ayly8V8RKSM2ne5pV8t7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72873487"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72873487"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:02:19 -0700
X-CSE-ConnectionGUID: lwvE+4liS4euERHRhhhhRA==
X-CSE-MsgGUID: EPgXIfSQSYKQymbWZ1sORg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179077650"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 04:02:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/7] ethdev: remove queue stats from ethdev stats structure
Date: Fri,  3 Oct 2025 12:01:57 +0100
Message-ID: <20251003110201.1541183-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003110201.1541183-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The queue stats part of the rte_eth_stats structure has been deprecated
for many years now, since 2020 [1]. Therefore we look to remove these
fields from the stats structure.

Unfortunately, the flag introduced by the deprecation,
"RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS", means that for drivers using it we
still have to return queue stats from the driver stats_get function.
This means that we need a new parameter for those stats as part of the
stats_get interface. The autofill flag is set for 35 drivers, which
means that if we didn't do so, users of those 35 drivers would lose all
ability to get per-queue stats.

[1] Commit a72cb3e7656a ("doc: announce queue stats moving to xstats")
	https://github.com/DPDK/dpdk/commit/a72cb3e

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V2:
- add documentation that qstats can be null
- fix zeroing bug when qstats == NULL
---
 config/rte_config.h               |  1 -
 lib/ethdev/ethdev_driver.h        | 35 +++++++++++++++++++++++++++--
 lib/ethdev/ethdev_private.c       | 27 ++++++++++++++++++++++
 lib/ethdev/ethdev_private.h       |  5 +++++
 lib/ethdev/rte_ethdev.c           | 37 +++++++++----------------------
 lib/ethdev/rte_ethdev.h           | 11 ---------
 lib/ethdev/rte_ethdev_telemetry.c | 20 +----------------
 7 files changed, 76 insertions(+), 60 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index 05344e2619..94f9a6427e 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -67,7 +67,6 @@
 
 /* ether defines */
 #define RTE_MAX_QUEUES_PER_PORT 1024
-#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
 #define RTE_ETHDEV_RXTX_CALLBACKS 1
 #define RTE_MAX_MULTI_HOST_CTRLS 4
 
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 71085bddff..298344c1ca 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -24,6 +24,27 @@
 extern "C" {
 #endif
 
+#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
+
+/**
+ * @internal
+ * structure used to pass queue stats back to ethdev for drivers which rely
+ * on ethdev to add the queue stats automatically to xstats.
+ */
+struct eth_queue_stats {
+	/* Queue stats are limited to max 256 queues */
+	/** Total number of queue Rx packets. */
+	uint64_t q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	/** Total number of queue Tx packets. */
+	uint64_t q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	/** Total number of successfully received queue bytes. */
+	uint64_t q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	/** Total number of successfully transmitted queue bytes. */
+	uint64_t q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	/** Total number of queue packets received that are dropped. */
+	uint64_t q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+};
+
 /**
  * @internal
  * Structure used to hold information about the callbacks to be called for a
@@ -426,9 +447,19 @@ typedef int (*eth_speed_lanes_get_capability_t)(struct rte_eth_dev *dev,
 						struct rte_eth_speed_lanes_capa *speed_lanes_capa,
 						unsigned int num);
 
-/** @internal Get global I/O statistics of an Ethernet device. */
+/**
+ * @internal Get global I/O statistics of an Ethernet device.
+ *
+ * @param dev
+ *   Device being queried
+ * @param stats
+ *   The stats structure to be completed by the driver and returned to the user
+ * @param qstats
+ *   Any queue statistics to be returned.
+ *   @note: This parameter can be NULL
+ */
 typedef int (*eth_stats_get_t)(struct rte_eth_dev *dev,
-				struct rte_eth_stats *igb_stats);
+				struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 
 /**
  * @internal
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 285d377d91..76a4570443 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -477,3 +477,30 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)
 	dev->data->nb_tx_queues = nb_queues;
 	return 0;
 }
+
+int
+eth_stats_qstats_get(uint16_t port_id, struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
+{
+	struct rte_eth_dev *dev;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (stats == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u stats to NULL",
+			port_id);
+		return -EINVAL;
+	}
+
+	memset(stats, 0, sizeof(*stats));
+	if (qstats != NULL)
+		memset(qstats, 0, sizeof(*qstats));
+
+	if (dev->dev_ops->stats_get == NULL)
+		return -ENOTSUP;
+	stats->rx_nombuf = dev->data->rx_mbuf_alloc_failed;
+	ret = eth_err(port_id, dev->dev_ops->stats_get(dev, stats, qstats));
+
+	return ret;
+}
diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index b07b1b4c42..2b69fb4bea 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -79,4 +79,9 @@ void eth_dev_txq_release(struct rte_eth_dev *dev, uint16_t qid);
 int eth_dev_rx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
 int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
 
+/* retrieve stats, and optionally queue stats from a device.
+ * Note: qstats parameter can be NULL if only port stats are requested.
+ */
+int eth_stats_qstats_get(uint16_t port_id, struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
+
 #endif /* _ETH_PRIVATE_H_ */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f22139cb38..aa2d5703bd 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -73,16 +73,16 @@ static const struct rte_eth_xstats_name_off eth_dev_stats_strings[] = {
 #define RTE_NB_STATS RTE_DIM(eth_dev_stats_strings)
 
 static const struct rte_eth_xstats_name_off eth_dev_rxq_stats_strings[] = {
-	{"packets", offsetof(struct rte_eth_stats, q_ipackets)},
-	{"bytes", offsetof(struct rte_eth_stats, q_ibytes)},
-	{"errors", offsetof(struct rte_eth_stats, q_errors)},
+	{"packets", offsetof(struct eth_queue_stats, q_ipackets)},
+	{"bytes", offsetof(struct eth_queue_stats, q_ibytes)},
+	{"errors", offsetof(struct eth_queue_stats, q_errors)},
 };
 
 #define RTE_NB_RXQ_STATS RTE_DIM(eth_dev_rxq_stats_strings)
 
 static const struct rte_eth_xstats_name_off eth_dev_txq_stats_strings[] = {
-	{"packets", offsetof(struct rte_eth_stats, q_opackets)},
-	{"bytes", offsetof(struct rte_eth_stats, q_obytes)},
+	{"packets", offsetof(struct eth_queue_stats, q_opackets)},
+	{"bytes", offsetof(struct eth_queue_stats, q_obytes)},
 };
 #define RTE_NB_TXQ_STATS RTE_DIM(eth_dev_txq_stats_strings)
 
@@ -3346,27 +3346,9 @@ RTE_EXPORT_SYMBOL(rte_eth_stats_get)
 int
 rte_eth_stats_get(uint16_t port_id, struct rte_eth_stats *stats)
 {
-	struct rte_eth_dev *dev;
-	int ret;
-
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
-	dev = &rte_eth_devices[port_id];
-
-	if (stats == NULL) {
-		RTE_ETHDEV_LOG_LINE(ERR, "Cannot get ethdev port %u stats to NULL",
-			port_id);
-		return -EINVAL;
-	}
-
-	memset(stats, 0, sizeof(*stats));
-
-	if (dev->dev_ops->stats_get == NULL)
-		return -ENOTSUP;
-	stats->rx_nombuf = dev->data->rx_mbuf_alloc_failed;
-	ret = eth_err(port_id, dev->dev_ops->stats_get(dev, stats));
+	int ret = eth_stats_qstats_get(port_id, stats, NULL);
 
 	rte_eth_trace_stats_get(port_id, stats, ret);
-
 	return ret;
 }
 
@@ -3709,12 +3691,13 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 {
 	struct rte_eth_dev *dev;
 	struct rte_eth_stats eth_stats;
+	struct eth_queue_stats queue_stats;
 	unsigned int count = 0, i, q;
 	uint64_t val, *stats_ptr;
 	uint16_t nb_rxqs, nb_txqs;
 	int ret;
 
-	ret = rte_eth_stats_get(port_id, &eth_stats);
+	ret = eth_stats_qstats_get(port_id, &eth_stats, &queue_stats);
 	if (ret < 0)
 		return ret;
 
@@ -3737,7 +3720,7 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 	/* per-rxq stats */
 	for (q = 0; q < nb_rxqs; q++) {
 		for (i = 0; i < RTE_NB_RXQ_STATS; i++) {
-			stats_ptr = RTE_PTR_ADD(&eth_stats,
+			stats_ptr = RTE_PTR_ADD(&queue_stats,
 					eth_dev_rxq_stats_strings[i].offset +
 					q * sizeof(uint64_t));
 			val = *stats_ptr;
@@ -3748,7 +3731,7 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 	/* per-txq stats */
 	for (q = 0; q < nb_txqs; q++) {
 		for (i = 0; i < RTE_NB_TXQ_STATS; i++) {
-			stats_ptr = RTE_PTR_ADD(&eth_stats,
+			stats_ptr = RTE_PTR_ADD(&queue_stats,
 					eth_dev_txq_stats_strings[i].offset +
 					q * sizeof(uint64_t));
 			val = *stats_ptr;
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d23c143eed..4cfc940000 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -272,17 +272,6 @@ struct rte_eth_stats {
 	uint64_t ierrors;   /**< Total number of erroneous received packets. */
 	uint64_t oerrors;   /**< Total number of failed transmitted packets. */
 	uint64_t rx_nombuf; /**< Total number of Rx mbuf allocation failures. */
-	/* Queue stats are limited to max 256 queues */
-	/** Total number of queue Rx packets. */
-	uint64_t q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of queue Tx packets. */
-	uint64_t q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of successfully received queue bytes. */
-	uint64_t q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of successfully transmitted queue bytes. */
-	uint64_t q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of queue packets received that are dropped. */
-	uint64_t q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
 };
 
 /**@{@name Link speed capabilities
diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index 5e6c4172d3..519ad34be7 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -10,6 +10,7 @@
 
 #include "rte_ethdev.h"
 #include "ethdev_driver.h"
+#include "ethdev_private.h"
 #include "sff_telemetry.h"
 #include "rte_tm.h"
 
@@ -60,20 +61,6 @@ eth_dev_handle_port_list(const char *cmd __rte_unused,
 	return 0;
 }
 
-static void
-eth_dev_add_port_queue_stats(struct rte_tel_data *d, uint64_t *q_stats,
-		const char *stat_name)
-{
-	int q;
-	struct rte_tel_data *q_data = rte_tel_data_alloc();
-	if (q_data == NULL)
-		return;
-	rte_tel_data_start_array(q_data, RTE_TEL_UINT_VAL);
-	for (q = 0; q < RTE_ETHDEV_QUEUE_STAT_CNTRS; q++)
-		rte_tel_data_add_array_uint(q_data, q_stats[q]);
-	rte_tel_data_add_dict_container(d, stat_name, q_data, 0);
-}
-
 static int
 eth_dev_parse_hide_zero(const char *key, const char *value, void *extra_args)
 {
@@ -121,11 +108,6 @@ eth_dev_handle_port_stats(const char *cmd __rte_unused,
 	ADD_DICT_STAT(stats, ierrors);
 	ADD_DICT_STAT(stats, oerrors);
 	ADD_DICT_STAT(stats, rx_nombuf);
-	eth_dev_add_port_queue_stats(d, stats.q_ipackets, "q_ipackets");
-	eth_dev_add_port_queue_stats(d, stats.q_opackets, "q_opackets");
-	eth_dev_add_port_queue_stats(d, stats.q_ibytes, "q_ibytes");
-	eth_dev_add_port_queue_stats(d, stats.q_obytes, "q_obytes");
-	eth_dev_add_port_queue_stats(d, stats.q_errors, "q_errors");
 
 	return 0;
 }
-- 
2.48.1

