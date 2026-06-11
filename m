Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C607CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5358942ECD;
	Thu, 11 Jun 2026 09:33:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EABD240288
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:33:28 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0Qs9N1253731 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=rSoRS40oV2fJDb27Rcn6sib
 0b2C1gpWbOYnqPwvfm7Q=; b=cQlU3aorvlNv2C3ymznquOlXrtPRjsg8eRqqZxO
 w7j34LYx2pxxHjFmelkTb3elAEP3V5/graMWjzmm3q84Gw7PGNJwurIlqGxN7sZl
 NjKDxF3jva38xrHzX/zbDX6qcZlg62MaNXf6sqZns6eDQHB+ShawWuaO5gNSjOX9
 HAxjQUQhrbzyCqTB1urUMLhnQLLP+Dg0c4+XCWXbSsRYCV6+FL9OcM/9EBn2+XIQ
 wnuQ82KdIZZiJuJSw+6ZQ4oIunot9XN2hmTeH2Lsx1FFP9d2cubU55eCVKZdXTdP
 /mdz9NcOjSWIvaFUvKGmBlLlVuXpy8WEaHaAvY+4BsDEk+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5vswn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:33:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:33:26 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E3E6F5B6973;
 Thu, 11 Jun 2026 00:33:23 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 01/17] net/cnxk: update mbuf next field for multi segment
Date: Thu, 11 Jun 2026 13:02:55 +0530
Message-ID: <20260611073311.3129711-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX9D9cZxAlXq+B
 rBmOaXIJGDUWe70CvxFwpaG4PgIcam4V6zZ7mtpnuD9B8lFRXzBjrxtgVINSP62l7EPfO2/aZtJ
 BkO0V1AvYciZGAK7AhtV9jsa3JPtBdA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX1m+8EZ08IR/A
 Ypd1QNcdLoXboCZKXSv1P9yVh8gTIe/1fpXUOEUL9GG1mcTKRtiGFX+n07YL5Od4a+dK1ZuelQx
 37XTFTJLR1AVtqWwAYnhFQc8JCZyAqMDcfGGEiXV15DLF3euD18wWop4akWpx+dB06nY61dOBcA
 nBJIuaNAd5pqnLeF2CDJsF5uTO9Y64ARcss+lNIrSUdrt1qBWZQtOaB/ZNaEF1MehpP7H0YFChU
 Bvwmw/sEThBWBw2XB1jPoBHd5u3sOO0HhojjNQt1jAHoO0h1bc0jHU+PCZRMcdCu/RZfCHBvjmg
 A5RNsKzG4uC65j0QVtnS5NjIpJGzFM3/8qeqckTXDVJluYidqixDQAki8OTHk7lDPq1aBAA+8Pw
 MmSBETO0lD+Sl5KhT4ipPpKbFegayrB0dPG2oGFZtM0rrLC5Gcoejqp3A7yHQAoJuDgqMxDtufy
 SSPTTsZp8+xquo0qtOw==
X-Authority-Analysis: v=2.4 cv=UPDt2ify c=1 sm=1 tr=0 ts=6a2a64c7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=yO0h6PI_INuvHoUhAc0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: VdG1aTZGQlueweCzxKfSA8jERZS08EXf
X-Proofpoint-GUID: VdG1aTZGQlueweCzxKfSA8jERZS08EXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

As per the requirement of rte_mbuf_raw_reset_bulk(), the mbuf's
'next' and 'nb_segs' fields are required to be reset.
This reset these field for multi-segment mbufs on cn9k platform.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn9k_rx.h |  8 --------
 drivers/net/cnxk/cn9k_tx.h | 42 ++++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/net/cnxk/cn9k_rx.h b/drivers/net/cnxk/cn9k_rx.h
index 79b56fe160..5ccdc5dee1 100644
--- a/drivers/net/cnxk/cn9k_rx.h
+++ b/drivers/net/cnxk/cn9k_rx.h
@@ -410,8 +410,6 @@ cn9k_nix_cqe_to_mbuf(const struct nix_cqe_hdr_s *cq, const uint32_t tag,
 		 * Hence, flag argument is not required.
 		 */
 		nix_cqe_xtract_mseg(rx, mbuf, val, 0);
-	else
-		mbuf->next = NULL;
 }
 
 static inline uint16_t
