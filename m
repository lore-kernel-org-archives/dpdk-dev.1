Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71592C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 05:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59E9B40E4A;
	Wed, 21 May 2025 07:12:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1C13340E34
 for <dev@dpdk.org>; Wed, 21 May 2025 07:12:00 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNl23O016167;
 Tue, 20 May 2025 22:11:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
 +5o2+zLIjNXMikAm5x0vha/gsTHKR8zakFnIPHUhFg=; b=GnBRaCQZ3X13C3zhY
 UhaXqQGdQpohoX5wp4MLf0gUK9kS64aJh8WZ88VKtXhgvAtLsOkEUAfLSb82mahh
 FSmUJYowDuwgKjkpOrFD1X0wknPr3xBWqXCN1ZZseIXqxqoixUw96lPWOPhjK/Mv
 SWVNa+F0XFFr3qDrajWhyoMg52ySh271nt/S+BOodbD8KdzQwukJNNFIM9SvCotr
 KmeB1MeJFZKvGq8KiC0s4emIPlcg944zYlZdpan6n9s4+X5/6BC313CtG34nu30E
 Db34H7thPGmU0wb3WYWq++1/5HLNJKeMjbx7tbpZYolvm8QHw6j+b7SXRAZQ6CL3
 Ypl3Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3purfs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 22:11:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 22:11:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 22:11:58 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id BFDEF3F704B;
 Tue, 20 May 2025 22:11:56 -0700 (PDT)
From: <skori@marvell.com>
To: Jie Hai <haijie1@huawei.com>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH v2 1/2] net: fix offset calculation for GENEVE packet
Date: Wed, 21 May 2025 10:41:42 +0530
Message-ID: <20250521051154.19595-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519160711.4024414-2-skori@marvell.com>
References: <20250519160711.4024414-2-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682d609f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=RaXvl21uGbYWHHQ77aoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: pqrp0kj0Y77w9UJEVeFiYC9awNF5v-88
X-Proofpoint-GUID: pqrp0kj0Y77w9UJEVeFiYC9awNF5v-88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA0OCBTYWx0ZWRfX6vor1lhRxt17
 FHuv3Bjm9EMhJd17zmAAG4YbeqPTf7jNPDoCUuIAvpGdkZwAiyzUZWIlVo1MQoABMibyc9Ib3rQ
 UiYSHSooS2yv+VNAjfOHXYzPK447rFxGTORxPkrbGiVBpgHvrdgVCEgdknpDKI365ctJAVf6lOH
 qP8q1hNKCo8MIdUNVLTbYuLVb7aYjfgkK+AFfZNFEYP2dMta0pG2NyP3ImCWfHHK27snf8mYs1G
 6uUbQdvaOiAhr2m+LeXHGdzgT0GEJoCnYKeaAo4TXtNDYdFXRVZ0PSbOzuSCTEzd67DHfZ2HDyK
 uQSXsEJ/o+PCt6NZWViyjMKtULg/GsmVlP81HOSK0efHXgbEIFpcT6bn1psRtO2KxqbV9hh+dxK
 GHQpfmbN8Y6cylAYpco8tnTUs+vMzIxNUEh5CBKUEvBW1lcBnisqau0ontRwRJLyKJ8zFGKd
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

While parsing packet headers, offset must be added to get next
header but for geneve header parsing offset is overwritten.
Also inner_l2_len is not set in case of geneve packets.

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 lib/net/rte_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index be24690fdf..1264f33d61 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -251,7 +251,8 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		if (unlikely(gnh == NULL))
 			return 0;
 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
-		*off = geneve_len;
+		*off += geneve_len;
+		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
 		*proto = gnh->proto;
 		if (gnh->proto == 0)
 			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
-- 
2.43.0

