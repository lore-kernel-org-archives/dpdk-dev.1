Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08ACD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:20:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 460D14278E;
	Thu, 11 Jun 2026 16:20:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A55C44278C
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:20:43 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXVk02190486 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:20:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 VE7MBUY5ZtBr7gC5vo3WNmJQsSpGTFHJAQsTC/TlHk=; b=DzwpFThQac6sOKTxm
 4cx35RXla49iVS0LusqeuPCh6VZKL4GWc23TxnnT1uLb03uOky7M0sAD01I6FQfi
 vHpLxbFutLGe00eR8a4DOEY3uBHr+8XxmC9V3V58XNloXXpV84/dW6yLgEujzPVv
 plDNpcvv1mlhf5sLkHsRmY45kyKR2U+8YkTpzmqWPySe4bL74g16Q4YVF1hvh2W6
 4o0ECj/vi22uH+SX9+lSC/HD5ewE/JazbUlnTNkeqUiTnogaeBQH7IK3HesSfboj
 EipvLP4E071eDmygh1rwjFnU4RZrMZ+NZzgrI91TrN0iDfWICSUOa4F0GOUo5lyE
 Q1GHw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb7sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:20:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:20:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:20:42 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 5D2DA5B6974;
 Thu, 11 Jun 2026 07:20:39 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 01/22] net/cnxk: update mbuf next field for multi segment
Date: Thu, 11 Jun 2026 19:50:08 +0530
Message-ID: <20260611142029.3351415-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac43a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=yO0h6PI_INuvHoUhAc0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xbimAsWpwUshXkvhGj8HeJAD7SAf1usB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MyBTYWx0ZWRfX3ZMI3YyWggcV
 MjN8X2Nbcg4PysWmBNIzi9HOOCkpGDIKrdUuDf4ZrqNRQ9nE4H/e1C7oxl3B13SyYrnbXayeQXh
 gRbDM6jrexhft1TrES/PlhxTfDLIQfM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MyBTYWx0ZWRfX21HdVVB8gxxX
 FH022ImSv6cDg0JzRaNp0IsOPm0VZ4KYNdvtva9QvIBPo3yVYeBJjq3OAuSGuzjFgQ/7QhqX8KO
 Jnxh6VtnbULViL/DlhiCqqv2xNW+ehocyCgzM9XsI0GH+WsHVATBLLL7LMhkxC6Tbp5icfv5eXq
 GliITm1zXrZ79ch3x31HZ0TNhUKIP5dnwoOdObv5tMZGnpN2rO69pIpY6swv0CQUerpNJaOQQv5
 oqH5nvsxzMv+kh77igE9lIyACNSnmpuQ7lUT5pk3v2AuF/Ijq3YDDj45UKFzfyajrtjKW1breqZ
 IlnfqmAoiFSTNH+AKDvHuhm+ah1eBWt7TgCk9YlimolpiG5gGcqOfRbLs7GhMKSyYtCqrW103dL
 L75xqt0YWiS0aA5zZtsYEtd5OvLQJ7EPMVF147Of7DYcU0ErEISo76TExgX5gZ+k894x0O6KA5q
 BxRYJYXkxS/jW7niYGw==
X-Proofpoint-ORIG-GUID: xbimAsWpwUshXkvhGj8HeJAD7SAf1usB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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
Changes in v2: No change.

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

