Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC3D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F247F40652;
	Wed, 28 Jan 2026 07:04:41 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A30FF402C1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:36 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S0XinL189689 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 4rE6KnnoW28P5M1Ec20qDzqUdx2YQyvjc71zk5u6FA=; b=WkZm24r6vQID+Pr6V
 76eNltXbeKtzwKo4tUWzaL6larvCnit1NOBsflyNBKlcMHMGdfFfYZDZB2/81YTx
 RmhNO8PTC00+6ov0TuuEPONrVW9Te3rXwI74kqsc+bDVv/0GDpdiWjTtqmT2pk0h
 4vllX4BHX4IDPow+21bok+Yx/g3qX9iTZm5cY0aU3bZGWW/3XEhmDQoP6LIB0kSn
 JNKzYlzONiL2QMm5umUaY1oaM8SXjDHEcxV2SRvvkc+lGbzwgMG/tzkx01EeKcWw
 JegAcCrLfpCG4RJ2isd3kHfPgcY9qy9oJqaKnFHipOnXhS17rP3QS4ZOe/nuaJe+
 dsj7Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4by80yghgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:35 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:50 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 94E4C3F706F;
 Tue, 27 Jan 2026 22:04:32 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 12/18] net/cnxk: update fastpath function for OOP
Date: Wed, 28 Jan 2026 11:33:10 +0530
Message-ID: <20260128060316.3967610-12-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FYc6BZ+6 c=1 sm=1 tr=0 ts=6979a6f3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=0yyWiAZ2KeGWNjGKiRsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfXwGvzICj73GvS
 rBoe2dmrbqm5bw8GlLwWsLRkySJEmRgDMysmwyEU5xhSAYVEtpCB+y7MsxgOrmxZ5VJU7hq/u9d
 wm+HCLGK8K2qcXFYS6f3dVWAIUB9wjfpqk5cNjog1bgt6wgJCy3wb5FQwSG9gQLKJmSBuaDAREV
 cc50icw1jK0Brs1KBZl1O23WeH70qZGWoLX1q7UpMiNbYV3wP3FbCxeS/vD7MmhZV7yYHlZ3P1s
 LzJwu0BMQ9oOjvKkF1nXflksC03U9VzR9ncLR/F56Jk64tZRNJPRc7rvDcPxwInYFJu7rFRq+C1
 SK67YBfutFwTU0pmDs7igBxQqyZCquP7SdvpWk5dXBsSuLWFYnAOOcEm48FgilDPMLOJGOfy+8L
 zcwNVv2+tkJpYHKuYBlLHZUr9wHFxI0ySN/o8I4hGXObPWvRGFhkZeOsmAgLbNjl+rBKunbkvzC
 UxW6/6s71CrbuzUVG/w==
X-Proofpoint-GUID: Yn6LP-3-DtsLvPnlXLwxqb6yrFugU7Gr
X-Proofpoint-ORIG-GUID: Yn6LP-3-DtsLvPnlXLwxqb6yrFugU7Gr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Update fastpath functions to support non inplace (OOP).

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev_sec.c |  22 +++--
 drivers/net/cnxk/cn20k_rx.h         | 119 ++++++++++++++++++++++++----
 2 files changed, 118 insertions(+), 23 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index bddc02eb3b..c6a51f99f5 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -9,6 +9,7 @@
 #include <rte_security_driver.h>
 
 #include <cn20k_ethdev.h>
+#include <cn20k_rx.h>
 #include <cnxk_security.h>
 #include <roc_priv.h>
 
@@ -810,10 +811,6 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 			inb_sa_dptr->w0.s.count_mib_pkts = 1;
 		}
 
-		/* Enable out-of-place processing */
-		if (ipsec->options.ingress_oop)
-			inb_sa_dptr->w0.s.pkt_format = ROC_IE_OT_SA_PKT_FMT_FULL;
-
 		/* Prepare session priv */
 		sess_priv.inb_sa = 1;
 		sess_priv.sa_idx = ipsec->spi & spi_mask;
