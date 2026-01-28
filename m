Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB1D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85CE840608;
	Wed, 28 Jan 2026 07:04:29 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B755C4064A
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:27 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S0Yf0o190828 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 EjyfiYjImGaC5mEho/L0VFbGm0dv8IrrTS9JJimPUo=; b=YPjI5jp++UiSmCKdF
 5u0jbZ4+FSIoExdlkr6+j+ubHkahVsPI6yFXnqrMisTwiakH6T/LiOGIY9pawBv5
 Dyg1loc9eFTm9U5zz34RFfYzZDx2USlAAu/cQ+FlBz5lSnRq+mEs5dlZEV3L7Daw
 cW09njRqU3lCP2cq5V/5qZA+VHpoYH+9aFvaKEdpZ8NQ/M3J5HLb4iywLoicBZ1S
 /TGUgRbKJb2vHtvbXkusduRj4BYBWXpmyq3zj3tlnbmViEOFouM52gvGGmDlqLri
 ZfTylZtf7Zrko4yGZD2N+nc3YYlshBYl7HQARHrYP5zybZvA0k6OJ1AJ/5FxvwXg
 5wTJA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4by80yghg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:26 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:41 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7519D3F706F;
 Tue, 27 Jan 2026 22:04:23 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 10/18] net/cnxk: update NIX reassembly fast path
Date: Wed, 28 Jan 2026 11:33:08 +0530
Message-ID: <20260128060316.3967610-10-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FYc6BZ+6 c=1 sm=1 tr=0 ts=6979a6ea cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=ItCUMrDBgBJEaJNzILsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX3pCZhlSwcQyu
 lYnWoxbyDGUnKTeJf0R3IBQ/Wzwf4u2K+5tvoLVXrWhJsZ5OHXV2Zynki9rE33ZFAW3G7pB1iQq
 2ECEeFZv9dMGvfYq4+qBBFE7sCDpz/VhUAo+O28X33rLF3mVlrTYnqpzYjvZqvgULEhDJKkXuf3
 5lgbBWgQ1GhuNmOI30vATFoMdTUOS1CnwgBHq2sNKeouOdPus4jTG8BLrkrkuwugpOtTV3MKkbH
 Hxq9PnBwEvmTjg2tz+JjJDoQui56kcESjQcRN48vcIaKwfaVzWupSCuYXgfHPmmZS1c6+FXyxVM
 krYSC1ufBxCVcxEZ+jTGLlGIFGUz3fuH+43r0Ak0YqOToAOn5HcxEkvBwFg+uFNc3MHZSKBRAtM
 H9Ol0Zn0RO6XoWxg16MwDaXjHO48xPX5RlgXoD0ksqQP3hn1esuEU4Kyw3FvzyS/PcO1wyShRm1
 D/NtbA5060+fSd0IRsQ==
X-Proofpoint-GUID: -gUZwHHzApavbFT-52VOHMyPJfXrml9J
X-Proofpoint-ORIG-GUID: -gUZwHHzApavbFT-52VOHMyPJfXrml9J
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

Update NIX reassembly fastpath for cn20k based on
CPT CSR change.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_rx.h | 80 +++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index 1944e507b0..ea8675be00 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -191,15 +191,13 @@ nix_sec_reass_first_frag_update(struct rte_mbuf *head, const rte_iova_t *iova_li
 	}
 
 	/* Remove the frag header by moving header 8 bytes forward */
-	ipv6_hdr->payload_len = rte_cpu_to_be_16(rlen - 8 - sizeof(struct rte_ipv6_hdr));
+	ipv6_hdr->payload_len = rte_cpu_to_be_16(rlen - sizeof(struct rte_ipv6_hdr));
 
 	/* tot_len is sum of all IP header's length before fragment header */
 	rte_memcpy(rte_pktmbuf_mtod_offset(head, void *, 8), rte_pktmbuf_mtod(head, void *),
 		   lc_off + tot_len);
 
-	head->data_len -= 8;
 	head->data_off += 8;
