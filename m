Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA29C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:10:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C13400D6;
	Thu, 17 Sep 2026 09:10:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D03EA400D5;
 Thu, 17 Sep 2026 09:10:39 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60SUD2242784; Thu, 17 Sep 2026 00:10:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=K4Eu5+SP1heNN1Xo66gU75n
 y6hdQPqgWvPLACOr4OLo=; b=Xae2mO/EmLtjpcE0wqFPqVoO8FlCZz5WXBOnvQC
 WW+iyfBhGzIND5Po2kSZTmj9QQGloGB/nRp7JAtlQYL+lxdd0jn5FXe1R29VSFjs
 N4Y29HUbysLvsb4HunoDLj9ly/7212PQfqscSE5u54/pnRXwcM6COoZYSo3JVNq/
 BiBopBMfZl/xvvCM4UcjH7lYTRG1FcIVdNldTO85QxNdIp3nQQ16/3g+CmdpAc0f
 3eDR01RQ6Gq4YAuodxkcNCY+zQM/ZMf0+VUOZydiKieEV1cBDwNra4HGygNlDrdh
 pbQ31TTieZJkK8ETw2qH/p4bxK9dL67qikeD36aAiAq0gcA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gr460236q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 00:10:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 00:10:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 00:10:37 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id B6E965C68E2;
 Thu, 17 Sep 2026 00:10:33 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>
CC: <jerinj@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 01/14] net/cnxk: fix packet length handling
Date: Thu, 17 Sep 2026 12:40:03 +0530
Message-ID: <20260917071016.2366467-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dgShK0SxhXnBHiRq62Wzhzmqh-W2BGpa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NSBTYWx0ZWRfX/bfHhcCeQ5Ep
 RaOCuBNDFXCjmg+7ZUXsJPVOD7rOixPPkdPHcVGCPyxWrY8yTW77DbOVEwOpnRib8nBwq3ZPGB+
 DW6jNoqpmVqnx93JBuW1n1vCg62g+34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NSBTYWx0ZWRfX2YM99bKcSUmq
 wwDjABR9eKtPe1g7HbEDqpST4sHB5c6NsXvDW26p4r5uemQaFOu1mu0+I4NHtrCDlN+oDufgO92
 UM63GcSJoeYMrbTd6j/GFom5cZ1DuXj3PXs4Du+LTiKTWjdlgyTAoBO6c5pxgZrD8X0qb1te7/4
 NU9G2+fOlWAFmL3k4mhC7yABT2c7JM53s4lbxPK1q5vOWrDFieGcoP3nToWP7po2yDVVrBxb/Ni
 pYP7J+HbKt3Zd/pc8+ku9WzuIvMAFew/KOvdwvCKKAiL+XibMnR8y8jZgZn95I8InHKuwEr7v7c
 WcQKjTDd1faeQEqxrH9bfCfJoYO+KbII8CXNe0reZfsMYFsLxHUHj4VuKUX/Tq0ao+YEtxCoXNQ
 fpUzshCxXYCQ5ULLHEGVqP8UORHqt9s2g0Tnh6Z+8LW8Dfl0fT7EN5zMrYnEerpRA5gVKUWHMzf
 OqxaO4wcxLAYz2WugdA==
X-Authority-Analysis: v=2.4 cv=VIJIDNPX c=1 sm=1 tr=0 ts=6aab926e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=967QuagO8dyZ687lA6MA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: dgShK0SxhXnBHiRq62Wzhzmqh-W2BGpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
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

Fix packet length handling for reassembly failure cases.
Also updated few macros as per cn20k platform.

Fixes: 5856f23129bb ("net/cnxk: support CN20K inline IPsec Rx")
Cc: stable@dpdk.org

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_rx.h | 42 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index f8fa6de2b9..0e9d562317 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -258,8 +258,7 @@ nix_sec_meta_to_mbuf_sc(uint64_t cq_w5, uint64_t cpth, const uint64_t sa_base,
 			*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
 	} else {
 		/* Update dynamic field with userdata */
-		if (flags & NIX_RX_REAS_F && inb_priv->userdata)
-			*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
+		*rte_security_dynfield(mbuf) = (uint64_t)inb_priv->userdata;
 	}
 
 	*len = ((w3 >> 48) & 0xFFFF) + ((cq_w5 >> 16) & 0xFF) - (cq_w5 & 0xFF);
@@ -346,16 +345,17 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	uint16_t rlen = hdr->w3.rlen;
 	const rte_iova_t *iova_list;
 	uint8_t sg_cnt = 1, nb_segs;
+	uint16_t sg_len, data_len;
 	uint16x4_t fsz, sg_swap;
 	uint16_t later_skip = 0;
 	bool reas_fail = false;
+	bool first_frag = true;
 	const rte_iova_t *eol;
 	uint16_t data_off = 0;
 	bool is_oop = false;
 	uint16_t l4_off = 0;
 	uint8_t ts_rx_off;
 	int dyn_off = 0;
-	uint16_t sg_len;
 	int64_t len;
 	uintptr_t p;
 
@@ -403,9 +403,11 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 				/* Reverse the order of fragment sizes */
 				fsz = vreinterpret_u16_u64(vdup_n_u64(finfo->w1.u64));
 				fsz = vrev64_u16(fsz);
-				fsz_w1 = vget_lane_u64(vreinterpret_u64_u16(fsz), 0) >> 16;
+				fsz_w1 = vget_lane_u64(vreinterpret_u64_u16(fsz), 0);
 				finfo++;
 				l4_off = ((cq_w5 >> 24) & 0xFF) - (cq_w5 & 0xFF);
+				mbuf->pkt_len = l4_off + (fsz_w1 & 0xFFFF) - ts_rx_off;
+				fsz_w1 >>= 16;
 			}
 		}
 
