Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8A606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=a/q4PpGg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0A3342707;
	Mon,  9 Nov 2026 17:21:17 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTPS id B74FA40A84
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=fJFtImdWx3n97/zezulUUJ6XzU9Q8RAH/WadVA9P4EQ=;
 b=a/q4PpGgckBBhkZ+IRdXKG2aEL7LXOFJcN6HycgiiWLor8vBESIQcAj9qDOCvh
 x79TaqNcZXQwdCMxhFxqH1jC6evh0P9e3iPRPRwBZ9g/kUOc9552xptfI4wMlIjm
 fReY650U8eIrlNqqGzxAmrlxs1RsrZkbpvaxrmzgQI8IQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 24/28] net/hinic3: expand TSO from 127 to 255 segments
Date: Tue, 10 Nov 2026 00:20:28 +0800
Message-ID: <20261109162033.1144-25-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S26
X-Coremail-Antispam: 1Uf129KBjvAXoWfZrW5AFy5ZF1rZF1fZrWkJFb_yoW8uFyxCo
 WfXrn3tw1avry8Gr409w4kuFs2qwsxZFs8Aw40krsFyFWUWr1UC3sxJw1xJa4rXwnYv3Zr
 AasxJF1Sk3s7X343n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwb10UUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwsOGGrx8usPUQAA32
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Raise the TSO segment limit to 255 so the largest jumbo frames can be
sent, reworking the SGE copy path to build multiple copy mbufs instead of
a single one. 255 is the number of buffer descriptors a WQE can carry, so
it is the limit the copy path has to compress the input segments into.

Raise the non-TSO SGE limit from 32 to 38 to match the non-TSO WQE, size
the per-port copy pool from the Tx queue depth (capped at 256 per queue),
and advance the per-segment copy source offset so a segment spanning
several copy mbufs is not copied from its start again.

Reject a packet whose WQE would need the whole ring, advertise the
segment limits through the Tx descriptor limits, keep the copy mbuf chain
consistent by updating nb_segs and pkt_len while it is built, reject
packets without a valid tso_segsz instead of dividing by it, and reject a
tso_segsz that does not fit the 14-bit MSS field instead of using the
truncated value for the fragment count.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/hinic3/hinic3_ethdev.c     |  46 +++-
 drivers/net/hinic3/hinic3_ethdev.h     |   1 -
 drivers/net/hinic3/hinic3_tx.c         | 328 ++++++++++++++-----------
 drivers/net/hinic3/hinic3_tx.h         |  15 +-
 5 files changed, 230 insertions(+), 161 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 247f6501f5..841f2c4f9d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -173,6 +173,7 @@ New Features
   * Added support for the SP560 NIC.
   * Added device parameters for runtime configuration.
   * Added a compact CQE receive data path.
