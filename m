Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB534C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 08:08:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92D4242709;
	Fri, 31 Jan 2025 09:06:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 147BF42830
 for <dev@dpdk.org>; Fri, 31 Jan 2025 09:06:57 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V538Tg017143
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
 LqXPNDE/18p5t4DGCmYfLfwKCNhcJaNfk2/xzG5aH4=; b=R72id5MZiitUXqb13
 SgNhW27iHT0Kx5yF2fv7W9FctedCPB2MgoA1yK4xcFL7UDPHIkq6We5Go5WH7+6g
 ZZM4czdu+vG0ucpx55FpAD3nzNK+0iK16HTUmRGehtsS/K86dPAfpI1iSBYUmnPf
 kE/nj0iNxGxk1P2PV4GUdl055nw0euHZFjSsJk0Mmfg4Mx1eUTWyBZx6Hcn53Yhi
 ktxjacOuTMOXKQcyKrCOb1EQfYJ9kFiYcDxdYGiIK4Z8QGsbRW+qNr8Gov3FZHmK
 xf41atPGnjxcB4AASaZKmkpS5bCaBNbgKwz6/VAJxuYFn/zQ+jnLIGrQ47LOSufK
 bINSw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44gr198776-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 31 Jan 2025 00:06:57 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 31 Jan 2025 00:06:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 31 Jan 2025 00:06:56 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 1D05C3F7045;
 Fri, 31 Jan 2025 00:06:52 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 26/34] net/cnxk: inline IPsec Rx support for cn20k
Date: Fri, 31 Jan 2025 13:35:21 +0530
Message-ID: <20250131080530.3224977-26-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250131080530.3224977-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: L_Mnf8G8f68o0pwFOb2XCi_NmUC9dnEE
X-Proofpoint-GUID: L_Mnf8G8f68o0pwFOb2XCi_NmUC9dnEE
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

Inline IPsec Rx support for cn20k

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/event/cnxk/cn20k_worker.h |   4 +-
 drivers/net/cnxk/cn20k_rx.h       | 737 ++++++++++++++++++++++++++++--
 2 files changed, 689 insertions(+), 52 deletions(-)

diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index b014e549b9..2366196d9d 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -24,7 +24,7 @@ cn20k_wqe_to_mbuf(uint64_t wqe, const uint64_t __mbuf, uint8_t port_id, const ui
 	struct rte_mbuf *mbuf = (struct rte_mbuf *)__mbuf;
 
 	cn20k_nix_cqe_to_mbuf((struct nix_cqe_hdr_s *)wqe, tag, (struct rte_mbuf *)mbuf, lookup_mem,
-			      mbuf_init | ((uint64_t)port_id) << 48, cpth, sa_base, flags);
+			      mbuf_init | ((uint64_t)port_id) << 48, cpth, sa_base, 0, flags);
 }
 
 static void
