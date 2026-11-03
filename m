Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2F606A335
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sy2iI9AM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD2E042EFD;
	Tue,  3 Nov 2026 16:17:24 +0100 (CET)
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 914E442F06
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:17:23 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=gTL+MGB8Y5wNRGMNCdtGVtqKaw/q1uUEwzQHkIpmA2Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719043; v=1; x=1794323843;
 b=sy2iI9AMXHsSDmlNod1PhcwxzKctQJnQUrYlEysOaYvGsqpB0KGXGo0NWPRFPFQFGTD7Ng3a
 vV3x8eluesIMw6VttYPGNHfcF+g1Lm1HgCd1xci+0k/1t5QWdBM9uCW4QYz8pLcOrnWy/alX/GB
 +GZ0BIyTTla7NHpKJGmbEPg0=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id c69195918e14e628;
 Tue, 03 Nov 2026 15:17:23 +0000
X-Mizu-Trace-ID: c69195918e14e628
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 156/227] net/zxdh: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:54 +0800
Message-ID: <20261103145306.487255-157-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/zxdh/zxdh_ethdev.c | 18 +++++++++---------
 drivers/net/zxdh/zxdh_queue.c  |  4 ++--
 drivers/net/zxdh/zxdh_queue.h  |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index f3efc927b2..616ed6f610 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -679,7 +679,7 @@ zxdh_init_queue(struct rte_eth_dev *dev, uint16_t vtpci_logic_qidx)
 		sz_hdr_mz = vq_size * sizeof(struct zxdh_tx_region);
 	}
 