+  * Extended TCP segmentation offload (TSO) to 255 segments.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index e939b33fd3..49d74d1420 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -331,6 +331,8 @@ static const struct rte_eth_desc_lim hinic3_tx_desc_lim = {
 	.nb_max = HINIC3_MAX_QUEUE_DEPTH,
 	.nb_min = HINIC3_MIN_QUEUE_DEPTH,
 	.nb_align = HINIC3_TXD_ALIGN,
+	.nb_seg_max = HINIC3_TSO_PKT_MAX_SGE,
+	.nb_mtu_seg_max = HINIC3_TSO_PKT_MAX_SGE,
 };
 
 /*
@@ -670,24 +672,41 @@ hinic3_deinit_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)
 static int
 hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev)
 {
-	nic_dev->cpy_mpool = rte_mempool_lookup(HINCI3_CPY_MEMPOOL_NAME);
+	char name[RTE_MEMPOOL_NAMESIZE];
+	struct hinic3_txq *txq = nic_dev->txqs[0];
+	unsigned int q_depth = 0;
+	unsigned int depth;
+
+	/*
+	 * Give each port its own copy pool sized from its Tx queue depth so
+	 * that in-flight copy mbufs from one port cannot starve another. A
+	 * copied packet pins its copy mbufs until Tx completion, so the pool
+	 * must be able to cover a full ring of in-flight packets. Cap the
+	 * per-queue depth at 256 to bound the hugepage memory a port can pin.
+	 */
+	if (txq != NULL)
+		q_depth = txq->q_depth;
+	depth = nic_dev->num_sqs * RTE_MIN(q_depth, 256u);
+	if (depth < HINIC3_COPY_MEMPOOL_DEPTH)
+		depth = HINIC3_COPY_MEMPOOL_DEPTH;
+
+	snprintf(name, sizeof(name), "hinic3_cpy_%u",
+		 (unsigned int)nic_dev->hwdev->eth_dev->data->port_id);
+	nic_dev->cpy_mpool = rte_pktmbuf_pool_create(name, depth,
+			HINIC3_COPY_MEMPOOL_CACHE, 0, HINIC3_COPY_MBUF_SIZE,
+			nic_dev->hwdev->pci_dev->device.numa_node);
 	if (nic_dev->cpy_mpool == NULL) {
-		nic_dev->cpy_mpool = rte_pktmbuf_pool_create(HINCI3_CPY_MEMPOOL_NAME,
-			HINIC3_COPY_MEMPOOL_DEPTH, HINIC3_COPY_MEMPOOL_CACHE,
-			0, HINIC3_COPY_MBUF_SIZE, rte_socket_id());
-		if (nic_dev->cpy_mpool == NULL) {
-			PMD_DRV_LOG(ERR,
-				    "Create copy mempool failed, errno: %d, dev_name: %s",
-				    rte_errno, HINCI3_CPY_MEMPOOL_NAME);
-			return -ENOMEM;
-		}
+		PMD_DRV_LOG(ERR,
+			    "Create copy mempool %s failed, errno: %d, dev_name: %s",
+			    name, rte_errno, nic_dev->dev_name);
+		return -ENOMEM;
 	}
 
 	return 0;
 }
 
 /**
- * Clear the reference to the copy memory pool without freeing it.
+ * Free the copy memory pool.
  *
  * @param[in] nic_dev
  * Pointer to NIC device structure.
@@ -695,6 +714,9 @@ hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev)
 static void
 hinic3_copy_mempool_uninit(struct hinic3_nic_dev *nic_dev)
 {
+	if (nic_dev->cpy_mpool != NULL)
+		rte_mempool_free(nic_dev->cpy_mpool);
+
 	nic_dev->cpy_mpool = NULL;
 }
 
@@ -1425,6 +1447,8 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	txq->wqebb_size = (uint16_t)RTE_BIT32(txq->wqebb_shift);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->owner = 1;
+	txq->non_tso_max_pkt_len =
+		HINIC3_IS_SP230_NIC(nic_dev) ? HINIC3_MAX_JUMBO_FRAME_SIZE : MAX_SINGLE_SGE_SIZE;
 
 	if (!ODD_NUMBER_QUEUE_ID(qid) &&
 		hinic3_cmd_vf_lag(nic_dev->hwdev, hinic3_global_func_id(nic_dev->hwdev),
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index eff0bca29e..dfa5bf8b8f 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -50,7 +50,6 @@
 #define HINIC3_PKT_RX_LRO		RTE_MBUF_F_RX_LRO
 #define HINIC3_PKT_TX_L4_NO_CKSUM	RTE_MBUF_F_TX_L4_NO_CKSUM
 
-#define HINCI3_CPY_MEMPOOL_NAME "cpy_mempool"
 /* Mbuf pool for copy invalid mbuf segs. */
 #define HINIC3_COPY_MEMPOOL_DEPTH	1024
 #define HINIC3_COPY_MEMPOOL_CACHE	128
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index ca84118b27..eedada96f6 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -658,122 +658,111 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
  * true as valid, false as invalid.
  */
 static bool
-hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
+hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf,
+			struct hinic3_wqe_info *wqe_info)
 {
-	uint32_t total_len, limit_len, checked_len, left_len, adjust_mss;
-	uint32_t max_sges, left_sges, first_len;
-	uint32_t payload_len, frag_num;
-	uint32_t i;
-	struct rte_mbuf *mbuf_head, *mbuf_first;
-	struct rte_mbuf *mbuf_pre = mbuf;
+	uint32_t payload_len, frag_num, adjust_mss, limit_len;
+	uint32_t i = 0, window_len = 0, no_copy_total_len = 0;
+	uint8_t copy_mbuf_num;
+	struct rte_mbuf *mbuf_pkt;
 
-	left_sges = mbuf->nb_segs;
-	mbuf_head = mbuf;
-	mbuf_first = mbuf;
+	if (unlikely(mbuf->data_len < wqe_info->payload_offset &&
+		     mbuf->nb_segs > HINIC3_NONTSO_PKT_MAX_SGE))
+		return false;
 
 	/* Calculate the number of message payload frag,
 	 * if it exceeds the hardware limit of 10 bits,
 	 * packet will be discarded.
 	 */
-	payload_len = mbuf_head->pkt_len - wqe_info->payload_offset;
-	frag_num = (payload_len + mbuf_head->tso_segsz - 1) / mbuf_head->tso_segsz;
-	if (frag_num > MAX_TSO_NUM_FRAG) {
-		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num:0x%x.", frag_num);
+	payload_len = mbuf->pkt_len - wqe_info->payload_offset;
+
+	frag_num = (payload_len + mbuf->tso_segsz - 1) / mbuf->tso_segsz;
+	if (frag_num > MAX_TSO_NUM_FRAG)
 		return false;
-	}
 
-	/* Tso sge number validation. */
-	if (unlikely(left_sges >= HINIC3_NONTSO_PKT_MAX_SGE)) {
-		checked_len = 0;
-		total_len = 0;
-		first_len = 0;
-		adjust_mss = mbuf->tso_segsz >= TX_MSS_MIN ? mbuf->tso_segsz
-							   : TX_MSS_MIN;
-		max_sges = HINIC3_NONTSO_PKT_MAX_SGE - 1;
-		limit_len = adjust_mss + wqe_info->payload_offset;
-
-		for (i = 0; (i < max_sges) && (total_len < limit_len); i++) {
-			total_len += mbuf->data_len;
-			mbuf_pre = mbuf;
-			mbuf = mbuf->next;
-		}
+	/* TSO SGE <= HINIC3_NONTSO_PKT_MAX_SGE: no processing */
+	if (likely(mbuf->nb_segs <= HINIC3_NONTSO_PKT_MAX_SGE))
+		return true;
 
-		/* Each continues 38 mbufs segmust do one check. */
-		while (left_sges >= HINIC3_NONTSO_PKT_MAX_SGE) {
-			if (total_len >= limit_len) {
-				/* Update the limit len. */
-				limit_len = adjust_mss;
-				/* Update checked len. */
-				checked_len += first_len;
-				/* Record the first len. */
-				first_len = mbuf_first->data_len;
-				/* First mbuf move to the next. */
-				mbuf_first = mbuf_first->next;
-				/* Update total len. */
-				total_len -= first_len;
-				left_sges--;
-				i--;
-				for (;
-				     (i < max_sges) && (total_len < limit_len);
-				     i++) {
-					total_len += mbuf->data_len;
-					mbuf_pre = mbuf;
-					mbuf = mbuf->next;
-				}
-			} else {
-				/* Try to copy if not valid. */
-				checked_len += (total_len - mbuf_pre->data_len);
+	adjust_mss = mbuf->tso_segsz >= TX_MSS_MIN ? mbuf->tso_segsz : TX_MSS_MIN;
 
-				left_len = mbuf_head->pkt_len - checked_len;
-				if (left_len > HINIC3_COPY_MBUF_SIZE)
-					return false;
-				wqe_info->sge_cnt = (uint16_t)(mbuf_head->nb_segs +
-							  i - left_sges);
-				wqe_info->cpy_mbuf_cnt = 1;
+	/* TSO SGE > HINIC3_TSO_PKT_MAX_SGE: skip MSS check, directly trigger copy */
+	if (unlikely(mbuf->nb_segs > HINIC3_TSO_PKT_MAX_SGE))
+		goto copy;
 
-				return true;
+	/* Check sum of 38 SGEs < MSS (First segment < header + MSS) */
+	limit_len = adjust_mss + wqe_info->payload_offset;
+	mbuf_pkt = mbuf;
+	while (mbuf_pkt) {
+		window_len += mbuf_pkt->data_len;
+		i++;
+		mbuf_pkt = mbuf_pkt->next;
+
+		if (i > HINIC3_NONTSO_PKT_MAX_SGE)
+			goto copy;
+
+		if (window_len >= limit_len) {
+			if (limit_len == adjust_mss + wqe_info->payload_offset) {
+				window_len -= limit_len;
+				limit_len = adjust_mss;
 			}
-		} /**< End of while. */
+			window_len %= adjust_mss;
+			i = (window_len == 0) ? 0 : 1;
+		}
+	}
+	return true;
+
+copy:
+	mbuf_pkt = mbuf;
+	for (i = 0; i < HINIC3_NON_COPY_SGE_NUM; i++) {
+		no_copy_total_len += mbuf_pkt->data_len;
+		mbuf_pkt = mbuf_pkt->next;
 	}
 
-	wqe_info->sge_cnt = mbuf_head->nb_segs;
+	/* TSO payload must fit in HINIC3_TSO_MBUF_NUM_MAX copy mbufs. */
+	if (unlikely(mbuf->pkt_len - no_copy_total_len >
+		     HINIC3_TSO_MBUF_NUM_MAX * HINIC3_COPY_MBUF_SIZE))
+		return false;
+
+	copy_mbuf_num = (mbuf->pkt_len - no_copy_total_len +
+			 HINIC3_COPY_MBUF_SIZE - 1) / HINIC3_COPY_MBUF_SIZE;
+
+	/* Total SGE = 28 normal SGEs + copy mbufs */
+	wqe_info->sge_cnt = HINIC3_NON_COPY_SGE_NUM + copy_mbuf_num;
+	wqe_info->cpy_mbuf_cnt = copy_mbuf_num;
 
 	return true;
 }
 
 static int
-hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
+hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info,
+			       uint32_t non_tso_max_pkt_len)
 {
 	struct rte_mbuf *mbuf_pkt = mbuf;
 	uint32_t total_len = 0;
-	uint16_t i;
+	uint16_t i, copy_mbuf_num = 0;
+
+	/* Non-tso packet length must less than HINIC3_MAX_JUMBO_FRAME_SIZE */
+	if (unlikely(mbuf->pkt_len > non_tso_max_pkt_len))
+		return -EINVAL;
 
 	if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))
 		return 0;
 
