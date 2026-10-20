Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D36606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66CDE40297;
	Tue, 20 Oct 2026 16:49:06 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0E9F1406B6
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:48:53 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E7DAA1A00B4;
 Tue, 20 Oct 2026 16:48:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B20441A008D;
 Tue, 20 Oct 2026 16:48:52 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A113180006C;
 Tue, 20 Oct 2026 22:48:51 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v14-S2 06/10] net/dpaa2: set default flow miss action per
 device
Date: Tue, 20 Oct 2026 20:18:37 +0530
Message-ID: <20261020144841.506038-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Remove the DPAA2_FLOW_CONTROL_MISS_FLOW environment variable and use
the last Rx queue configured in the traffic class as the default
flow steering miss queue.

Users who relied on the environment variable must use the rte_flow API
instead.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 drivers/net/dpaa2/dpaa2_flow.c         | 18 +++++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 934efaaf93..9835d74b17 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -105,6 +105,11 @@ New Features
 
   * Added the inner IP header to the RSS hash so tunneled traffic is
     distributed across the Rx queues.
+  * Removed ``DPAA2_FLOW_CONTROL_MISS_FLOW`` environment variable. The
+    flow steering miss queue now defaults to the last Rx queue configured
+    in the traffic class. Users who previously redirected unmatched
+    frames to a specific queue via this variable must use the rte_flow
+    API instead.
 
 * **Updated NXP ENETC4 PMD.**
 
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index f0748081b3..04b6618bbf 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -24,7 +24,6 @@
 #include <dpaa2_pmd_logs.h>
 
 static char *dpaa2_flow_control_log;
-static uint16_t dpaa2_flow_miss_flow_id; /* Default miss flow id is 0. */
 static int dpaa2_sp_loaded = -1;
 
 enum dpaa2_flow_entry_size {
@@ -4589,8 +4588,12 @@ dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
 	if (rss_dist)
 		return 0;
 
+	uint16_t nb_rxq = priv->eth_dev->data->nb_rx_queues;
+	uint16_t first = tc_id * dist_size;
+
 	tc_cfg.enable = true;
-	tc_cfg.fs_miss_flow_id = dpaa2_flow_miss_flow_id;
+	tc_cfg.fs_miss_flow_id = nb_rxq > first ?
+		RTE_MIN(dist_size, nb_rxq - first) - 1 : 0;
 	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW,
 			priv->token, &tc_cfg);
 	if (ret < 0) {
@@ -5224,17 +5227,6 @@ dpaa2_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
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

