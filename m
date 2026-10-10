Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD4FCA9EC1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CAD440BA5;
	Sat, 10 Oct 2026 16:45:34 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id C99D04064E
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=R3un49EYeL7QtsbR7q6NzIV7YxTRRyzJq83ntmYfvSs=;
 b=qOMb7CpuYRoz61WyV9eFDjRSsJEi3+Spz/emRT4ggK2jldrcidpoZfSVDF+mq2
 FYrqmlQ9/giQRACFI6Tvjp4oUDNyWUQ2EXhXasHc82Amc4HbtCzXk/MiP6e6PUXh
 uSKudyvM8DdB+mTFcSb3rjnJB21ojvsxyW2EYjLS+hbwQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 13/17] net/hinic3: expand TSO from 127 to 255 segments
Date: Sat, 10 Oct 2026 22:45:04 +0800
Message-ID: <20261010144509.2731-14-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S15
X-Coremail-Antispam: 1Uf129KBjvAXoW3tr17uw47AFW7Xry5tF4rGrg_yoW8WFWDto
 WfXFnayr1Yvry8Gr409w4kuFs2qwsxJFs8A340krsFkFW8ur1UC3sxJw1fGa4rXwnYv3Zr
 CasxGF1Sk3s7X343n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw_-PDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMh5ASmrKT34nyQAA3Z
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

Raise the TSO segment limit to 255 so the largest jumbo frames can be sent,=
=0D
reworking the SGE copy path to build multiple copy mbufs.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst |   1 +=0D
 drivers/net/hinic3/hinic3_ethdev.c     |   2 +=0D
 drivers/net/hinic3/hinic3_tx.c         | 287 ++++++++++++++-----------=0D
 drivers/net/hinic3/hinic3_tx.h         |  14 +-=0D
 4 files changed, 175 insertions(+), 129 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index a8a1641d2a..19ecce010f 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -101,6 +101,7 @@ New Features=0D
   * Added support for the SP560 NIC.=0D
   * Added device parameters for runtime configuration.=0D
   * Added a compact CQE receive data path.=0D
+  * Extended TCP segmentation offload (TSO) to 255 segments.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index b272d42007..c472b8fae1 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -1454,6 +1454,8 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16=
_t qid, uint16_t nb_desc,=0D
 	txq->wqebb_size =3D (uint16_t)RTE_BIT32(txq->wqebb_shift);=0D
 	txq->tx_free_thresh =3D tx_free_thresh;=0D
 	txq->owner =3D 1;=0D
