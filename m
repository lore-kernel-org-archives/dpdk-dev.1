Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76600C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:08:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E8C642D27;
	Fri, 31 Jan 2025 09:06:56 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F1A1142D27
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:54 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2nAwh015037
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 ZJ8ixiCYlokEjY9obB4Tb/t9aB16s8BF1CqmFwqZsg=; b=aSi8QPvJCKd8iX7LM
 c5GagkRy53A1rkNKjNZj1oz+zdpIli6PJRc0bNgWHlv651QwNY8h5Mvu1y0U262U
 +nM+1i9SG+UVDSY0gvkA3m5z6qQEXj7ohpwRjpr9lglh3/bDS2QJzrHEthMB+Nv2
 zT6jI5pTHjJ2ujkAslZo/1Nybk0tRXLQpwDB8kD1mx4KPBp4jvJK3xwTlv2oiylF
 OA2Q4f8cGpreVj939pd63zn5a90A2pzk35SsdiMbGJ6zgxoO04J5QFmxQU45PYqd
 UF4PKZq1kUyMSWg9gt4H66bgjA44qGnAhpyI2l/N90gxWdp2G+9yGUdIkrtKbuPJ
 1bseQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44gmhnghn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:53 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:52 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id E0AED3F7045;
 Fri, 31 Jan 2025 00:06:49 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 25/34] net/cnxk: store pool buffer size in lookup memory
Date: Fri, 31 Jan 2025 13:35:20 +0530
Message-ID: <20250131080530.3224977-25-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S_f5A62jU7GGeFlfkPP8ZgQ4fvPrWUid
X-Proofpoint-GUID: S_f5A62jU7GGeFlfkPP8ZgQ4fvPrWUid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Store the pool buffer size in lookup memory to calculate
mbuf start address for reassembly case in fastpath.
Also, restructured lookup memory data per port.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev.c   | 17 +++++++++
 drivers/net/cnxk/cn20k_rxtx.h     |  1 +
 drivers/net/cnxk/cnxk_ethdev.h    |  2 +
 drivers/net/cnxk/cnxk_ethdev_dp.h | 29 ++++++++++++---
 drivers/net/cnxk/cnxk_lookup.c    | 61 +++++++++++++++++++++++++++----
 5 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index db8d08cb2a..740fdb7f76 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -319,6 +319,8 @@ cn20k_nix_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t qid, uint16_t nb_
 	/* Data offset from data to start of mbuf is first_skip */
 	rxq->data_off = rq->first_skip;
 	rxq->mbuf_initializer = cnxk_nix_rxq_mbuf_setup(dev);
+	rxq->mp_buf_sz = (mp->elt_size + mp->header_size + mp->trailer_size) & 0xFFFFFFFF;
+	rxq->mp_buf_sz |= (uint64_t)mp->header_size << 32;
 
 	/* Setup security related info */
 	if (dev->rx_offload_flags & NIX_RX_OFFLOAD_SECURITY_F) {
@@ -358,6 +360,18 @@ cn20k_nix_rx_queue_meta_aura_update(struct rte_eth_dev *eth_dev)
 	cnxk_nix_lookup_mem_metapool_set(dev);
 }
 
