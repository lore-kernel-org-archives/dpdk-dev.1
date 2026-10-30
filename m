Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00A606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8A4540A6F;
	Fri, 30 Oct 2026 06:20:26 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FCFC406FF
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:24 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 473231A00C0;
 Fri, 30 Oct 2026 06:20:24 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DBA9F1A00BF;
 Fri, 30 Oct 2026 06:20:23 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 824021800068;
 Fri, 30 Oct 2026 13:20:22 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 02/14] drivers: net/dpaa2 centralize devargs definitions
Date: Fri, 30 Oct 2026 10:50:04 +0530
Message-ID: <20261030052016.3301766-3-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Add a common dpaax_devarg.h header providing the dpaax_devargs type, the
dpaax_get_devargs() parse helper, and two X-macro operators:

  DPAAX_DEVARG_TABLE_ENTRY(key, handle, flag)  -> {key, handle, flag},
  DPAAX_DEVARG_STRING_ENTRY(key, handle, flag) -> key "=<int> "

Convert the dpaa2 net driver to declare its device arguments once via a
single DPAA2_DEVARGS(ENTRY) list. The same list now builds both the
parse table (s_dpaa2_devargs) and the RTE_PMD_REGISTER_PARAM_STRING
valid-args string, so every key is spelled exactly once. The per-arg
string defines and the hand-written dpaa2_get_devargs()/
check_devargs_handler() lookups are replaced by a single
dpaax_get_devargs() call that sets priv->flags.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa2.rst           |   4 +
 drivers/common/dpaax/dpaax_devarg.h | 112 +++++++++++++++++
 drivers/net/dpaa2/dpaa2_ethdev.c    | 188 +++++++++-------------------
 3 files changed, 177 insertions(+), 127 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_devarg.h

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 60ca695f59..826eb4340c 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -494,6 +494,10 @@ Refer to the document :doc:`build_and_test` for details.
   packets, so that user can check what is wrong with those packets.
   e.g. ``fslmc:dpni.1,drv_error_queue=1``
 
+* Use dev arg option ``drv_strict_order=1`` to enable strict ordering.
+  By default, loose ordering is set for ordered schedule type event.
+  e.g. ``fslmc:dpni.1,drv_strict_order=1``
+
 Enabling logs
 -------------
 
