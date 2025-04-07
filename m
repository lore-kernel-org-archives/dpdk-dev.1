Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049ACC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 07:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 216D140156;
	Mon,  7 Apr 2025 09:22:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5447040150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 09:22:02 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372oDOw001710;
 Mon, 7 Apr 2025 00:22:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=lsaOertLohC/eeyicOxMHO1
 aQ4Aa3H2Bb8Wa22/+8u4=; b=BZg2sicesvSA5VS3k/+V+2+MnbgFnlB7gbTYCCT
 30Wq/Ta8baltQCs1mwk2joX9RwQbhsNpbwdDY1EjqvkJY85cd5UdFSAwUUkzzYP1
 xLw9o2/wEXZecMurehTwWmA5D30l6GHc+D5hx74BLpYNgGG1fN9xpb6CtTH+W1j4
 WR3taYHmrOqjZaGzLUMbXmjFRx2JLKsk+hjT1IWqdTKYWx6N0gsmaSl6FtJzug5R
 UEh9loamFlS/NikyznTeImviMkDMnIljBA07HQZZJw/ykAm1sAd48BtDtqqkz90S
 BZHf1ABqBajGW4KuZwtDHOyjVpo6bza4RMV/B3HrmfZSRyA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45un99sjkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 00:22:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 00:21:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Apr 2025 00:21:59 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id A09A45E6862;
 Mon,  7 Apr 2025 00:21:57 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
Subject: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPsec packets
Date: Mon, 7 Apr 2025 12:51:55 +0530
Message-ID: <20250407072155.1255817-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I/JlRMgg c=1 sm=1 tr=0 ts=67f37d19 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=2dapPLs2fwDiHPUAxjwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: daMY-sPNzvMS-WjX-iNJyER33k8k9-vF
X-Proofpoint-ORIG-GUID: daMY-sPNzvMS-WjX-iNJyER33k8k9-vF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
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

launching ipsec-segw application in event vector mode
after traffic has started results in segfault because
we are receiving few IPSEC packet and application is trying
to decrypt IPSEC packets using lookaside protocol.
This contradicts inline event mode.This patch fixes the same
by freeing IPSEC packets and processing only plain packets.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 examples/ipsec-secgw/ipsec_worker.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/examples/ipsec-secgw/ipsec_worker.c b/examples/ipsec-secgw/ipsec_worker.c
index e0690fc8d9..04609964cd 100644
--- a/examples/ipsec-secgw/ipsec_worker.c
+++ b/examples/ipsec-secgw/ipsec_worker.c
@@ -700,6 +700,9 @@ ipsec_ev_inbound_route_pkts(struct rte_event_vector *vec,
 	struct rte_ipsec_session *sess;
 	struct rte_mbuf *pkt;
 	struct ipsec_sa *sa;
+	uint8_t mask = (1UL << RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO) |
+		       (1UL << RTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL);
+
 
 	j = ipsec_ev_route_ip_pkts(vec, rt, t);
 
@@ -707,7 +710,7 @@ ipsec_ev_inbound_route_pkts(struct rte_event_vector *vec,
 	for (i = 0; i < t->ipsec.num; i++) {
 		pkt = t->ipsec.pkts[i];
 		sa = ipsec_mask_saptr(t->ipsec.saptr[i]);
-		if (unlikely(sa == NULL)) {
+		if (unlikely(sa == NULL) || ((1UL << sa->sessions[0].type) & mask)) {
 			free_pkts(&pkt, 1);
 			continue;
 		}
-- 
2.25.1

