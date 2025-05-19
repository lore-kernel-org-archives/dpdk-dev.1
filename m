Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51705C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 16:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1065140612;
	Mon, 19 May 2025 18:07:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D7E98402EB
 for <dev@dpdk.org>; Mon, 19 May 2025 18:07:30 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54INmc7Q008032;
 Mon, 19 May 2025 09:07:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=vQgOHBeBA9K/j1hChUmLGwJ
 887Kx3p8ErcPkyiGrlRQ=; b=Uvsw/nQrnUa4QEypMabkWd24JPf0co8pgE9aRDH
 PtHOKFvJkUI6D5JajOye++JV/+X+yFUlXw38rKNQ4Lgz5R1982ALYhigohWfqObR
 zEZA6++t+2kvCbyBfpQRI4zHcqbgi1mtxr2l6P8aaYt0ImcmpOHKuLwNnRrIUVln
 Q3JvbbMMqArvuYQVLTj2/irpf+jzE72/0f8Q4BZ3wSevOfPQpSd2FAD3gOoMemQm
 0zV88C1rFpeZ3RxGaec9Tpiyvt+qeFmULBuRGi5ZHC1FuZKpeR3VjP1/uqNR8BnY
 uFzquMgUbU95QVvU1UKWB1KSEXGEmldSJLkTH2nZJzQf3dg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46qb79aejh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 09:07:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 May 2025 09:07:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 May 2025 09:07:28 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 0B16D3F7080;
 Mon, 19 May 2025 09:07:26 -0700 (PDT)
From: <skori@marvell.com>
To: Jie Hai <haijie1@huawei.com>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH 1/2] net: fix offset calculation for GENEVE packet
Date: Mon, 19 May 2025 21:36:55 +0530
Message-ID: <20250519160711.4024414-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2V0PEMf9XACyNLsuVlKy79NveFBY9m4a
X-Proofpoint-ORIG-GUID: 2V0PEMf9XACyNLsuVlKy79NveFBY9m4a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1MCBTYWx0ZWRfX/3AGUoiRZHiz
 EZJnFxdzmt+XF2cM5YBc9mSYldEohyPpPcu/vx8dWYzqp1khlSfii/jwapucIxb/MBlWonYZ17F
 NAjEAv9sbf50np2+CzMqKlzexQ50pSe1dKmZtW5DmoXOtBK2QAqA3Qao0q4Q3WWPVBY8fYUXs6f
 eQ6tRv2RrFnT7nHPWRZWXjQc37g9dertZ9N/Wawk+Ahk6ugJ10DYwg0t9PWgsXG7AA9LG+E1mvX
 WrpCGmMumjStLonsUstMzwEKsQucPe6VHmo6xCl7OSTc3r3FUa6M8WvWQyuPKSEq1Yj7m6aKSIl
 1QM8Sk3LpQINC2uMPHsRZy9SW+jdJXG2MW4EswkZ/sca2Nnc24xt6SGFDWA5Cwxhlt1lCNsxg69
 vVLNBDBDdefJ3WD6zJncBsatuU6qJkB84xpIkFwV4WKcK6nRXNyFKFjtoDuayvZQ+udKj5b1
X-Authority-Analysis: v=2.4 cv=YvQPR5YX c=1 sm=1 tr=0 ts=682b5741 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=RaXvl21uGbYWHHQ77aoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
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

While parsing packet headers, offset must be added to get next
header but for geneve header parsing offset is overwritten.
Also inner_l2_len is not set in case of geneve packets.

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 lib/net/rte_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index be24690fdf..8a3ebf8478 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -251,7 +251,8 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		if (unlikely(gnh == NULL))
 			return 0;
 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
-		*off = geneve_len;
+		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
+		*off += geneve_len;
 		*proto = gnh->proto;
 		if (gnh->proto == 0)
 			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
-- 
2.43.0