diff --git a/drivers/common/dpaax/dpaax_devarg.h b/drivers/common/dpaax/dpaax_devarg.h
new file mode 100644
index 0000000000..cd91d286e2
--- /dev/null
+++ b/drivers/common/dpaax/dpaax_devarg.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+#ifndef _DPAAX_DEVARG_H_
+#define _DPAAX_DEVARG_H_
+#include <stdlib.h>
+#include <rte_kvargs.h>
+#include <ethdev_driver.h>
+#include <rte_log.h>
+
+static inline __rte_format_printf(2, 3) void
+dpaax_devargs_dump(uint32_t level, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	rte_vlog(level, RTE_LOGTYPE_USER1, fmt, ap);
+	va_end(ap);
+}
+
+struct dpaax_devargs {
+	const char *arg_key;
+	void (*handle)(void *vdev, const char *key, int val);
+	uint64_t flag_bit;
+};
+
+/* Shared expansions for a driver's devargs X-macro list.
+ *
+ * A driver declares its argument list once as a list-macro that takes the
+ * per-entry operator as a parameter, for example:
+ *
+ *   #define MY_DEVARGS(ENTRY) \
+ *     ENTRY("drv_foo", foo_handler, 0) \
+ *     ENTRY("drv_bar", NULL, MY_BAR_FLAG)
+ *
+ * The same list then generates both the parse table and the registered
+ * valid-args string by passing the matching operator below:
+ *
+ *   static const struct dpaax_devargs s_my_devargs[] = {
+ *     MY_DEVARGS(DPAAX_DEVARG_TABLE_ENTRY)
+ *   };
+ *   RTE_PMD_REGISTER_PARAM_STRING(name, MY_DEVARGS(DPAAX_DEVARG_STRING_ENTRY));
+ *
+ * This keeps each key spelled exactly once.
+ */
+#define DPAAX_DEVARG_TABLE_ENTRY(key, handle, flag) {key, handle, flag},
+#define DPAAX_DEVARG_STRING_ENTRY(key, handle, flag) key "=<int> "
+
+static inline void
+dpaax_get_devargs_impl(const struct dpaax_devargs *dev_args,
+	uint32_t arg_num, struct rte_device *rdev, void *dev, void *flags)
+{
+	struct rte_kvargs *kvlist = NULL;
+	struct rte_kvargs_pair *pair;
+	uint32_t arg_idx, kv_idx;
+	uint32_t flag_bit;
+	char *end = NULL;
+	int val;
+
+	if (rdev->devargs)
+		kvlist = rte_kvargs_parse(rdev->devargs->args, NULL);
+
+	if (!kvlist)
+		return;
+
+	for (arg_idx = 0; arg_idx < arg_num; arg_idx++) {
+		for (kv_idx = 0; kv_idx < kvlist->count; kv_idx++) {
+			pair = &kvlist->pairs[kv_idx];
+			if (strcmp(pair->key, dev_args[arg_idx].arg_key))
+				continue;
+
+			if (!pair->value) {
+				dpaax_devargs_dump(RTE_LOG_WARNING,
+					"Argument(%s)'s val is not set\n", pair->key);
+				continue;
+			}
+			errno = 0;
+			val = (int)strtoul(pair->value, &end, 0);
+			if (errno || end == pair->value || *end != '\0') {
+				dpaax_devargs_dump(RTE_LOG_WARNING,
+					"Failed to get value of %s", pair->key);
+				continue;
+			}
+
+			if ((!dev_args[arg_idx].flag_bit || !flags) &&
+			    !dev_args[arg_idx].handle) {
+				dpaax_devargs_dump(RTE_LOG_WARNING,
+					"No action for argument(%s)\n", pair->key);
+				continue;
+			}
+
+			if (flags) {
+				flag_bit = dev_args[arg_idx].flag_bit;
+				if (val)
+					*((uint32_t *)flags) |= flag_bit;
+				else
+					*((uint32_t *)flags) &= ~flag_bit;
+			}
+
+			if (dev_args[arg_idx].handle)
+				dev_args[arg_idx].handle(dev, pair->key, val);
+		}
+	}
+
+	rte_kvargs_free(kvlist);
+}
+
+#define dpaax_get_devargs(dev_args, dev, flags) \
+	dpaax_get_devargs_impl((dev_args), RTE_DIM(dev_args), \
+		(dev)->device, (dev), (flags))
+#endif /* _DPAAX_DEVARG_H_ */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index e69dc5b9a2..fb3757aaeb 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -31,18 +31,44 @@
 #include "dpaa2_ethdev.h"
 #include "dpaa2_sparser.h"
 #include <fsl_qbman_debug.h>
+#include <dpaax_devarg.h>
+
+static void
+dpaa2_dev_args_set_strict_order(void *vdev, const char *key, int val)
+{
+	struct rte_eth_dev *dev = vdev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	RTE_SET_USED(key);
+
+	priv->en_loose_ordered = !val;
+}
+
+/* Single source of truth for dpaa2 devargs:
+ *   ENTRY(key-string, handle, flag-bit)
+ * handle is an optional per-arg callback (NULL if the arg only sets a flag).
+ * Both the parse table (s_dpaa2_devargs) and the registered valid-args
+ * string are generated from this list, so each key is spelled once. The
+ * ENTRY operator (table vs string form) is provided by dpaax_devarg.h.
+ */
+#define DPAA2_DEVARGS(ENTRY) \
+	ENTRY("drv_loopback", NULL, DPAA2_RX_LOOPBACK_MODE) \
+	ENTRY("drv_no_prefetch", NULL, DPAA2_NO_PREFETCH_RX) \
+	ENTRY("drv_tx_conf", NULL, DPAA2_TX_CONF_ENABLE) \
+	ENTRY("drv_rx_parse_drop", NULL, DPAA2_PARSE_ERR_DROP) \
+	ENTRY("drv_rx_print_parser_result", NULL, DPAA2_RX_PRINT_PSR_RESULT_FLAG) \
+	ENTRY("drv_error_queue", NULL, DPAA2_RX_ERROR_QUEUE_FLAG) \
+	ENTRY("drv_no_taildrop", NULL, DPAA2_RX_TAILDROP_OFF) \
+	ENTRY("drv_no_data_stashing", NULL, DPAA2_RX_DATA_STASHING_OFF_FLAG) \
+	ENTRY("drv_strict_order", dpaa2_dev_args_set_strict_order, 0)
 
