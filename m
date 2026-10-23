Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76900606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D29440E34;
	Fri, 23 Oct 2026 15:44:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A632840DDC
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86EB21A000A;
 Fri, 23 Oct 2026 15:44:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 512BA1A0021;
 Fri, 23 Oct 2026 15:44:12 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4627118000B7;
 Fri, 23 Oct 2026 21:44:11 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 19/65] net/dpaa2: reimplement xstats_get() on top of
 xstats_get_by_id()
Date: Fri, 23 Oct 2026 19:12:59 +0530
Message-ID: <20261023134346.37727-20-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
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

dpaa2_dev_xstats_get() duplicated almost all of the logic already
present in dpaa2_dev_xstats_get_by_id(): it walked the DPNI pages
one by one with dpaa2_xstats_id_parse(), called dpni_get_statistics()
per page, special-cased the DPMAC counter range with its own
dpni_get_mac_statistics() path, handled per-page/per-MAC availability
with inline zero-fill loops, etc. All of that behavior is already
provided by dpaa2_dev_xstats_get_by_id(), so the standalone
implementation was just a second place to keep in sync.

Rewrite dpaa2_dev_xstats_get() as a thin wrapper:

- Clamp the requested count to DPAA2_XSTAT_MAX_NUM (new helper
  defined as sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t))
  with a warning when the caller asks for more.
- Build a trivial [0..n) id array, pre-zero the xstats[] entries,
  and call dpaa2_dev_xstats_get_by_id() once.
- Copy the returned values into xstats[].value and return the
  number of entries dpaa2_dev_xstats_get_by_id() produced.

Also reuse DPAA2_XSTAT_MAX_NUM in dpaa2_dev_xstats_get_names() and
dpaa2_dev_xstats_get_names_by_id() in place of the open-coded
sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t) local array
sizes, and move dpaa2_dev_xstats_get() below the _by_id variants
to reflect the new dependency direction.

No functional change: availability gating (DPNI page / DPMAC MC
version), per-page dpni_get_statistics() batching and the DPMAC
dpni_get_mac_statistics() path are all still performed, now solely
inside dpaa2_dev_xstats_get_by_id().

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 146 +++++++++----------------------
 1 file changed, 42 insertions(+), 104 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b30a8e7b3d..a0c5eccf57 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -180,6 +180,9 @@ struct dpaa2_xstats_seq {
 	struct dpni_dpmac_counters mac_cnt;
 };
 
+#define DPAA2_XSTAT_MAX_NUM \
+	(sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t))
+
 #define DPAA2_DPNI_XSTAT_MAX_NUM \
 	(offsetof(struct dpaa2_xstats_seq, mac_cnt) / sizeof(uint64_t))
 
@@ -2186,115 +2189,13 @@ dpaa2_dev_dpni_xstats_avail(struct rte_eth_dev *dev,
 	return false;
 }
 
