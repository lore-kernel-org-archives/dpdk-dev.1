Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E31E83855
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 05:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2504D406FF;
	Tue, 17 Feb 2026 06:44:49 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E60C2406B4
 for <dev@dpdk.org>; Tue, 17 Feb 2026 06:44:47 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61H1uqhQ860882 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 q8cMoQ9BrNxHoyxPa72gx4xNT3Wlm7kj+zxgWrFc64=; b=JjWgW/yxeu3FJcHhH
 h2uSZFm833WAZC3yuIGy2e3SARmo88AzdP0kaVifueCG48gA0MqoPoH2o0HaSUkW
 TS32rJkaGRSu1bMdh4qmUQ8ZQm+i5iZJ6d+nU2pqq/e8JEdrxUknb1DoeX1Pc5np
 Gdbo7Wd3uYg5uneNQ/H6EAKlvCo2kjaOeg67V+1mKsodwSRYmYXRnTvsXEjc1MFO
 eQyjS80tB4rj7rgCDYWYdBTTWYOqQ8G9SaZym+LmIAz2Q2NWNPleD6Trm5QrVND7
 HsPc0GQ4kZGUqssXDIsqlSIzQRK9y7WqbOdXQumSlAVMwXvJQbjJctSZKUbf7XS9
 xL72g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cccxf8d1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 16 Feb 2026 21:44:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Feb 2026 21:45:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 16 Feb 2026 21:45:02 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 426115B696D;
 Mon, 16 Feb 2026 21:44:43 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH v2 11/18] net/cnxk: update aura batch free
Date: Tue, 17 Feb 2026 11:13:38 +0530
Message-ID: <20260217054345.2759687-11-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054345.2759687-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260217054345.2759687-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cdbfb3DM c=1 sm=1 tr=0 ts=6994004f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=1brba8Zsg9n62mL7sFYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NSBTYWx0ZWRfX10BG7KpXmzid
 ZD5HZ7Lb70IYD/P+is3/Gm1SQ8QTn4usxaHma1C7nW2zgHnK4PIi1JZIbqNlTxeukV9kJ7M8b1Z
 Z0zmz32B14bwwuLfLyiQqpIEmsFBn4RC5uqi3KVKXMh/KdW/+Fcpr1y4Z9Kk9D1j+ztzwJ8/6S0
 4jz6VmAe97TULFFl6DEiGXBc0S7ZeW8PKdd5XL1xSJPjqQlPef47nnQC0n3b+qpvyWcWOo7qaCC
 HIFADZH+prewhxAze2q9Wx8tQO2SufpOU28BmVTJEPFEMldKXp7WhQWu3SDfbHClmgPK6/41v2C
 S9YJJ/lIxf/S7RkJVabWbwIxhTC0hNt9tNDAKyd94dhb8gpLRpHxZBgSgtEvstDLdSQrnNHXN62
 PcW4iJVlu+Nzf6VLqyMolNbLiSj5YeudSm8w8HEd5MwKLFgJWzOfYh2AgT/0x1DlC+GAkaDR3dJ
 GUIYx6Hy/G0x4sf7LzA==
X-Proofpoint-ORIG-GUID: DQ3z4oRICtR7tX06MAZXzK-6BnbdxcLW
X-Proofpoint-GUID: DQ3z4oRICtR7tX06MAZXzK-6BnbdxcLW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
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

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Modify aura batch free operation in RX fastpath as per
COUNT_EOT bits update in NPA_LF_AURA_BATCH_FREE0 CSR
for cn20k platform.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
Changes in v2: Updated commit message.

 drivers/net/cnxk/cn20k_rx.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index ea8675be00..eed8d59a14 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -112,7 +112,7 @@ nix_sec_flush_meta(uintptr_t laddr, uint16_t lmt_id, uint8_t loff, uintptr_t aur

 	/* Update aura handle */
 	*(uint64_t *)laddr =
-		(((uint64_t)(loff & 0x1) << 32) | roc_npa_aura_handle_to_aura(aura_handle));
+		(((uint64_t)(loff & 0x3) << 32) | roc_npa_aura_handle_to_aura(aura_handle));

 	pa |= ((uint64_t)(loff >> 1) << 4);
 	roc_lmt_submit_steorl(lmt_id, pa);
@@ -1561,7 +1561,7 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 			/* Check if lmtline border is crossed and adjust lnum */
 			if (loff > 15) {
 				/* Update aura handle */
-				*(uint64_t *)(laddr - 8) = (((uint64_t)(15 & 0x1) << 32) |
+				*(uint64_t *)(laddr - 8) = (((uint64_t)(15 & 0x3) << 32) |
 							    roc_npa_aura_handle_to_aura(meta_aura));
 				loff = loff - 15;
 				shft += 3;
@@ -1582,7 +1582,7 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 				uint64_t data = BIT_ULL(48) - 1;

 				/* Update aura handle */
-				*(uint64_t *)(laddr - 8) = (((uint64_t)(loff & 0x1) << 32) |
+				*(uint64_t *)(laddr - 8) = (((uint64_t)(loff & 0x3) << 32) |
 							    roc_npa_aura_handle_to_aura(meta_aura));

 				data = (data & ~(0x7UL << shft)) | (((uint64_t)loff >> 1) << shft);
@@ -1605,7 +1605,7 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c

 		/* Update aura handle */
 		*(uint64_t *)(laddr - 8) =
-			(((uint64_t)(loff & 0x1) << 32) | roc_npa_aura_handle_to_aura(meta_aura));
+			(((uint64_t)(loff & 0x3) << 32) | roc_npa_aura_handle_to_aura(meta_aura));

 		data = (data & ~(0x7UL << shft)) | (((uint64_t)loff >> 1) << shft);

--
2.34.1