@@ -427,6 +429,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 			return;
 
 		len = rx->pkt_lenm1 + 1;
+		mbuf->pkt_len = len;
 
 		/* Skip SG_S and first IOVA */
 		eol = ((const rte_iova_t *)(rx + 1) + ((rx->desc_sizem1 + 1) << 1));
@@ -434,6 +437,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	}
 
 	sg_len = sg & 0xFFFF;
+	data_len = sg_len;
 	sg = sg >> 16;
 
 	/* Update data len as per the segment size */
@@ -478,14 +482,16 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 
 			/* Reset last mbuf next and start new mbuf chain */
 			last_mbuf->next = NULL;
+			head->nb_segs = sg_cnt;
+			head->data_len =
+				(!first_frag && (sg_cnt == 1)) ? data_len + l4_off : data_len;
 			head = mbuf;
 			len = fsz_w1 & 0xFFFF;
 			head->pkt_len = l4_off + len - ts_rx_off;
-			head->nb_segs = sg_cnt;
-			/* later frag size update*/
-			sg_len += l4_off;
+			data_len = sg_len;
 			data_off = rearm & 0xFFFF;
 			sg_cnt = 0;
+			first_frag = false;
 			nxt_frag = nxt_frag >> 1;
 			fsz_w1 = fsz_w1 >> 16;
 			if (--num_frags == 4) {
@@ -568,6 +574,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 
 	/* Update for last failure fragment */
 	if ((flags & NIX_RX_REAS_F) && reas_fail) {
+		head->data_len = (!first_frag && (sg_cnt == 1)) ? data_len + l4_off : data_len;
 		cnxk_ip_reassembly_dynfield(head, dyn_off)->next_frag = NULL;
 		cnxk_ip_reassembly_dynfield(head, dyn_off)->nb_frags = 0;
 	}
@@ -1079,10 +1086,9 @@ nix_sec_meta_to_mbuf(uintptr_t inb_sa, uintptr_t cpth, struct rte_mbuf **inner,
 		*rearm = (*rearm & ~(BIT_ULL(16) - 1)) | inner_m->data_off;
 	} else {
 		/* Get SPI from CPT_PARSE_S's cookie(already swapped) */
-		inb_priv = roc_nix_inl_ot_ipsec_inb_sa_sw_rsvd((void *)inb_sa);
+		inb_priv = roc_nix_inl_ow_ipsec_inb_sa_sw_rsvd((void *)inb_sa);
 		/* Update dynamic field with userdata */
-		if (flags & NIX_RX_REAS_F && inb_priv->userdata)
-			*rte_security_dynfield(inner_m) = (uint64_t)inb_priv->userdata;
+		*rte_security_dynfield(inner_m) = (uint64_t)inb_priv->userdata;
 	}
 
 	/* Clear and update original lower 16 bit of data offset */
@@ -1444,8 +1450,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 				mask23 = vceqq_u64(sa23, vdupq_n_u64(0xFFFFFFFF));
 			}
 
-			sa01 = vshlq_n_u64(sa01, ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2);
-			sa23 = vshlq_n_u64(sa23, ROC_NIX_INL_OT_IPSEC_INB_SA_SZ_LOG2);
+			sa01 = vshlq_n_u64(sa01, ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2);
+			sa23 = vshlq_n_u64(sa23, ROC_NIX_INL_OW_IPSEC_INB_SA_SZ_LOG2);
 			sa01 = vaddq_u64(sa01, vdupq_n_u64(sa_base));
 			sa23 = vaddq_u64(sa23, vdupq_n_u64(sa_base));
 
@@ -1456,23 +1462,23 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 
 			const uint8x16x2_t tbl = {{
 				{
-					/* ROC_IE_OT_UCC_SUCCESS_PKT_IP_BADCSUM */
+					/* ROC_IE_OW_UCC_SUCCESS_PKT_IP_BADCSUM */
 					RTE_MBUF_F_RX_IP_CKSUM_BAD >> 1,
-					/* ROC_IE_OT_UCC_SUCCESS_PKT_L4_GOODCSUM */
+					/* ROC_IE_OW_UCC_SUCCESS_PKT_L4_GOODCSUM */
 					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
 					 RTE_MBUF_F_RX_L4_CKSUM_GOOD) >>
 						1,
-					/* ROC_IE_OT_UCC_SUCCESS_PKT_L4_BADCSUM */
+					/* ROC_IE_OW_UCC_SUCCESS_PKT_L4_BADCSUM */
 					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
 					 RTE_MBUF_F_RX_L4_CKSUM_BAD) >>
 						1,
 					1,
-					/* ROC_IE_OT_UCC_SUCCESS_PKT_UDPESP_NZCSUM */
+					/* ROC_IE_OW_UCC_SUCCESS_PKT_UDPESP_NZCSUM */
 					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
 					 RTE_MBUF_F_RX_L4_CKSUM_GOOD) >>
 						1,
 					1,
-					/* ROC_IE_OT_UCC_SUCCESS_PKT_UDP_ZEROCSUM */
+					/* ROC_IE_OW_UCC_SUCCESS_PKT_UDP_ZEROCSUM */
 					(RTE_MBUF_F_RX_IP_CKSUM_GOOD |
 					 RTE_MBUF_F_RX_L4_CKSUM_GOOD) >>
 						1,
@@ -1490,7 +1496,7 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 					1,
 					1,
 					1,
-					/* ROC_IE_OT_UCC_SUCCESS_PKT_IP_GOODCSUM */
+					/* ROC_IE_OW_UCC_SUCCESS_PKT_IP_GOODCSUM */
 					RTE_MBUF_F_RX_IP_CKSUM_GOOD >> 1,
 					/* Rest 0 to indicate RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED */
 					0,
-- 
2.34.1