@@ -83,7 +83,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 
-		cn20k_nix_cqe_to_mbuf(cqe, cqe->tag, mbuf, lookup_mem, mbuf_init, cpth, sa_base,
+		cn20k_nix_cqe_to_mbuf(cqe, cqe->tag, mbuf, lookup_mem, mbuf_init, cpth, sa_base, 0,
 				      flags);
 
 		if (flags & NIX_RX_OFFLOAD_TSTAMP_F)
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index 01bf483787..6af63aaeb6 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -82,6 +82,42 @@ union mbuf_initializer {
 	uint64_t value;
 };
 
+static __rte_always_inline void
+nix_sec_flush_meta_burst(uint16_t lmt_id, uint64_t data, uint16_t lnum, uintptr_t aura_handle)
+{
+	uint64_t pa;
+
+	/* Prepare PA and Data */
+	pa = roc_npa_aura_handle_to_base(aura_handle) + NPA_LF_AURA_BATCH_FREE0;
+	pa |= ((data & 0x7) << 4);
+
+	data >>= 3;
+	data <<= 19;
+	data |= (uint64_t)lmt_id;
+	data |= (uint64_t)(lnum - 1) << 12;
+
+	roc_lmt_submit_steorl(data, pa);
+}
+
+static __rte_always_inline void
+nix_sec_flush_meta(uintptr_t laddr, uint16_t lmt_id, uint8_t loff, uintptr_t aura_handle)
+{
+	uint64_t pa;
+
+	/* laddr is pointing to first pointer */
+	laddr -= 8;
+
+	/* Trigger free either on lmtline full or different aura handle */
+	pa = roc_npa_aura_handle_to_base(aura_handle) + NPA_LF_AURA_BATCH_FREE0;
+
+	/* Update aura handle */
+	*(uint64_t *)laddr =
+		(((uint64_t)(loff & 0x1) << 32) | roc_npa_aura_handle_to_aura(aura_handle));
+
+	pa |= ((uint64_t)(loff >> 1) << 4);
+	roc_lmt_submit_steorl(lmt_id, pa);
+}
+
 static __rte_always_inline uint64_t
 nix_clear_data_off(uint64_t oldval)
 {
@@ -101,6 +137,56 @@ nix_get_mbuf_from_cqe(void *cq, const uint64_t data_off)
 	return (struct rte_mbuf *)(buff - data_off);
 }
 
+static __rte_always_inline uint64_t
+nix_sec_meta_to_mbuf_sc(uint64_t cq_w5, uint64_t cpth, const uint64_t sa_base,
+			struct rte_mbuf *mbuf, uint16_t *len, uint64_t *mbuf_init,
+			const uint16_t flags)
+{
+	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
+	struct cn20k_inb_priv_data *inb_priv;
+	uint64_t ol_flags, w3 = hdr->w3.u64;
+	uint32_t sa_idx;
+	uint16_t ucc;
+	void *inb_sa;
+
+	/* Get SPI from CPT_PARSE_S's cookie(already swapped) */
+	sa_idx = hdr->w0.cookie;
+	inb_sa = roc_nix_inl_ow_ipsec_inb_sa(sa_base, sa_idx);
+	inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd(inb_sa);
+
+	/* Cryptodev injected packet can be identified from SA IDX 0xFFFFFFFF, and
+	 * Ethdev injected packet can be identified with match ID 0xFFFF.
+	 */
+	if (flags & NIX_RX_REAS_F && !hdr->w2.pkt_inline) {
+		*mbuf_init = (*mbuf_init & ~(BIT_ULL(16) - 1)) | mbuf->data_off;
+		if (hdr->w0.match_id == 0xFFFFU)
+			*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
+	} else {
+		/* Update dynamic field with userdata */
+		*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
+	}
+
+	*len = ((w3 >> 48) & 0xFFFF) + ((cq_w5 >> 16) & 0xFF) - (cq_w5 & 0xFF);
+
+	/* Get ucc from cpt parse header */
+	ucc = w3 & 0xFF;
+	ol_flags = ((CPT_COMP_HWGOOD_MASK & (1U << ucc)) ?
+			    RTE_MBUF_F_RX_SEC_OFFLOAD :
+			    RTE_MBUF_F_RX_SEC_OFFLOAD | RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED);
+
+	ucc = (w3 >> 8) & 0xFF;
+	if (ucc && ucc < ROC_IE_OW_UCC_SUCCESS_PKT_IP_BADCSUM) {
+		ol_flags |= RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+	} else {
+		ucc += 3; /* To make codes in 0xFx series except 0 */
+		ol_flags |= ((ucc & 0xF0) == 0xF0) ?
+				    ((NIX_RX_SEC_UCC_CONST >> ((ucc & 0xF) << 3)) & 0xFF) << 1 :
+				    RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+	}
+
+	return ol_flags;
+}
+
 static __rte_always_inline uint32_t
 nix_ptype_get(const void *const lookup_mem, const uint64_t in)
 {
@@ -151,72 +237,150 @@ nix_update_match_id(const uint16_t match_id, uint64_t ol_flags, struct rte_mbuf
 
 static __rte_always_inline void
 nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint64_t rearm,
-		    uintptr_t cpth, uintptr_t sa_base, const uint16_t flags)
+		    uintptr_t cpth, uintptr_t sa_base, const uint64_t buf_sz, const uint16_t flags)
 {
+	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
+	struct cn20k_inb_priv_data *inb_priv = NULL;
+	uint32_t offset = hdr->w2.ptr_offset;
+	const struct cpt_frag_info_s *finfo;
+	uint8_t num_frags = 0, nxt_frag = 0;
+	struct rte_mbuf *head, *last_mbuf;
+	uint64_t fsz_w1 = 0, cq_w1, sg;
 	const rte_iova_t *iova_list;
+	uint8_t sg_cnt = 1, nb_segs;
 	uint16_t later_skip = 0;
-	struct rte_mbuf *head;
+	bool reas_fail = false;
 	const rte_iova_t *eol;
-	uint8_t nb_segs;
-	uint16_t sg_len;
-	int64_t len;
-	uint64_t sg;
+	uint8_t ts_rx_off;
+	int dyn_off = 0;
+	uint32_t len;
 	uintptr_t p;
 
-	(void)cpth;
-	(void)sa_base;
+	cq_w1 = *(const uint64_t *)rx;
+	ts_rx_off = (flags & NIX_RX_OFFLOAD_TSTAMP_F) ? CNXK_NIX_TIMESYNC_RX_OFFSET : 0;
 
-	sg = *(const uint64_t *)(rx + 1);
-	nb_segs = (sg >> 48) & 0x3;
+	if ((flags & NIX_RX_SEC_REASSEMBLY_F) && (cq_w1 & BIT(11))) {
+		uint64_t sg_base;
 
-	if (nb_segs == 1)
-		return;
+		/* Check if there are no SG's */
+		if (!hdr->w4.gthr_size && ((flags & NIX_RX_REAS_F) || !hdr->w4.sctr_size))
+			return;
 
-	len = rx->pkt_lenm1 + 1;
+		num_frags = hdr->w0.num_frags;
+		sg_base = cpth + (offset ? (offset << 3) : 256);
+		finfo = (const struct cpt_frag_info_s *)sg_base;
+		sg_base += num_frags ? (num_frags >> 2 ? 32 : 16) : 0;
+		sg = *(uint64_t *)sg_base;
+		nb_segs = (sg >> 48) & 0x3;
+		iova_list = (rte_iova_t *)(sg_base);
+		eol = iova_list + (hdr->w4.gthr_size << 2);
+		iova_list += 2;
 
-	mbuf->pkt_len = len - (flags & NIX_RX_OFFLOAD_TSTAMP_F ? CNXK_NIX_TIMESYNC_RX_OFFSET : 0);
+		if ((flags & NIX_RX_REAS_F) && num_frags) {
+			void *inb_sa;
+
+			num_frags = hdr->w0.num_frags;
+			inb_sa = roc_nix_inl_ot_ipsec_inb_sa(sa_base, hdr->w0.cookie);
+			inb_priv = roc_nix_inl_ot_ipsec_inb_sa_sw_rsvd(inb_sa);
+			dyn_off = inb_priv->reass_dynfield_off;
+			num_frags -= 1;
+
+			if (hdr->w0.reas_sts ||
+			    (hdr->w0.err_sum && !roc_ie_ow_ucc_is_success(hdr->w3.uc_ccode))) {
+				reas_fail = true;
+				nxt_frag = (sg >> 51) & 0x3;
+				fsz_w1 = finfo->w1.u64 >> 16;
+				finfo++;
+			}
+		}
+	} else {
+		sg = *(const uint64_t *)(rx + 1);
+		nb_segs = (sg >> 48) & 0x3;
+
+		if (nb_segs == 1)
+			return;
+
+		/* Skip SG_S and first IOVA */
+		eol = ((const rte_iova_t *)(rx + 1) + ((rx->desc_sizem1 + 1) << 1));
+		iova_list = ((const rte_iova_t *)(rx + 1)) + 2;
+	}
+
+	/* Update data len as per the segment size */
+	mbuf->data_len = sg & 0xFFFF;
 	mbuf->nb_segs = nb_segs;
 	head = mbuf;
-	mbuf->data_len =
-		(sg & 0xFFFF) - (flags & NIX_RX_OFFLOAD_TSTAMP_F ? CNXK_NIX_TIMESYNC_RX_OFFSET : 0);
-	eol = ((const rte_iova_t *)(rx + 1) + ((rx->desc_sizem1 + 1) << 1));
 
-	len -= mbuf->data_len;
 	sg = sg >> 16;
-	/* Skip SG_S and first IOVA*/
-	iova_list = ((const rte_iova_t *)(rx + 1)) + 2;
 	nb_segs--;
 
 	later_skip = (uintptr_t)mbuf->buf_addr - (uintptr_t)mbuf;
 
 	while (nb_segs) {
-		mbuf->next = (struct rte_mbuf *)(*iova_list - later_skip);
+		last_mbuf = mbuf;
+		if (flags & NIX_RX_REAS_F) {
+			offset = (*iova_list) % (buf_sz & 0xFFFFFFFF);
+			mbuf->next = (struct rte_mbuf *)((*iova_list) - offset + (buf_sz >> 32));
+		} else {
+			mbuf->next = (struct rte_mbuf *)((*iova_list) - later_skip);
+		}
 		mbuf = mbuf->next;
 
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 
-		sg_len = sg & 0XFFFF;
+		/* Process reassembly failure case */
+		if ((flags & NIX_RX_REAS_F) && unlikely(reas_fail && (nxt_frag & 1))) {
+			head->ol_flags |=
+				BIT_ULL(inb_priv->reass_dynflag_bit) | RTE_MBUF_F_RX_SEC_OFFLOAD;
 
-		mbuf->data_len = sg_len;
+			cnxk_ip_reassembly_dynfield(head, dyn_off)->next_frag = mbuf;
+			cnxk_ip_reassembly_dynfield(head, dyn_off)->nb_frags = num_frags;
+
+			/* Update dynamic field with userdata from prev head */
+			*rte_security_dynfield(mbuf) = *rte_security_dynfield(head);
+
+			/* Reset last mbuf next and start new mbuf chain */
+			last_mbuf->next = NULL;
+			head = mbuf;
+			len = fsz_w1 & 0xFFFF;
+			head->pkt_len = len - ts_rx_off;
+			head->nb_segs = sg_cnt;
+			sg_cnt = 0;
+			nxt_frag = nxt_frag >> 1;
+			fsz_w1 = fsz_w1 >> 16;
+			if (--num_frags == 4)
+				fsz_w1 = finfo->w1.u64;
+		}
+
+		mbuf->data_len = (sg & 0xFFFF) - ts_rx_off;
 		sg = sg >> 16;
 		p = (uintptr_t)&mbuf->rearm_data;
 		*(uint64_t *)p = rearm & ~0xFFFF;
+
+		sg_cnt++;
 		nb_segs--;
 		iova_list++;
 
 		if (!nb_segs && (iova_list + 1 < eol)) {
 			sg = *(const uint64_t *)(iova_list);
 			nb_segs = (sg >> 48) & 0x3;
+			iova_list++;
 			head->nb_segs += nb_segs;
-			iova_list = (const rte_iova_t *)(iova_list + 1);
+			if ((flags & NIX_RX_REAS_F) && reas_fail)
+				nxt_frag = (sg >> 50) & 0x7;
 		}
 	}
+
+	/* Update for last failure fragment */
+	if ((flags & NIX_RX_REAS_F) && reas_fail) {
+		cnxk_ip_reassembly_dynfield(head, dyn_off)->next_frag = NULL;
+		cnxk_ip_reassembly_dynfield(head, dyn_off)->nb_frags = 0;
+	}
 }
 
 static __rte_always_inline void
 cn20k_nix_cqe_to_mbuf(const struct nix_cqe_hdr_s *cq, const uint32_t tag, struct rte_mbuf *mbuf,
-		      const void *lookup_mem, const uint64_t val, const uintptr_t cpth,
-		      const uintptr_t sa_base, const uint16_t flag)
+		      const void *lookup_mem, uint64_t val, const uintptr_t cpth,
+		      const uintptr_t sa_base, const uint64_t buf_sz, const uint16_t flag)
 {
 	const union nix_rx_parse_u *rx = (const union nix_rx_parse_u *)((const uint64_t *)cq + 1);
 	const uint64_t w1 = *(const uint64_t *)rx;
@@ -234,7 +398,6 @@ cn20k_nix_cqe_to_mbuf(const struct nix_cqe_hdr_s *cq, const uint32_t tag, struct
 		ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
 	}
 
-	/* Skip rx ol flags extraction for Security packets */
 	ol_flags |= (uint64_t)nix_rx_olflags_get(lookup_mem, w1);
 
 	if (flag & NIX_RX_OFFLOAD_VLAN_STRIP_F) {
@@ -251,20 +414,21 @@ cn20k_nix_cqe_to_mbuf(const struct nix_cqe_hdr_s *cq, const uint32_t tag, struct
 	if (flag & NIX_RX_OFFLOAD_MARK_UPDATE_F)
 		ol_flags = nix_update_match_id(rx->match_id, ol_flags, mbuf);
 
+	if (flag & NIX_RX_OFFLOAD_SECURITY_F && w1 & BIT_ULL(11)) {
+		const uint64_t cq_w5 = *((const uint64_t *)cq + 5);
+
+		ol_flags |= nix_sec_meta_to_mbuf_sc(cq_w5, cpth, sa_base, mbuf, &len, &val, flag);
+	}
+
+	p = (uintptr_t)&mbuf->rearm_data;
+	*(uint64_t *)p = val;
+
 	mbuf->ol_flags = ol_flags;
 	mbuf->pkt_len = len;
 	mbuf->data_len = len;
-	p = (uintptr_t)&mbuf->rearm_data;
-	*(uint64_t *)p = val;
 
-	if (flag & NIX_RX_MULTI_SEG_F)
-		/*
-		 * For multi segment packets, mbuf length correction according
-		 * to Rx timestamp length will be handled later during
-		 * timestamp data process.
-		 * Hence, timestamp flag argument is not required.
-		 */
-		nix_cqe_xtract_mseg(rx, mbuf, val, cpth, sa_base, flag & ~NIX_RX_OFFLOAD_TSTAMP_F);
+	if ((flag & NIX_RX_MULTI_SEG_F) || (flag & NIX_RX_REAS_F))
+		nix_cqe_xtract_mseg(rx, mbuf, val, cpth, sa_base, buf_sz, flag);
 }
 
 static inline uint16_t
@@ -325,21 +489,37 @@ static __rte_always_inline uint16_t
 cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, const uint16_t flags)
 {
 	struct cn20k_eth_rxq *rxq = rx_queue;
-	const uint64_t mbuf_init = rxq->mbuf_initializer;
+	uint64_t mbuf_init = rxq->mbuf_initializer;
 	const void *lookup_mem = rxq->lookup_mem;
 	const uint64_t data_off = rxq->data_off;
-	const uintptr_t desc = rxq->desc;
+	uint8_t m_sz = sizeof(struct rte_mbuf);
 	const uint64_t wdata = rxq->wdata;
 	const uint32_t qmask = rxq->qmask;
+	const uintptr_t desc = rxq->desc;
+	uint64_t buf_sz = rxq->mp_buf_sz;
+	uint64_t lbase = rxq->lmt_base;
 	uint16_t packets = 0, nb_pkts;
+	uint8_t loff = 0, lnum = 0;
 	uint32_t head = rxq->head;
 	struct nix_cqe_hdr_s *cq;
 	struct rte_mbuf *mbuf;
+	uint64_t aura_handle;
 	uint64_t sa_base = 0;
 	uintptr_t cpth = 0;
+	uint16_t lmt_id;
+	uint64_t laddr;
 
 	nb_pkts = nix_rx_nb_pkts(rxq, wdata, pkts, qmask);
 
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+		aura_handle = rxq->meta_aura;
+		sa_base = rxq->sa_base;
+		sa_base &= ~(ROC_NIX_INL_SA_BASE_ALIGN - 1);
+		ROC_LMT_BASE_ID_GET(lbase, lmt_id);
+		laddr = lbase;
+		laddr += 8;
+	}
+
 	while (packets < nb_pkts) {
 		/* Prefetch N desc ahead */
 		rte_prefetch_non_temporal((void *)(desc + (CQE_SZ((head + 2) & qmask))));
@@ -350,14 +530,48 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, co
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 
+		/* Translate meta to mbuf */
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			const uint64_t cq_w1 = *((const uint64_t *)cq + 1);
+
+			cpth = ((uintptr_t)mbuf + (uint16_t)data_off);
+
+			if (cq_w1 & BIT(11)) {
+				/* Mark meta mbuf as put */
+				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 0);
+
+				/* Store meta in lmtline to free
+				 * Assume all meta's from same aura.
+				 */
+				*(uint64_t *)(laddr + (loff << 3)) = (uint64_t)mbuf;
+				loff = loff + 1;
+				mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
+
+				/* Mark inner mbuf as get */
+				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
+			}
+		}
+
 		cn20k_nix_cqe_to_mbuf(cq, cq->tag, mbuf, lookup_mem, mbuf_init, cpth, sa_base,
-				      flags);
+				      buf_sz, flags);
 		cn20k_nix_mbuf_to_tstamp(mbuf, rxq->tstamp, (flags & NIX_RX_OFFLOAD_TSTAMP_F),
 					 (uint64_t *)((uint8_t *)mbuf + data_off));
 		rx_pkts[packets++] = mbuf;
 		roc_prefetch_store_keep(mbuf);
 		head++;
 		head &= qmask;
