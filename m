Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0724DCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 06:03:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE1A442709;
	Wed,  7 Oct 2026 08:02:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1D47440E68
 for <dev@dpdk.org>; Wed,  7 Oct 2026 08:02:40 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0E97200098;
 Wed,  7 Oct 2026 08:02:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBF4120007D;
 Wed,  7 Oct 2026 08:02:39 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6717B180023D;
 Wed,  7 Oct 2026 14:02:38 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v7-S2 07/13] net/dpaa2: set default flow miss action per device
Date: Wed,  7 Oct 2026 11:32:21 +0530
Message-ID: <20261007060227.219835-8-prashant.gupta_3@nxp.com>
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

The flow steering miss flow id was a file-scope global defaulting to 0
and optionally overridden via the DPAA2_FLOW_CONTROL_MISS_FLOW
environment variable. Replace it with a per-device default_flow field
in dpaa2_dev_priv, initialised to 0 at probe time, so that each device
has its own independent miss-flow setting.

The DPAA2_FLOW_CONTROL_MISS_FLOW environment variable is removed.
Users who relied on it must use the rte_flow API instead.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 drivers/net/dpaa2/dpaa2_ethdev.c       |  2 ++
 drivers/net/dpaa2/dpaa2_ethdev.h       |  2 ++
 drivers/net/dpaa2/dpaa2_flow.c         | 14 +-------------
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b1ebd508fd..63342b855f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -25,6 +25,10 @@ DPDK Release 26.11
   * Added Tx queue based flow control and confirmation queue handling.
   * Added software parser based packet dump for debugging.
   * Added support for traffic metering and policing (rte_mtr API).
+  * Removed ``DPAA2_FLOW_CONTROL_MISS_FLOW`` environment variable. The
+    per-device FS table miss flow id is now fixed at 0. Users who
+    previously redirected unmatched frames to a specific queue via this
+    variable must use the rte_flow API instead.
 
 New Features
 ------------
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 5f1e832ce3..b1bb080fc7 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3540,6 +3540,8 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->dist_queues = attr.num_queues;
 	priv->num_channels = attr.num_channels;
 	priv->channel_inuse = 0;
+	priv->default_flow = RTE_MIN(priv->fs_entries,
+		priv->dist_queues) - 1;
 	rte_spinlock_init(&priv->lpbk_qp_lock);
 	rte_spinlock_init(&priv->meter_lock);
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index e329111c0b..58a47cd1a2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -436,6 +436,8 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 	rte_spinlock_t meter_lock;
+	/* Lowest priority FS flow id to receive flow steering miss frames. */
+	uint16_t default_flow;
 
 	/* Current hash distribution size per RX TC, written by
 	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index f0748081b3..03f9193f51 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -24,7 +24,6 @@
 #include <dpaa2_pmd_logs.h>
 
 static char *dpaa2_flow_control_log;
-static uint16_t dpaa2_flow_miss_flow_id; /* Default miss flow id is 0. */
 static int dpaa2_sp_loaded = -1;
 
 enum dpaa2_flow_entry_size {
@@ -4590,7 +4589,7 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 		return 0;
 
 	tc_cfg.enable = true;
-	tc_cfg.fs_miss_flow_id = dpaa2_flow_miss_flow_id;
+	tc_cfg.fs_miss_flow_id = priv->default_flow;
 	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW,
 			priv->token, &tc_cfg);
 	if (ret < 0) {
@@ -5224,17 +5223,6 @@ dpaa2_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
 	dpaa2_flow_control_log =
 		getenv("DPAA2_FLOW_CONTROL_LOG");
 
-	if (getenv("DPAA2_FLOW_CONTROL_MISS_FLOW")) {
-		dpaa2_flow_miss_flow_id =
-			(uint16_t)atoi(getenv("DPAA2_FLOW_CONTROL_MISS_FLOW"));
-		if (dpaa2_flow_miss_flow_id >= priv->dist_queues) {
-			DPAA2_PMD_ERR("Missed flow ID %d >= dist size(%d)",
-				      dpaa2_flow_miss_flow_id,
-				      priv->dist_queues);
-			return NULL;
-		}
-	}
-
 	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
 			   RTE_CACHE_LINE_SIZE);
 	if (!flow) {
-- 
2.43.0