@@ -843,6 +840,13 @@ cn20k_eth_sec_session_create(void *device, struct rte_security_session_conf *con
 		if (ipsec->options.ingress_oop)
 			dev->inb.nb_oop++;
 
+		/* Update function pointer to handle OOP sessions */
+		if (dev->inb.nb_oop && !(dev->rx_offload_flags & NIX_RX_REAS_F)) {
+			dev->rx_offload_flags |= NIX_RX_REAS_F;
+			cn20k_eth_set_rx_function(eth_dev);
+			if (cnxk_ethdev_rx_offload_cb)
+				cnxk_ethdev_rx_offload_cb(eth_dev->data->port_id, NIX_RX_REAS_F);
+		}
 	} else {
 		struct roc_ow_ipsec_outb_sa *outb_sa, *outb_sa_dptr;
 		struct cn20k_outb_priv_data *outb_priv;
@@ -986,6 +990,12 @@ cn20k_eth_sec_session_destroy(void *device, struct rte_security_session *sess)
 		if (eth_sec->inb_oop)
 			dev->inb.nb_oop--;
 
+		/* Clear offload flags if was used by OOP */
+		if (!dev->inb.nb_oop && !dev->inb.reass_en &&
+		    dev->rx_offload_flags & NIX_RX_REAS_F) {
+			dev->rx_offload_flags &= ~NIX_RX_REAS_F;
+			cn20k_eth_set_rx_function(eth_dev);
+		}
 	} else {
 		/* Disable SA */
 		sa_dptr = dev->outb.sa_dptr;
@@ -1064,10 +1074,6 @@ cn20k_eth_sec_session_update(void *device, struct rte_security_session *sess,
 			inb_sa_dptr->w0.s.count_mib_pkts = 1;
 		}
 
-		/* Enable out-of-place processing */
-		if (ipsec->options.ingress_oop)
-			inb_sa_dptr->w0.s.pkt_format = ROC_IE_OT_SA_PKT_FMT_FULL;
-
 		rc = roc_nix_inl_ctx_write(&dev->nix, inb_sa_dptr, eth_sec->sa, eth_sec->inb,
 					   sizeof(struct roc_ow_ipsec_inb_sa));
 		if (rc)
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index eed8d59a14..83c222c53c 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -200,6 +200,38 @@ nix_sec_reass_first_frag_update(struct rte_mbuf *head, const rte_iova_t *iova_li
 	head->data_off += 8;
 }
 
+static __rte_always_inline struct rte_mbuf *
+nix_sec_oop_process(uintptr_t cpth, uint64_t buf_sz)
+{
+	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
+	uint32_t offset = hdr->w2.ptr_offset;
+	struct rte_mbuf *inner, *mbuf;
+	union nix_rx_parse_u *rx;
+	rte_iova_t *iova_list;
+	uint64_t addr;
+
+	iova_list = (rte_iova_t *)(cpth + (offset ? (offset << 5) : 256)) + 1;
+	addr = *iova_list;
+	offset = addr % (buf_sz & 0xFFFFFFFF);
+	mbuf = (struct rte_mbuf *)(addr - offset + (buf_sz >> 32));
+
+	rx = (union nix_rx_parse_u *)(((uintptr_t)(mbuf + 1)) + 8);
+	mbuf->pkt_len = rx->pkt_lenm1 + 1;
+	mbuf->data_len = rx->pkt_lenm1 + 1;
+	mbuf->data_off = addr - (uint64_t)mbuf->buf_addr;
+
+	/* Pointers will be alternate encrypted-decrypted in gather list */
+	iova_list++;
+	addr = *iova_list;
+	inner = (struct rte_mbuf *)(addr - offset + (buf_sz >> 32));
+
+	/* Mark original mbuf as get */
+	RTE_MEMPOOL_CHECK_COOKIES(inner->pool, (void **)&mbuf, 1, 1);
+
+	*rte_security_oop_dynfield(inner) = mbuf;
+	return inner;
+}
+
 static __rte_always_inline uint64_t
 nix_sec_meta_to_mbuf_sc(uint64_t cq_w5, uint64_t cpth, const uint64_t sa_base,
 			struct rte_mbuf *mbuf, uint16_t *len, uint64_t *mbuf_init,
@@ -318,10 +350,11 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	bool reas_fail = false;
 	const rte_iova_t *eol;
 	uint16_t data_off = 0;
+	bool is_oop = false;
+	uint16_t l4_off = 0;
 	uint8_t ts_rx_off;
 	int dyn_off = 0;
 	uint16_t sg_len;
-	uint16_t l4_off;
 	int64_t len;
 	uintptr_t p;
 
@@ -332,7 +365,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		uint64_t sg_base;
 
 		/* Check if there are no SG's */
-		if (!hdr->w4.gthr_size && ((flags & NIX_RX_REAS_F) || !hdr->w4.sctr_size))
+		if (!hdr->w4.gthr_size)
 			return;
 
 		cq_w5 = *((const uint64_t *)rx + 4);
@@ -342,7 +375,12 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		finfo = (const struct cpt_frag_info_s *)sg_base;
 		sg_base += num_frags ? (num_frags > 4 ? 32 : 16) : 0;
 		sg = *(uint64_t *)sg_base;
+
+		is_oop = (hdr->w4.l4_chksum_type == 0) && (hdr->w4.l4_chksum == 1);
 		nb_segs = (sg >> 14) & 0x3;
+		if (is_oop && nb_segs <= 2)
+			return;
+
 		iova_list = (rte_iova_t *)(sg_base);
 		eol = iova_list + (hdr->w4.gthr_size << 2);
 		iova_list += 2;
@@ -374,6 +412,12 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		sg_swap = vreinterpret_u16_u64(vdup_n_u64(sg));
 		sg_swap = vrev64_u16(sg_swap);
 		sg = vget_lane_u64(vreinterpret_u64_u16(sg_swap), 0);
+
+		/* For Non inplace, first SG pointer will be original encrypted,
+		 * whereas input mbuf is decrypted one. So need to update mbuf pointer
+		 * in order to process SG list accordingly.
+		 */
+		mbuf = is_oop ? *rte_security_oop_dynfield(mbuf) : mbuf;
 	} else {
 		sg = *(const uint64_t *)(rx + 1);
 		nb_segs = (sg >> 48) & 0x3;
@@ -397,17 +441,17 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	head = mbuf;
 
 	/* Update IP header */
-	if ((flags & NIX_RX_REAS_F) && num_frags && !reas_fail)
+	if ((flags & NIX_RX_REAS_F) && num_frags && !reas_fail && !is_oop)
 		nix_sec_reass_first_frag_update(mbuf, iova_list - 1, cpth, cq_w1, cq_w5, rlen);
 
-	len -= sg_len;
+	len -= is_oop ? 0 : sg_len;
 	nb_segs--;
 
 	later_skip = (uintptr_t)mbuf->buf_addr - (uintptr_t)mbuf;
 
 	while (nb_segs) {
 		last_mbuf = mbuf;
-		if ((flags & NIX_RX_REAS_F) && num_frags) {
+		if ((flags & NIX_RX_REAS_F) && (num_frags || is_oop)) {
 			offset = (*iova_list) % (buf_sz & 0xFFFFFFFF);
 			mbuf->next = (struct rte_mbuf *)((*iova_list) - offset + (buf_sz >> 32));
 		} else {
@@ -451,12 +495,14 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 			}
 		}
 
-		if ((flags & NIX_RX_REAS_F) && num_frags && !reas_fail)
+		if ((flags & NIX_RX_REAS_F) && ((num_frags && !reas_fail) || is_oop))
 			data_off = *iova_list - (uint64_t)mbuf->buf_addr;
 
-		if ((flags & NIX_RX_OFFLOAD_SECURITY_F) && !(flags & NIX_RX_REAS_F)) {
+		if (((flags & NIX_RX_OFFLOAD_SECURITY_F) && !(flags & NIX_RX_REAS_F)) ||
+		    (is_oop && (sg_cnt % 2))) {
 			/* Adjust last mbuf data length with negative offset for
 			 * security pkts if needed.
+			 * For OOP, will correct mbuf length of decrypted pkt.
 			 */
 			len -= sg_len;
 			sg_len = (len > 0) ? sg_len : (sg_len + len);
@@ -496,6 +542,29 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		}
 	}
 
+	if (unlikely(is_oop)) {
+		struct rte_mbuf *o_mbuf;
+
+		/* mbuf chain will have all pointers of encrypted + decrypted
+		 * alternatively. So will need to sort it.
+		 */
+		mbuf = head;
+		o_mbuf = head->next;
+		nb_segs = head->nb_segs;
+		mbuf->nb_segs = nb_segs / 2;
+		o_mbuf->nb_segs = nb_segs / 2;
+		nb_segs -= 2;
+		while (unlikely(nb_segs && (nb_segs % 2 == 0))) {
+			mbuf->next = o_mbuf->next;
+			o_mbuf->next = o_mbuf->next->next;
+			mbuf = mbuf->next;
+			o_mbuf = o_mbuf->next;
+			nb_segs -= 2;
+		}
+		mbuf->next = NULL;
+		o_mbuf->next = NULL;
+	}
+
 	/* Update for last failure fragment */
 	if ((flags & NIX_RX_REAS_F) && reas_fail) {
 		cnxk_ip_reassembly_dynfield(head, dyn_off)->next_frag = NULL;
@@ -648,6 +717,8 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, co
 	uintptr_t cpth = 0;
 	uint16_t lmt_id;
 	uint64_t laddr;
+	uint64_t w4;
+	bool is_oop;
 
 	nb_pkts = nix_rx_nb_pkts(rxq, wdata, pkts, qmask);
 
@@ -685,7 +756,12 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pkts, co
 				 */
 				*(uint64_t *)(laddr + (loff << 3)) = (uint64_t)mbuf;
 				loff = loff + 1;
-				mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
+				w4 = *(uint64_t *)(cpth + 32);
+				is_oop = !((w4 >> 32) & 0x3) && ((w4 & 0xffffffff) == 1);
+				if ((flags & NIX_RX_REAS_F) && is_oop)
+					mbuf = nix_sec_oop_process(cpth, buf_sz);
+				else
+					mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
 
 				/* Mark inner mbuf as get */
 				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
@@ -815,11 +891,21 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t pk
 
 static __rte_always_inline void
 nix_sec_meta_to_mbuf(uintptr_t inb_sa, uintptr_t cpth, struct rte_mbuf **inner, uint64_t *ol_flags,
-		     const uint16_t flags, uint64x2_t *rearm)
+		     const uint16_t flags, uint64x2_t *rearm, uint64_t buf_sz)
 {
 	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
-	struct rte_mbuf *inner_m = inner[0];
 	struct cn20k_inb_priv_data *inb_priv;
+	struct rte_mbuf *inner_m;
+	uint64_t w4;
+	bool is_oop;
+
+	w4 = *(uint64_t *)(cpth + 32);
+	is_oop = !((w4 >> 32) & 0x3) && ((w4 & 0xffffffff) == 1);
+
+	if ((flags & NIX_RX_REAS_F) && is_oop)
+		inner[0] = nix_sec_oop_process(cpth, buf_sz);
+
+	inner_m = inner[0];
 
 	/* Clear checksum flags */
 	*ol_flags &= ~(RTE_MBUF_F_RX_L4_CKSUM_MASK | RTE_MBUF_F_RX_IP_CKSUM_MASK);
@@ -1328,7 +1414,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 				f0 = vsetq_lane_u16(len, f0, 2);
 				f0 = vsetq_lane_u16(len, f0, 4);
 
-				nix_sec_meta_to_mbuf(sa, cpth0, &mbuf0, &ol_flags0, flags, &rearm0);
+				nix_sec_meta_to_mbuf(sa, cpth0, &mbuf0, &ol_flags0, flags, &rearm0,
+						     buf_sz);
 				mbuf01 = vsetq_lane_u64((uintptr_t)mbuf0, mbuf01, 0);
 				code = vget_lane_u8(ucc, 1);
 				ol_flags0 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
@@ -1344,7 +1431,6 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 
 				cpth1 = (uintptr_t)mbuf1 + d_off;
 
-				/* Free meta to aura */
 				NIX_PUSH_META_TO_FREE(mbuf1, laddr, &loff);
 				mbuf1 = (struct rte_mbuf *)wqe;
 
@@ -1352,7 +1438,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 				f1 = vsetq_lane_u16(len, f1, 2);
 				f1 = vsetq_lane_u16(len, f1, 4);
 
-				nix_sec_meta_to_mbuf(sa, cpth1, &mbuf1, &ol_flags1, flags, &rearm1);
+				nix_sec_meta_to_mbuf(sa, cpth1, &mbuf1, &ol_flags1, flags, &rearm1,
+						     buf_sz);
 				mbuf01 = vsetq_lane_u64((uintptr_t)mbuf1, mbuf01, 1);
 				code = vget_lane_u8(ucc, 3);
 				ol_flags1 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
@@ -1375,7 +1462,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 				f2 = vsetq_lane_u16(len, f2, 2);
 				f2 = vsetq_lane_u16(len, f2, 4);
 
-				nix_sec_meta_to_mbuf(sa, cpth2, &mbuf2, &ol_flags2, flags, &rearm2);
+				nix_sec_meta_to_mbuf(sa, cpth2, &mbuf2, &ol_flags2, flags, &rearm2,
+						     buf_sz);
 				mbuf23 = vsetq_lane_u64((uintptr_t)mbuf2, mbuf23, 0);
 				code = vget_lane_u8(ucc, 5);
 				ol_flags2 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
@@ -1398,7 +1486,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 				f3 = vsetq_lane_u16(len, f3, 2);
 				f3 = vsetq_lane_u16(len, f3, 4);
 
-				nix_sec_meta_to_mbuf(sa, cpth3, &mbuf3, &ol_flags3, flags, &rearm3);
+				nix_sec_meta_to_mbuf(sa, cpth3, &mbuf3, &ol_flags3, flags, &rearm3,
+						     buf_sz);
 				mbuf23 = vsetq_lane_u64((uintptr_t)mbuf3, mbuf23, 1);
 				code = vget_lane_u8(ucc, 7);
 				ol_flags3 |= code ? (code > 1 ? ((uint64_t)code) << 1 : 0) :
-- 
2.34.1

