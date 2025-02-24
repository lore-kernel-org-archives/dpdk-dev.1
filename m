Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F891C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 11:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B11A140DCE;
	Mon, 24 Feb 2025 12:40:25 +0100 (CET)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217]) by mails.dpdk.org (Postfix) with ESMTP id 55B224042E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1740397224; x=1771933224;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=eCgNnZK4IyT0uJHbR0XbTB7+fIHE0Ef8Ym0tqv66D/I=;
 b=aKIw4XUEjf74kS1fuYpSV8NWqqDHsg9ccOw4TolM3QuhOVAmHuZQpRW8
 rmOntZEss4llRrggVt9iuN/lJJYENzNqSJUqW7Vv/sjvyb5yq9o/5+SA/
 CxHYHmqu9xUVlNgfyoYTbZ06oHIPWO8xI+1HTiQg5NfCFFWQWcLePS5r4 k=;
X-IronPort-AV: E=Sophos;i="6.13,311,1732579200"; d="scan'208";a="25416057"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:40:22 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:64881]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.214:2525]
 with esmtp (Farcaster)
 id 5a4c18b4-777b-4be6-bdc9-8caf68d21e02; Mon, 24 Feb 2025 11:40:20 +0000 (UTC)
X-Farcaster-Flow-ID: 5a4c18b4-777b-4be6-bdc9-8caf68d21e02
Received: from EX19D007EUA003.ant.amazon.com (10.252.50.8) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:19 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D007EUA003.ant.amazon.com (10.252.50.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:19 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 11:40:19 +0000
Received: from HFA15-CG15235BS.amazon.com (unknown [10.1.213.12])
 by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix)
 with ESMTP id 8AF9780223; Mon, 24 Feb 2025 11:40:17 +0000 (UTC)
From: <shaibran@amazon.com>
To: <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Yosef Raisman
 <yraisman@amazon.com>
Subject: [PATCH 2/4] net/ena: add support for mutable RSS table size
Date: Mon, 24 Feb 2025 13:40:09 +0200
Message-ID: <20250224114011.1789-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224114011.1789-1-shaibran@amazon.com>
References: <20250224114011.1789-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
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

From: Shai Brandes <shaibran@amazon.com>

This patch enables the configuration of a mutable RSS table size, allowing
it to adapt to the device's capabilities instead of relying on a fixed 128
hardcoded value.

Signed-off-by: Yosef Raisman <yraisman@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
---
 doc/guides/rel_notes/release_25_03.rst        |  4 ++
 drivers/net/ena/base/ena_com.c                | 60 ++++++++++---------
 drivers/net/ena/base/ena_com.h                |  3 +-
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  3 +
 drivers/net/ena/ena_ethdev.c                  | 31 ++++++++--
 drivers/net/ena/ena_ethdev.h                  |  8 +--
 drivers/net/ena/ena_rss.c                     | 48 ++++++++++++---
 7 files changed, 111 insertions(+), 46 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 2b139fc35b..e7757e0d53 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -97,6 +97,10 @@ New Features
   * Added ability to option to configure receive packet fanout mode.
   * Added statistics for failed buffer allocation and missed packets.
 
+* **Updated Amazon ENA (Elastic Network Adapter) net driver.**
+
+  * Added support for mutable RSS table size based on device capabilities.
+
 * **Updated AMD axgbe driver.**
 
   * Added support for the TCP Segmentation Offload (TSO).
diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 8018663e18..238716de29 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -40,6 +40,7 @@
 
 #define ENA_MAX_ADMIN_POLL_US 5000
 
+#define ENA_MAX_INDIR_TABLE_LOG_SIZE 16
 /* PHC definitions */
 #define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
 #define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
@@ -1030,6 +1031,11 @@ static bool ena_com_check_supported_feature_id(struct ena_com_dev *ena_dev,
 	return true;
 }
 
+bool ena_com_indirection_table_config_supported(struct ena_com_dev *ena_dev)
+{
+	return ena_com_check_supported_feature_id(ena_dev,
+						  ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG);
+}
 static int ena_com_get_feature_ex(struct ena_com_dev *ena_dev,
 				  struct ena_admin_get_feat_resp *get_resp,
 				  enum ena_admin_aq_feature_id feature_id,
@@ -1175,55 +1181,55 @@ static void ena_com_hash_ctrl_destroy(struct ena_com_dev *ena_dev)
 	rss->hash_ctrl = NULL;
 }
 