+static void
+cn20k_nix_rx_queue_bufsize_update(struct rte_eth_dev *eth_dev)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cn20k_eth_rxq *rxq;
+
+	rxq = eth_dev->data->rx_queues[0];
+
+	/* Store bufsize in lookup mem */
+	cnxk_nix_lookup_mem_bufsize_set(dev, rxq->mp_buf_sz);
+}
+
 static int
 cn20k_nix_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx)
 {
@@ -590,6 +604,9 @@ cn20k_nix_dev_start(struct rte_eth_dev *eth_dev)
 	if (roc_idev_nix_rx_inject_get(nix->port_id))
 		dev->rx_offload_flags |= NIX_RX_SEC_REASSEMBLY_F;
 
+	if (dev->rx_offload_flags & NIX_RX_REAS_F)
+		cn20k_nix_rx_queue_bufsize_update(eth_dev);
+
 	cn20k_eth_set_tx_function(eth_dev);
 	cn20k_eth_set_rx_function(eth_dev);
 	return 0;
diff --git a/drivers/net/cnxk/cn20k_rxtx.h b/drivers/net/cnxk/cn20k_rxtx.h
index e40edba69d..f23c16ec07 100644
--- a/drivers/net/cnxk/cn20k_rxtx.h
+++ b/drivers/net/cnxk/cn20k_rxtx.h
@@ -82,6 +82,7 @@ struct cn20k_eth_rxq {
 	uint64_t meta_aura;
 	uintptr_t meta_pool;
 	uint16_t rq;
+	uint64_t mp_buf_sz;
 	struct cnxk_timesync_info *tstamp;
 } __plt_cache_aligned;
 
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 9b85927f48..daf80be51b 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -727,6 +727,8 @@ int cnxk_nix_lookup_mem_sa_base_set(struct cnxk_eth_dev *dev);
 int cnxk_nix_lookup_mem_sa_base_clear(struct cnxk_eth_dev *dev);
 int cnxk_nix_lookup_mem_metapool_set(struct cnxk_eth_dev *dev);
 int cnxk_nix_lookup_mem_metapool_clear(struct cnxk_eth_dev *dev);
+int cnxk_nix_lookup_mem_bufsize_set(struct cnxk_eth_dev *dev, uint64_t size);
+int cnxk_nix_lookup_mem_bufsize_clear(struct cnxk_eth_dev *dev);
 __rte_internal
 int cnxk_nix_inb_mode_set(struct cnxk_eth_dev *dev, bool use_inl_dev);
 __rte_internal
diff --git a/drivers/net/cnxk/cnxk_ethdev_dp.h b/drivers/net/cnxk/cnxk_ethdev_dp.h
index 100d22e759..b5836b491e 100644
--- a/drivers/net/cnxk/cnxk_ethdev_dp.h
+++ b/drivers/net/cnxk/cnxk_ethdev_dp.h
@@ -35,8 +35,11 @@
 #define ERRCODE_ERRLEN_WIDTH 12
 #define ERR_ARRAY_SZ	     ((BIT(ERRCODE_ERRLEN_WIDTH)) * sizeof(uint32_t))
 
-#define SA_BASE_TBL_SZ	(RTE_MAX_ETHPORTS * sizeof(uintptr_t))
-#define MEMPOOL_TBL_SZ	(RTE_MAX_ETHPORTS * sizeof(uintptr_t))
+#define SA_BASE_OFFSET 8 /* offset in bytes */
+#define MEMPOOL_OFFSET 8 /* offset in bytes */
+#define BUFLEN_OFFSET  8 /* offset in bytes */
+#define LOOKUP_MEM_PORTDATA_SZ (SA_BASE_OFFSET + MEMPOOL_OFFSET + BUFLEN_OFFSET)
+#define LOOKUP_MEM_PORTDATA_TOTAL_SZ (RTE_MAX_ETHPORTS * LOOKUP_MEM_PORTDATA_SZ)
 
 #define CNXK_NIX_UDP_TUN_BITMASK                                               \
 	((1ull << (RTE_MBUF_F_TX_TUNNEL_VXLAN >> 45)) |                               \
@@ -174,20 +177,36 @@ static __rte_always_inline uintptr_t
 cnxk_nix_sa_base_get(uint16_t port, const void *lookup_mem)
 {
 	uintptr_t sa_base_tbl;
+	uint32_t offset;
 
 	sa_base_tbl = (uintptr_t)lookup_mem;
 	sa_base_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
-	return *((const uintptr_t *)sa_base_tbl + port);
+	offset = port * LOOKUP_MEM_PORTDATA_SZ;
+	return *((const uintptr_t *)sa_base_tbl + offset / 8);
 }
 
 static __rte_always_inline uintptr_t
 cnxk_nix_inl_metapool_get(uint16_t port, const void *lookup_mem)
 {
 	uintptr_t metapool_tbl;
+	uint32_t offset;
 
 	metapool_tbl = (uintptr_t)lookup_mem;
-	metapool_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ + SA_BASE_TBL_SZ;
-	return *((const uintptr_t *)metapool_tbl + port);
+	metapool_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
+	offset = (port * LOOKUP_MEM_PORTDATA_SZ) + SA_BASE_OFFSET;
+	return *((const uintptr_t *)metapool_tbl + offset / 8);
+}
+
+static __rte_always_inline uintptr_t
+cnxk_nix_inl_bufsize_get(uint16_t port, const void *lookup_mem)
+{
+	uintptr_t bufsz_tbl;
+	uint32_t offset;
+
+	bufsz_tbl = (uintptr_t)lookup_mem;
+	bufsz_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
+	offset = (port * LOOKUP_MEM_PORTDATA_SZ) + SA_BASE_OFFSET + MEMPOOL_OFFSET;
+	return *((const uintptr_t *)bufsz_tbl + offset / 8);
 }
 
 #endif /* __CNXK_ETHDEV_DP_H__ */
diff --git a/drivers/net/cnxk/cnxk_lookup.c b/drivers/net/cnxk/cnxk_lookup.c
index 1e8cc396b4..7af9cb111e 100644
--- a/drivers/net/cnxk/cnxk_lookup.c
+++ b/drivers/net/cnxk/cnxk_lookup.c
@@ -7,7 +7,8 @@
 
 #include "cnxk_ethdev.h"
 
-#define LOOKUP_ARRAY_SZ (PTYPE_ARRAY_SZ + ERR_ARRAY_SZ + SA_BASE_TBL_SZ + MEMPOOL_TBL_SZ)
+#define LOOKUP_ARRAY_SZ (PTYPE_ARRAY_SZ + ERR_ARRAY_SZ + LOOKUP_MEM_PORTDATA_TOTAL_SZ)
+
 const uint32_t *
 cnxk_nix_supported_ptypes_get(struct rte_eth_dev *eth_dev,
 			      size_t *no_of_elements)
@@ -336,6 +337,7 @@ cnxk_nix_lookup_mem_sa_base_set(struct cnxk_eth_dev *dev)
 	uint16_t port = dev->eth_dev->data->port_id;
 	uintptr_t sa_base_tbl;
 	uintptr_t sa_base;
+	uint32_t offset;
 	uint8_t sa_w;
 
 	if (!lookup_mem)
@@ -351,7 +353,8 @@ cnxk_nix_lookup_mem_sa_base_set(struct cnxk_eth_dev *dev)
 	/* Set SA Base in lookup mem */
 	sa_base_tbl = (uintptr_t)lookup_mem;
 	sa_base_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
-	*((uintptr_t *)sa_base_tbl + port) = sa_base | sa_w;
+	offset = port * LOOKUP_MEM_PORTDATA_SZ;
+	*((uintptr_t *)sa_base_tbl + offset / 8) = sa_base | sa_w;
 	return 0;
 }
 
@@ -361,6 +364,7 @@ cnxk_nix_lookup_mem_sa_base_clear(struct cnxk_eth_dev *dev)
 	void *lookup_mem = cnxk_nix_fastpath_lookup_mem_get();
 	uint16_t port = dev->eth_dev->data->port_id;
 	uintptr_t sa_base_tbl;
+	uint32_t offset;
 
 	if (!lookup_mem)
 		return -EIO;
@@ -368,7 +372,8 @@ cnxk_nix_lookup_mem_sa_base_clear(struct cnxk_eth_dev *dev)
 	/* Set SA Base in lookup mem */
 	sa_base_tbl = (uintptr_t)lookup_mem;
 	sa_base_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
-	*((uintptr_t *)sa_base_tbl + port) = 0;
+	offset = port * LOOKUP_MEM_PORTDATA_SZ;
+	*((uintptr_t *)sa_base_tbl + offset / 8) = 0;
 	return 0;
 }
 
