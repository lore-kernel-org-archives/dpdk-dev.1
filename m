Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B39BCA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2EA41149;
	Tue,  6 Oct 2026 17:08:02 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A417940EE5;
 Tue,  6 Oct 2026 17:08:00 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83517200039;
 Tue,  6 Oct 2026 17:08:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EAAD200019;
 Tue,  6 Oct 2026 17:08:00 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A1914180006C;
 Tue,  6 Oct 2026 23:07:58 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org, Jun Yang <jun.yang@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v6-S1 6/6] mempool/dpaa2: look up ops index locally in
 secondary
Date: Tue,  6 Oct 2026 20:37:49 +0530
Message-ID: <20261006150749.3591526-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
References: <20260929142117.3109066-1-prashant.gupta_3@nxp.com>
 <20261006150749.3591526-1-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

Secondary processes call rte_dpaa2_mpool_get_ops_idx() but the ops
index was registered only in the primary process, so the function
returned the sentinel RTE_MEMPOOL_MAX_OPS_IDX on every call in a
secondary. dpaa2_sec then compares mb_pool->ops_index against that
sentinel and always takes the MAX_BPID path.

The ops index is process-invariant: mempool ops are registered by a
constructor at library load time in the same link order in every
process. Fix rte_dpaa2_mpool_get_ops_idx() to scan rte_mempool_ops_table
by name ("dpaa2") locally and cache the result. No IPC round-trip is
needed.

Also fix a duplicated word in an error message in rte_hw_mbuf_create_pool
("Only single ops index only" -> "Single ops index only") and improve the
error log in rte_hw_mbuf_free_pool to include the pool name.

Fixes: de6a6e897fe6 ("mempool/dpaa2: add operation index")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 25 ++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index ee001d8ce0..c2f2aecc2e 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -43,7 +43,25 @@ static int16_t s_dpaa2_pool_ops_idx = RTE_MEMPOOL_MAX_OPS_IDX;
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mpool_get_ops_idx)
 int rte_dpaa2_mpool_get_ops_idx(void)
 {
-	return s_dpaa2_pool_ops_idx;
+	uint32_t i;
+
+	if (s_dpaa2_pool_ops_idx != RTE_MEMPOOL_MAX_OPS_IDX)
+		return s_dpaa2_pool_ops_idx;
+
+	/* Mempool ops are registered by constructor in the same order in
+	 * every process, so the index is process-invariant. Scan the ops
+	 * table locally and cache the result.
+	 */
+	for (i = 0; i < rte_mempool_ops_table.num_ops; i++) {
+		if (strcmp(rte_mempool_ops_table.ops[i].name,
+				DPAA2_MEMPOOL_OPS_NAME) == 0) {
+			s_dpaa2_pool_ops_idx = (int16_t)i;
+			return s_dpaa2_pool_ops_idx;
+		}
+	}
+
+	DPAA2_MEMPOOL_ERR("dpaa2 mempool ops not found");
+	return -ENOENT;
 }
 
 static int
@@ -128,11 +146,10 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	if (s_dpaa2_pool_ops_idx == RTE_MEMPOOL_MAX_OPS_IDX) {
 		s_dpaa2_pool_ops_idx = mp->ops_index;
 	} else if (s_dpaa2_pool_ops_idx != mp->ops_index) {
-		DPAA2_MEMPOOL_ERR("Only single ops index only");
+		DPAA2_MEMPOOL_ERR("Single ops index only");
 		ret = -EINVAL;
 		goto err4;
 	}
-
 	bp_list->next = h_bp_list;
 	bp_list->mp = mp;
 
@@ -172,7 +189,7 @@ rte_hw_mbuf_free_pool(struct rte_mempool *mp)
 	struct dpaa2_dpbp_dev *dpbp_node;
 
 	if (!mp->pool_data) {
-		DPAA2_MEMPOOL_ERR("Not a valid dpaa2 buffer pool");
+		DPAA2_MEMPOOL_ERR("Not a valid dpaa2 buffer pool %s", mp->name);
 		return;
 	}
 
-- 
2.43.0

