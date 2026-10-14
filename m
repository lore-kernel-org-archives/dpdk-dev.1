Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADCCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D75F40E1C;
	Wed, 14 Oct 2026 17:10:10 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 7A273406B6
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=2IQtF2unQKV4s87+pX+wouoNKgRVDLH9hID16VO1iiE=;
 b=BDk2iroYqkHc45zs/BGZ1UW7RYhC4BO3Xm++oeJgbGoBEhPJvXA3atIN+TzA3s
 nvPEsOKAtiHRHabjL/BVw2X2hMTahQw6SO+q/sY/+7rKCwYpAVVEyVZ/hOctKOGd
 wuvfhY8723TRqvFm14Shl/DkIQbZ90Zui2dwmnRV7ON74=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 19/26] net/hinic3: expand TSO from 127 to 255 segments
Date: Wed, 14 Oct 2026 23:09:15 +0800
Message-ID: <20261014150923.838-20-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S21
X-Coremail-Antispam: 1Uf129KBjvAXoW3tr1xZFW7Jw1rCryxJFWrKrg_yoW8WFyfJo
 WfXFn3tr1Yvry8Gr409w4kuFs2qwsxJFs8A340krsFkay8ur1UC3sxJw1xGa4rXwnYv3Zr
 CasxGF1Sk3s7X343n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUoyCGUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNByEjmrPmzwcoQAA3d
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

Raise the TSO segment limit to 255 so the largest jumbo frames can be sent,
reworking the SGE copy path to build multiple copy mbufs.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/hinic3/hinic3_ethdev.c     |   2 +
 drivers/net/hinic3/hinic3_tx.c         | 284 ++++++++++++++-----------
 drivers/net/hinic3/hinic3_tx.h         |  14 +-
 4 files changed, 172 insertions(+), 129 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index cda505cb37..53d0f76a32 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -124,6 +124,7 @@ New Features
   * Added support for the SP560 NIC.
   * Added device parameters for runtime configuration.
   * Added a compact CQE receive data path.
+  * Extended TCP segmentation offload (TSO) to 255 segments.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 6007b5fb8d..d3e95a361a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -1377,6 +1377,8 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	txq->wqebb_size = (uint16_t)RTE_BIT32(txq->wqebb_shift);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->owner = 1;
+	txq->non_tso_max_pkt_len =
+		HINIC3_IS_SP230_NIC(nic_dev) ? HINIC3_MAX_JUMBO_FRAME_SIZE : MAX_SINGLE_SGE_SIZE;
 
 	if (!ODD_NUMBER_QUEUE_ID(qid) &&
 		hinic3_cmd_vf_lag(nic_dev->hwdev, hinic3_global_func_id(nic_dev->hwdev),
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
index 6b2bffb14e..c8a4170b87 100644
--- a/drivers/net/hinic3/hinic3_tx.c
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -473,122 +473,117 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_dev,
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
-
-	left_sges = mbuf->nb_segs;
-	mbuf_head = mbuf;
-	mbuf_first = mbuf;
+	uint32_t payload_len, frag_num, adjust_mss, limit_len;
+	uint32_t i = 0, window_len = 0, no_copy_total_len = 0;
+	uint8_t copy_mbuf_num;
+	struct rte_mbuf *mbuf_pkt;
+
+	if (unlikely(mbuf->data_len < wqe_info->payload_offset &&
+		     mbuf->nb_segs > HINIC3_NONTSO_PKT_MAX_SGE)) {
+		PMD_DRV_LOG(WARNING, "illegal pkt, payload offset (%u) > data len (%u).",
+			    wqe_info->payload_offset, mbuf->data_len);
+		return false;
+	}
 
 	/* Calculate the number of message payload frag,
 	 * if it exceeds the hardware limit of 10 bits,
 	 * packet will be discarded.
 	 */
-	payload_len = mbuf_head->pkt_len - wqe_info->payload_offset;
-	frag_num = (payload_len + mbuf_head->tso_segsz - 1) / mbuf_head->tso_segsz;
+	payload_len = mbuf->pkt_len - wqe_info->payload_offset;
+
+	frag_num = (payload_len + mbuf->tso_segsz - 1) / mbuf->tso_segsz;
 	if (frag_num > MAX_TSO_NUM_FRAG) {
-		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num:0x%x.", frag_num);
+		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num: 0x%x", frag_num);
 		return false;
 	}
 
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
+	}
+
+	/* TSO payload must fit in HINIC3_TSO_MBUF_NUM_MAX copy mbufs. */
+	if (unlikely(mbuf->pkt_len - no_copy_total_len >
+		     HINIC3_TSO_MBUF_NUM_MAX * HINIC3_COPY_MBUF_SIZE)) {
+		PMD_DRV_LOG(WARNING, "TSO payload over hardware limit.");
+		return false;
 	}
 
-	wqe_info->sge_cnt = mbuf_head->nb_segs;
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
 
 	if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))
 		return 0;
 
-	/* Non-tso packet length must less than 64KB. */
-	if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))
+	/* Non-tso packet length must less than HINIC3_MAX_JUMBO_FRAME_SIZE */
+	if (unlikely(mbuf->pkt_len > non_tso_max_pkt_len))
 		return -EINVAL;
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
@@ -607,7 +602,7 @@ hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wq
  */
 static int
 hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