-	/* Non-tso packet length must less than 64KB. */
-	if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))
-		return -EINVAL;
-
-	/*
-	 * Mbuf number of non-tso packet must less than the sge number
-	 * that nic can support. The excess part will be copied to another
-	 * mbuf.
-	 */
-	for (i = 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {
+	for (i = 0; i < HINIC3_NON_COPY_SGE_NUM; i++) {
 		total_len += mbuf_pkt->data_len;
 		mbuf_pkt = mbuf_pkt->next;
 	}
 
-	/*
-	 * Max copy mbuf size is 4KB, packet will be dropped directly,
-	 * if total copy length is more than it.
-	 */
-	if ((total_len + HINIC3_COPY_MBUF_SIZE) < mbuf->pkt_len)
+	/* Calculate required mbuf number */
+	copy_mbuf_num = (mbuf->pkt_len - total_len +
+			 HINIC3_COPY_MBUF_SIZE - 1) / HINIC3_COPY_MBUF_SIZE;
+	if (copy_mbuf_num > HINIC3_NONTSO_MBUF_NUM_MAX)
 		return -EINVAL;
 
-	wqe_info->sge_cnt = HINIC3_NONTSO_PKT_MAX_SGE;
-	wqe_info->cpy_mbuf_cnt = 1;
+	/* Total SGE = 28 normal SGEs + copy mbufs */
+	wqe_info->sge_cnt = HINIC3_NON_COPY_SGE_NUM + copy_mbuf_num;
+	wqe_info->cpy_mbuf_cnt = copy_mbuf_num;
 
 	return 0;
 }
@@ -787,12 +776,15 @@ hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wq
  * Point to the mbuf to send.
  * @param[in] wqe_info
  * Point to wqe_info of send queue(SQ).
+ * @param[in] q_depth
+ *  Depth of the send queue, used to reject a WQE that can never fit.
  * @return
  * 0 as success, -EINVAL as failure.
  */
 static int
 hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-		      struct hinic3_wqe_info *wqe_info)