-	head->pkt_len -= 8;
 }
 
 static __rte_always_inline uint64_t
@@ -300,6 +298,7 @@ nix_update_match_id(const uint16_t match_id, uint64_t ol_flags, struct rte_mbuf
 	return ol_flags;
 }
 
+#if defined(RTE_ARCH_ARM64)
 static __rte_always_inline void
 nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint64_t rearm,
 		    uintptr_t cpth, uintptr_t sa_base, const uint64_t buf_sz, const uint16_t flags)
@@ -314,6 +313,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	uint16_t rlen = hdr->w3.rlen;
 	const rte_iova_t *iova_list;
 	uint8_t sg_cnt = 1, nb_segs;
+	uint16x4_t fsz, sg_swap;
 	uint16_t later_skip = 0;
 	bool reas_fail = false;
 	const rte_iova_t *eol;
@@ -321,6 +321,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	uint8_t ts_rx_off;
 	int dyn_off = 0;
 	uint16_t sg_len;
+	uint16_t l4_off;
 	int64_t len;
 	uintptr_t p;
 
@@ -341,7 +342,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		finfo = (const struct cpt_frag_info_s *)sg_base;
 		sg_base += num_frags ? (num_frags > 4 ? 32 : 16) : 0;
 		sg = *(uint64_t *)sg_base;
-		nb_segs = (sg >> 48) & 0x3;
+		nb_segs = (sg >> 14) & 0x3;
 		iova_list = (rte_iova_t *)(sg_base);
 		eol = iova_list + (hdr->w4.gthr_size << 2);
 		iova_list += 2;
@@ -357,11 +358,22 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 			if (hdr->w0.reas_sts ||
 			    (hdr->w0.err_sum && !roc_ie_ow_ucc_is_success(hdr->w3.uc_ccode))) {
 				reas_fail = true;
-				nxt_frag = (sg >> 51) & 0x3;
-				fsz_w1 = finfo->w1.u64 >> 16;
+				nxt_frag = (sg >> 11) & 0x3;
+				nxt_frag = ((nxt_frag << 1) | (nxt_frag >> 1)) & 0x3;
+
+				/* Reverse the order of fragment sizes */
+				fsz = vreinterpret_u16_u64(vdup_n_u64(finfo->w1.u64));
+				fsz = vrev64_u16(fsz);
+				fsz_w1 = vget_lane_u64(vreinterpret_u64_u16(fsz), 0) >> 16;
 				finfo++;
+				l4_off = ((cq_w5 >> 24) & 0xFF) - (cq_w5 & 0xFF);
 			}
 		}
+
+		/* sg byte swap */
+		sg_swap = vreinterpret_u16_u64(vdup_n_u64(sg));
+		sg_swap = vrev64_u16(sg_swap);
+		sg = vget_lane_u64(vreinterpret_u64_u16(sg_swap), 0);
 	} else {
 		sg = *(const uint64_t *)(rx + 1);
 		nb_segs = (sg >> 48) & 0x3;
@@ -376,8 +388,10 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		iova_list = ((const rte_iova_t *)(rx + 1)) + 2;
 	}
 
-	/* Update data len as per the segment size */
 	sg_len = sg & 0xFFFF;
+	sg = sg >> 16;
+
+	/* Update data len as per the segment size */
 	mbuf->data_len = sg_len;
 	mbuf->nb_segs = nb_segs;
 	head = mbuf;
@@ -387,7 +401,6 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		nix_sec_reass_first_frag_update(mbuf, iova_list - 1, cpth, cq_w1, cq_w5, rlen);
 
 	len -= sg_len;
-	sg = sg >> 16;
 	nb_segs--;
 
 	later_skip = (uintptr_t)mbuf->buf_addr - (uintptr_t)mbuf;
