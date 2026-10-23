Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710A606A326
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 672714278E;
	Fri, 23 Oct 2026 15:44:57 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A3FA4410F6
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:44 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 889ED1A0042;
 Fri, 23 Oct 2026 15:44:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 520D21A0021;
 Fri, 23 Oct 2026 15:44:44 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EF0A9180006C;
 Fri, 23 Oct 2026 21:44:42 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 48/65] bus/fslmc: move Tx SG mempool to fslmc bus
Date: Fri, 23 Oct 2026 19:13:28 +0530
Message-ID: <20261023134346.37727-49-prashant.gupta_3@nxp.com>
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

The scatter-gather mbuf pool used to build multi-segment Tx frames was
a global owned by the dpaa2 net PMD (dpaa2_tx_sg_pool), created lazily
on first probe and reference-counted with dpaa2_valid_dev. This tied a
bus-wide resource to the net driver and duplicated primary/secondary
lookup logic.

Create the SG pool once on the fslmc bus instead:

  - Allocate "dpaa2_sg_pool" in rte_fslmc_probe() and free it in
    rte_fslmc_close(), storing the handle in fslmc_bus_info.mem_pool.
  - Expose the pool sizing via DPAA2_TX_SG_POOL_SIZE,
    DPAA2_TX_SG_POOL_CACHE_SIZE and DPAA2_TX_SG_POOL_ELEM_SIZE in the
    bus driver header.

Update the net PMD to consume it:

  - dpaa2_dev_init() takes the pool from the device's bus_info and
    stores it in priv->tx_sg_pool; dpaa2_dev_close() clears the
    reference.
  - Remove dpaa2_tx_sg_pool_init(), the dpaa2_tx_sg_pool /
    dpaa2_valid_dev globals, and the now-unused DPAA2_MAX_SGS,
    DPAA2_POOL_SIZE, DPAA2_POOL_CACHE_SIZE and struct sw_buf_free
    definitions.
  - Bound the SG receive walk by the pool element size instead of
    DPAA2_MAX_SGS.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h |  4 +++
 drivers/bus/fslmc/fslmc_bus.c        |  9 ++++++
 drivers/net/dpaa2/dpaa2_ethdev.c     | 44 ++--------------------------
 drivers/net/dpaa2/dpaa2_ethdev.h     | 20 ++-----------
 drivers/net/dpaa2/dpaa2_rxtx.c       |  9 +++---
 5 files changed, 22 insertions(+), 64 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 3ba865e632..4d56da45b3 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -89,6 +89,10 @@ enum rte_dpaa2_dev_type {
 	DPAA2_DEVTYPE_MAX,
 };
 
+#define DPAA2_TX_SG_POOL_SIZE 2048
+#define DPAA2_TX_SG_POOL_CACHE_SIZE 256
+#define DPAA2_TX_SG_POOL_ELEM_SIZE 2048
+
 struct rte_fslmc_bus_info {
 	void *mem_pool;
 	int sp_protocol;
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index a418f9a420..d20103ee36 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -690,6 +690,10 @@ rte_fslmc_probe(struct rte_bus *bus)
 		return ret;
 	}
 
+	fslmc_bus_info.mem_pool = rte_pktmbuf_pool_create("dpaa2_sg_pool",
+		DPAA2_TX_SG_POOL_SIZE, DPAA2_TX_SG_POOL_CACHE_SIZE, 0,
+		DPAA2_TX_SG_POOL_ELEM_SIZE, rte_socket_id());
+
 	return rte_bus_generic_probe(bus);
 }
 
@@ -750,6 +754,11 @@ rte_fslmc_close(struct rte_bus *bus __rte_unused)
 {
 	int ret = 0;
 
+	if (fslmc_bus_info.mem_pool) {
+		rte_mempool_free(fslmc_bus_info.mem_pool);
+		fslmc_bus_info.mem_pool = NULL;
+	}
+
 	ret = fslmc_bus_close_group();
 	if (ret)
 		DPAA2_BUS_INFO("Unable to close devices %d", ret);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 88a0f9bdbb..995e0db1f2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -203,9 +203,6 @@ dpaa2_dist_size_is_supported(uint16_t n)
 	return false;
 }
 
-int dpaa2_valid_dev;
-struct rte_mempool *dpaa2_tx_sg_pool;
-
 struct dpaa2_xstats_seq {
 	struct dpni_statistics_page_0 pg0;
 	struct dpni_statistics_page_1 pg1;
@@ -2402,6 +2399,7 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 
 	/* Free the allocated memory for ethernet private data and dpni*/
 	priv->hw = NULL;
+	priv->tx_sg_pool = NULL;
 	dev->process_private = NULL;
 	rte_free(dpni);
 
@@ -4195,6 +4193,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		eth_dev->data->name, dpaa2_dev->ep_name);
 
 	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
+	priv->tx_sg_pool = dpaa2_dev->bus_info->mem_pool;
 
 	return 0;
 init_err:
@@ -4244,35 +4243,6 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 	return priv->ep_name;
 }
 
