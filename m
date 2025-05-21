Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A053C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 05:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F09340E4F;
	Wed, 21 May 2025 07:12:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 09ECA40E4F
 for <dev@dpdk.org>; Wed, 21 May 2025 07:12:02 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L3ejdu006545;
 Tue, 20 May 2025 22:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 HE2GJWvkiD+33xfi+abkHIJK9sLDil1by8l/Jy7ZjI=; b=PExWYDfcTBmrj4Xr9
 bck/DKWygr0F42faSHV+e2QKTz/Pa1uRTPTQINlt3IVb7EA6VdQnjH6dHc3MBQQR
 EpzuUV4uVyqJx3ry2mTe8HVXEq4J9sgM4Ij3MJKPwC2/G7KA/k4w3A6KRZlOZdmj
 T3iNQKp+g1GRAj+OXlHplH4fxFdW5bGBgsvPRTe40RTDZvlL0zSWDO/2LxQCWUL2
 WBLrqSw0rscTAhjrTWAvHnD+2p1Lj4Ue3wZcXdB6E6DaeVr3wgIK9ItSmvyMNAsT
 bvXGqKXXIcC7FTi9jld2A9xHnbv+aQh6Z3PanY7ECmanrKGmNUSvucewwx6GteQS
 35JbA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46rwfgh7cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 22:12:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 22:12:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 22:12:00 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id C67373F704B;
 Tue, 20 May 2025 22:11:58 -0700 (PDT)
From: <skori@marvell.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH v2 2/2] app/testpmd: clear stale internal len information
Date: Wed, 21 May 2025 10:41:43 +0530
Message-ID: <20250521051154.19595-2-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521051154.19595-1-skori@marvell.com>
References: <20250519160711.4024414-2-skori@marvell.com>
 <20250521051154.19595-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA0OCBTYWx0ZWRfX5SqYsa8QdWn6
 8KfW0BteXNzMXum+xubeNi2z1WuJSDssaUTHDXOcyBuomINHuXX9iOQ4zcXSdq4qnpTwwbkmfRo
 5Gdw+jEw4t83R66WJqzSZgBZEKOQEezcGyexaJMhlOYxJAi6134kD000PvTK5AHAR1g/aohWaUf
 8muRjWM8ooATVxn6ZOoYrt645Bo1LABa53jCrGK1kUna3RFf/X5wBVnMeLyJGkpleCuw0IRxdzs
 Rq5MH6TuA0dIdoxzTkCPg0xWiDbi37+eY9OWgvmOnrp+i/Lo6FG3zu427ObAPL+Ikgm9dKCw2Uy
 u+YCgz3Aw3mLpUi2zQwabqnf9B6I6mpLiSq2nWyRSVm7Am/IFkssofQ64V3LGe0EjqHM57P0lWu
 +bDKOh9L7FBwOS/01lakAeWVzmyePra1xo5Y5q2QqWzNzer3FHF3+pen8DL1GzejBA8FMc7H
X-Proofpoint-GUID: aOnBXdM9JcbqeZUEaZvn-u_mYs9SOgjJ
X-Authority-Analysis: v=2.4 cv=T6OMT+KQ c=1 sm=1 tr=0 ts=682d60a1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=AxJqTr6LTAOIiJSEcHMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aOnBXdM9JcbqeZUEaZvn-u_mYs9SOgjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

hdr_lens is used to maintain header lengths after parsing packets.
When port receives different type of packets (say first is VXLAN
packet and second is GRE packet).

For first packet, L2/L3/L4 lengths are set for inner and outer header
alongwith tunnel_len.

Now for second packet, tunnel_len is added more than its size it
contains stale value which further leads to wrong header pointers.

Hence clearing stale information before processing each packet.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 app/test-pmd/csumonly.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index fa0002d321..203af35cf0 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -627,7 +627,6 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 	uint32_t rx_bad_outer_l4_csum;
 	uint32_t rx_bad_outer_ip_csum;
 	struct testpmd_offload_info info;
-	struct rte_net_hdr_lens hdr_lens = {0};
 	uint32_t ptype;
 
 	/* receive a burst of packet */
@@ -666,6 +665,8 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 #endif
 
 	for (i = 0; i < nb_rx; i++) {
+		struct rte_net_hdr_lens hdr_lens = {0};
+
 		if (likely(i < nb_rx - 1))
 			rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i + 1],
 						       void *));
-- 
2.43.0