@@ -404,6 +417,9 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 
+		sg_len = sg & 0xFFFF;
+		sg = sg >> 16;
+
 		/* Process reassembly failure case */
 		if ((flags & NIX_RX_REAS_F) && unlikely(reas_fail && (nxt_frag & 1))) {
 			head->ol_flags |=
@@ -419,20 +435,25 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 			last_mbuf->next = NULL;
 			head = mbuf;
 			len = fsz_w1 & 0xFFFF;
-			head->pkt_len = len - ts_rx_off;
+			head->pkt_len = l4_off + len - ts_rx_off;
 			head->nb_segs = sg_cnt;
+			/* later frag size update*/
+			sg_len += l4_off;
 			data_off = rearm & 0xFFFF;
 			sg_cnt = 0;
 			nxt_frag = nxt_frag >> 1;
 			fsz_w1 = fsz_w1 >> 16;
-			if (--num_frags == 4)
-				fsz_w1 = finfo->w1.u64;
+			if (--num_frags == 4) {
+				/* Reverse the order of fragment sizes */
+				fsz = vreinterpret_u16_u64(vdup_n_u64(finfo->w1.u64));
+				fsz = vrev64_u16(fsz);
+				fsz_w1 = vget_lane_u64(vreinterpret_u64_u16(fsz), 0);
+			}
 		}
 
 		if ((flags & NIX_RX_REAS_F) && num_frags && !reas_fail)
 			data_off = *iova_list - (uint64_t)mbuf->buf_addr;
 
-		sg_len = sg & 0xFFFF;
 		if ((flags & NIX_RX_OFFLOAD_SECURITY_F) && !(flags & NIX_RX_REAS_F)) {
 			/* Adjust last mbuf data length with negative offset for
 			 * security pkts if needed.
@@ -443,7 +464,6 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		}
 
 		mbuf->data_len = sg_len;
-		sg = sg >> 16;
 		p = (uintptr_t)&mbuf->rearm_data;
 		*(uint64_t *)p = (rearm & ~0xFFFF) | data_off;
 
@@ -454,11 +474,25 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 
 		if (!nb_segs && (iova_list + 1 < eol)) {
 			sg = *(const uint64_t *)(iova_list);
-			nb_segs = (sg >> 48) & 0x3;
+
+			if ((flags & NIX_RX_SEC_REASSEMBLY_F) && (cq_w1 & BIT(11))) {
+				nb_segs = (sg >> 14) & 0x3;
+
+				if (unlikely(reas_fail)) {
+					nxt_frag = (sg >> 11) & 7;
+					nxt_frag = ((nxt_frag << 2) | (nxt_frag & 2) |
+						    (nxt_frag >> 2)) & 0x7;
+				}
+
+				sg_swap = vreinterpret_u16_u64(vdup_n_u64(sg));
+				sg_swap = vrev64_u16(sg_swap);
+				sg = vget_lane_u64(vreinterpret_u64_u16(sg_swap), 0);
+			} else {
+				nb_segs = (sg >> 48) & 0x3;
+			}
+
 			iova_list++;
 			head->nb_segs += nb_segs;
-			if ((flags & NIX_RX_REAS_F) && reas_fail)
-				nxt_frag = (sg >> 50) & 0x7;
 		}
 	}
 
@@ -468,6 +502,20 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 		cnxk_ip_reassembly_dynfield(head, dyn_off)->nb_frags = 0;
 	}
 }
+#else
+static __rte_always_inline void
+nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint64_t rearm,
+		    uintptr_t cpth, uintptr_t sa_base, const uint64_t buf_sz, const uint16_t flags)
+{
+	RTE_SET_USED(rx);
+	RTE_SET_USED(mbuf);
+	RTE_SET_USED(rearm);
+	RTE_SET_USED(cpth);
+	RTE_SET_USED(sa_base);
+	RTE_SET_USED(buf_sz);
+	RTE_SET_USED(flags);
+}
+#endif
 
 static __rte_always_inline void
 cn20k_nix_cqe_to_mbuf(const struct nix_cqe_hdr_s *cq, const uint32_t tag, struct rte_mbuf *mbuf,
-- 
2.34.1