-static int dpaa2_tx_sg_pool_init(void)
-{
-	char name[RTE_MEMZONE_NAMESIZE];
-
-	if (dpaa2_tx_sg_pool)
-		return 0;
-
-	sprintf(name, "dpaa2_mbuf_tx_sg_pool");
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		dpaa2_tx_sg_pool = rte_pktmbuf_pool_create(name,
-			DPAA2_POOL_SIZE,
-			DPAA2_POOL_CACHE_SIZE, 0,
-			DPAA2_MAX_SGS * sizeof(struct qbman_sge),
-			rte_socket_id());
-		if (!dpaa2_tx_sg_pool) {
-			DPAA2_PMD_ERR("SG pool creation failed");
-			return -ENOMEM;
-		}
-	} else {
-		dpaa2_tx_sg_pool = rte_mempool_lookup(name);
-		if (!dpaa2_tx_sg_pool) {
-			DPAA2_PMD_ERR("SG pool lookup failed");
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
 static int
 rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
 		struct rte_dpaa2_device *dpaa2_dev)
@@ -4326,11 +4296,7 @@ rte_dpaa2_probe(struct rte_dpaa2_driver *dpaa2_drv,
 	/* Invoke PMD device initialization function */
 	diag = dpaa2_dev_init(eth_dev);
 	if (!diag) {
-		diag = dpaa2_tx_sg_pool_init();
-		if (diag)
-			return diag;
 		rte_eth_dev_probing_finish(eth_dev);
-		dpaa2_valid_dev++;
 		return 0;
 	}
 
@@ -4353,12 +4319,6 @@ rte_dpaa2_remove(struct rte_dpaa2_device *dpaa2_dev)
 		ret = rte_eth_dev_release_port(eth_dev);
 	}
 
-	dpaa2_valid_dev--;
-	if (!dpaa2_valid_dev) {
-		rte_mempool_free(dpaa2_tx_sg_pool);
-		dpaa2_tx_sg_pool = NULL;
-	}
-
 	return ret;
 }
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index e4dc7b7e4f..91414114ac 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -223,24 +223,6 @@
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
 #define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
 
-/* Global pool used by driver for SG list TX */
-extern struct rte_mempool *dpaa2_tx_sg_pool;
-/* Maximum SG segments */
-#define DPAA2_MAX_SGS 128
-/* SG pool size */
-#define DPAA2_POOL_SIZE 2048
-/* SG pool cache size */
-#define DPAA2_POOL_CACHE_SIZE 256
-/* structure to free external and indirect
- * buffers.
- */
-struct sw_buf_free {
-	/* To which packet this segment belongs */
-	uint16_t pkt_id;
-	/* The actual segment */
-	struct rte_mbuf *seg;
-};
-
 /* Externally defined */
 extern const struct rte_flow_ops dpaa2_flow_ops;
 
@@ -478,6 +460,8 @@ struct dpaa2_dev_priv {
 	 */
 	union dpni_statistics pg_xstats[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
 
+	struct rte_mempool *tx_sg_pool;
+
 	LIST_HEAD(, dpaa2_dev_flow) flows;
 	LIST_HEAD(, dpaa2_dev_meter_profile) profiles;
 	LIST_HEAD(, dpaa2_dev_meter_policy) policies;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index a44b991d1b..6d12e6818d 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -456,7 +456,7 @@ dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 		(void **)&first_seg, 1, 1);
 #endif
 	cur_seg = first_seg;
-	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
+	while (!DPAA2_SG_IS_FINAL(sge)) {
 		sge = &sgt[i++];
 		sg_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FLE_ADDR(sge));
 		next_seg = DPAA2_INLINE_MBUF_FROM_BUF(sg_addr,
@@ -746,6 +746,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 	uint16_t nb_segs = mbuf->nb_segs;
 	uint32_t sg_size = nb_segs * sizeof(struct qbman_sge);
 	struct rte_mempool *mp;
+	struct dpaa2_dev_priv *priv = txq->eth_data->dev_private;
 
 	if (conf == DPAA2_TX_DYNAMIC_CONF) {
 		while (cur_seg) {
@@ -789,8 +790,8 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 		DPAA2_SET_FD_OFFSET(fd, offset);
 	} else {
 		sg_mbuf = NULL;
-		if (dpaa2_tx_sg_pool)
-			sg_mbuf = rte_pktmbuf_alloc(dpaa2_tx_sg_pool);
+		if (priv->tx_sg_pool)
+			sg_mbuf = rte_pktmbuf_alloc(priv->tx_sg_pool);
 		if (!sg_mbuf) {
 			DPAA2_PMD_DP_DEBUG("No memory to allocate S/G table");
 			return -ENOMEM;
@@ -803,7 +804,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 			DPAA2_SET_ONLY_FD_BPID(fd, MAX_BPID);
 			DPAA2_SET_FD_IVP(fd);
 		} else {
-			DPAA2_SET_ONLY_FD_BPID(fd, mempool_to_bpid(dpaa2_tx_sg_pool));
+			DPAA2_SET_ONLY_FD_BPID(fd, mempool_to_bpid(priv->tx_sg_pool));
 		}
 		DPAA2_SET_FD_OFFSET(fd, sg_mbuf->data_off);
 		offset = sg_mbuf->data_off;
-- 
2.43.0