+		      struct hinic3_wqe_info *wqe_info, uint32_t non_tso_max_pkt_len,
+		      uint16_t q_depth)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 	uint16_t inner_l3_offset = 0;
@@ -803,28 +795,43 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 	/* Check if the packet set available offload flags. */
 	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {
 		wqe_info->offload = 0;
-		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
-	}
-
-	wqe_info->offload = 1;
-	err = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
-	if (err)
-		return err;
-
-	/* Non-tso mbuf only check sge num. */
-	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG)))
-		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
+		err = hinic3_non_tso_pkt_pre_process(mbuf, wqe_info,
+						     non_tso_max_pkt_len);
+		if (unlikely(err))
+			return err;
+	} else {
+		wqe_info->offload = 1;
+		err = hinic3_get_inner_l3_offset(nic_dev, mbuf, &inner_l3_offset);
+		if (err)
+			return err;
+
+		/* Non-tso mbuf only check sge num. */
+		if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG))) {
+			err = hinic3_non_tso_pkt_pre_process(mbuf, wqe_info,
+							     non_tso_max_pkt_len);
+			if (unlikely(err))
+				return err;
+		} else {
+			/* Tso mbuf. */
+			if (unlikely(mbuf->tso_segsz == 0 ||
+				     mbuf->tso_segsz > SQ_CTRL_QUEUE_INFO_MSS_MASK))
+				return -EINVAL;
 
-	/* Tso mbuf. */
-	wqe_info->payload_offset =
-		inner_l3_offset + mbuf->l3_len + mbuf->l4_len;
+			wqe_info->payload_offset =
+				inner_l3_offset + mbuf->l3_len + mbuf->l4_len;
 
-	/* Too many mbuf segs. */
-	if (unlikely(HINIC3_TSO_SEG_NUM_INVALID(mbuf->nb_segs)))
-		return -EINVAL;
+			/* Check whether can cover all tso mbuf segs or not. */
+			if (unlikely(!hinic3_is_tso_sge_valid(mbuf, wqe_info)))
+				return -EINVAL;
+		}
+	}
 
-	/* Check whether can cover all tso mbuf segs or not. */
-	if (unlikely(!hinic3_is_tso_sge_valid(mbuf, wqe_info)))
+	/*
+	 * The WQE needs one WQEBB per SGE plus one for the task section, while
+	 * the ring never reports more than q_depth - 1 free WQEBBs. A packet
+	 * that needs the whole ring would never fit and would stall the queue.
+	 */
+	if (unlikely(wqe_info->sge_cnt >= q_depth - 1))
 		return -EINVAL;
 
 	return 0;
@@ -858,33 +865,70 @@ hinic3_alloc_cpy_mbuf(struct hinic3_nic_dev *nic_dev)
  * The address of the copied mbuf.
  */
 static void *
