Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D9606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4148A40E39;
	Fri, 23 Oct 2026 15:44:24 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1CAFA40A82
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:14 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F31431A003D;
 Fri, 23 Oct 2026 15:44:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BCD2A1A000A;
 Fri, 23 Oct 2026 15:44:13 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6174E180006C;
 Fri, 23 Oct 2026 21:44:12 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 20/65] net/dpaa2: fetch only requested MAC xstats in one
 MC call
Date: Fri, 23 Oct 2026 19:13:00 +0530
Message-ID: <20261023134346.37727-21-prashant.gupta_3@nxp.com>
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

dpaa2_dev_xstats_get_by_id() previously handled MAC counters by
issuing dpni_get_mac_statistics() for all DPAA2_MAC_NUM_STATS
counters on the first MAC id seen, caching the full result in
priv->cnt_values_dma_mem, and indexing into it for the remaining
MAC ids in the same call. That had two drawbacks:

- Every caller that asked for even a single MAC counter paid for a
  full-block MC fetch.
- The cnt_idx_dma_mem table was pre-populated at setup time with a
  fixed 0..N-1 index list, so the MC command was effectively locked
  to "read all counters in order".

Rework the MAC path to build the index list on the fly from the
ids the caller actually requested:

- Drop the one-shot cnt_idx_dma_mem initialisation in
  dpaa2_dev_xstat_mac_setup_mem(); it now only allocates and maps
  the DMA buffers.
- Call dpaa2_dev_xstat_mac_setup_mem() once at the top of
  dpaa2_dev_xstats_get_by_id() so the DMA memory is always ready.
- While walking ids[], for every id in the MAC range populate
  mac_idx[mac_num] with the MAC counter index and remember the
  destination slot in mac_val[mac_num]; zero values[i] up front
  so unavailable MAC counters stay zero.
- After the DPNI loop, if mac_num > 0 issue a single
  dpni_get_mac_statistics() for exactly mac_num entries and
  scatter the results back through mac_val[]. Removes the
  mac_fetched flag and the dpmac_get_xstat / dpni_get_xstat
  gotos.

Also replace the open-coded `priv->ep_dev_type == DPAA2_MAC`
checks in dpaa2_dev_xstats_get_names(),
dpaa2_dev_xstats_get_names_by_id() and _get_by_id() with the
existing dpaa2_dev_mac_xstats_avail() helper, so MAC xstats are
only exposed when both the endpoint is DPAA2_MAC and the MC
version supports them.

Introduce DPAA2_MAC_XSTAT_MAX_NUM (= DPAA2_MAC_NUM_STATS) and a
static_assert that
DPAA2_DPNI_XSTAT_MAX_NUM + DPAA2_MAC_XSTAT_MAX_NUM
equals DPAA2_XSTAT_MAX_NUM, so the DPNI+MAC id space stays
consistent with struct dpaa2_xstats_seq.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 97 +++++++++++++++-----------------
 1 file changed, 44 insertions(+), 53 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index a0c5eccf57..5dcdc6fa76 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -186,6 +186,10 @@ struct dpaa2_xstats_seq {
 #define DPAA2_DPNI_XSTAT_MAX_NUM \
 	(offsetof(struct dpaa2_xstats_seq, mac_cnt) / sizeof(uint64_t))
 
+#define DPAA2_MAC_XSTAT_MAX_NUM DPAA2_MAC_NUM_STATS
+
+static_assert((DPAA2_DPNI_XSTAT_MAX_NUM + DPAA2_MAC_XSTAT_MAX_NUM) == DPAA2_XSTAT_MAX_NUM);
+
 #define DPAA2_DPNI_STAT_SET_PAGE_PARAM(param) \
 ({ \
 	int ret = false; \
@@ -2099,7 +2103,6 @@ static int
 dpaa2_dev_xstat_mac_setup_mem(struct rte_eth_dev *dev)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	uint32_t *cnt_idx, i;
 	int ret = 0;
 
 	if (!priv->cnt_idx_dma_mem) {
@@ -2118,9 +2121,6 @@ dpaa2_dev_xstat_mac_setup_mem(struct rte_eth_dev *dev)
 				__func__, priv->cnt_idx_dma_mem);
 			goto err_dma_map;
 		}
-		cnt_idx = priv->cnt_idx_dma_mem;
-		for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-			cnt_idx[i] = rte_cpu_to_le_32(i);
 	}
 
 	if (!priv->cnt_values_dma_mem) {
@@ -2193,13 +2193,12 @@ static int
 dpaa2_dev_xstats_get_names(struct rte_eth_dev *dev,
 	struct rte_eth_xstat_name *xstats_names, uint32_t limit)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	uint16_t i, stat_cnt;
 	uint64_t xstat_str[DPAA2_XSTAT_MAX_NUM];
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
-	if (priv->ep_dev_type == DPAA2_MAC)
-		stat_cnt += DPAA2_MAC_NUM_STATS;
+	if (dpaa2_dev_mac_xstats_avail(dev))
+		stat_cnt += DPAA2_MAC_XSTAT_MAX_NUM;
 
 	if (!limit)
 		return stat_cnt;
@@ -2222,20 +2221,28 @@ static int
 dpaa2_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 	uint64_t *values, uint32_t n)
 {
-	uint16_t i, id, stat_cnt;
+	uint16_t i, id, stat_cnt, mac_num = 0;
 	uint8_t page_id, stat_id;
 	uint16_t param;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = dev->process_private;
 	bool page_fetched[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
-	/* Fetch all MAC counters in a single MC command on first MAC xstat. */
-	bool mac_fetched = false;
+	/* Fetch required MAC counters in a single MC command. */
 	int retcode;
-	uint64_t *cnt_values;
+	uint32_t *mac_idx;
+	uint64_t *mac_val[DPAA2_MAC_XSTAT_MAX_NUM];
+
+	retcode = dpaa2_dev_xstat_mac_setup_mem(dev);
+	if (retcode) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to setup %s's MAC statistics!",
+			__func__, retcode, dev->data->name);
+		return retcode;
+	}
+	mac_idx = priv->cnt_idx_dma_mem;
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
-	if (priv->ep_dev_type == DPAA2_MAC)
-		stat_cnt += DPAA2_MAC_NUM_STATS;
+	if (dpaa2_dev_mac_xstats_avail(dev))
+		stat_cnt += DPAA2_MAC_XSTAT_MAX_NUM;
 
 	memset(page_fetched, 0, sizeof(page_fetched));
 
@@ -2246,16 +2253,13 @@ dpaa2_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		}
 		id = ids ? ids[i] : i;
 		if (id >= DPAA2_MAC_XSTATS_START_ID) {
-			if (!dpaa2_dev_mac_xstats_avail(dev)) {
-				values[i] = 0;
-				continue;
-			}
-			if (mac_fetched) {
-				cnt_values = priv->cnt_values_dma_mem;
-				values[i] = cnt_values[id - DPAA2_MAC_XSTATS_START_ID];
-				continue;
+			values[i] = 0;
+			if (dpaa2_dev_mac_xstats_avail(dev)) {
+				mac_idx[mac_num] = rte_cpu_to_le_32(id - DPAA2_MAC_XSTATS_START_ID);
+				mac_val[mac_num] = &values[i];
+				mac_num++;
 			}
-			goto dpmac_get_xstat;
+			continue;
 		}
 		page_id = 0;
 		stat_id = 0;
@@ -2267,35 +2271,10 @@ dpaa2_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 			values[i] = 0;
 			continue;
 		}