@@ -826,12 +824,6 @@ cn9k_nix_recv_pkts_vector(void *rx_queue, struct rte_mbuf **rx_pkts,
 			nix_cqe_xtract_mseg((union nix_rx_parse_u *)
 						(cq0 + CQE_SZ(3) + 8), mbuf3,
 					    mbuf_initializer, flags);
-		} else {
-			/* Update that no more segments */
-			mbuf0->next = NULL;
-			mbuf1->next = NULL;
-			mbuf2->next = NULL;
-			mbuf3->next = NULL;
 		}
 
 		/* Store the mbufs to rx_pkts */
diff --git a/drivers/net/cnxk/cn9k_tx.h b/drivers/net/cnxk/cn9k_tx.h
index 32665d2050..0ec448e36c 100644
--- a/drivers/net/cnxk/cn9k_tx.h
+++ b/drivers/net/cnxk/cn9k_tx.h
@@ -665,14 +665,14 @@ cn9k_nix_prepare_mseg(struct cn9k_eth_txq *txq, struct rte_mbuf *m, struct rte_m
 #else
 	RTE_SET_USED(cookie);
 #endif
-#ifdef RTE_ENABLE_ASSERT
-	m->next = NULL;
-	m->nb_segs = 1;
-#endif
-	m = m_next;
-	if (!m)
+	if (likely(!m_next))
 		goto done;
 
+	if (!(flags & NIX_TX_OFFLOAD_MBUF_NOFF_F)) {
+		m->next = NULL;
+		m->nb_segs = 1;
+	}
+	m = m_next;
 	/* Fill mbuf segments */
 	do {
 		m_next = m->next;
@@ -704,12 +704,13 @@ cn9k_nix_prepare_mseg(struct cn9k_eth_txq *txq, struct rte_mbuf *m, struct rte_m
 			sg_u = sg->u;
 			slist++;
 		}
-#ifdef RTE_ENABLE_ASSERT
-		m->next = NULL;
-#endif
+		if (!(flags & NIX_TX_OFFLOAD_MBUF_NOFF_F))
+			m->next = NULL;
 		m = m_next;
 	} while (nb_segs);
 
+	if (!(flags & NIX_TX_OFFLOAD_MBUF_NOFF_F))
+		rte_io_wmb();
 done:
 	sg->u = sg_u;
 	sg->segs = i;
@@ -720,9 +721,6 @@ cn9k_nix_prepare_mseg(struct cn9k_eth_txq *txq, struct rte_mbuf *m, struct rte_m
 	segdw += (off >> 1) + 1 + !!(flags & NIX_TX_OFFLOAD_TSTAMP_F);
 	send_hdr->w0.sizem1 = segdw - 1;
 
-#ifdef RTE_ENABLE_ASSERT
-	rte_io_wmb();
-#endif
 	return segdw;
 }
 
@@ -950,10 +948,10 @@ cn9k_nix_prepare_mseg_vec_list(struct cn9k_eth_txq *txq,
 	RTE_SET_USED(cookie);
 #endif
 
-#ifdef RTE_ENABLE_ASSERT
-	m->next = NULL;
-	m->nb_segs = 1;
-#endif
+	if (!(flags & NIX_TX_OFFLOAD_MBUF_NOFF_F)) {
+		m->next = NULL;
+		m->nb_segs = 1;
+	}
 	m = m_next;
 	/* Fill mbuf segments */
 	do {
@@ -984,9 +982,8 @@ cn9k_nix_prepare_mseg_vec_list(struct cn9k_eth_txq *txq,
 			sg_u = sg->u;
 			slist++;
 		}
-#ifdef RTE_ENABLE_ASSERT
-		m->next = NULL;
-#endif
+		if (!(flags & NIX_TX_OFFLOAD_MBUF_NOFF_F))
+			m->next = NULL;
 		m = m_next;
 	} while (nb_segs);
 
@@ -1002,9 +999,6 @@ cn9k_nix_prepare_mseg_vec_list(struct cn9k_eth_txq *txq,
 		 !!(flags & NIX_TX_OFFLOAD_TSTAMP_F);
 	send_hdr->w0.sizem1 = segdw - 1;
 
-#ifdef RTE_ENABLE_ASSERT
-	rte_io_wmb();
-#endif
 	return segdw;
 }
 
@@ -1089,6 +1083,10 @@ cn9k_nix_xmit_pkts_mseg_vector(uint64x2_t *cmd0, uint64x2_t *cmd1,
 		}
 	}
 
+	/* Multi segment mbufs */
+	if (!(flags & NIX_TX_OFFLOAD_MBUF_NOFF_F))
+		rte_io_wmb();
+
 	for (j = 0; j < NIX_DESCS_PER_LOOP;) {
 		/* Fit consecutive packets in same LMTLINE. */
 		if ((segdw[j] + segdw[j + 1]) <= 8) {
-- 
2.34.1