-	vq = rte_zmalloc_socket(vq_name, size, RTE_CACHE_LINE_SIZE, numa_node);
+	vq = rte_zmalloc_numa(vq_name, size, RTE_CACHE_LINE_SIZE, numa_node);
 	if (vq == NULL) {
 		PMD_DRV_LOG(ERR, "can not allocate vq");
 		return -ENOMEM;
@@ -1665,7 +1665,7 @@ zxdh_dtb_dump_res_init(struct zxdh_hw *hw, ZXDH_DEV_INIT_CTRL_T *dpp_ctrl)
 
 		const struct rte_memzone *generic_dump_mz =
 				rte_memzone_reserve_aligned(p->mz_name, p->mz_size,
-				SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
+				RTE_NUMA_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
 		if (generic_dump_mz == NULL) {
 			PMD_DRV_LOG(ERR, "Cannot alloc mem for dtb table bulk dump, mz_name is %s, mz_size is %u",
 				p->mz_name, p->mz_size);
@@ -1732,7 +1732,7 @@ zxdh_np_dtb_res_init(struct rte_eth_dev *dev)
 	if (!dtb_data->dtb_table_conf_mz) {
 		snprintf(buf, sizeof(buf), "%s_%x", "zxdh_dtb_table_conf_mz", hw->dev_id);
 		const struct rte_memzone *conf_mz = rte_memzone_reserve_aligned(buf,
-				ZXDH_DTB_TABLE_CONF_SIZE, SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
+				ZXDH_DTB_TABLE_CONF_SIZE, RTE_NUMA_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
 
 		if (conf_mz == NULL) {
 			PMD_DRV_LOG(ERR,
@@ -1750,7 +1750,7 @@ zxdh_np_dtb_res_init(struct rte_eth_dev *dev)
 		memset(buf, '\0', sizeof(buf));
 		snprintf(buf, sizeof(buf), "%s_%x", "zxdh_dtb_table_dump_mz", hw->dev_id);
 		const struct rte_memzone *dump_mz = rte_memzone_reserve_aligned(buf,
-				ZXDH_DTB_TABLE_DUMP_SIZE, SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
+				ZXDH_DTB_TABLE_DUMP_SIZE, RTE_NUMA_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
 
 		if (dump_mz == NULL) {
 			PMD_DRV_LOG(ERR,
@@ -1842,7 +1842,7 @@ zxdh_init_shared_data(void)
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			/* Allocate shared memory. */
 			mz = rte_memzone_reserve("zxdh_pmd_shared_data",
-					sizeof(*zxdh_shared_data), SOCKET_ID_ANY, 0);
+					sizeof(*zxdh_shared_data), RTE_NUMA_ID_ANY, 0);
 			if (mz == NULL) {
 				PMD_DRV_LOG(ERR, "Cannot allocate zxdh shared data");
 				ret = -rte_errno;
@@ -1898,14 +1898,14 @@ zxdh_init_sh_res(struct zxdh_shared_data *sd)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		flow_mp = rte_mempool_create(MZ_ZXDH_FLOW_MP, ZXDH_MAX_FLOW_NUM,
 			sizeof(struct zxdh_flow), 64, 0,
-			NULL, NULL, NULL, NULL, SOCKET_ID_ANY, 0);
+			NULL, NULL, NULL, NULL, RTE_NUMA_ID_ANY, 0);
 		if (flow_mp == NULL) {
 			PMD_DRV_LOG(ERR, "Cannot allocate zxdh flow mempool");
 			goto error;
 		}
 		mtr_mp = rte_mempool_create(MZ_ZXDH_MTR_MP, ZXDH_MAX_MTR_NUM,
 			sizeof(struct zxdh_mtr_object), 64, 0,
-			NULL, NULL, NULL, NULL, SOCKET_ID_ANY, 0);
+			NULL, NULL, NULL, NULL, RTE_NUMA_ID_ANY, 0);
 		if (mtr_mp == NULL) {
 			PMD_DRV_LOG(ERR, "Cannot allocate zxdh mtr mempool");
 			goto error;
@@ -1913,14 +1913,14 @@ zxdh_init_sh_res(struct zxdh_shared_data *sd)
 		mtr_profile_mp = rte_mempool_create(MZ_ZXDH_MTR_PROFILE_MP,
 			MAX_MTR_PROFILE_NUM, sizeof(struct zxdh_meter_profile),
 			64, 0, NULL, NULL, NULL,
-			NULL, SOCKET_ID_ANY, 0);
+			NULL, RTE_NUMA_ID_ANY, 0);
 		if (mtr_profile_mp == NULL) {
 			PMD_DRV_LOG(ERR, "Cannot allocate zxdh mtr profile mempool");
 			goto error;
 		}
 		mtr_policy_mp = rte_mempool_create(MZ_ZXDH_MTR_POLICY_MP,
 			ZXDH_MAX_POLICY_NUM, sizeof(struct zxdh_meter_policy),
-			64, 0, NULL, NULL, NULL, NULL, SOCKET_ID_ANY, 0);
+			64, 0, NULL, NULL, NULL, NULL, RTE_NUMA_ID_ANY, 0);
 		if (mtr_policy_mp == NULL) {
 			PMD_DRV_LOG(ERR, "Cannot allocate zxdh mtr profile mempool");
 			goto error;
diff --git a/drivers/net/zxdh/zxdh_queue.c b/drivers/net/zxdh/zxdh_queue.c
index 4668cb5d13..b2b7c30fab 100644
--- a/drivers/net/zxdh/zxdh_queue.c
+++ b/drivers/net/zxdh/zxdh_queue.c
@@ -223,7 +223,7 @@ int32_t
 zxdh_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			uint32_t socket_id __rte_unused,
+			uint32_t numa_id __rte_unused,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp)
 {
@@ -316,7 +316,7 @@ int32_t
 zxdh_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			uint32_t socket_id __rte_unused,
+			uint32_t numa_id __rte_unused,
 			const struct rte_eth_txconf *tx_conf)
 {
 	struct zxdh_hw *hw = dev->data->dev_private;
diff --git a/drivers/net/zxdh/zxdh_queue.h b/drivers/net/zxdh/zxdh_queue.h
index 006b02c425..a254d3781e 100644
--- a/drivers/net/zxdh/zxdh_queue.h
+++ b/drivers/net/zxdh/zxdh_queue.h
@@ -376,12 +376,12 @@ int32_t zxdh_get_queue_type(uint16_t vtpci_queue_idx);
 int32_t zxdh_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			uint32_t socket_id,
+			uint32_t numa_id,
 			const struct rte_eth_txconf *tx_conf);
 int32_t zxdh_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
-			uint32_t socket_id,
+			uint32_t numa_id,
 			const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mp);
 int32_t zxdh_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
-- 
2.55.0