-#define DRIVER_LOOPBACK_MODE "drv_loopback"
-#define DRIVER_NO_PREFETCH_MODE "drv_no_prefetch"
-#define DRIVER_TX_CONF "drv_tx_conf"
-#define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
-#define DRIVER_RX_PRINT_PARSER_RESULT "drv_rx_print_parser_result"
-#define DRIVER_ERROR_QUEUE  "drv_err_queue"
-#define DRIVER_NO_TAILDROP  "drv_no_taildrop"
-#define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
+static const struct dpaax_devargs s_dpaa2_devargs[] = {
+	DPAA2_DEVARGS(DPAAX_DEVARG_TABLE_ENTRY)
+};
+
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |
@@ -2877,13 +2903,7 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		/* ORL resource exhaustion advance NESN disabled */
 		ocfg.oeane = 0;
 		/* Loose ordering enabled */
-		ocfg.oloe = 1;
-		eth_priv->en_loose_ordered = 1;
-		/* Strict ordering enabled if explicitly set */
-		if (getenv("DPAA2_STRICT_ORDERING_ENABLE")) {
-			ocfg.oloe = 0;
-			eth_priv->en_loose_ordered = 0;
-		}
+		ocfg.oloe = eth_priv->en_loose_ordered ? 1 : 0;
 
 		ret = dpni_set_opr(dpni, CMD_PRI_LOW, eth_priv->token,
 				   dpaa2_ethq->tc_index, flow_id,
@@ -3398,47 +3418,9 @@ populate_mac_addr(struct fsl_mc_io *dpni_dev,
 	return ret;
 }
 
-static int
-check_devargs_handler(__rte_unused const char *key, const char *value,
-		      __rte_unused void *opaque)
-{
-	if (strcmp(value, "1"))
-		return -1;
-
-	return 0;
-}
-
-static int
-dpaa2_get_devargs(struct rte_devargs *devargs, const char *key)
-{
-	struct rte_kvargs *kvlist;
-
-	if (!devargs)
-		return 0;
-
-	kvlist = rte_kvargs_parse(devargs->args, NULL);
-	if (!kvlist)
-		return 0;
-
-	if (!rte_kvargs_count(kvlist, key)) {
-		rte_kvargs_free(kvlist);
-		return 0;
-	}
-
-	if (rte_kvargs_process(kvlist, key,
-			       check_devargs_handler, NULL) < 0) {
-		rte_kvargs_free(kvlist);
-		return 0;
-	}
-	rte_kvargs_free(kvlist);
-
-	return 1;
-}
-
 static int
 dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_device *dev = eth_dev->device;
 	struct rte_dpaa2_device *dpaa2_dev;
 	struct fsl_mc_io *dpni_dev;
 	struct dpni_attr attr;
@@ -3456,42 +3438,35 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	dpni_dev->regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 	eth_dev->process_private = dpni_dev;
 
-	/* RX no prefetch mode? */
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_PREFETCH_MODE)) {
-		priv->flags |= DPAA2_NO_PREFETCH_RX;
-		DPAA2_PMD_INFO("No RX prefetch mode");
-	}
-
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
-		priv->flags |= DPAA2_RX_LOOPBACK_MODE;
-		DPAA2_PMD_INFO("Rx loopback mode");
-	}
-
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_TAILDROP)) {
-		priv->flags |= DPAA2_RX_TAILDROP_OFF;
-		DPAA2_PMD_INFO("Rx taildrop disabled");
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		priv->flags = 0;
+		priv->en_loose_ordered = 1;
+		dpaax_get_devargs(s_dpaa2_devargs, eth_dev, &priv->flags);
+		/** Preserve support for the legacy environment variables.
+		 * The equivalent devargs control already exists, but existing
+		 * deployments may still rely on the environment variable.
+		 * Keep honoring it to avoid silently changing user-visible behavior.
+		 */
+		if (getenv("DPAA2_DATA_STASHING_OFF"))
+			priv->flags |= DPAA2_RX_DATA_STASHING_OFF_FLAG;
+		if (getenv("DPAA2_STRICT_ORDERING_ENABLE"))
+			priv->en_loose_ordered = 0;
 	}
 
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING) ||
-	    getenv("DPAA2_DATA_STASHING_OFF")) {
-		priv->flags |= DPAA2_RX_DATA_STASHING_OFF_FLAG;
-		DPAA2_PMD_INFO("Data stashing disabled");
-	}
+	eth_dev->dev_ops = &dpaa2_ethdev_ops;
+	eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
+	if (priv->flags & DPAA2_RX_LOOPBACK_MODE)
+		eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
+	else if (priv->flags & DPAA2_NO_PREFETCH_RX)
+		eth_dev->rx_pkt_burst = dpaa2_dev_rx;
+	else
+		eth_dev->rx_pkt_burst = dpaa2_dev_prefetch_rx;
+	eth_dev->tx_pkt_burst = dpaa2_dev_tx;
 
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
-		/* In case of secondary, only burst and ops API need to be
-		 * plugged.
+		/* In case of secondary, everything is done here.
 		 */
