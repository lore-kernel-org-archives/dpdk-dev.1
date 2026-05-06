Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA0CD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED1540696;
	Wed,  6 May 2026 19:22:54 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4A1F34066B
 for <dev@dpdk.org>; Wed,  6 May 2026 19:22:51 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9hy84YWWzHnGhl
 for <dev@dpdk.org>; Thu,  7 May 2026 01:21:52 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id B41B240570
 for <dev@dpdk.org>; Thu,  7 May 2026 01:22:50 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:22:50 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 05/10] bpf: support rte_bpf_prm_ex with port callbacks
Date: Wed, 6 May 2026 18:22:02 +0100
Message-ID: <20260506172209.6805-6-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Introduce new functions to install an already loaded BPF program into RX
or TX port/queue, since previous API was tied to rte_bpf_prm.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_pkt.c        | 65 ++++++++++++++++++++++++++++++----------
 lib/bpf/rte_bpf_ethdev.h | 54 +++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 5007f6aef57d..87065e939f31 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -490,13 +490,11 @@ rte_bpf_eth_tx_unload(uint16_t port, uint16_t queue)
 }
 
 static int
-bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
-	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
-	uint32_t flags)
+bpf_eth_elf_install(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
+	struct rte_bpf *bpf, uint32_t flags)
 {
 	int32_t rc;
 	struct bpf_eth_cbi *bc;
-	struct rte_bpf *bpf;
 	rte_rx_callback_fn frx;
 	rte_tx_callback_fn ftx;
 	struct rte_bpf_jit jit;
@@ -504,14 +502,17 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	frx = NULL;
 	ftx = NULL;
 
-	if (prm == NULL || rte_eth_dev_is_valid_port(port) == 0 ||
+	if (bpf == NULL || rte_eth_dev_is_valid_port(port) == 0 ||
 			queue >= RTE_MAX_QUEUES_PER_PORT)
 		return -EINVAL;
 
+	if (bpf->prm.nb_prog_arg != 1)
+		return -EINVAL;
+
 	if (cbh->type == BPF_ETH_RX)
-		frx = select_rx_callback(prm->prog_arg.type, flags);
+		frx = select_rx_callback(bpf->prm.prog_arg[0].type, flags);
 	else
-		ftx = select_tx_callback(prm->prog_arg.type, flags);
+		ftx = select_tx_callback(bpf->prm.prog_arg[0].type, flags);
 
 	if (frx == NULL && ftx == NULL) {
 		RTE_BPF_LOG_LINE(ERR, "%s(%u, %u): no callback selected;",
@@ -519,16 +520,11 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 		return -EINVAL;
 	}
 
-	bpf = rte_bpf_elf_load(prm, fname, sname);
-	if (bpf == NULL)
-		return -rte_errno;
-
 	rte_bpf_get_jit(bpf, &jit);
 
 	if ((flags & RTE_BPF_ETH_F_JIT) != 0 && jit.func == NULL) {
 		RTE_BPF_LOG_LINE(ERR, "%s(%u, %u): no JIT generated;",
 			__func__, port, queue);
-		rte_bpf_destroy(bpf);
 		return -ENOTSUP;
 	}
 
@@ -551,7 +547,6 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 
 	if (bc->cb == NULL) {
 		rc = -rte_errno;
-		rte_bpf_destroy(bpf);
 		bpf_eth_cbi_cleanup(bc);
 	} else
 		rc = 0;
@@ -564,13 +559,33 @@ int
 rte_bpf_eth_rx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
 	uint32_t flags)
+{
+	struct rte_bpf *bpf;
+	int32_t rc;
+
+	bpf = rte_bpf_elf_load(prm, fname, sname);
+	if (bpf == NULL)
+		return -rte_errno;
+
+	rc = rte_bpf_eth_rx_install(port, queue, bpf, flags);
+
+	if (rc < 0)
+		rte_bpf_destroy(bpf);
+
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_eth_rx_install, 26.11)
+int
+rte_bpf_eth_rx_install(uint16_t port, uint16_t queue, struct rte_bpf *bpf,
+	uint32_t flags)
 {
 	int32_t rc;
 	struct bpf_eth_cbh *cbh;
 
 	cbh = &rx_cbh;
 	rte_spinlock_lock(&cbh->lock);
-	rc = bpf_eth_elf_load(cbh, port, queue, prm, fname, sname, flags);
+	rc = bpf_eth_elf_install(cbh, port, queue, bpf, flags);
 	rte_spinlock_unlock(&cbh->lock);
 
 	return rc;
@@ -581,13 +596,33 @@ int
 rte_bpf_eth_tx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
 	uint32_t flags)
+{
+	struct rte_bpf *bpf;
+	int32_t rc;
+
+	bpf = rte_bpf_elf_load(prm, fname, sname);
+	if (bpf == NULL)
+		return -rte_errno;
+
+	rc = rte_bpf_eth_tx_install(port, queue, bpf, flags);
+
+	if (rc < 0)
+		rte_bpf_destroy(bpf);
+
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_eth_tx_install, 26.11)
+int
+rte_bpf_eth_tx_install(uint16_t port, uint16_t queue, struct rte_bpf *bpf,
+	uint32_t flags)
 {
 	int32_t rc;
 	struct bpf_eth_cbh *cbh;
 
 	cbh = &tx_cbh;
 	rte_spinlock_lock(&cbh->lock);
-	rc = bpf_eth_elf_load(cbh, port, queue, prm, fname, sname, flags);
+	rc = bpf_eth_elf_install(cbh, port, queue, bpf, flags);
 	rte_spinlock_unlock(&cbh->lock);
 
 	return rc;
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index cab8e9e3887a..e5eaf5b245e3 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -109,6 +109,60 @@ rte_bpf_eth_tx_elf_load(uint16_t port, uint16_t queue,
 	const struct rte_bpf_prm *prm, const char *fname, const char *sname,
 	uint32_t flags);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Install callback to execute specified BPF program on given TX port/queue.
+ *
+ * On success the ownership of the program passes to the library,
+ * rte_bpf_eth_unload must be used to unload it, and rte_bpf_destroy must no
+ * longer be called.
+ *
+ * @param port
+ *   The identifier of the ethernet port
+ * @param queue
+ *   The identifier of the TX queue on the given port
+ * @param bpf
+ *   BPF program
+ * @param flags
+ *   Flags that define expected behavior of the loaded filter
+ *   (i.e. jited/non-jited version to use).
+ * @return
+ *   Zero on successful completion or negative error code otherwise.
+ */
+__rte_experimental
+int
+rte_bpf_eth_rx_install(uint16_t port, uint16_t queue, struct rte_bpf *bpf,
+	uint32_t flags);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Install callback to execute specified BPF program on given RX port/queue.
+ *
+ * On success the ownership of the program passes to the library,
+ * rte_bpf_eth_unload must be used to unload it, and rte_bpf_destroy must no
+ * longer be called.
+ *
+ * @param port
+ *   The identifier of the ethernet port
+ * @param queue
+ *   The identifier of the RX queue on the given port
+ * @param bpf
+ *   BPF program
+ * @param flags
+ *   Flags that define expected behavior of the loaded filter
+ *   (i.e. jited/non-jited version to use).
+ * @return
+ *   Zero on successful completion or negative error code otherwise.
+ */
+__rte_experimental
+int
+rte_bpf_eth_tx_install(uint16_t port, uint16_t queue, struct rte_bpf *bpf,
+	uint32_t flags);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0

