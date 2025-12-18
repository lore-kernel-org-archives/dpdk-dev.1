Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7BBD6ACD4
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 09:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE26C40275;
	Thu, 18 Dec 2025 10:09:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 33B5C4026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 10:09:58 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI68LsW3297436; Thu, 18 Dec 2025 01:09:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 yBE+NTkHUIOhu72vRoFA9CCobBfevHtdsQuiXrzB9I=; b=TwsL0eqxuvRjUrCqG
 9Bd/QF2+12KJdiu3FM+MBMhb8SJn+DwcbKSVoH8ouaK2zVjuvqL/SYD1eCV067P/
 keqa0W3HiDNNFM5bPvxgpu2Rr6RXBjgXfwd+69aHDNaeQgPbDbUdgOodo+HwXHQ9
 y796Ntg1RlSpZSS1vKiK+K+ORY3nBM6hYW6UWApcCHrXw/bjJKb7v16/cUVa9IMD
 9YCVWQPDHkjjvQ8cxHcHqvd8OL0X4JSnxI0NFMbnG3tItoxEqEJelwn1vQRi/5L/
 GjC5NW5EC28yEs/73RQRG4sw4A7TqPmWfXnnk0HDbWMqHjj4uzbzm3dB6C9Jb4CE
 yK2vg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b3w5s294x-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 01:09:55 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Dec 2025 01:09:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Dec 2025 01:09:50 -0800
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id BEE123F7076;
 Thu, 18 Dec 2025 01:09:34 -0800 (PST)
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Jie Hai <haijie1@huawei.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <ndabilpuram@marvell.com>, "Rakesh
 Kudurumalla" <rkudurumalla@marvell.com>
Subject: [PATCH v2 1/1] net: fix inner L2 length for GRE and NVGRE
Date: Thu, 18 Dec 2025 14:39:32 +0530
Message-ID: <20251218090932.1767124-1-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029130523.1642847-1-rkudurumalla@marvell.com>
References: <20251029130523.1642847-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA3NCBTYWx0ZWRfX+4DAZ2bbXflV
 qPKReEghuKRxeo4issw5TDI2l3858629jG+r/YsJJO6zZBPwyH2nYQrZr6navYi9MGrnKGDR7QK
 XugbhyuPO4TuVEtWmPPZPC+3x7wdugY7sDAFlwslkvwybXYE1iIlGj9QQht8/6MWwcut2tZOME6
 moaY4CCTM6V+1lZQUysGWgWmZixFaFV20JY6FbKcYi199f8o7Uxs3urP5P0pWn39+Il0DMa8q/G
 gB31BjowpcxiqxkFNCIQFh/gNVss9d7EsQ8uH+2Vnkd9ZTOJhzHZsM4cKJQTzVmJGu8nyrBq/jR
 lgBqYTj32B6aLyJdWttST0pqg/T/eiGbYndGOUfZciRAodbctV3/+8L96PaiRrerBu97I8lRLMC
 fb4bWAWDBwuY6uwtMB4ivH0PmyS//A==
X-Proofpoint-GUID: yYgYfHrJYO7i3jxOG7Vo7snXXvzR-bwJ
X-Proofpoint-ORIG-GUID: yYgYfHrJYO7i3jxOG7Vo7snXXvzR-bwJ
X-Authority-Analysis: v=2.4 cv=Zpvg6t7G c=1 sm=1 tr=0 ts=6943c4e3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=-Rt_IdBXOZU5NuI9SysA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
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

V2: update innner l2 length based of GRE header flags
for key, sequence and checksum

 lib/net/rte_net.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index c70b57fdc0..a24a0db526 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -480,6 +480,19 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 			return pkt_type;
 
 		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
+		if ((pkt_type & RTE_PTYPE_TUNNEL_MASK) == RTE_PTYPE_TUNNEL_GRE ||
+		    (pkt_type & RTE_PTYPE_TUNNEL_MASK) == RTE_PTYPE_TUNNEL_NVGRE) {
+			const struct rte_gre_hdr *gh;
+
+			gh = rte_pktmbuf_read(m, prev_off, sizeof(*gh), NULL);
+			if (gh->k)
+				hdr_lens->inner_l2_len += 4;
+			if (gh->s)
+				hdr_lens->inner_l2_len += 4;
+			if (gh->c)
+				hdr_lens->inner_l2_len += 4;
+			hdr_lens->inner_l2_len += sizeof(struct rte_gre_hdr);
+		}
 		hdr_lens->tunnel_len = off - prev_off;
 		hdr_lens->inner_l2_len = off - prev_off;
 	}
-- 
2.25.1