-hinic3_copy_tx_mbuf(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-		    uint16_t sge_cnt)
+hinic3_copy_tx_mbuf_multi(struct hinic3_nic_dev *nic_dev,
+			  struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)
 {
-	struct rte_mbuf *dst_mbuf;
-	uint32_t offset = 0;
-	uint16_t i;
+	uint8_t i;
+	uint32_t remaining_len, dst_mbuf_space, copy_size, copy_offset = 0;
+	uint32_t src_off;
+	struct rte_mbuf *prev_mbuf = NULL;
+	struct rte_mbuf *head_mbuf = NULL;
+	struct rte_mbuf *cur_mbuf;
 
 	if (unlikely(!nic_dev->cpy_mpool))
 		return NULL;
 
-	dst_mbuf = hinic3_alloc_cpy_mbuf(nic_dev);
-	if (unlikely(!dst_mbuf))
-		return NULL;
+	/* Allocate all copy mbufs and build linked list */
+	for (i = 0; i < wqe_info->cpy_mbuf_cnt; i++) {
+		cur_mbuf = hinic3_alloc_cpy_mbuf(nic_dev);
+		if (unlikely(!cur_mbuf))
+			goto err_free;
+
+		cur_mbuf->data_off = 0;
+		cur_mbuf->data_len = 0;
+		cur_mbuf->pkt_len = 0;
+		cur_mbuf->next = NULL;
+
+		if (prev_mbuf == NULL)
+			head_mbuf = cur_mbuf;
+		else
+			prev_mbuf->next = cur_mbuf;
+		prev_mbuf = cur_mbuf;
+		head_mbuf->nb_segs = i + 1;
+	}
 
-	dst_mbuf->data_off = 0;
-	dst_mbuf->data_len = 0;
-	for (i = 0; i < sge_cnt; i++) {
-		memcpy((uint8_t *)dst_mbuf->buf_addr + offset,
-			   (uint8_t *)mbuf->buf_addr + mbuf->data_off,
-			   mbuf->data_len);
-		dst_mbuf->data_len += mbuf->data_len;
-		offset += mbuf->data_len;
+	/* Copy data to mbufs - mbuf already points to first SGE to copy */
+	cur_mbuf = head_mbuf;
+	while (mbuf != NULL) {
+		remaining_len = mbuf->data_len;
+		while (remaining_len > 0 && cur_mbuf != NULL) {
+			dst_mbuf_space = HINIC3_COPY_MBUF_SIZE - copy_offset;
+			copy_size = RTE_MIN(remaining_len, dst_mbuf_space);
+			src_off = mbuf->data_len - remaining_len;
+
+			rte_memcpy((uint8_t *)cur_mbuf->buf_addr + copy_offset,
+				   rte_pktmbuf_mtod_offset(mbuf, uint8_t *, src_off),
+				   copy_size);
+
+			cur_mbuf->data_len += copy_size;
+			head_mbuf->pkt_len += copy_size;
+			copy_offset += copy_size;
+			remaining_len -= copy_size;
+
+			if (copy_offset >= HINIC3_COPY_MBUF_SIZE) {
+				copy_offset = 0;
+				cur_mbuf = cur_mbuf->next;
+			}
+		}
 		mbuf = mbuf->next;
 	}
-	dst_mbuf->pkt_len = dst_mbuf->data_len;
 
-	return dst_mbuf;
+	return head_mbuf;
+
+err_free:
+	/* Free all allocated mbufs on error */
+	hinic3_free_cpy_mbuf(nic_dev, head_mbuf);
+	return NULL;
 }
 
 /**
@@ -910,9 +954,9 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
 	struct hinic3_sq_bufdesc *buf_desc = wqe_combo->bds_head;
 	uint16_t nb_segs = wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;
-	uint16_t real_segs = mbuf->nb_segs;
 	rte_iova_t dma_addr;
 	uint32_t i;
+	uint8_t mbuf_idx;
 
 	for (i = 0; i < nb_segs; i++) {
 		if (unlikely(mbuf == NULL)) {
@@ -951,40 +995,34 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 		mbuf = mbuf->next;
 	}
 
-	/* For now: support over 38 sge, copy the last 2 mbuf. */
 	if (unlikely(wqe_info->cpy_mbuf_cnt != 0)) {
 		/*
 		 * Copy invalid mbuf segs to a valid buffer, lost performance.
 		 */
 		txq->txq_stats.cpy_pkts += 1;
-		mbuf = hinic3_copy_tx_mbuf(txq->nic_dev, mbuf,
-					   real_segs - nb_segs);
+		mbuf = hinic3_copy_tx_mbuf_multi(txq->nic_dev, mbuf, wqe_info);
 		if (unlikely(!mbuf))
 			return -EINVAL;
 
 		txq->tx_info[wqe_info->pi].cpy_mbuf = mbuf;
 
-		/* Deal with the last mbuf. */
-		dma_addr = rte_mbuf_data_iova(mbuf);
-		if (unlikely(mbuf->data_len == 0)) {
-			txq->txq_stats.sge_len0++;
-			return -EINVAL;
-		}
-		/*
-		 * Parts of wqe is in sq bottom while parts
-		 * of wqe is in sq head.
-		 */
-		if (i == 0) {
-			wqe_desc->hi_addr =
-				hinic3_hw_be32(upper_32_bits(dma_addr));
-			wqe_desc->lo_addr =
-				hinic3_hw_be32(lower_32_bits(dma_addr));
-			wqe_desc->ctrl_len = mbuf->data_len;
-		} else {
-			if (unlikely(((uint64_t)buf_desc == txq->sq_bot_sge_addr)))
+		/* Set DMA descriptors for all copy mbufs */
+		for (mbuf_idx = 0; mbuf_idx < wqe_info->cpy_mbuf_cnt; mbuf_idx++) {
+			dma_addr = rte_mbuf_data_iova(mbuf);
+			if (unlikely(mbuf->data_len == 0)) {
+				txq->txq_stats.sge_len0++;
+				hinic3_free_cpy_mbuf(txq->nic_dev,
+						     txq->tx_info[wqe_info->pi].cpy_mbuf);
+				txq->tx_info[wqe_info->pi].cpy_mbuf = NULL;
+				return -EINVAL;
+			}
+
+			if (unlikely((uint64_t)buf_desc == txq->sq_bot_sge_addr))
 				buf_desc = (struct hinic3_sq_bufdesc *)txq->sq_head_addr;
 
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);
+			buf_desc++;
+			mbuf = mbuf->next;
 		}
 	}
 
@@ -1085,7 +1123,9 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/* Tx loop routine. */
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		mbuf_pkt = *tx_pkts++;
-		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info))) {
+		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info,
+						   txq->non_tso_max_pkt_len,
+						   txq->q_depth))) {
 			txq->txq_stats.offload_errors++;
 			break;
 		}
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index 3b1580dd3a..e5aa0a6f8e 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -6,11 +6,17 @@
 #define _HINIC3_TX_H_
 
 #define MAX_SINGLE_SGE_SIZE		 65536
