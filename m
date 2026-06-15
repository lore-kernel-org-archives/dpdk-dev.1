Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DDECD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BD6940663;
	Mon, 15 Jun 2026 18:25:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C75F400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:25:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFcGJQ392920 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 Vdl5jJyts18zoMUXgLH2NX4X/BxfstSnshN/Jpo27Y=; b=HiNIBFv9Zko5PUyoL
 OzMR8+vmIL6s6qVAVTE7MRsBCNsAlyTx7OhrKxOnWaD9F9rKL6aD89XBnHj5e9oq
 FEa4kSMLKx4am6NVEVc5HMuGPO+NOe6ntS5fKfLjVksZC8rOAVZapylwjB7uINMS
 SMBt3TTsodM8ELj+pmPdVUmY5VVYpeM0nsnhX7GPUEmP/YeTXil6p2dz+N4mXp6O
 Sdhfh30AuHAlzxjCOIj/QIAoHTnuwgrJW8rSWqfiOdKTJuUd5zR4/umBOcIlodEW
 v2+gnebGhAyd0j5ev2F/WCT1jFr6B+8hFXtwOLKksHuN+ofamsGnrlWcovWrJ9V0
 coAWw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4esqy8d7jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:25:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:25:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:25:52 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 2CDD43F7063;
 Mon, 15 Jun 2026 09:25:49 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 01/20] net/cnxk: update mbuf next field for multi segment
Date: Mon, 15 Jun 2026 21:54:27 +0530
Message-ID: <20260615162446.578336-1-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SbzHsPRu c=1 sm=1 tr=0 ts=6a302792 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=yO0h6PI_INuvHoUhAc0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: B1cClfbSl6SHsG0xlQNcS3zW1Vpk0bxy
X-Proofpoint-ORIG-GUID: B1cClfbSl6SHsG0xlQNcS3zW1Vpk0bxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3MiBTYWx0ZWRfXzoTzULZveA5M
 cv0QeGBkxtq//DKKfWrX9HOG8wPkllofo5UoznRnKrpVflba2dAXUcjMt4uF0aIq3P+Y3P4JaHf
 QiE7xesGCKQgom4X+F7RoonCBVX1Vtqr8GBhIQQY+zEAp0R8kq3PKbp1kukw9I9dQzxVkXdUCHZ
 tBJDoroaPpYJSfpj9FVT7vKMgX4JIIXNxBBhZsF+mZYaVtCklMAxfSabXKKd9hjMzHfulqjXhJ7
 JhQtGgMeWbfB3eDTDj6hKvvnCJum1bvZW2U8t58496FjrVkhZRxzqTOE2wwy1R1oma08iYRMMej
 OJeLb5JiXV3wlL6wlL/dQulKzRVahbdulsM8Uv0TbS47Y0+TBhNmiF/g2W6YOXcr3JeRLhWwiAV
 SwgZn8v2ndQc8lFANuChFbwUaI6pZK69V3O7PHigkLby3H+C2Vs/tH8015c40vcrMul8UAFNwqG
 tUtAEpmEZBt7Z9d9fsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3MiBTYWx0ZWRfXwb8Mh+k1EKI7
 CQkaUNMh/vLPiBtg36JPxooNIgXML6gWOI8V7NMT5LBvvsxSntXBhnxXjGsTX3aUAPTEGcRX52M
 +meQzzYJWdS6/aYrEyJIO3ObRf6vi98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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
Changes in v3: No change.
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

