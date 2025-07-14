Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72205C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 05:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65EE84013F;
	Mon, 14 Jul 2025 07:40:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BD66840041;
 Mon, 14 Jul 2025 07:40:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E24qaF020821;
 Sun, 13 Jul 2025 22:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=khcZMofNfXvX2plliG9BlcD
 bpCr1rXfy+rHiGoqbT4I=; b=D+NcS5Wfbme+aNYQp8e3J1BclLBnUr+m4/ULrOJ
 gZFdTDHX0nYEbGmf9HUwQW5L/IJjGIqfUn1mKGkPFcM8kNI1j91UUYyn350XBfiF
 VNAT2w3SZFY9ZOHJhPckIYtKlvve9J/O9nmxjs5VICQyO/ntWFrTu4g+h5Uuhyvp
 QcFFaAxEmVbzG0X5ZT+Z6lA2w3Z/BC4+D7Ae34VvzBCCfY4emgTpwvj4X4j/niEa
 Mxkb27XrJ+CtKUyTn/wcZqhogbgd/KEab2EPAFAMDr41T7HVNR7SYXTu44kQwBVf
 1UApUCeSrk8q5Hyql3l72fIntibET6DOdc4mSRbvW5scvuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47vrrrrbwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jul 2025 22:40:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 22:40:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:51 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id C58863F7066;
 Sun, 13 Jul 2025 22:40:47 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, Vamsi Attunuru <vattunuru@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v0 1/1] net/octeon_ep: fix mbuf data offset update
Date: Mon, 14 Jul 2025 11:10:41 +0530
Message-ID: <20250714054041.2257589-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=B4e50PtM c=1 sm=1 tr=0 ts=68749865 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=-eirMn7HVkwvTgvHS4MA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzMSBTYWx0ZWRfX1f3NKerU0Cat
 EtEKu6Lx+wgjoep7YbGSeHFZkR0s2p6LFnbKIq5UkrcjdRRtWVvomgRsCRudjyhpRcBexthaI7Y
 1QGCnCBmxWJafjAjNUxDcLPgoyLpSHHqL31meJBRyTyxjsKDRUyZ6Cfb3nEjAIuXJwNDTMw1ZgO
 k1yDpvTJG9nS5arW/2RyR/AiZWL1SjGh+c4XB4MmGFziLKaUfXMh7c1iY7imcDTg0oylpfjFn3I
 fFww41yenwgSTE1/xjx53s6Dvn7zNDizVzEPNnSkJ7kXgYUbV6/JFctKZXjjambGzq6njFpALm4
 GMXTExRV8kbcTzXxGjG+mlvjYpKkZ5BNxsZo0bn/VM1o4omrg3RUyNWCWMqf2HQghqOp6JkYBOw
 xn4Qs72d/nglhd7LeaKXrmeuJj2TljQjObkywkjT/DhdVp2vlG6ANxa4aiNyG4gDCnD8LNaC
X-Proofpoint-ORIG-GUID: -Mfw2YlVCSWVFchRKJ6UkImTCBKsEOJo
X-Proofpoint-GUID: -Mfw2YlVCSWVFchRKJ6UkImTCBKsEOJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Buffer refill routine uses mempool API instead of pktmbuf
alloc to avoid mbuf reset. Patch uses rearm to update the
mbuf fields. Also it removes redundant refill count update.

Fixes: 35dee56cee00 ("net/octeon_ep: add new fastpath routines")
Cc: stable@dpdk.org

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/net/octeon_ep/cnxk_ep_rx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.c b/drivers/net/octeon_ep/cnxk_ep_rx.c
index 7465e0a017..a10e9c536e 100644
--- a/drivers/net/octeon_ep/cnxk_ep_rx.c
+++ b/drivers/net/octeon_ep/cnxk_ep_rx.c
@@ -10,7 +10,6 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_pkts, struct otx_ep_droq *
 {
 	struct rte_mbuf **recv_buf_list = droq->recv_buf_list;
 	uint32_t total_pkt_len, bytes_rsvd = 0;
-	uint16_t port_id = droq->otx_ep_dev->port_id;
 	uint16_t nb_desc = droq->nb_desc;
 	uint16_t pkts;
 
@@ -22,7 +21,7 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_pkts, struct otx_ep_droq *
 		uint32_t pkt_len = 0;
 
 		mbuf = recv_buf_list[droq->read_idx];
-		info = rte_pktmbuf_mtod(mbuf, struct otx_ep_droq_info *);
+		info = cnxk_pktmbuf_mtod(mbuf, struct otx_ep_droq_info *);
 
 		total_pkt_len = rte_bswap16(info->length >> 48) + OTX_EP_INFO_SIZE;
 
@@ -37,7 +36,7 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_pkts, struct otx_ep_droq *
 			if (!pkt_len) {
 				/* Note the first seg */
 				first_buf = mbuf;
-				mbuf->data_off += OTX_EP_INFO_SIZE;
+				*(uint64_t *)&mbuf->rearm_data = droq->rearm_data;
 				mbuf->pkt_len = cpy_len - OTX_EP_INFO_SIZE;
 				mbuf->data_len = cpy_len - OTX_EP_INFO_SIZE;
 			} else {
@@ -57,12 +56,10 @@ cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_pkts, struct otx_ep_droq *
 			droq->refill_count++;
 		}
 		mbuf = first_buf;
-		mbuf->port = port_id;
 		rx_pkts[pkts] = mbuf;
 		bytes_rsvd += pkt_len;
 	}
 
-	droq->refill_count += new_pkts;
 	droq->pkts_pending -= pkts;
 	/* Stats */
 	droq->stats.pkts_received += pkts;
-- 
2.34.1