-/*
- * dpaa2_dev_xstats_get(): Get counters of dpni and dpmac.
- * MAC (mac_*) counters are supported on MC version > 10.39.0
- * TC_x_policer_* counters are supported only when Policer is enable.
- */
-static int
-dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
-	struct rte_eth_xstat *xstats, uint32_t n)
-{
-	struct fsl_mc_io *dpni = dev->process_private;
-	uint16_t i, j, param, stat_cnt, size;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	union dpni_statistics values;
-	uint8_t page_id, stat_id;
-	uint64_t *cnt_values;
-	int retcode;
-
-	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
-	if (priv->ep_dev_type == DPAA2_MAC)
-		stat_cnt += DPAA2_MAC_NUM_STATS;
-
-	if (n > stat_cnt) {
-		DPAA2_PMD_ERR("%s: Expected number(%d) > max number(%d)",
-			__func__, n, stat_cnt);
-		return -EINVAL;
-	}
-
-	if (!xstats)
-		return 0;
-
-	i = 0;
-	while (i < n) {
-		if (i >= DPAA2_MAC_XSTATS_START_ID) {
-			if (!dpaa2_dev_mac_xstats_avail(dev)) {
-				for (j = i; j < n; j++) {
-					xstats[j].id = j;
-					xstats[j].value = 0;
-				}
-				i = n;
-				break;
-			}
-			goto dpmac_get_xstat;
-		}
-
-		page_id = 0;
-		stat_id = 0;
-		param = 0;
-		retcode = dpaa2_xstats_id_parse(i, &page_id, &stat_id, &param, &size);
-		if (retcode)
-			return retcode;
-		if (!dpaa2_dev_dpni_xstats_avail(dev, page_id, param)) {
-			xstats[i].id = i;
-			xstats[i].value = 0;
-			i++;
-			continue;
-		}
-		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
-			priv->token, page_id, param, &values);
-		if (retcode) {
-			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's statistcis of page%d!",
-				__func__, retcode, dev->data->name, page_id);
-			return retcode;
-		}
-		cnt_values = (void *)&values;
-		j = stat_id;
-		while (i < n && j < size) {
-			xstats[i].id = i;
-			xstats[i].value = cnt_values[j];
-			i++;
-			j++;
-		}
-		continue;
-
-dpmac_get_xstat:
-		retcode = dpaa2_dev_xstat_mac_setup_mem(dev);
-		if (retcode) {
-			DPAA2_PMD_ERR("%s: Failed(%d) to setup %s MAC statistics!",
-				__func__, retcode, dev->data->name);
-			return retcode;
-		}
-		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW,
-			priv->token, priv->cnt_idx_iova,
-			priv->cnt_values_iova, DPAA2_MAC_NUM_STATS);
-		if (retcode) {
-			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's MAC statistics!",
-				__func__, retcode, dev->data->name);
-			return retcode;
-		}
-		cnt_values = priv->cnt_values_dma_mem;
-
-		j = i - DPAA2_MAC_XSTATS_START_ID;
-		while (i < n && j < DPAA2_MAC_NUM_STATS) {
-			xstats[i].id = i;
-			xstats[i].value = cnt_values[j];
-			i++;
-			j++;
-		}
-	}
-
-	return i;
-}
-
 static int
 dpaa2_dev_xstats_get_names(struct rte_eth_dev *dev,
 	struct rte_eth_xstat_name *xstats_names, uint32_t limit)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	uint16_t i, stat_cnt;
-	uint64_t xstat_str[sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t)];
+	uint64_t xstat_str[DPAA2_XSTAT_MAX_NUM];
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
 	if (priv->ep_dev_type == DPAA2_MAC)
@@ -2420,7 +2321,7 @@ dpaa2_dev_xstats_get_names_by_id(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	uint16_t i, stat_cnt;
-	uint64_t xstat_str[sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t)];
+	uint64_t xstat_str[DPAA2_XSTAT_MAX_NUM];
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
 	if (priv->ep_dev_type == DPAA2_MAC)
@@ -2442,6 +2343,43 @@ dpaa2_dev_xstats_get_names_by_id(struct rte_eth_dev *dev,
 	return limit;
 }
 
+/*
+ * dpaa2_dev_xstats_get(): Get counters of dpni and dpmac.
+ * MAC (mac_*) counters are supported on MC version > 10.39.0
+ * TC_x_policer_* counters are supported only when Policer is enable.
+ */
+static int
+dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
+	struct rte_eth_xstat *xstats, uint32_t n)
+{
+	int retcode;
+	uint32_t i;
+	uint64_t ids[DPAA2_XSTAT_MAX_NUM], vals[DPAA2_XSTAT_MAX_NUM];
+
+	if (!xstats || !n)
+		return 0;
+
+	if (n > DPAA2_XSTAT_MAX_NUM) {
+		DPAA2_PMD_WARN("%s: Expected xstat number(%d) > max(%ld)",
+			__func__, n, DPAA2_XSTAT_MAX_NUM);
+		n = DPAA2_XSTAT_MAX_NUM;
+	}
+	for (i = 0; i < n; i++) {
+		ids[i] = i;
+		xstats[i].id = i;
+		xstats[i].value = 0;
+	}
+
+	retcode = dpaa2_dev_xstats_get_by_id(dev, ids, vals, n);
+	if (retcode < 0)
+		return retcode;
+
+	for (i = 0; i < (uint32_t)retcode; i++)
+		xstats[i].value = vals[i];
+
+	return retcode;
+}
+
 static int
 dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
-- 
2.43.0