-static int ena_com_indirect_table_allocate(struct ena_com_dev *ena_dev,
-					   u16 log_size)
+static int ena_com_indirect_table_allocate(struct ena_com_dev *ena_dev)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
-	size_t tbl_size;
+	struct ena_rss *rss = &ena_dev->rss;
+	u16 requested_log_tbl_size;
+	int requested_tbl_size;
 	int ret;
 
 	ret = ena_com_get_feature(ena_dev, &get_resp,
-				  ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG, 0);
+				  ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG,
+				  ENA_ADMIN_RSS_FEATURE_VERSION_1);
+
 	if (unlikely(ret))
 		return ret;
 
-	if ((get_resp.u.ind_table.min_size > log_size) ||
-	    (get_resp.u.ind_table.max_size < log_size)) {
-		ena_trc_err(ena_dev, "Indirect table size doesn't fit. requested size: %d while min is:%d and max %d\n",
-			    1 << log_size,
-			    1 << get_resp.u.ind_table.min_size,
-			    1 << get_resp.u.ind_table.max_size);
+	requested_log_tbl_size = get_resp.u.ind_table.max_size;
+
+	if (requested_log_tbl_size > ENA_MAX_INDIR_TABLE_LOG_SIZE) {
+		ena_trc_err(ena_dev, "Requested indirect table size too large. Requested log size: %u.\n",
+			    requested_log_tbl_size);
 		return ENA_COM_INVAL;
 	}
 
-	tbl_size = (1ULL << log_size) *
-		sizeof(struct ena_admin_rss_ind_table_entry);
-
+	requested_tbl_size = (1ULL << requested_log_tbl_size) *
+			     sizeof(struct ena_admin_rss_ind_table_entry);
 	ENA_MEM_ALLOC_COHERENT(ena_dev->dmadev,
-			     tbl_size,
-			     rss->rss_ind_tbl,
-			     rss->rss_ind_tbl_dma_addr,
-			     rss->rss_ind_tbl_mem_handle);
+			       requested_tbl_size,
+			       rss->rss_ind_tbl,
+			       rss->rss_ind_tbl_dma_addr,
+			       rss->rss_ind_tbl_mem_handle);
 	if (unlikely(!rss->rss_ind_tbl))
 		goto mem_err1;
 
-	tbl_size = (1ULL << log_size) * sizeof(u16);
+	requested_tbl_size = (1ULL << requested_log_tbl_size) *
+			     sizeof(u16);
 	rss->host_rss_ind_tbl =
-		ENA_MEM_ALLOC(ena_dev->dmadev, tbl_size);
+		ENA_MEM_ALLOC(ena_dev->dmadev,
+			      requested_tbl_size);
 	if (unlikely(!rss->host_rss_ind_tbl))
 		goto mem_err2;
 
-	rss->tbl_log_size = log_size;
+	rss->tbl_log_size = requested_log_tbl_size;
 
 	return 0;
 
 mem_err2:
-	tbl_size = (1ULL << log_size) *
-		sizeof(struct ena_admin_rss_ind_table_entry);
-
 	ENA_MEM_FREE_COHERENT(ena_dev->dmadev,
-			      tbl_size,
+			      (1ULL << requested_log_tbl_size) *
+			      sizeof(struct ena_admin_rss_ind_table_entry),
 			      rss->rss_ind_tbl,
 			      rss->rss_ind_tbl_dma_addr,
 			      rss->rss_ind_tbl_mem_handle);
@@ -3146,13 +3152,13 @@ int ena_com_indirect_table_get(struct ena_com_dev *ena_dev, u32 *ind_tbl)
 	return 0;
 }
 
-int ena_com_rss_init(struct ena_com_dev *ena_dev, u16 indr_tbl_log_size)
+int ena_com_rss_init(struct ena_com_dev *ena_dev)
 {
 	int rc;
 
 	memset(&ena_dev->rss, 0x0, sizeof(ena_dev->rss));
 
-	rc = ena_com_indirect_table_allocate(ena_dev, indr_tbl_log_size);
+	rc = ena_com_indirect_table_allocate(ena_dev);
 	if (unlikely(rc))
 		goto err_indr_tbl;
 
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index ce27e693c8..b2aede1be1 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -779,7 +779,7 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu);
  *
  * @return: 0 on Success and negative value otherwise.
  */