+
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			/* Flush when we don't have space for 4 meta */
+			if ((15 - loff) < 1) {
+				nix_sec_flush_meta(laddr, lmt_id + lnum, loff, aura_handle);
+				lnum++;
+				lnum &= BIT_ULL(ROC_LMT_LINES_PER_CORE_LOG2) - 1;
+				/* First pointer starts at 8B offset */
+				laddr = (uintptr_t)LMT_OFF(lbase, lnum, 8);
+				loff = 0;
+			}
+		}
 	}
 
 	rxq->head = head;
@@ -366,6 +580,13 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, co
 	/* Free all the CQs that we've processed */
 	plt_write64((wdata | nb_pkts), rxq->cq_door);
 
+	/* Free remaining meta buffers if any */
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F && loff)
+		nix_sec_flush_meta(laddr, lmt_id + lnum, loff, aura_handle);
+
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F)
+		rte_io_wmb();
+
 	return nb_pkts;
 }
 
@@ -374,12 +595,14 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 			  const uint16_t flags)
 {
 	struct cn20k_eth_rxq *rxq = rx_queue;
-	const uint64_t mbuf_init = rxq->mbuf_initializer;
+	uint64_t mbuf_init = rxq->mbuf_initializer;
 	const void *lookup_mem = rxq->lookup_mem;
 	const uint64_t data_off = rxq->data_off;
+	uint8_t m_sz = sizeof(struct rte_mbuf);
 	const uint64_t wdata = rxq->wdata;
 	const uint32_t qmask = rxq->qmask;
 	const uintptr_t desc = rxq->desc;
+	uint64_t buf_sz = rxq->mp_buf_sz;
 	uint16_t packets = 0, nb_pkts;
 	uint16_t lmt_id __rte_unused;
 	uint32_t head = rxq->head;
@@ -390,6 +613,12 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 
 	nb_pkts = nix_rx_nb_pkts(rxq, wdata, pkts, qmask);
 
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+		sa_base = rxq->sa_base;
+		sa_base &= ~(ROC_NIX_INL_SA_BASE_ALIGN - 1);
+		ROC_LMT_BASE_ID_GET(lbase, lmt_id);
+	}
+
 	while (packets < nb_pkts) {
 		/* Prefetch N desc ahead */
 		rte_prefetch_non_temporal((void *)(desc + (CQE_SZ((head + 2) & qmask))));
@@ -400,8 +629,29 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 
+		/* Translate meta to mbuf */
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			const uint64_t cq_w1 = *((const uint64_t *)cq + 1);
+
+			cpth = ((uintptr_t)mbuf + (uint16_t)data_off);
+
+			if (cq_w1 & BIT(11)) {
+				/* Mark meta mbuf as put */
+				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 0);
+
+				/* Store meta in lmtline to free
+				 * Assume all meta's from same aura.
+				 */
+				roc_npa_aura_op_free(mbuf->pool->pool_id, 0, (uint64_t)mbuf);
+				mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
+
+				/* Mark inner mbuf as get */
+				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
+			}
+		}
+
 		cn20k_nix_cqe_to_mbuf(cq, cq->tag, mbuf, lookup_mem, mbuf_init, cpth, sa_base,
-				      flags);
+				      buf_sz, flags);
 		cn20k_nix_mbuf_to_tstamp(mbuf, rxq->tstamp, (flags & NIX_RX_OFFLOAD_TSTAMP_F),
 					 (uint64_t *)((uint8_t *)mbuf + data_off));
 		rx_pkts[packets++] = mbuf;
