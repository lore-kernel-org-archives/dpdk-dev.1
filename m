Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6F606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UnmadvZq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32C714279D;
	Tue,  3 Nov 2026 16:11:14 +0100 (CET)
Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
 by mails.dpdk.org (Postfix) with ESMTPS id 5056242E59
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:12 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=k+479Dlg452SID6e4tvAxKOVTnONFpNyd6wQuRPHAnQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718672; v=1; x=1794323472;
 b=UnmadvZqZwQ6f6TfVxmUGYiQT4+6HoKxWxubbX62duYkMYXIaDp5egIIP5OCeoPw8TuKytjp
 xy1I0MLDQFQJTOxbYyiFSf7PrFkF3YUn62TKMm8oTWs0mim2NP4lEQsIbYpn3uNDEfi728zxWLv
 GuPaygyFSYHdAtup+VCPwB8E=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id dc6cbc7cb17558e0;
 Tue, 03 Nov 2026 15:11:12 +0000
X-Mizu-Trace-ID: dc6cbc7cb17558e0
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 111/227] net/cnxk: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:09 +0800
Message-ID: <20261103145306.487255-112-chengwen.feng@linux.dev>
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
 drivers/net/cnxk/cnxk_eswitch.c    | 2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c | 6 +++---
 drivers/net/cnxk/cnxk_lookup.c     | 2 +-
 drivers/net/cnxk/cnxk_rep.h        | 4 ++--
 drivers/net/cnxk/cnxk_rep_ops.c    | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index 57e2c490df..741621959e 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -722,7 +722,7 @@ cnxk_eswitch_dev_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pc
 			return 0;
 
 		mz = rte_memzone_reserve_aligned(CNXK_REP_ESWITCH_DEV_MZ, sizeof(*eswitch_dev),
-						 SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
+						 RTE_NUMA_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
 		if (mz == NULL) {
 			plt_err("Failed to reserve a memzone");
 			goto fail;
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index d208569168..4c41151bdc 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -87,7 +87,7 @@ cnxk_nix_inl_meta_pool_cb(uint64_t *aura_handle, uintptr_t *mpool, uint32_t buf_
 	 */
 	mp = rte_mempool_create_empty(mp_name, nb_bufs, buf_sz, 0,
 				      sizeof(struct rte_pktmbuf_pool_private),
-				      SOCKET_ID_ANY, 0);
+				      RTE_NUMA_ID_ANY, 0);
 	if (!mp) {
 		plt_err("Failed to create inline meta pool");
 		return -EIO;
@@ -157,7 +157,7 @@ cnxk_nix_inl_custom_meta_pool_cb(uintptr_t pmpool, uintptr_t *mpool, const char
 	 */
 	hp = rte_mempool_create_empty(mempool_name, nb_bufs, buf_sz, 0,
 				      sizeof(struct rte_pktmbuf_pool_private),
-				      SOCKET_ID_ANY, 0);
+				      RTE_NUMA_ID_ANY, 0);
 	if (!hp) {
 		plt_err("Failed to create inline meta pool");
 		return -EIO;
@@ -865,7 +865,7 @@ cnxk_nix_inl_dev_probe(struct rte_pci_driver *pci_drv,
 		return 0;
 
 	mz = rte_memzone_reserve_aligned(nix_inl_dev_to_name(pci_dev, name),
-					 sizeof(*inl_dev), SOCKET_ID_ANY, 0,
+					 sizeof(*inl_dev), RTE_NUMA_ID_ANY, 0,
 					 RTE_CACHE_LINE_SIZE);
 	if (mz == NULL)
 		return rc;
diff --git a/drivers/net/cnxk/cnxk_lookup.c b/drivers/net/cnxk/cnxk_lookup.c
index 7af9cb111e..9504327e58 100644
--- a/drivers/net/cnxk/cnxk_lookup.c
+++ b/drivers/net/cnxk/cnxk_lookup.c
@@ -316,7 +316,7 @@ cnxk_nix_fastpath_lookup_mem_get(void)
 		return mz->addr;
 
 	/* Request for the first time */
-	mz = rte_memzone_reserve_aligned(name, LOOKUP_ARRAY_SZ, SOCKET_ID_ANY,
+	mz = rte_memzone_reserve_aligned(name, LOOKUP_ARRAY_SZ, RTE_NUMA_ID_ANY,
 					 0, ROC_ALIGN);
 	if (mz != NULL) {
 		mem = mz->addr;
diff --git a/drivers/net/cnxk/cnxk_rep.h b/drivers/net/cnxk/cnxk_rep.h
index 9ede1e6dad..b891856bb7 100644
--- a/drivers/net/cnxk/cnxk_rep.h
+++ b/drivers/net/cnxk/cnxk_rep.h
@@ -122,10 +122,10 @@ int cnxk_rep_dev_configure(struct rte_eth_dev *eth_dev);
 int cnxk_rep_link_update(struct rte_eth_dev *eth_dev, int wait_to_compl);
 int cnxk_rep_dev_start(struct rte_eth_dev *eth_dev);
 int cnxk_rep_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t queue_idx, uint16_t nb_desc,
-			    unsigned int socket_id, const struct rte_eth_rxconf *rx_conf,
+			    unsigned int numa_id, const struct rte_eth_rxconf *rx_conf,
 			    struct rte_mempool *mp);
 int cnxk_rep_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t queue_idx, uint16_t nb_desc,
-			    unsigned int socket_id, const struct rte_eth_txconf *tx_conf);
+			    unsigned int numa_id, const struct rte_eth_txconf *tx_conf);
 void cnxk_rep_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 void cnxk_rep_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 int cnxk_rep_dev_stop(struct rte_eth_dev *eth_dev);
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index d4f260af20..792de73bba 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -288,7 +288,7 @@ cnxk_rep_dev_stop(struct rte_eth_dev *ethdev)
 
 int
 cnxk_rep_rx_queue_setup(struct rte_eth_dev *ethdev, uint16_t rx_queue_id, uint16_t nb_rx_desc,
-			unsigned int socket_id, const struct rte_eth_rxconf *rx_conf,
+			unsigned int numa_id, const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mb_pool)
 {
 	struct cnxk_rep_dev *rep_dev = cnxk_rep_pmd_priv(ethdev);
@@ -296,7 +296,7 @@ cnxk_rep_rx_queue_setup(struct rte_eth_dev *ethdev, uint16_t rx_queue_id, uint16
 	uint16_t qid = 0;
 	int rc;
 
-	PLT_SET_USED(socket_id);
+	PLT_SET_USED(numa_id);
 	/* If no representee assigned, store the respective rxq parameters */
 	if (!rep_dev->is_vf_active && !rep_dev->rxq) {
 		rxq = plt_zmalloc(sizeof(*rxq), RTE_CACHE_LINE_SIZE);
@@ -384,13 +384,13 @@ cnxk_rep_rx_queue_release(struct rte_eth_dev *ethdev, uint16_t queue_id)
 
 int
 cnxk_rep_tx_queue_setup(struct rte_eth_dev *ethdev, uint16_t tx_queue_id, uint16_t nb_tx_desc,
-			unsigned int socket_id, const struct rte_eth_txconf *tx_conf)
+			unsigned int numa_id, const struct rte_eth_txconf *tx_conf)
 {
 	struct cnxk_rep_dev *rep_dev = cnxk_rep_pmd_priv(ethdev);
 	struct cnxk_rep_txq *txq = NULL;
 	int rc = 0, qid = 0;
 
-	PLT_SET_USED(socket_id);
+	PLT_SET_USED(numa_id);
 	/* If no representee assigned, store the respective rxq parameters */
 	if (!rep_dev->is_vf_active && !rep_dev->txq) {
 		txq = plt_zmalloc(sizeof(*txq), RTE_CACHE_LINE_SIZE);
-- 
2.55.0