-#define HINIC3_NONTSO_PKT_MAX_SGE	 32 /**< non-tso max sge 32. */
+#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */
 #define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <= HINIC3_NONTSO_PKT_MAX_SGE)
 
-#define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */
-#define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)
+#define HINIC3_TSO_PKT_MAX_SGE		255 /**< tso max sge 255. */
+
+/* Non-copy SGE configuration: 28 SGEs are not copied */
+#define HINIC3_NON_COPY_SGE_NUM	28
+#define HINIC3_NONTSO_MBUF_NUM_MAX \
+	(HINIC3_NONTSO_PKT_MAX_SGE - HINIC3_NON_COPY_SGE_NUM)
+#define HINIC3_TSO_MBUF_NUM_MAX \
+	(HINIC3_TSO_PKT_MAX_SGE - HINIC3_NON_COPY_SGE_NUM)
 
 /* Tx wqe queue info */
 struct hinic3_queue_info {
@@ -57,7 +63,6 @@ struct hinic3_wqe_info {
 	uint16_t pi;
 
 	uint16_t wqebb_cnt;
-	uint16_t rsvd2; /**< Reserved field 2. */
 
 	struct hinic3_queue_info queue_info;
 	struct hinic3_offload_info offload_info;
@@ -375,7 +380,7 @@ struct __rte_cache_aligned hinic3_txq {
 	uint64_t sq_bot_sge_addr;
 	uint32_t cos;
 	uint8_t tx_wqe_compact_task;
-	uint8_t rsvd[3];
+	uint32_t non_tso_max_pkt_len;
 	struct hinic3_txq_stats txq_stats;
 #ifdef HINIC3_XSTAT_PROF_TX
 	uint64_t prof_tx_end_tsc;
-- 
2.33.0