@@ -416,11 +666,43 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 	/* Free all the CQs that we've processed */
 	plt_write64((wdata | nb_pkts), rxq->cq_door);
 
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F)
+		rte_io_wmb();
+
 	return nb_pkts;
 }
 
 #if defined(RTE_ARCH_ARM64)
 
+static __rte_always_inline void
+nix_sec_meta_to_mbuf(uintptr_t inb_sa, uintptr_t cpth, struct rte_mbuf **inner, uint64_t *ol_flags,
+		     const uint16_t flags, uint64x2_t *rearm)
+{
+	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
+	struct rte_mbuf *inner_m = inner[0];
+	struct cn20k_inb_priv_data *inb_priv;
+
+	/* Clear checksum flags */
+	*ol_flags &= ~(RTE_MBUF_F_RX_L4_CKSUM_MASK | RTE_MBUF_F_RX_IP_CKSUM_MASK);
+
+	if (flags & NIX_RX_REAS_F && !inb_sa) {
+		/* Clear and update original lower 16 bit of data offset */
+		*rearm = (*rearm & ~(BIT_ULL(16) - 1)) | inner_m->data_off;
+	} else {
+		/* Get SPI from CPT_PARSE_S's cookie(already swapped) */
+		inb_priv = roc_nix_inl_ot_ipsec_inb_sa_sw_rsvd((void *)inb_sa);
+		/* Update dynamic field with userdata */
+		*rte_security_dynfield(inner_m) = (uint64_t)inb_priv->userdata;
+	}
+
+	/* Clear and update original lower 16 bit of data offset */
+	if (flags & NIX_RX_REAS_F && hdr->w0.match_id == 0xFFFFU)
+		*rearm = (*rearm & ~(BIT_ULL(16) - 1)) | inner_m->data_off;
+
+	/* Mark inner mbuf as get */
+	RTE_MEMPOOL_CHECK_COOKIES(inner_m->pool, (void **)&inner_m, 1, 1);
+}
+
 static __rte_always_inline uint64_t
 nix_vlan_update(const uint64_t w2, uint64_t ol_flags, uint8x16_t *f)
 {
@@ -472,15 +754,16 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 	uint64x2_t rearm2 = vdupq_n_u64(mbuf_initializer);
 	uint64x2_t rearm3 = vdupq_n_u64(mbuf_initializer);
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3;
+	uint8_t loff = 0, lnum = 0, shft = 0;
 	uint8x16_t f0, f1, f2, f3;
+	uint16_t lmt_id, d_off;
+	uint64_t lbase, laddr;
 	uintptr_t sa_base = 0;
 	uint16_t packets = 0;
 	uint16_t pkts_left;
 	uint32_t head;
 	uintptr_t cq0;
-
-	(void)lmt_base;
-	(void)meta_aura;
+	uint64_t buf_sz = rxq->mp_buf_sz;
 
 	if (!(flags & NIX_RX_VWQE_F)) {
 		lookup_mem = rxq->lookup_mem;
@@ -502,6 +785,44 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 		RTE_SET_USED(head);
 	}
 
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+		if (flags & NIX_RX_VWQE_F) {
+			uint64_t sg_w1;
+			uint16_t port;
+
+			mbuf0 = (struct rte_mbuf *)((uintptr_t)mbufs[0] - sizeof(struct rte_mbuf));
+			/* Pick first mbuf's aura handle assuming all
+			 * mbufs are from a vec and are from same RQ.
+			 */
+			if (!meta_aura)
+				meta_aura = mbuf0->pool->pool_id;
+			/* Calculate offset from mbuf to actual data area */
+			/* Zero aura's first skip i.e mbuf setup might not match the actual
+			 * offset as first skip is taken from second pass RQ. So compute
+			 * using diff b/w first SG pointer and mbuf addr.
+			 */
+			sg_w1 = *(uint64_t *)((uintptr_t)mbufs[0] + 72);
+			d_off = (sg_w1 - (uint64_t)mbuf0);
+
+			/* Get SA Base from lookup tbl using port_id */
+			port = mbuf_initializer >> 48;
+			sa_base = cnxk_nix_sa_base_get(port, lookup_mem);
+			buf_sz = cnxk_nix_inl_bufsize_get(port, lookup_mem);
+			lbase = lmt_base;
+		} else {
+			meta_aura = rxq->meta_aura;
+			d_off = rxq->data_off;
+			sa_base = rxq->sa_base;
+			lbase = rxq->lmt_base;
+		}
+
+		sa_base &= ~(ROC_NIX_INL_SA_BASE_ALIGN - 1);
+		ROC_LMT_BASE_ID_GET(lbase, lmt_id);
+		lnum = 0;
+		laddr = lbase;
+		laddr += 8;
+	}
+
 	while (packets < pkts) {
 		if (!(flags & NIX_RX_VWQE_F)) {
 			/* Exit loop if head is about to wrap and become
@@ -688,6 +1009,265 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 			ol_flags3 |= (uint64_t)nix_rx_olflags_get(lookup_mem, cq3_w1);
 		}
 
+		/* Translate meta to mbuf */
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			uint64_t cq0_w5 = *CQE_PTR_OFF(cq0, 0, 40, flags);
+			uint64_t cq1_w5 = *CQE_PTR_OFF(cq0, 1, 40, flags);
+			uint64_t cq2_w5 = *CQE_PTR_OFF(cq0, 2, 40, flags);
+			uint64_t cq3_w5 = *CQE_PTR_OFF(cq0, 3, 40, flags);
+			uint8_t code;
+
+			uint64x2_t inner0, inner1, inner2, inner3;
+			uint64x2_t wqe01, wqe23, sa01, sa23;
+			uint64x2_t mask01, mask23;
+			uint16x4_t lens, l2lens;
+			uint8x8_t ucc;
+
+			cpth0 = (uintptr_t)mbuf0 + d_off;
+			cpth1 = (uintptr_t)mbuf1 + d_off;
+			cpth2 = (uintptr_t)mbuf2 + d_off;
+			cpth3 = (uintptr_t)mbuf3 + d_off;
+
+			inner0 = vld1q_u64((const uint64_t *)cpth0);
+			inner1 = vld1q_u64((const uint64_t *)cpth1);
+			inner2 = vld1q_u64((const uint64_t *)cpth2);
+			inner3 = vld1q_u64((const uint64_t *)cpth3);
+
+			/* Extract and reverse wqe pointers */
+			wqe01 = vzip2q_u64(inner0, inner1);
+			wqe23 = vzip2q_u64(inner2, inner3);
+
+			/* Adjust wqe pointers to point to mbuf */
+			wqe01 = vsubq_u64(wqe01, vdupq_n_u64(sizeof(struct rte_mbuf)));
+			wqe23 = vsubq_u64(wqe23, vdupq_n_u64(sizeof(struct rte_mbuf)));
+
+			/* Extract sa idx from cookie area and add to sa_base */
+			sa01 = vzip1q_u64(inner0, inner1);
+			sa23 = vzip1q_u64(inner2, inner3);
+
+			sa01 = vandq_u64(sa01, vdupq_n_u64(0xFFFFFFFF));
+			sa23 = vandq_u64(sa23, vdupq_n_u64(0xFFFFFFFF));
+
+			if (flags & NIX_RX_REAS_F) {
+				/* Crypto Look-aside Rx Inject case */
+				mask01 = vceqq_u64(sa01, vdupq_n_u64(0xFFFFFFFF));
+				mask23 = vceqq_u64(sa23, vdupq_n_u64(0xFFFFFFFF));
+			}
+
+			sa01 = vshlq_n_u64(sa01, ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2);
+			sa23 = vshlq_n_u64(sa23, ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2);
+			sa01 = vaddq_u64(sa01, vdupq_n_u64(sa_base));
+			sa23 = vaddq_u64(sa23, vdupq_n_u64(sa_base));
+
+			if (flags & NIX_RX_REAS_F) {
+				sa01 = vbicq_u64(sa01, mask01);
+				sa23 = vbicq_u64(sa23, mask23);
+			}
+
+			const uint8x16x2_t tbl = {{
+				{
+					/* ROC_IE_OT_UCC_SUCCESS_PKT_IP_BADCSUM */
+					RTE_MBUF_F_RX_IP_CKSUM_BAD >> 1,
+					/* ROC_IE_OT_UCC_SUCCESS_PKT_L4_GOODCSUM */
+					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+					 RTE_MBUF_F_RX_L4_CKSUM_GOOD) >>
+						1,
+					/* ROC_IE_OT_UCC_SUCCESS_PKT_L4_BADCSUM */
+					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+					 RTE_MBUF_F_RX_L4_CKSUM_BAD) >>
+						1,
+					1,
+					/* ROC_IE_OT_UCC_SUCCESS_PKT_UDPESP_NZCSUM */
+					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+					 RTE_MBUF_F_RX_L4_CKSUM_GOOD) >>
+						1,
+					1,
+					/* ROC_IE_OT_UCC_SUCCESS_PKT_UDP_ZEROCSUM */
+					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+					 RTE_MBUF_F_RX_L4_CKSUM_GOOD) >>
+						1,
+					3,
+					1,
+					3,
+					3,
+					3,
+					3,
+					1,
+					3,
+					1,
+				},
+				{
+					1,
+					1,
+					1,
+					/* ROC_IE_OT_UCC_SUCCESS_PKT_IP_GOODCSUM */
+					RTE_MBUF_F_RX_IP_CKSUM_GOOD >> 1,
+					/* Rest 0 to indicate RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED */
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+					0,
+				},
+			}};
+
+			const uint8x8_t err_off = {
+				/* HW_CCODE 0:6 -> 7:D */
+				-7,
+				/* UCC */
+				0xED,
+				-7,
+				0xED,
+				-7,
+				0xED,
+				-7,
+				0xED,
+			};
+
+			ucc = vdup_n_u8(0);
+			ucc = vset_lane_u16(*(uint16_t *)(cpth0 + 24), ucc, 0);
+			ucc = vset_lane_u16(*(uint16_t *)(cpth1 + 24), ucc, 1);
+			ucc = vset_lane_u16(*(uint16_t *)(cpth2 + 24), ucc, 2);
+			ucc = vset_lane_u16(*(uint16_t *)(cpth3 + 24), ucc, 3);
+			ucc = vsub_u8(ucc, err_off);
+
+			/* Table lookup to get the corresponding flags, Out of the range
+			 * from this lookup will have value 0 and consider as
+			 * RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED.
+			 */
+			ucc = vqtbl2_u8(tbl, ucc);
+
+			/* Extract l3 lengths from hdr */
+			lens = vdup_n_u16(0);
+			lens = vset_lane_u16(*(uint16_t *)(cpth0 + 30), lens, 0);
+			lens = vset_lane_u16(*(uint16_t *)(cpth1 + 30), lens, 1);
+			lens = vset_lane_u16(*(uint16_t *)(cpth2 + 30), lens, 2);
+			lens = vset_lane_u16(*(uint16_t *)(cpth3 + 30), lens, 3);
+
+			/* Add l2 length to l3 lengths */
+			l2lens = vdup_n_u16(0);
+			l2lens =
+				vset_lane_u16(((cq0_w5 >> 16) & 0xFF) - (cq0_w5 & 0xFF), l2lens, 0);
+			l2lens =
+				vset_lane_u16(((cq1_w5 >> 16) & 0xFF) - (cq1_w5 & 0xFF), l2lens, 1);
+			l2lens =
+				vset_lane_u16(((cq2_w5 >> 16) & 0xFF) - (cq2_w5 & 0xFF), l2lens, 2);
+			l2lens =
+				vset_lane_u16(((cq3_w5 >> 16) & 0xFF) - (cq3_w5 & 0xFF), l2lens, 3);
+			lens = vadd_u16(lens, l2lens);
+
+			/* Initialize rearm data when reassembly is enabled as
+			 * data offset might change.
+			 */
+			if (flags & NIX_RX_REAS_F) {
+				rearm0 = vdupq_n_u64(mbuf_initializer);
+				rearm1 = vdupq_n_u64(mbuf_initializer);
+				rearm2 = vdupq_n_u64(mbuf_initializer);
+				rearm3 = vdupq_n_u64(mbuf_initializer);
+			}
+
+			/* Checksum ol_flags will be cleared if mbuf is meta */
+			if (cq0_w1 & BIT(11)) {
+				uintptr_t wqe = vgetq_lane_u64(wqe01, 0);
+				uintptr_t sa = vgetq_lane_u64(sa01, 0);
+				uint16_t len = vget_lane_u16(lens, 0);
+
+				cpth0 = (uintptr_t)mbuf0 + d_off;
+
+				/* Free meta to aura */
+				NIX_PUSH_META_TO_FREE(mbuf0, laddr, &loff);
+				mbuf0 = (struct rte_mbuf *)wqe;
+
+				/* Update pkt_len and data_len */
+				f0 = vsetq_lane_u16(len, f0, 2);
+				f0 = vsetq_lane_u16(len, f0, 4);
+
+				nix_sec_meta_to_mbuf(sa, cpth0, &mbuf0, &ol_flags0, flags, &rearm0);
+				mbuf01 = vsetq_lane_u64((uintptr_t)mbuf0, mbuf01, 0);
+				code = vget_lane_u8(ucc, 1);
+				ol_flags0 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
+						    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+
+				ol_flags0 |= ((uint64_t)(vget_lane_u8(ucc, 0)) << 18);
+			}
+
+			if (cq1_w1 & BIT(11)) {
+				uintptr_t wqe = vgetq_lane_u64(wqe01, 1);
+				uintptr_t sa = vgetq_lane_u64(sa01, 1);
+				uint16_t len = vget_lane_u16(lens, 1);
+
+				cpth1 = (uintptr_t)mbuf1 + d_off;
+
+				/* Free meta to aura */
+				NIX_PUSH_META_TO_FREE(mbuf1, laddr, &loff);
+				mbuf1 = (struct rte_mbuf *)wqe;
+
+				/* Update pkt_len and data_len */
+				f1 = vsetq_lane_u16(len, f1, 2);
+				f1 = vsetq_lane_u16(len, f1, 4);
+
+				nix_sec_meta_to_mbuf(sa, cpth1, &mbuf1, &ol_flags1, flags, &rearm1);
+				mbuf01 = vsetq_lane_u64((uintptr_t)mbuf1, mbuf01, 1);
+				code = vget_lane_u8(ucc, 3);
+				ol_flags1 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
+						    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+				ol_flags1 |= ((uint64_t)(vget_lane_u8(ucc, 2)) << 18);
+			}
+
+			if (cq2_w1 & BIT(11)) {
+				uintptr_t wqe = vgetq_lane_u64(wqe23, 0);
+				uintptr_t sa = vgetq_lane_u64(sa23, 0);
+				uint16_t len = vget_lane_u16(lens, 2);
+
+				cpth2 = (uintptr_t)mbuf2 + d_off;
+
+				/* Free meta to aura */
+				NIX_PUSH_META_TO_FREE(mbuf2, laddr, &loff);
+				mbuf2 = (struct rte_mbuf *)wqe;
+
+				/* Update pkt_len and data_len */
+				f2 = vsetq_lane_u16(len, f2, 2);
+				f2 = vsetq_lane_u16(len, f2, 4);
+
+				nix_sec_meta_to_mbuf(sa, cpth2, &mbuf2, &ol_flags2, flags, &rearm2);
+				mbuf23 = vsetq_lane_u64((uintptr_t)mbuf2, mbuf23, 0);
+				code = vget_lane_u8(ucc, 5);
+				ol_flags2 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
+						    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+				ol_flags2 |= ((uint64_t)(vget_lane_u8(ucc, 4)) << 18);
+			}
+
+			if (cq3_w1 & BIT(11)) {
+				uintptr_t wqe = vgetq_lane_u64(wqe23, 1);
+				uintptr_t sa = vgetq_lane_u64(sa23, 1);
+				uint16_t len = vget_lane_u16(lens, 3);
+
+				cpth3 = (uintptr_t)mbuf3 + d_off;
+
+				/* Free meta to aura */
+				NIX_PUSH_META_TO_FREE(mbuf3, laddr, &loff);
+				mbuf3 = (struct rte_mbuf *)wqe;
+
+				/* Update pkt_len and data_len */
+				f3 = vsetq_lane_u16(len, f3, 2);
+				f3 = vsetq_lane_u16(len, f3, 4);
+
+				nix_sec_meta_to_mbuf(sa, cpth3, &mbuf3, &ol_flags3, flags, &rearm3);
+				mbuf23 = vsetq_lane_u64((uintptr_t)mbuf3, mbuf23, 1);
+				code = vget_lane_u8(ucc, 7);
+				ol_flags3 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
+						    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED;
+				ol_flags3 |= ((uint64_t)(vget_lane_u8(ucc, 6)) << 18);
+			}
+		}
+
 		if (flags & NIX_RX_OFFLOAD_VLAN_STRIP_F) {
 			ol_flags0 = nix_vlan_update(cq0_w2, ol_flags0, &f0);
 			ol_flags1 = nix_vlan_update(cq1_w2, ol_flags1, &f1);
@@ -807,18 +1387,18 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 		vst1q_u64((uint64_t *)mbuf2->rearm_data, rearm2);
 		vst1q_u64((uint64_t *)mbuf3->rearm_data, rearm3);
 
-		if (flags & NIX_RX_MULTI_SEG_F) {
+		if (flags & NIX_RX_MULTI_SEG_F || (flags & NIX_RX_REAS_F)) {
 			/* Multi segment is enable build mseg list for
 			 * individual mbufs in scalar mode.
 			 */
 			nix_cqe_xtract_mseg((union nix_rx_parse_u *)(CQE_PTR_OFF(cq0, 0, 8, flags)),
-					    mbuf0, mbuf_initializer, cpth0, sa_base, flags);
+					    mbuf0, mbuf_initializer, cpth0, sa_base, buf_sz, flags);
 			nix_cqe_xtract_mseg((union nix_rx_parse_u *)(CQE_PTR_OFF(cq0, 1, 8, flags)),
-					    mbuf1, mbuf_initializer, cpth1, sa_base, flags);
+					    mbuf1, mbuf_initializer, cpth1, sa_base, buf_sz, flags);
 			nix_cqe_xtract_mseg((union nix_rx_parse_u *)(CQE_PTR_OFF(cq0, 2, 8, flags)),
-					    mbuf2, mbuf_initializer, cpth2, sa_base, flags);
+					    mbuf2, mbuf_initializer, cpth2, sa_base, buf_sz, flags);
 			nix_cqe_xtract_mseg((union nix_rx_parse_u *)(CQE_PTR_OFF(cq0, 3, 8, flags)),
-					    mbuf3, mbuf_initializer, cpth3, sa_base, flags);
+					    mbuf3, mbuf_initializer, cpth3, sa_base, buf_sz, flags);
 		}
 
 		/* Store the mbufs to rx_pkts */