-		eth_dev->dev_ops = &dpaa2_ethdev_ops;
-		eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
-		if (priv->flags & DPAA2_RX_LOOPBACK_MODE)
-			eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
-		else if (priv->flags & DPAA2_NO_PREFETCH_RX)
-			eth_dev->rx_pkt_burst = dpaa2_dev_rx;
-		else
-			eth_dev->rx_pkt_burst = dpaa2_dev_prefetch_rx;
-		eth_dev->tx_pkt_burst = dpaa2_dev_tx;
 		return 0;
 	}
 
@@ -3564,30 +3539,10 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->options = attr.options;
 	priv->max_mac_filters = attr.mac_filter_entries;
 	priv->max_vlan_filters = attr.vlan_filter_entries;
-	priv->flags = 0;
 #if defined(RTE_LIBRTE_IEEE1588)
 	DPAA2_PMD_INFO("DPDK IEEE1588 is enabled");
 	priv->flags |= DPAA2_TX_CONF_ENABLE;
 #endif
-	/* Used with ``fslmc:dpni.1,drv_tx_conf=1`` */
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_TX_CONF)) {
-		priv->flags |= DPAA2_TX_CONF_ENABLE;
-		DPAA2_PMD_INFO("TX_CONF Enabled");
-	}
-
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_ERROR_QUEUE)) {
-		priv->flags |= DPAA2_RX_ERROR_QUEUE_FLAG;
-		DPAA2_PMD_INFO("Enable error queue");
-	}
-
-	/* Packets with parse error to be dropped in hw */
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_RX_PARSE_ERR_DROP)) {
-		priv->flags |= DPAA2_PARSE_ERR_DROP;
-		DPAA2_PMD_INFO("Drop parse error packets in hw");
-	}
-
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_RX_PRINT_PARSER_RESULT))
-		priv->flags |= DPAA2_RX_PRINT_PSR_RESULT_FLAG;
 
 	/* Allocate memory for hardware structure for queues */
 	ret = dpaa2_alloc_rx_tx_queues(eth_dev);
@@ -3666,20 +3621,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
-	eth_dev->dev_ops = &dpaa2_ethdev_ops;
-	eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
-
-	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
-		eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
-		DPAA2_PMD_INFO("Loopback mode");
-	} else if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_PREFETCH_MODE)) {
-		eth_dev->rx_pkt_burst = dpaa2_dev_rx;
-		DPAA2_PMD_INFO("No Prefetch mode");
-	} else {
-		eth_dev->rx_pkt_burst = dpaa2_dev_prefetch_rx;
-	}
-	eth_dev->tx_pkt_burst = dpaa2_dev_tx;
-
 	/* Init fields w.r.t. classification */
 	memset(&priv->extract.qos_key_extract, 0,
 		sizeof(struct dpaa2_key_extract));
@@ -3704,8 +3645,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	ret = dpni_set_max_frame_length(dpni_dev, CMD_PRI_LOW, priv->token,
-					RTE_ETHER_MAX_LEN - RTE_ETHER_CRC_LEN
-					+ VLAN_TAG_SIZE);
+		RTE_ETHER_MAX_LEN - RTE_ETHER_CRC_LEN + VLAN_TAG_SIZE);
 	if (ret) {
 		DPAA2_PMD_ERR("Unable to set mtu. check config");
 		goto init_err;
@@ -3985,12 +3925,6 @@ static struct rte_dpaa2_driver rte_dpaa2_pmd = {
 
 RTE_PMD_REGISTER_DPAA2(NET_DPAA2_PMD_DRIVER_NAME, rte_dpaa2_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
-		DRIVER_LOOPBACK_MODE "=<int> "
-		DRIVER_NO_PREFETCH_MODE "=<int>"
-		DRIVER_TX_CONF "=<int>"
-		DRIVER_RX_PARSE_ERR_DROP "=<int>"
-		DRIVER_RX_PRINT_PARSER_RESULT "=<int>"
-		DRIVER_ERROR_QUEUE "=<int>"
-		DRIVER_NO_TAILDROP "=<int>"
-		DRIVER_NO_DATA_STASHING "=<int>");
+		DPAA2_DEVARGS(DPAAX_DEVARG_STRING_ENTRY)
+);
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
-- 
2.43.0