+	txq->non_tso_max_pkt_len =3D=0D
+		HINIC3_IS_SP230_NIC(nic_dev) ? MAX_SINGLE_SGE_SIZE : HINIC3_MAX_JUMBO_FR=
AME_SIZE;=0D
 =0D
 	if (!ODD_NUMBER_QUEUE_ID(qid) &&=0D
 		hinic3_cmd_vf_lag(nic_dev->hwdev, hinic3_global_func_id(nic_dev->hwdev),=
=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
index bbe8c1c085..566e22315d 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.c=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -474,122 +474,121 @@ hinic3_set_tx_offload(struct hinic3_nic_dev *nic_de=
v,=0D
  * true as valid, false as invalid.=0D
  */=0D
 static bool=0D
-hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe=
_info)=0D
+hinic3_is_tso_sge_valid(struct rte_mbuf *mbuf,=0D
+			struct hinic3_wqe_info *wqe_info)=0D
 {=0D
-	uint32_t total_len, limit_len, checked_len, left_len, adjust_mss;=0D
-	uint32_t max_sges, left_sges, first_len;=0D
-	uint32_t payload_len, frag_num;=0D
-	uint32_t i;=0D
-	struct rte_mbuf *mbuf_head, *mbuf_first;=0D
-	struct rte_mbuf *mbuf_pre =3D mbuf;=0D
-=0D
-	left_sges =3D mbuf->nb_segs;=0D
-	mbuf_head =3D mbuf;=0D
-	mbuf_first =3D mbuf;=0D
+	uint32_t payload_len, frag_num, adjust_mss, limit_len, total_used_len;=0D
+	uint32_t i =3D 0, window_len =3D 0, no_copy_total_len =3D 0;=0D
+	uint8_t copy_mbuf_num;=0D
+	struct rte_mbuf *mbuf_pkt;=0D
+=0D
+	if (unlikely(mbuf->data_len < wqe_info->payload_offset &&=0D
+		     mbuf->nb_segs > HINIC3_NONTSO_PKT_MAX_SGE)) {=0D
+		PMD_DRV_LOG(WARNING, "illegal pkt, payload offset (%u) > data len (%u)."=
,=0D
+			    wqe_info->payload_offset, mbuf->data_len);=0D
+		return false;=0D
+	}=0D
 =0D
 	/* Calculate the number of message payload frag,=0D
 	 * if it exceeds the hardware limit of 10 bits,=0D
 	 * packet will be discarded.=0D
 	 */=0D
-	payload_len =3D mbuf_head->pkt_len - wqe_info->payload_offset;=0D
-	frag_num =3D (payload_len + mbuf_head->tso_segsz - 1) / mbuf_head->tso_se=
gsz;=0D
+	payload_len =3D mbuf->pkt_len - wqe_info->payload_offset;=0D
+=0D
+	frag_num =3D (payload_len + mbuf->tso_segsz - 1) / mbuf->tso_segsz;=0D
 	if (frag_num > MAX_TSO_NUM_FRAG) {=0D
-		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num:0x%x.", frag_=
num);=0D
+		PMD_DRV_LOG(WARNING, "tso frag num over hw limit, frag_num: 0x%x", frag_=
num);=0D
 		return false;=0D
 	}=0D
 =0D
-	/* Tso sge number validation. */=0D
-	if (unlikely(left_sges >=3D HINIC3_NONTSO_PKT_MAX_SGE)) {=0D
-		checked_len =3D 0;=0D
-		total_len =3D 0;=0D
-		first_len =3D 0;=0D
-		adjust_mss =3D mbuf->tso_segsz >=3D TX_MSS_MIN ? mbuf->tso_segsz=0D
-							   : TX_MSS_MIN;=0D
-		max_sges =3D HINIC3_NONTSO_PKT_MAX_SGE - 1;=0D
-		limit_len =3D adjust_mss + wqe_info->payload_offset;=0D
-=0D
-		for (i =3D 0; (i < max_sges) && (total_len < limit_len); i++) {=0D
-			total_len +=3D mbuf->data_len;=0D
-			mbuf_pre =3D mbuf;=0D
-			mbuf =3D mbuf->next;=0D
-		}=0D
+	/* TSO SGE <=3D HINIC3_NONTSO_PKT_MAX_SGE: no processing */=0D
+	if (likely(mbuf->nb_segs <=3D HINIC3_NONTSO_PKT_MAX_SGE))=0D
+		return true;=0D
 =0D
-		/* Each continues 38 mbufs segmust do one check. */=0D
-		while (left_sges >=3D HINIC3_NONTSO_PKT_MAX_SGE) {=0D
-			if (total_len >=3D limit_len) {=0D
-				/* Update the limit len. */=0D
-				limit_len =3D adjust_mss;=0D
-				/* Update checked len. */=0D
-				checked_len +=3D first_len;=0D
-				/* Record the first len. */=0D
-				first_len =3D mbuf_first->data_len;=0D
-				/* First mbuf move to the next. */=0D
-				mbuf_first =3D mbuf_first->next;=0D
-				/* Update total len. */=0D
-				total_len -=3D first_len;=0D
-				left_sges--;=0D
-				i--;=0D
-				for (;=0D
-				     (i < max_sges) && (total_len < limit_len);=0D
-				     i++) {=0D
-					total_len +=3D mbuf->data_len;=0D
-					mbuf_pre =3D mbuf;=0D
-					mbuf =3D mbuf->next;=0D
-				}=0D
-			} else {=0D
-				/* Try to copy if not valid. */=0D
-				checked_len +=3D (total_len - mbuf_pre->data_len);=0D
+	adjust_mss =3D mbuf->tso_segsz >=3D TX_MSS_MIN ? mbuf->tso_segsz : TX_MSS=
_MIN;=0D
 =0D
-				left_len =3D mbuf_head->pkt_len - checked_len;=0D
-				if (left_len > HINIC3_COPY_MBUF_SIZE)=0D
-					return false;=0D
-				wqe_info->sge_cnt =3D (uint16_t)(mbuf_head->nb_segs +=0D
-							  i - left_sges);=0D
-				wqe_info->cpy_mbuf_cnt =3D 1;=0D
+	/* TSO SGE > HINIC3_TSO_PKT_MAX_SGE: skip MSS check, directly trigger cop=
y */=0D
+	if (unlikely(mbuf->nb_segs > HINIC3_TSO_PKT_MAX_SGE))=0D
+		goto copy;=0D
 =0D
-				return true;=0D
+	/* Check sum of 38 SGEs < MSS (First segment < header + MSS) */=0D
+	limit_len =3D adjust_mss + wqe_info->payload_offset;=0D
+	mbuf_pkt =3D mbuf;=0D
+	while (mbuf_pkt) {=0D
+		window_len +=3D mbuf_pkt->data_len;=0D
+		i++;=0D
+		mbuf_pkt =3D mbuf_pkt->next;=0D
+=0D
+		if (i > HINIC3_NONTSO_PKT_MAX_SGE)=0D
+			goto copy;=0D
+=0D
+		if (window_len >=3D limit_len) {=0D
+			if (limit_len =3D=3D adjust_mss + wqe_info->payload_offset) {=0D
+				window_len -=3D limit_len;=0D
+				limit_len =3D adjust_mss;=0D
 			}=0D
-		} /**< End of while. */=0D
+			window_len %=3D adjust_mss;=0D
+			i =3D (window_len =3D=3D 0) ? 0 : 1;=0D
+		}=0D
+	}=0D
+	return true;=0D
+=0D
+copy:=0D
+	mbuf_pkt =3D mbuf;=0D
+	for (i =3D 0; i < HINIC3_NON_COPY_SGE_NUM; i++) {=0D
+		no_copy_total_len +=3D mbuf_pkt->data_len;=0D
+		mbuf_pkt =3D mbuf_pkt->next;=0D
+	}=0D
+=0D
+	if (unlikely(mbuf->pkt_len - no_copy_total_len >=0D
+		     HINIC3_TSO_MBUF_NUM_MAX * HINIC3_COPY_MBUF_SIZE)) {=0D
+		copy_mbuf_num =3D HINIC3_TSO_MBUF_NUM_MAX;=0D
+		/* The len of first (HINIC3_TSO_PKT_MAX_SGE - 1) mbufs + last=0D
+		 * one (last_cpy_mbuf_usable) =3D header + N * MSS=0D
+		 */=0D
+		total_used_len =3D no_copy_total_len - wqe_info->payload_offset +=0D
+			(HINIC3_TSO_MBUF_NUM_MAX - 1) * HINIC3_COPY_MBUF_SIZE;=0D
+		wqe_info->last_cpy_mbuf_usable =3D adjust_mss - total_used_len % adjust_=
mss;=0D
+	} else {=0D
+		copy_mbuf_num =3D (mbuf->pkt_len - no_copy_total_len +=0D
+			 HINIC3_COPY_MBUF_SIZE - 1) / HINIC3_COPY_MBUF_SIZE;=0D
 	}=0D
 =0D
-	wqe_info->sge_cnt =3D mbuf_head->nb_segs;=0D
+	/* Total SGE =3D 28 normal SGEs + copy mbufs */=0D
+	wqe_info->sge_cnt =3D HINIC3_NON_COPY_SGE_NUM + copy_mbuf_num;=0D
+	wqe_info->cpy_mbuf_cnt =3D copy_mbuf_num;=0D
 =0D
 	return true;=0D
 }=0D
 =0D
 static int=0D
-hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_in=
fo *wqe_info)=0D
+hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, struct hinic3_wqe_in=
fo *wqe_info,=0D
+			       uint32_t non_tso_max_pkt_len)=0D
 {=0D
 	struct rte_mbuf *mbuf_pkt =3D mbuf;=0D
 	uint32_t total_len =3D 0;=0D
-	uint16_t i;=0D
+	uint16_t i, copy_mbuf_num =3D 0;=0D
 =0D
 	if (likely(HINIC3_NONTSO_SEG_NUM_VALID(mbuf->nb_segs)))=0D
 		return 0;=0D
 =0D
-	/* Non-tso packet length must less than 64KB. */=0D
-	if (unlikely(mbuf->pkt_len > MAX_SINGLE_SGE_SIZE))=0D
+	/* Non-tso packet length must less than HINIC3_MAX_JUMBO_FRAME_SIZE */=0D
+	if (unlikely(mbuf->pkt_len > non_tso_max_pkt_len))=0D
 		return -EINVAL;=0D
-=0D
-	/*=0D
-	 * Mbuf number of non-tso packet must less than the sge number=0D
-	 * that nic can support. The excess part will be copied to another=0D
-	 * mbuf.=0D
-	 */=0D
-	for (i =3D 0; i < (HINIC3_NONTSO_PKT_MAX_SGE - 1); i++) {=0D
+	for (i =3D 0; i < HINIC3_NON_COPY_SGE_NUM; i++) {=0D
 		total_len +=3D mbuf_pkt->data_len;=0D
 		mbuf_pkt =3D mbuf_pkt->next;=0D
 	}=0D
 =0D
-	/*=0D
-	 * Max copy mbuf size is 4KB, packet will be dropped directly,=0D
-	 * if total copy length is more than it.=0D
-	 */=0D
-	if ((total_len + HINIC3_COPY_MBUF_SIZE) < mbuf->pkt_len)=0D
+	/* Calculate required mbuf number */=0D
+	copy_mbuf_num =3D (mbuf->pkt_len - total_len +=0D
+			 HINIC3_COPY_MBUF_SIZE - 1) / HINIC3_COPY_MBUF_SIZE;=0D
+	if (copy_mbuf_num > HINIC3_NONTSO_MBUF_NUM_MAX)=0D
 		return -EINVAL;=0D
 =0D
-	wqe_info->sge_cnt =3D HINIC3_NONTSO_PKT_MAX_SGE;=0D
-	wqe_info->cpy_mbuf_cnt =3D 1;=0D
+	/* Total SGE =3D 28 normal SGEs + copy mbufs */=0D
+	wqe_info->sge_cnt =3D HINIC3_NON_COPY_SGE_NUM + copy_mbuf_num;=0D
+	wqe_info->cpy_mbuf_cnt =3D copy_mbuf_num;=0D
 =0D
 	return 0;=0D
 }=0D
@@ -608,7 +607,7 @@ hinic3_non_tso_pkt_pre_process(struct rte_mbuf *mbuf, s=
truct hinic3_wqe_info *wq=0D
  */=0D
 static int=0D
 hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbu=
f,=0D
-		      struct hinic3_wqe_info *wqe_info)=0D
+		      struct hinic3_wqe_info *wqe_info, uint32_t non_tso_max_pkt_len)=0D
 {=0D
 	uint64_t ol_flags =3D mbuf->ol_flags;=0D
 	uint16_t inner_l3_offset =3D 0;=0D
@@ -619,7 +618,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, s=
truct rte_mbuf *mbuf,=0D
 	/* Check if the packet set available offload flags. */=0D
 	if (!(ol_flags & HINIC3_TX_OFFLOAD_MASK)) {=0D
 		wqe_info->offload =3D 0;=0D
-		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);=0D
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info, non_tso_max_pkt_le=
n);=0D
 	}=0D
 =0D
 	wqe_info->offload =3D 1;=0D
