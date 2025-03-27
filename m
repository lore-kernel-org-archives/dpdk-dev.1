Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3CFC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 07:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0CDD40275;
	Thu, 27 Mar 2025 08:03:13 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0E56B40261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 08:03:11 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QNSgn6004983;
 Thu, 27 Mar 2025 00:03:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=NbsKkKXhntSgKhnHVkvVQ7E
 p2XIVqqnA7/0X+Vn3d/4=; b=V0mf8MOzZyPr4/WKE8cJMpppkK2rnEH/WsG74qU
 d1pqrEOA0OJtJsSiNuxeOmSs72+dJ1i3yK0JPVET0eGY53U/OHPVDIUoa/OpNVno
 ozw8uiOnD00JmKPYyBBpoZqcuTqk1+YYbmwan59Wfl/A2T72dZaWoVpsLZHkPqAv
 QcazpY+ybsL/H9b6taQ6wvXQpDXM7fQt2zM6wTKpcwASEWrBvhIEX+8knKouForR
 guuLLegC+dLxqNKj0hafgxMzjgW31xjQz3A0YEHvOmmx/HmS8OZkOgFuxKvDduMi
 ARQHJ8JP28aUsCx1V2LprcEyDj/csjiHNnp3XMb2OHWMqjw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45mu9mrr5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 00:03:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 00:03:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 00:03:06 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id B56083F7077;
 Thu, 27 Mar 2025 00:03:03 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>, Rahul Bhansali
 <rbhansali@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
Subject: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPv6 packets
Date: Thu, 27 Mar 2025 12:33:00 +0530
Message-ID: <20250327070300.2839933-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Vd33PEp9 c=1 sm=1 tr=0 ts=67e4f82b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=fco5YS8PagvA9881CFoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: w-9ynsS6rL8LRtalB1BswsbSFh6mivdh
X-Proofpoint-ORIG-GUID: w-9ynsS6rL8LRtalB1BswsbSFh6mivdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
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

While running ipsec-secgw application if IPV6 rules are not
configured in ipsec configuration lpm look up fails and
destination port is updated as BAD_PORT.During process_packet
ethernet_hdr is updated resulting in crash due out of bound.
This patch fixes the same.
Fixes: 6eb3ba03995c ("examples/ipsec-secgw: support poll mode NEON LPM lookup")

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 examples/ipsec-secgw/ipsec_neon.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/examples/ipsec-secgw/ipsec_neon.h b/examples/ipsec-secgw/ipsec_neon.h
index 8b93b4b52e..fc04000336 100644
--- a/examples/ipsec-secgw/ipsec_neon.h
+++ b/examples/ipsec-secgw/ipsec_neon.h
@@ -23,6 +23,7 @@ processx4_step3(struct rte_mbuf *pkts[FWDSTEP], uint16_t dst_port[FWDSTEP],
 	uint32x4_t ve[FWDSTEP];
 	uint32_t *p[FWDSTEP];
 	struct rte_mbuf *pkt;
+	uint16_t port;
 	uint32_t val;
 	uint8_t i;
 
@@ -34,7 +35,8 @@ processx4_step3(struct rte_mbuf *pkts[FWDSTEP], uint16_t dst_port[FWDSTEP],
 			*l_pkt |= 1;
 
 		p[i] = rte_pktmbuf_mtod(pkt, uint32_t *);
-		ve[i] = vreinterpretq_u32_s32(val_eth[dst_port[i]]);
+		port = (dst_port[i] == BAD_PORT) ? 0 : dst_port[i];
+		ve[i] = vreinterpretq_u32_s32(val_eth[port]);
 		te[i] = vld1q_u32(p[i]);
 
 		/* Update last 4 bytes */
@@ -76,6 +78,7 @@ process_packet(struct rte_mbuf *pkt, uint16_t *dst_port, uint64_t tx_offloads,
 {
 	struct rte_ether_hdr *eth_hdr;
 	uint32x4_t te, ve;
+	uint16_t port;
 	uint32_t val;
 
 	/* Check if it is a large packet */
@@ -85,7 +88,8 @@ process_packet(struct rte_mbuf *pkt, uint16_t *dst_port, uint64_t tx_offloads,
 	eth_hdr = rte_pktmbuf_mtod(pkt, struct rte_ether_hdr *);
 
 	te = vld1q_u32((uint32_t *)eth_hdr);
-	ve = vreinterpretq_u32_s32(val_eth[dst_port[0]]);
+	port = (dst_port[0] == BAD_PORT) ? 0 : dst_port[0];
+	ve = vreinterpretq_u32_s32(val_eth[port]);
 
 	val = vgetq_lane_u32(te, 3);
 #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
-- 
2.25.1