@@ -378,14 +383,16 @@ cnxk_nix_lookup_mem_metapool_set(struct cnxk_eth_dev *dev)
 	void *lookup_mem = cnxk_nix_fastpath_lookup_mem_get();
 	uint16_t port = dev->eth_dev->data->port_id;
 	uintptr_t mp_tbl;
+	uint32_t offset;
 
 	if (!lookup_mem)
 		return -EIO;
 
 	/* Set Mempool in lookup mem */
 	mp_tbl = (uintptr_t)lookup_mem;
-	mp_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ + SA_BASE_TBL_SZ;
-	*((uintptr_t *)mp_tbl + port) = dev->nix.meta_mempool;
+	mp_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
+	offset = (port * LOOKUP_MEM_PORTDATA_SZ) + SA_BASE_OFFSET;
+	*((uintptr_t *)mp_tbl + offset / 8) = dev->nix.meta_mempool;
 	return 0;
 }
 
@@ -395,13 +402,53 @@ cnxk_nix_lookup_mem_metapool_clear(struct cnxk_eth_dev *dev)
 	void *lookup_mem = cnxk_nix_fastpath_lookup_mem_get();
 	uint16_t port = dev->eth_dev->data->port_id;
 	uintptr_t mp_tbl;
+	uint32_t offset;
 
 	if (!lookup_mem)
 		return -EIO;
 
 	/* Clear Mempool in lookup mem */
 	mp_tbl = (uintptr_t)lookup_mem;