@@ -629,7 +628,7 @@ hinic3_get_tx_offload(struct hinic3_nic_dev *nic_dev, s=
truct rte_mbuf *mbuf,=0D
 =0D
 	/* Non-tso mbuf only check sge num. */=0D
 	if (likely(!(mbuf->ol_flags & HINIC3_PKT_TX_TCP_SEG)))=0D
-		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info);=0D
+		return hinic3_non_tso_pkt_pre_process(mbuf, wqe_info, non_tso_max_pkt_le=
n);=0D
 =0D
 	/* Tso mbuf. */=0D
 	wqe_info->payload_offset =3D=0D
@@ -674,33 +673,76 @@ hinic3_alloc_cpy_mbuf(struct hinic3_nic_dev *nic_dev)=
=0D
  * The address of the copied mbuf.=0D
  */=0D
 static void *=0D
-hinic3_copy_tx_mbuf(struct hinic3_nic_dev *nic_dev, struct rte_mbuf *mbuf,=
=0D
-		    uint16_t sge_cnt)=0D
+hinic3_copy_tx_mbuf_multi(struct hinic3_nic_dev *nic_dev,=0D
+			  struct rte_mbuf *mbuf, struct hinic3_wqe_info *wqe_info)=0D
 {=0D
-	struct rte_mbuf *dst_mbuf;=0D
-	uint32_t offset =3D 0;=0D
-	uint16_t i;=0D
+	uint8_t i;=0D
+	uint32_t remaining_len, dst_mbuf_space, copy_size, copy_offset =3D 0;=0D
+	struct rte_mbuf *prev_mbuf =3D NULL;=0D
+	struct rte_mbuf *head_mbuf =3D NULL;=0D
+	struct rte_mbuf *cur_mbuf;=0D
 =0D
 	if (unlikely(!nic_dev->cpy_mpool))=0D
 		return NULL;=0D
 =0D
-	dst_mbuf =3D hinic3_alloc_cpy_mbuf(nic_dev);=0D
-	if (unlikely(!dst_mbuf))=0D
-		return NULL;=0D
+	/* Allocate all copy mbufs and build linked list */=0D
+	for (i =3D 0; i < wqe_info->cpy_mbuf_cnt; i++) {=0D
+		cur_mbuf =3D hinic3_alloc_cpy_mbuf(nic_dev);=0D
+		if (unlikely(!cur_mbuf))=0D
+			goto err_free;=0D
+=0D
+		cur_mbuf->data_off =3D 0;=0D
+		cur_mbuf->data_len =3D 0;=0D
+		cur_mbuf->pkt_len =3D mbuf->pkt_len;=0D
+		cur_mbuf->next =3D NULL;=0D
+=0D
+		if (prev_mbuf =3D=3D NULL)=0D
+			head_mbuf =3D cur_mbuf;=0D
+		else=0D
+			prev_mbuf->next =3D cur_mbuf;=0D
+		prev_mbuf =3D cur_mbuf;=0D
+	}=0D
 =0D
-	dst_mbuf->data_off =3D 0;=0D
-	dst_mbuf->data_len =3D 0;=0D
-	for (i =3D 0; i < sge_cnt; i++) {=0D
-		memcpy((uint8_t *)dst_mbuf->buf_addr + offset,=0D
-			   (uint8_t *)mbuf->buf_addr + mbuf->data_off,=0D
-			   mbuf->data_len);=0D
-		dst_mbuf->data_len +=3D mbuf->data_len;=0D
-		offset +=3D mbuf->data_len;=0D
+	/* Copy data to mbufs - mbuf already points to first SGE to copy */=0D
+	cur_mbuf =3D head_mbuf;=0D
+	while (mbuf !=3D NULL) {=0D
+		remaining_len =3D mbuf->data_len;=0D
+		while (remaining_len > 0 && cur_mbuf !=3D NULL) {=0D
+			dst_mbuf_space =3D HINIC3_COPY_MBUF_SIZE - copy_offset;=0D
+			copy_size =3D RTE_MIN(remaining_len, dst_mbuf_space);=0D
+=0D
+			rte_memcpy((uint8_t *)cur_mbuf->buf_addr + copy_offset,=0D
+				   (uint8_t *)mbuf->buf_addr + mbuf->data_off,=0D
+				   copy_size);=0D
+=0D
+			cur_mbuf->data_len +=3D copy_size;=0D
+			copy_offset +=3D copy_size;=0D
+			remaining_len -=3D copy_size;=0D
+=0D
+			if (copy_offset >=3D HINIC3_COPY_MBUF_SIZE) {=0D
+				copy_offset =3D 0;=0D
+				cur_mbuf =3D cur_mbuf->next;=0D
+			}=0D
+		}=0D
 		mbuf =3D mbuf->next;=0D
 	}=0D
-	dst_mbuf->pkt_len =3D dst_mbuf->data_len;=0D
 =0D
-	return dst_mbuf;=0D
+	/* all copy_mbuf cann't store packet data, cut off last mbuf, ensure=0D
+	 * the len of all mbuf =3D header + N * MSS=0D
+	 */=0D
+	if (unlikely(wqe_info->last_cpy_mbuf_usable !=3D 0)) {=0D
+		cur_mbuf =3D head_mbuf;=0D
+		for (i =3D 0; i < wqe_info->cpy_mbuf_cnt - 1; i++)=0D
+			cur_mbuf =3D cur_mbuf->next;=0D
+		cur_mbuf->data_len =3D wqe_info->last_cpy_mbuf_usable;=0D
+	}=0D
+=0D
+	return head_mbuf;=0D
+=0D
+err_free:=0D
+	/* Free all allocated mbufs on error */=0D
+	hinic3_free_cpy_mbuf(nic_dev, head_mbuf);=0D
+	return NULL;=0D
 }=0D
 =0D
 /**=0D
@@ -726,9 +768,9 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struct =
rte_mbuf *mbuf,=0D
 	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->hdr;=0D
 	struct hinic3_sq_bufdesc *buf_desc =3D wqe_combo->bds_head;=0D
 	uint16_t nb_segs =3D wqe_info->sge_cnt - wqe_info->cpy_mbuf_cnt;=0D
-	uint16_t real_segs =3D mbuf->nb_segs;=0D
 	rte_iova_t dma_addr;=0D
 	uint32_t i;=0D
+	uint8_t mbuf_idx;=0D
 =0D
 	for (i =3D 0; i < nb_segs; i++) {=0D
 		if (unlikely(mbuf =3D=3D NULL)) {=0D
@@ -767,40 +809,34 @@ hinic3_mbuf_dma_map_sge(struct hinic3_txq *txq, struc=
t rte_mbuf *mbuf,=0D
 		mbuf =3D mbuf->next;=0D
 	}=0D
 =0D
-	/* For now: support over 38 sge, copy the last 2 mbuf. */=0D
 	if (unlikely(wqe_info->cpy_mbuf_cnt !=3D 0)) {=0D
 		/*=0D
 		 * Copy invalid mbuf segs to a valid buffer, lost performance.=0D
 		 */=0D
 		txq->txq_stats.cpy_pkts +=3D 1;=0D
-		mbuf =3D hinic3_copy_tx_mbuf(txq->nic_dev, mbuf,=0D
-					   real_segs - nb_segs);=0D
+		mbuf =3D hinic3_copy_tx_mbuf_multi(txq->nic_dev, mbuf, wqe_info);=0D
 		if (unlikely(!mbuf))=0D
 			return -EINVAL;=0D
 =0D
 		txq->tx_info[wqe_info->pi].cpy_mbuf =3D mbuf;=0D
 =0D
-		/* Deal with the last mbuf. */=0D
-		dma_addr =3D rte_mbuf_data_iova(mbuf);=0D
-		if (unlikely(mbuf->data_len =3D=3D 0)) {=0D
-			txq->txq_stats.sge_len0++;=0D
-			return -EINVAL;=0D
-		}=0D
-		/*=0D
-		 * Parts of wqe is in sq bottom while parts=0D
-		 * of wqe is in sq head.=0D
-		 */=0D
-		if (i =3D=3D 0) {=0D
-			wqe_desc->hi_addr =3D=0D
-				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
-			wqe_desc->lo_addr =3D=0D
-				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
-			wqe_desc->ctrl_len =3D mbuf->data_len;=0D
-		} else {=0D
-			if (unlikely(((uint64_t)buf_desc =3D=3D txq->sq_bot_sge_addr)))=0D
+		/* Set DMA descriptors for all copy mbufs */=0D
+		for (mbuf_idx =3D 0; mbuf_idx < wqe_info->cpy_mbuf_cnt; mbuf_idx++) {=0D
+			dma_addr =3D rte_mbuf_data_iova(mbuf);=0D
+			if (unlikely(mbuf->data_len =3D=3D 0)) {=0D
+				txq->txq_stats.sge_len0++;=0D
+				hinic3_free_cpy_mbuf(txq->nic_dev,=0D
+						    txq->tx_info[wqe_info->pi].cpy_mbuf);=0D
+				txq->tx_info[wqe_info->pi].cpy_mbuf =3D NULL;=0D
+				return -EINVAL;=0D
+			}=0D
+=0D
+			if (unlikely((uint64_t)buf_desc =3D=3D txq->sq_bot_sge_addr))=0D
 				buf_desc =3D (struct hinic3_sq_bufdesc *)txq->sq_head_addr;=0D
 =0D
 			hinic3_set_buf_desc(buf_desc, dma_addr, mbuf->data_len);=0D
+			buf_desc++;=0D
+			mbuf =3D mbuf->next;=0D
 		}=0D
 	}=0D
 =0D
@@ -901,7 +937,8 @@ hinic3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_p=
kts, uint16_t nb_pkts)=0D
 	/* Tx loop routine. */=0D
 	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {=0D
 		mbuf_pkt =3D *tx_pkts++;=0D
-		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info))) =
{=0D
+		if (unlikely(hinic3_get_tx_offload(txq->nic_dev, mbuf_pkt, &wqe_info,=0D
+						   txq->non_tso_max_pkt_len))) {=0D
 			txq->txq_stats.offload_errors++;=0D
 			break;=0D
 		}=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
index e0ed9908ad..5d4101630e 100644=0D
--- a/drivers/net/hinic3/hinic3_tx.h=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -6,12 +6,18 @@=0D
 #define _HINIC3_TX_H_=0D
 =0D
 #define MAX_SINGLE_SGE_SIZE		 65536=0D
-#define HINIC3_NONTSO_PKT_MAX_SGE	 32 /**< non-tso max sge 32. */=0D
+#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */=0D
 #define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <=3D HINIC3_NONTSO_PKT_MAX=
_SGE)=0D
 =0D