-		      struct hinic3_wqe_info *wqe_info)
+		      struct hinic3_wqe_info *wqe_info, uint32_t non_tso_max_pkt_len)
 {
 	uint64_t ol_flags = mbuf->ol_flags;
 	uint16_t inner_l3_offset = 0;
@@ -615,10 +610,11 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 
 	wqe_info->sge_cnt = mbuf->nb_segs;
 	wqe_info->cpy_mbuf_cnt = 0;
+	wqe_info->last_cpy_mbuf_usable = 0;
 	/* Check if the packet set available offload flags. */
 	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {
 		wqe_info->offload = 0;
-		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info, non_tso_max_pkt_len);
 	}
 
 	wqe_info->offload = 1;
@@ -628,7 +624,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,
 
 	/* Non-tso mbuf only check sge num. */
 	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG)))
-		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info, non_tso_max_pkt_len);
 
 	/* Tso mbuf. */
 	wqe_info->payload_offset =
@@ -673,33 +669,76 @@ hinic3_alloc_cpy_mbuf(struct hinic3_nic_dev *nic_dev)
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
+		cur_mbuf->pkt_len = mbuf->pkt_len;
+		cur_mbuf->next = NULL;
+
+		if (prev_mbuf == NULL)
+			head_mbuf = cur_mbuf;
+		else
+			prev_mbuf->next = cur_mbuf;
+		prev_mbuf = cur_mbuf;
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
+
+			rte_memcpy((uint8_t *)cur_mbuf->buf_addr + copy_offset,
+				   (uint8_t *)mbuf->buf_addr + mbuf->data_off,
+				   copy_size);
+
+			cur_mbuf->data_len += copy_size;
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
+	/* all copy_mbuf cann't store packet data, cut off last mbuf, ensure
+	 * the len of all mbuf = header + N * MSS
+	 */
+	if (unlikely(wqe_info->last_cpy_mbuf_usable != 0)) {
+		cur_mbuf = head_mbuf;
+		for (i = 0; i < wqe_info->cpy_mbuf_cnt - 1; i++)
+			cur_mbuf = cur_mbuf->next;
+		cur_mbuf->data_len = wqe_info->last_cpy_mbuf_usable;
+	}
+
+	return head_mbuf;
+
+err_free:
+	/* Free all allocated mbufs on error */
+	hinic3_free_cpy_mbuf(nic_dev, head_mbuf);
+	return NULL;
 }
 
 /**
@@ -725,9 +764,9 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->hdr;
 	struct hinic3_sq_bufdesc *buf_desc = wqe_combo->bds_head;
 	uint16_t nb_segs = wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;
-	uint16_t real_segs = mbuf->nb_segs;
 	rte_iova_t dma_addr;
 	uint32_t i;
+	uint8_t mbuf_idx;
 
 	for (i = 0; i < nb_segs; i++) {
 		if (unlikely(mbuf == NULL)) {
@@ -766,40 +805,34 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct rte_mbuf *mbuf,
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
+						    txq->tx_info[wqe_info->pi].cpy_mbuf);
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
 
@@ -900,7 +933,8 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/* Tx loop routine. */
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		mbuf_pkt = *tx_pkts++;
-		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info))) {
+		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info,
+						   txq->non_tso_max_pkt_len))) {
 			txq->txq_stats.offload_errors++;
 			break;
 		}
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
index e0ed9908ad..5d4101630e 100644
--- a/drivers/net/hinic3/hinic3_tx.h
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -6,12 +6,18 @@
 #define _HINIC3_TX_H_
 
 #define MAX_SINGLE_SGE_SIZE		 65536
-#define HINIC3_NONTSO_PKT_MAX_SGE	 32 /**< non-tso max sge 32. */
+#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */
 #define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <= HINIC3_NONTSO_PKT_MAX_SGE)
 
-#define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */
+#define HINIC3_TSO_PKT_MAX_SGE		255 /**< tso max sge 255. */
 #define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)
 
+/* Non-copy SGE configuration: 28 SGEs are not copied */
+#define HINIC3_NON_COPY_SGE_NUM	28
+#define HINIC3_NONTSO_MBUF_NUM_MAX \
+	(HINIC3_NONTSO_PKT_MAX_SGE - HINIC3_NON_COPY_SGE_NUM)
+#define HINIC3_TSO_MBUF_NUM_MAX			(HINIC3_TSO_PKT_MAX_SGE - HINIC3_NON_COPY_SGE_NUM)
+
 /* Tx wqe queue info */
 struct hinic3_queue_info {
 	uint8_t pri;
@@ -57,7 +63,7 @@ struct hinic3_wqe_info {
 	uint16_t pi;
 
 	uint16_t wqebb_cnt;
-	uint16_t rsvd2; /**< Reserved field 2. */
+	uint16_t last_cpy_mbuf_usable;
 
 	struct hinic3_queue_info queue_info;
 	struct hinic3_offload_info offload_info;
@@ -375,7 +381,7 @@ struct __rte_cache_aligned hinic3_txq {
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

