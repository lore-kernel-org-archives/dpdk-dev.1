Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB2DD3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3EED4064C;
	Wed, 28 Jan 2026 07:04:35 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 79D9F40431
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:31 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S0Y9ob190353 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 3AXeglsFZWjv98/w98rGPHzWtzTSuADgfdbKOlNu/Y=; b=Oc/Oteu1O00LxtOko
 xcFY87LCKVNuLSxPE/r2JzkfBefTL5alGJ6Hj15kGjNANCSlDPjJuydnTbqpFFQd
 vlo3pkvAMxBwEWQ6nQEYhUYdLDTDBvcLGCqR6y8u/FCr/+VRvMzi2poJBait7HoE
 DClSmLSZKDvBpNVvGzSzAVxHvvxdyGTGKQOb/6PjXGHz1BGnfNN5UGvXbgu9yqZZ
 dwFaN1jbblE7/2ZfuYcd2sD7xeMabR/SWcxpJP2om3d4NwpJIFF7q3s02aVGa1nb
 CzSQQSbek5tU3Co14+7Uq7EmkGP5SINl6v2NkUJd85fPmyNy2YSQW+tP2VUcltE8
 qdQww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4by80yghgf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:30 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:45 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id DDE4E3F706F;
 Tue, 27 Jan 2026 22:04:27 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>
Subject: [PATCH 11/18] net/cnxk: update aura batch free
Date: Wed, 28 Jan 2026 11:33:09 +0530
Message-ID: <20260128060316.3967610-11-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FYc6BZ+6 c=1 sm=1 tr=0 ts=6979a6ee cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=OATtx_ZI3Iv-yofghcUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfXwGkjprTcmoSR
 ktC6W269XPZgoFSF/PIMVHenO0kLdtYwqz/QV8LGXfeR75w1CtV4aUxEGnK5XDPmcaHlXAMUhH/
 aI0jtY5sN9iaA5ub7ivKjJlamjT2l1lkYKrKaaUnLrt+lDucSB1xH/9yFN2uWaei7VQquRuUUdv
 628sQBv8JA7dJi6qqGu9wUZ2Jg0xQyAO+W2bc5J6H2CdGNnHDC4I125zdGmeEuFdUgKQ4KnQHTF
 6fDSFeTERi13cTQyjIUiQiyz/p60uGP4pmAWzUZVxwTeYrOzrngd/1kgHgv3tp4ra8d2d/fBVb1
 aFQU6AgGC/mKtmBATD0uYoj7QhBWEmCd+qPABeqwL4iNWXwZWV7vcBIRVDA5Ug9v0P5jQKNTXBv
 v7M4ffF+kV1nDpXHpxJ16h9iR2tHFOLKU5Ddoeg0ylDtVuaiXKx9BYbk5na4cIn8IBO+nK3U7mw
 sssG6aR7APOdcUruBoQ==
X-Proofpoint-GUID: AhT-d4IPXqgKf_RhGHtfyE29S4tTIu1T
X-Proofpoint-ORIG-GUID: AhT-d4IPXqgKf_RhGHtfyE29S4tTIu1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Update aura batch free for cn20k fastpath

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
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