@@ -837,6 +1417,63 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 			head += NIX_DESCS_PER_LOOP;
 			head &= qmask;
 		}
+
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			/* Check if lmtline border is crossed and adjust lnum */
+			if (loff > 15) {
+				/* Update aura handle */
+				*(uint64_t *)(laddr - 8) = (((uint64_t)(15 & 0x1) << 32) |
+							    roc_npa_aura_handle_to_aura(meta_aura));
+				loff = loff - 15;
+				shft += 3;
+
+				lnum++;
+				laddr = (uintptr_t)LMT_OFF(lbase, lnum, 8);
+				/* Pick the pointer from 16th index and put it
+				 * at end of this new line.
+				 */
+				*(uint64_t *)(laddr + (loff << 3) - 8) = *(uint64_t *)(laddr - 8);
+			}
+
+			/* Flush it when we are in 16th line and might
+			 * overflow it
+			 */
+			if (lnum >= 15 && loff >= 12) {
+				/* 16 LMT Line size m1 */
+				uint64_t data = BIT_ULL(48) - 1;
+
+				/* Update aura handle */
+				*(uint64_t *)(laddr - 8) = (((uint64_t)(loff & 0x1) << 32) |
+							    roc_npa_aura_handle_to_aura(meta_aura));
+
+				data = (data & ~(0x7UL << shft)) | (((uint64_t)loff >> 1) << shft);
+
+				/* Send up to 16 lmt lines of pointers */
+				nix_sec_flush_meta_burst(lmt_id, data, lnum + 1, meta_aura);
+				rte_io_wmb();
+				lnum = 0;
+				loff = 0;
+				shft = 0;
+				/* First pointer starts at 8B offset */
+				laddr = (uintptr_t)LMT_OFF(lbase, lnum, 8);
+			}
+		}
+	}
+
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F && loff) {
+		/* 16 LMT Line size m1 */
+		uint64_t data = BIT_ULL(48) - 1;
+
+		/* Update aura handle */
+		*(uint64_t *)(laddr - 8) =
+			(((uint64_t)(loff & 0x1) << 32) | roc_npa_aura_handle_to_aura(meta_aura));
+
+		data = (data & ~(0x7UL << shft)) | (((uint64_t)loff >> 1) << shft);
+
+		/* Send up to 16 lmt lines of pointers */
+		nix_sec_flush_meta_burst(lmt_id, data, lnum + 1, meta_aura);
+		if (flags & NIX_RX_VWQE_F)
+			plt_io_wmb();
 	}
 
 	if (flags & NIX_RX_VWQE_F)
-- 
2.34.1