-int ena_com_rss_init(struct ena_com_dev *ena_dev, u16 log_size);
+int ena_com_rss_init(struct ena_com_dev *ena_dev);
 
 /* ena_com_rss_destroy - Destroy rss
  * @ena_dev: ENA communication layer struct
@@ -1144,6 +1144,7 @@ static inline void ena_com_disable_adaptive_moderation(struct ena_com_dev *ena_d
 	ena_dev->adaptive_coalescing = false;
 }
 
+bool ena_com_indirection_table_config_supported(struct ena_com_dev *ena_dev);
 /* ena_com_get_cap - query whether device supports a capability.
  * @ena_dev: ENA communication layer struct
  * @cap_id: enum value representing the capability
diff --git a/drivers/net/ena/base/ena_defs/ena_admin_defs.h b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
index 8a1bb0bb76..bdc6efadcf 100644
--- a/drivers/net/ena/base/ena_defs/ena_admin_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
@@ -840,6 +840,9 @@ struct ena_admin_feature_offload_desc {
 	uint32_t rx_enabled;
 };
 
+enum ena_admin_rss_feature_version {
+	ENA_ADMIN_RSS_FEATURE_VERSION_1             = 1,
+};
 enum ena_admin_hash_functions {
 	ENA_ADMIN_TOEPLITZ                          = 1,
 	ENA_ADMIN_CRC32                             = 2,
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index aea2e5c929..71a60b0eff 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -603,7 +603,7 @@ __extension__ ({
 	ENA_TOUCH(ena_dev);
 	if (ind_tbl != adapter->indirect_table)
 		rte_memcpy(ind_tbl, adapter->indirect_table,
-			   sizeof(adapter->indirect_table));
+			   sizeof(u32) * adapter->indirect_table_size);
 }),
 	struct ena_com_dev *ena_dev, u32 *ind_tbl);
 
@@ -889,6 +889,13 @@ static void ena_config_debug_area(struct ena_adapter *adapter)
 	ena_com_delete_debug_area(&adapter->ena_dev);
 }
 
+static inline void ena_indirect_table_release(struct ena_adapter *adapter)
+{
+	if (likely(adapter->indirect_table)) {
+		rte_free(adapter->indirect_table);
+		adapter->indirect_table = NULL;
+	}
+}
 static int ena_close(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
@@ -920,6 +927,7 @@ static int ena_close(struct rte_eth_dev *dev)
 	ena_rx_queue_release_all(dev);
 	ena_tx_queue_release_all(dev);
 
+	ena_indirect_table_release(adapter);
 	rte_free(adapter->drv_stats);
 	adapter->drv_stats = NULL;
 
@@ -2278,6 +2286,7 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 	int rc;
 	static int adapters_found;
 	bool disable_meta_caching;
+	size_t indirect_table_size;
 
 	eth_dev->dev_ops = &ena_dev_ops;
 	eth_dev->rx_pkt_burst = &eth_ena_recv_pkts;
@@ -2413,12 +2422,24 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 			get_feat_ctx.dev_attr.mac_addr,
 			(struct rte_ether_addr *)adapter->mac_addr);
 
-	rc = ena_com_rss_init(ena_dev, ENA_RX_RSS_TABLE_LOG_SIZE);
+	rc = ena_com_rss_init(ena_dev);
 	if (unlikely(rc != 0)) {
 		PMD_DRV_LOG_LINE(ERR, "Failed to initialize RSS in ENA device");
 		goto err_delete_debug_area;
 	}
 
+	indirect_table_size = ena_rss_get_indirection_table_size(adapter);
+	if (indirect_table_size) {
+		adapter->indirect_table = rte_zmalloc("adapter RSS indirection table",
+						sizeof(u32) * indirect_table_size,
+						RTE_CACHE_LINE_SIZE);
+		if (!adapter->indirect_table) {
+			PMD_DRV_LOG_LINE(ERR,
+				"Failed to allocate memory for RSS indirection table");
+			rc = -ENOMEM;
+			goto err_rss_destroy;
+		}
+	}
 	adapter->drv_stats = rte_zmalloc("adapter stats",
 					 sizeof(*adapter->drv_stats),
 					 RTE_CACHE_LINE_SIZE);
@@ -2426,7 +2447,7 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for adapter statistics");
 		rc = -ENOMEM;
-		goto err_rss_destroy;
+		goto err_indirect_table_destroy;
 	}
 
 	rte_spinlock_init(&adapter->admin_lock);
@@ -2454,6 +2475,8 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 err_control_path_destroy:
 	rte_free(adapter->drv_stats);
+err_indirect_table_destroy:
+	ena_indirect_table_release(adapter);
 err_rss_destroy:
 	ena_com_rss_destroy(ena_dev);
 err_delete_debug_area:
@@ -2643,7 +2666,7 @@ static int ena_infos_get(struct rte_eth_dev *dev,
 
 	dev_info->max_rx_queues = adapter->max_num_io_queues;
 	dev_info->max_tx_queues = adapter->max_num_io_queues;
-	dev_info->reta_size = ENA_RX_RSS_TABLE_SIZE;
+	dev_info->reta_size = adapter->indirect_table_size;
 
 	dev_info->rx_desc_lim.nb_max = adapter->max_rx_ring_size;
 	dev_info->rx_desc_lim.nb_min = ENA_MIN_RING_DESC;
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index b8aead8f46..335028ad19 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -29,8 +29,6 @@
 #define ENA_RX_BUF_MIN_SIZE	1400
 #define ENA_DEFAULT_RING_SIZE	1024
 
-#define ENA_RX_RSS_TABLE_LOG_SIZE	7
-#define ENA_RX_RSS_TABLE_SIZE		(1 << ENA_RX_RSS_TABLE_LOG_SIZE)
 
 #define ENA_MIN_MTU		128
 
@@ -65,8 +63,6 @@
 #define ENA_IDX_NEXT_MASKED(idx, mask) (((idx) + 1) & (mask))
 #define ENA_IDX_ADD_MASKED(idx, n, mask) (((idx) + (n)) & (mask))
 
-#define ENA_RX_RSS_TABLE_LOG_SIZE	7
-#define ENA_RX_RSS_TABLE_SIZE		(1 << ENA_RX_RSS_TABLE_LOG_SIZE)
 
 #define ENA_HASH_KEY_SIZE		40
 
@@ -333,7 +329,8 @@ struct ena_adapter {
 	struct ena_stats_dev dev_stats;
 	struct ena_admin_basic_stats basic_stats;
 
-	u32 indirect_table[ENA_RX_RSS_TABLE_SIZE];
+	u32 *indirect_table;
+	size_t indirect_table_size;
 
 	uint32_t all_aenq_groups;
 	uint32_t active_aenq_groups;
@@ -360,6 +357,7 @@ struct ena_adapter {
 	alignas(RTE_CACHE_LINE_SIZE) struct ena_stats_srd srd_stats;
 };
 
+size_t ena_rss_get_indirection_table_size(struct ena_adapter *adapter);
 int ena_mp_indirect_table_set(struct ena_adapter *adapter);
 int ena_mp_indirect_table_get(struct ena_adapter *adapter,
 			      uint32_t *indirect_table);
diff --git a/drivers/net/ena/ena_rss.c b/drivers/net/ena/ena_rss.c
index 85c6152f0c..45578189b9 100644
--- a/drivers/net/ena/ena_rss.c
+++ b/drivers/net/ena/ena_rss.c
@@ -45,6 +45,17 @@ static void ena_reorder_rss_hash_key(uint8_t *reordered_key,
 				     size_t key_size);
 static int ena_get_rss_hash_key(struct ena_com_dev *ena_dev, uint8_t *rss_key);
 
+size_t ena_rss_get_indirection_table_size(struct ena_adapter *adapter)
+{
+	struct ena_com_dev *ena_dev = &adapter->ena_dev;
+	if (!ena_com_indirection_table_config_supported(ena_dev)) {
+		PMD_DRV_LOG_LINE(WARNING,
+			"Indirection table is not supported by the device.");
+		return 0;
+	}
+	adapter->indirect_table_size = (1UL << ena_dev->rss.tbl_log_size);
+	return adapter->indirect_table_size;
+}
 void ena_rss_key_fill(void *key, size_t size)
 {
 	static bool key_generated;
@@ -71,6 +82,7 @@ int ena_rss_reta_update(struct rte_eth_dev *dev,
 	u16 entry_value;
 	int conf_idx;
 	int idx;
+	size_t tbl_size;
 
 	if (reta_size == 0 || reta_conf == NULL)
 		return -EINVAL;
@@ -81,10 +93,11 @@ int ena_rss_reta_update(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
-	if (reta_size > ENA_RX_RSS_TABLE_SIZE) {
-		PMD_DRV_LOG_LINE(WARNING,
-			"Requested indirection table size (%d) is bigger than supported: %d",
-			reta_size, ENA_RX_RSS_TABLE_SIZE);
+	tbl_size = ena_rss_get_indirection_table_size(adapter);
+	if (reta_size != tbl_size) {
+		PMD_DRV_LOG_LINE(ERR,
+			"Requested indirection table size (%" PRIu16 ") isn't supported (expected: %zu)",
+			reta_size, tbl_size);
 		return -EINVAL;
 	}
 
@@ -129,12 +142,12 @@ int ena_rss_reta_query(struct rte_eth_dev *dev,
 		       struct rte_eth_rss_reta_entry64 *reta_conf,
 		       uint16_t reta_size)
 {
-	uint32_t indirect_table[ENA_RX_RSS_TABLE_SIZE];
 	struct ena_adapter *adapter = dev->data->dev_private;
 	int rc;
 	int i;
 	int reta_conf_idx;
 	int reta_idx;
+	size_t tbl_size;
 
 	if (reta_size == 0 || reta_conf == NULL)
 		return -EINVAL;
@@ -145,10 +158,22 @@ int ena_rss_reta_query(struct rte_eth_dev *dev,
 		return -ENOTSUP;
 	}
 
+	tbl_size = ena_rss_get_indirection_table_size(adapter);
+	if (reta_size != tbl_size) {
+		PMD_DRV_LOG_LINE(ERR,
+			"Cannot get indirection table: size (%" PRIu16 ") mismatch (expected: %zu)",
+			reta_size, tbl_size);
+		return -EINVAL;
+	}
+	if (!adapter->indirect_table) {
+		PMD_DRV_LOG_LINE(ERR,
+			"Cannot get indirection table: local table not allocated");
+		return -EINVAL;
+	}
 	rte_spinlock_lock(&adapter->admin_lock);
-	rc = ena_mp_indirect_table_get(adapter, indirect_table);
-	rte_spinlock_unlock(&adapter->admin_lock);
+	rc = ena_mp_indirect_table_get(adapter, adapter->indirect_table);
 	if (unlikely(rc != 0)) {
+		rte_spinlock_unlock(&adapter->admin_lock);
 		PMD_DRV_LOG_LINE(ERR, "Cannot get indirection table");
 		return rc;
 	}
@@ -158,8 +183,9 @@ int ena_rss_reta_query(struct rte_eth_dev *dev,
 		reta_idx = i % RTE_ETH_RETA_GROUP_SIZE;
 		if (TEST_BIT(reta_conf[reta_conf_idx].mask, reta_idx))
 			reta_conf[reta_conf_idx].reta[reta_idx] =
-				ENA_IO_RXQ_IDX_REV(indirect_table[i]);
+				ENA_IO_RXQ_IDX_REV(adapter->indirect_table[i]);
 	}
+	rte_spinlock_unlock(&adapter->admin_lock);
 
 	return 0;
 }
@@ -475,6 +501,7 @@ int ena_rss_configure(struct ena_adapter *adapter)
 	struct rte_eth_rss_conf *rss_conf;
 	struct ena_com_dev *ena_dev;
 	int rc;
+	size_t tbl_size;
 
 	ena_dev = &adapter->ena_dev;
 	rss_conf = &adapter->edev_data->dev_conf.rx_adv_conf.rss_conf;
@@ -482,11 +509,14 @@ int ena_rss_configure(struct ena_adapter *adapter)
 	if (adapter->edev_data->nb_rx_queues == 0)
 		return 0;
 
+	tbl_size = ena_rss_get_indirection_table_size(adapter);
+	if (!tbl_size)
+		return 0;
 	/* Restart the indirection table. The number of queues could change
 	 * between start/stop calls, so it must be reinitialized with default
 	 * values.
 	 */
-	rc = ena_fill_indirect_table_default(ena_dev, ENA_RX_RSS_TABLE_SIZE,
+	rc = ena_fill_indirect_table_default(ena_dev, tbl_size,
 		adapter->edev_data->nb_rx_queues);
 	if (unlikely(rc != 0)) {
 		PMD_DRV_LOG_LINE(ERR,
-- 
2.17.1

