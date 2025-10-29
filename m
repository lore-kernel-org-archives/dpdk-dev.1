Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E5CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65524402A6;
	Wed, 29 Oct 2025 14:05:30 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 58E024028E
 for <dev@dpdk.org>; Wed, 29 Oct 2025 14:05:29 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59TCfWFP3884945; Wed, 29 Oct 2025 06:05:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=aCoSNK36G2WGExEPgQD84YP
 +/0WjOrfJPgHXCTyyT00=; b=kEGMQ8RHSyEWjLdvvKGhO8CQ/6mwub1D+ghIHc4
 Wd5kXSVjqqa06p0hXuIlMGy2f9ZwVqjQC+78xmVqDr1LHDcv1rgfJW2cIioLWW+E
 S3dg3NxNgqf7MH1Cd9Zfz7eNtAkSnR/WTfmHEKOGAIekKKvhbts0nRgyrkgWedgQ
 UDRjtfkWzjSOlqwg+Ur9xewUL56RoXIComHvw2Qskg6sssm2O6s9Q4B0AdD0EoKw
 Z7WAT6wdw2N9kJDLe3KMmtW3z5vHHwrhn3ilskbwZSMhOn+S2QUA8perKe0B6+Nt
 mqNNczjCxtQh1j6lDN/kh1AZwEWewxlWsqvzkF0LWzGmXHQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a348ma8rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 06:05:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Oct 2025 06:05:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Oct 2025 06:05:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id F28593F70CB;
 Wed, 29 Oct 2025 06:05:25 -0700 (PDT)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Jie Hai <haijie1@huawei.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
Subject: [PATCH v1 1/1] net: fix inner L2 length for GRE and NVGRE
Date: Wed, 29 Oct 2025 18:35:23 +0530
Message-ID: <20251029130523.1642847-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEwMCBTYWx0ZWRfX7Op4GcbEgKQU
 WGVh3O8SEGcVdLJ7J2r/znytYArbtNG6jqBw9R4Vf9PCkFMJ75hgrzbo37ErwoO8/Az2cQWf3Ak
 IGl5l/OnFPhpM5SUQNBCzOqp/lXcVdp+LnnwYPU73JUfR4/k2ieBAutQElqhZlhTIfFBeoQ3C6A
 /MM6xk9pSdd3cDPuFJdj62HDv756rVtpViaDwqSFSOan8DslJYPqIlSboZCF+ijeuBfQAIomrdu
 8243vZ8MqKjboXft5ZbsVcsjekQ2b/gCLbrNN/WT+vEulU5kuctbcPk1KuVeaXA7NdVmQczgOTV
 4A3XAIg5SprcDG+XXHNTV07wP+cvxbw51KNzY3MTt9fVLLiLGAu5fSvVmpTjbuURZRQBHgH5+pF
 FFK3CRASsRtHyKqRO0U1ny7+Qdoq4Q==
X-Authority-Analysis: v=2.4 cv=T/mBjvKQ c=1 sm=1 tr=0 ts=69021118 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=pIk_GNdga5_yIZ7ewsAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: EexYRnDiYp4juwMTt3GdF5E3P7EDU74i
X-Proofpoint-ORIG-GUID: EexYRnDiYp4juwMTt3GdF5E3P7EDU74i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
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

Inner l2 length needs to be updated to include GRE and NVGRE
headers. Not updating this would cause failures for applications
which would be expecting l2_len field to be valid for
inner checksum offload cases.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 lib/net/rte_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..5476d2a573 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -480,6 +480,9 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 			return pkt_type;
 
 		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
+		if ((pkt_type & RTE_PTYPE_TUNNEL_MASK) == RTE_PTYPE_TUNNEL_GRE ||
+		    (pkt_type & RTE_PTYPE_TUNNEL_MASK) == RTE_PTYPE_TUNNEL_NVGRE)
+			hdr_lens->inner_l2_len += sizeof(struct rte_gre_hdr);
 		hdr_lens->tunnel_len = off - prev_off;
 	}
 
-- 
2.25.1

