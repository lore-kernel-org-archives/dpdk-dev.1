Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B8CD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 04:29:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C1A240264;
	Mon,  1 Jun 2026 06:29:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B2E164025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 06:29:52 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64VLUDB13286782; Sun, 31 May 2026 21:29:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=tRMRyooYcGhPCRTzz/EvtOe
 zcrV5agfEeNrjZ79mTHM=; b=SZJli9FbzqLBrwdYNH9/iM6NzdRn3dmcHz+v94v
 vrsBZzk8Ucsq/fVkfwzTU6pNMo2i1IodTLbCDiVdNJz+C/0zEJ2vJo8hKEQFDT2s
 2a5J7SB6wWI8AX/BVwfqy4++QkrO5MY8umUPV0nC2/X3/92RCQMSqBn4YjQH0d/V
 qYsEVBvLX6IDmZlB0N0MrdNDS7o2Vqg/9AXZka6efrEVTKkIaurlPHVHNHYYqRwS
 wJu7IOh9qlaDMc+QmoMeoQCgwMWacq8NhYIgPJ4YZIyz+ZmsHeIqCyq/lcqvMNkw
 7LkDua2nPsvFSApamaNJ/wngn8FXYnkHMhCE8QZ26ysGJ4A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eggn8aaqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 31 May 2026 21:29:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 31 May 2026 21:29:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 31 May 2026 21:29:51 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id D1A9C5B6921;
 Sun, 31 May 2026 21:29:48 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
Subject: [PATCH] examples/ipsec-secgw: drop packets in poll mode
Date: Mon, 1 Jun 2026 09:59:46 +0530
Message-ID: <20260601042946.89719-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VYvGYnvvOeGTU_W438En7_lv7pB8LK27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA0MiBTYWx0ZWRfX8SMd93+5roxf
 a0TZp0bjYH/bAnZrvclRNGrrxUFooHjMeOPy/XMzbfapgelQpisRtzQtp1wRMkcceSYklc6+xJa
 qQLO4pGxyoUCX0uRA0S37gSSj5EujuuAplGyW7m6TAeb59nHZse0qJCvrBLv8o/yjpPwUnjMJ6K
 +K1pImHzKKe/Gd2+uBBc+uEJcDu+kJUjbQEOvWhx1Gum7a9nhl5V5zGZ8R6JoFdsKMiN8XpbEtt
 QKX3Zy3kIpN4N0mCADHSsc14IfmR8eIHOsPxVZ+tIe2itcoOjMMNQzR1gwbZcuTkQUsg5XLWSSQ
 5r7eeGwngaf77mon/sr74ZKisrmmTCGD2AygRV6KMGZj9TeEWork2DwR8lWGN66pyP7hcD/pTPy
 Sx8jnKXX+drby62lcspvVFvBRvmjdR0NCvHdVJKzlvqlC+84s8LzrBzPpFmiCSbI2eGYhOPImWR
 E1uApab3YF/sNoSz+CA==
X-Proofpoint-GUID: VYvGYnvvOeGTU_W438En7_lv7pB8LK27
X-Authority-Analysis: v=2.4 cv=ON0XGyaB c=1 sm=1 tr=0 ts=6a1d0abf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=98f5OIb2xmrjpXXyq94A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
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

During antireplay test packets are forwarded despite
errors in poll mode instead of dropping.This patch
fixes the same.

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 examples/ipsec-secgw/ipsec_worker.c | 4 ++--
 examples/ipsec-secgw/ipsec_worker.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec_worker.c b/examples/ipsec-secgw/ipsec_worker.c
index 04609964cd..61b4126759 100644
--- a/examples/ipsec-secgw/ipsec_worker.c
+++ b/examples/ipsec-secgw/ipsec_worker.c
@@ -428,7 +428,7 @@ process_ipsec_ev_inbound(struct ipsec_ctx *ctx, struct route_table *rt,
 		if (pkt->ol_flags & RTE_MBUF_F_RX_SEC_OFFLOAD) {
 			if (unlikely(pkt->ol_flags &
 				     RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED)) {
-				RTE_LOG(ERR, IPSEC,
+				RTE_LOG(DEBUG, IPSEC,
 					"Inbound security offload failed\n");
 				goto drop_pkt_and_exit;
 			}
@@ -446,7 +446,7 @@ process_ipsec_ev_inbound(struct ipsec_ctx *ctx, struct route_table *rt,
 		if (pkt->ol_flags & RTE_MBUF_F_RX_SEC_OFFLOAD) {
 			if (unlikely(pkt->ol_flags &
 				     RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED)) {
-				RTE_LOG(ERR, IPSEC,
+				RTE_LOG(DEBUG, IPSEC,
 					"Inbound security offload failed\n");
 				goto drop_pkt_and_exit;
 			}
diff --git a/examples/ipsec-secgw/ipsec_worker.h b/examples/ipsec-secgw/ipsec_worker.h
index 8f96161293..d5b8618fc8 100644
--- a/examples/ipsec-secgw/ipsec_worker.h
+++ b/examples/ipsec-secgw/ipsec_worker.h
@@ -421,7 +421,9 @@ inbound_sp_sa(struct sp_ctx *sp, struct sa_ctx *sa, struct traffic_type *ip,
 		}
 
 		/* Only check SPI match for processed IPSec packets */
-		if (i < lim && ((m->ol_flags & RTE_MBUF_F_RX_SEC_OFFLOAD) == 0)) {
+		if (i < lim && ((m->ol_flags & (RTE_MBUF_F_RX_SEC_OFFLOAD |
+				 RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED))) !=
+				 RTE_MBUF_F_RX_SEC_OFFLOAD) {
 			stats->discard++;
 			free_pkts(&m, 1);
 			continue;
-- 
2.25.1