-	mp_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ + SA_BASE_TBL_SZ;
-	*((uintptr_t *)mp_tbl + port) = dev->nix.meta_mempool;
+	mp_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
+	offset = (port * LOOKUP_MEM_PORTDATA_SZ) + SA_BASE_OFFSET;
+	*((uintptr_t *)mp_tbl + offset / 8) = dev->nix.meta_mempool;
+	return 0;
+}
+
+int
+cnxk_nix_lookup_mem_bufsize_set(struct cnxk_eth_dev *dev, uint64_t size)
+{
+	void *lookup_mem = cnxk_nix_fastpath_lookup_mem_get();
+	uint16_t port = dev->eth_dev->data->port_id;
+	uintptr_t mp_tbl;
+	uint32_t offset;
+
+	if (!lookup_mem)
+		return -EIO;
+
+	/* Set bufsize in lookup mem */
+	mp_tbl = (uintptr_t)lookup_mem;
+	mp_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
+	offset = (port * LOOKUP_MEM_PORTDATA_SZ) + SA_BASE_OFFSET + MEMPOOL_OFFSET;
+	*((uintptr_t *)mp_tbl + offset / 8) = size;
+	return 0;
+}
+
+int
+cnxk_nix_lookup_mem_bufsize_clear(struct cnxk_eth_dev *dev)
+{
+	void *lookup_mem = cnxk_nix_fastpath_lookup_mem_get();
+	uint16_t port = dev->eth_dev->data->port_id;
+	uintptr_t mp_tbl;
+	uint32_t offset;
+
+	if (!lookup_mem)
+		return -EIO;
+
+	/* Clear bufsize in lookup mem */
+	mp_tbl = (uintptr_t)lookup_mem;
+	mp_tbl += PTYPE_ARRAY_SZ + ERR_ARRAY_SZ;
+	offset = (port * LOOKUP_MEM_PORTDATA_SZ) + SA_BASE_OFFSET + MEMPOOL_OFFSET;
+	*((uintptr_t *)mp_tbl + offset / 8) = 0;
 	return 0;
 }
-- 
2.34.1