-		if (!page_fetched[page_id][param])
-			goto dpni_get_xstat;
-		values[i] = priv->pg_xstats[page_id][param].raw.counter[stat_id];
-		continue;
-
-dpmac_get_xstat:
-		/* Single MC call fetches all MAC counters at once;
-		 * reuse the result for every subsequent MAC xstat.
-		 */
-		retcode = dpaa2_dev_xstat_mac_setup_mem(dev);
-		if (retcode) {
-			DPAA2_PMD_ERR("%s: Failed(%d) to setup %s's MAC statistics!",
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
+		if (page_fetched[page_id][param]) {
+			values[i] = priv->pg_xstats[page_id][param].raw.counter[stat_id];
+			continue;
 		}
-		mac_fetched = true;
-		cnt_values = priv->cnt_values_dma_mem;
-		values[i] = cnt_values[id - DPAA2_MAC_XSTATS_START_ID];
-		continue;
-
-dpni_get_xstat:
 		/* Cache dpni page results: multiple xstats can share
 		 * the same (page_id, param), so only fetch each pair once.
 		 */
@@ -2311,6 +2290,19 @@ dpaa2_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		values[i] = priv->pg_xstats[page_id][param].raw.counter[stat_id];
 	}
 
+	if (mac_num > 0) {
+		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW,
+			priv->token, priv->cnt_idx_iova,
+			priv->cnt_values_iova, mac_num);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's %d MAC statistics!",
+				__func__, retcode, dev->data->name, mac_num);
+			return retcode;
+		}
+		for (i = 0; i < mac_num; i++)
+			*mac_val[i] = priv->cnt_values_dma_mem[i];
+	}
+
 	return n;
 }
 
@@ -2319,13 +2311,12 @@ dpaa2_dev_xstats_get_names_by_id(struct rte_eth_dev *dev,
 	const uint64_t *ids, struct rte_eth_xstat_name *xstats_names,
 	uint32_t limit)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	uint16_t i, stat_cnt;
 	uint64_t xstat_str[DPAA2_XSTAT_MAX_NUM];
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
-	if (priv->ep_dev_type == DPAA2_MAC)
-		stat_cnt += DPAA2_MAC_NUM_STATS;
+	if (dpaa2_dev_mac_xstats_avail(dev))
+		stat_cnt += DPAA2_MAC_XSTAT_MAX_NUM;
 
 	if (!ids)
 		return dpaa2_dev_xstats_get_names(dev, xstats_names, limit);
-- 
2.43.0