-#define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */=0D
+#define HINIC3_TSO_PKT_MAX_SGE		255 /**< tso max sge 255. */=0D
 #define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)=0D
 =0D
+/* Non-copy SGE configuration: 28 SGEs are not copied */=0D
+#define HINIC3_NON_COPY_SGE_NUM	28=0D
+#define HINIC3_NONTSO_MBUF_NUM_MAX \=0D
+	(HINIC3_NONTSO_PKT_MAX_SGE - HINIC3_NON_COPY_SGE_NUM)=0D
+#define HINIC3_TSO_MBUF_NUM_MAX			(HINIC3_TSO_PKT_MAX_SGE - HINIC3_NON_COP=
Y_SGE_NUM)=0D
+=0D
 /* Tx wqe queue info */=0D
 struct hinic3_queue_info {=0D
 	uint8_t pri;=0D
@@ -57,7 +63,7 @@ struct hinic3_wqe_info {=0D
 	uint16_t pi;=0D
 =0D
 	uint16_t wqebb_cnt;=0D
-	uint16_t rsvd2; /**< Reserved field 2. */=0D
+	uint16_t last_cpy_mbuf_usable;=0D
 =0D
 	struct hinic3_queue_info queue_info;=0D
 	struct hinic3_offload_info offload_info;=0D
@@ -375,7 +381,7 @@ struct __rte_cache_aligned hinic3_txq {=0D
 	uint64_t sq_bot_sge_addr;=0D
 	uint32_t cos;=0D
 	uint8_t tx_wqe_compact_task;=0D
-	uint8_t rsvd[3];=0D
+	uint32_t non_tso_max_pkt_len;=0D
 	struct hinic3_txq_stats txq_stats;=0D
 #ifdef HINIC3_XSTAT_PROF_TX=0D
 	uint64_t prof_tx_end_tsc;=0D
-- =0D
2.33.0=0D
=0D

