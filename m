Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8201CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5944066E;
	Mon, 15 Jun 2026 18:26:08 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5D8A3400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 18:26:08 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbMIn279834 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 oluJBYdeOuPyFhVQz5OsC4BZayM7iDdUh8JGzcIP6A=; b=FsB0okUhFhLNBChwL
 nJ0dQzES82c2x1Xp6ZHwgsqHnkcWK0NOn9XXF635S/qwmLBs6wByXbkoj961etg4
 XRQwT2U6hCHTXBDnzWySQxpZ1zV8IEOOP9H4TBdL/SjcA1pr5Es37tyHhe+hXYR2
 EnLIOdLd9He8FR38fThvLR6vspaMt5UBCNyulmqWYcJrzrJJQQP5HCOtHzpnHshv
 cIBHUjjq8Rf31Sh3qDYk/0PJttsMHYXl5DTynW7fJN/qGY3Z1hlFdi6D2paUhgYD
 vAliJh7FCeOAnUJTJBu4Ll2gneMLi/PW1GQWdfrfixvyJHFXv9DfIFC9K5dh7FGr
 NMsMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8vpgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:26:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:26:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:26:06 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7536B3F7063;
 Mon, 15 Jun 2026 09:26:03 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 03/20] common/cnxk: additional NIX SQ ctx fields prints
Date: Mon, 15 Jun 2026 21:54:29 +0530
Message-ID: <20260615162446.578336-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfXygBlciaHMa63
 MA4KNmuRAA9GQIciDrnoeilauD9GztHcMaPGPIyj6gQz7rz1MDT/2U410yePQbsPQ2sOhKU7+ve
 NXcIhmV9Z10mrhQZHDxmH4FWeIm+dI0yacrCg0TP8YFNpzrHGPd79dSRNyl7NR+n1X0UxTbLE3I
 huoGU+SsdhmY+IRt66vWDJBW4FJdpWk13nmFrUUBjF/BY6bBf4qmOr15xUdl+Q2eO3SMyP/LqvP
 qUxFojX/YYuFQuoIfG+q18b4bsyIgn+WiQutQLpi0hpB7GfJTrMkfaXOB2907SIfT2nr3n2bYdQ
 gfDTauvyKlpGQTE3nZMCEKqwmHCcNmX/JUmLt6oj38e9DI/7zQthCEmy+81CwpmR2ZXky+1FSFR
 vzRS1+ij/AySivai1IGqyl6IMFoE1X9IWj5/yIgF+d9koRWXknEXB1d8xAUoOyCl+cQB5yaNdua
 UyN1jOB41VYp+DQl8SA==
X-Proofpoint-ORIG-GUID: UqkTSmCZJSQT0X3mc8uOfpLsRxlE4dby
X-Proofpoint-GUID: UqkTSmCZJSQT0X3mc8uOfpLsRxlE4dby
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a30279f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ZpN07vpPjGnXzvhiFWsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX5jC0diKAp96Q
 WtRtXX5+/V/dkY21njmuOeeAY2wyXLRY72bR/qy+zdrlSPjXazt4a4DaM1D4QnCIsPzZSgT5HCv
 7gYmcyuvtHtFycfZCrzm+ZfqCmTRJ/0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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

Additional debug prints for CN20k NIX SQ ctx dump

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
Changes in v3: No change.
Changes in v2: fix ubuntu clang stdatmoic compile failure.

 drivers/common/cnxk/roc_nix_debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index 11994bf131..d4b2b86916 100644
--- a/drivers/common/cnxk/roc_nix_debug.c
+++ b/drivers/common/cnxk/roc_nix_debug.c
@@ -540,6 +540,8 @@ nix_cn10k_lf_sq_dump(__io struct nix_cn10k_sq_ctx_s *ctx, uint32_t *sqb_aura_p,
 static inline void
 nix_lf_sq_dump(__io struct nix_cn20k_sq_ctx_s *ctx, uint32_t *sqb_aura_p, FILE *file)
 {
+	int64_t *sq_cnt_ptr = NULL;
+
 	nix_dump(file, "W0: sqe_way_mask \t\t%d\nW0: cq \t\t\t\t%d",
 		 ctx->sqe_way_mask, ctx->cq);
 	nix_dump(file, "W0: sdp_mcast \t\t\t%d\nW0: substream \t\t\t0x%03x",
@@ -561,6 +563,7 @@ nix_lf_sq_dump(__io struct nix_cn20k_sq_ctx_s *ctx, uint32_t *sqb_aura_p, FILE *
 	nix_dump(file, "W2: smq_rr_count[ub:lb] \t\t%x:%x\n", ctx->smq_rr_count_ub,
 		 ctx->smq_rr_count_lb);

+	nix_dump(file, "W3: update_sq_count\t\t%d\n", ctx->update_sq_count);
 	nix_dump(file, "W3: smq_next_sq_vld\t\t%d\nW3: smq_pend\t\t\t%d",
 		 ctx->smq_next_sq_vld, ctx->smq_pend);
 	nix_dump(file, "W3: smenq_next_sqb_vld  \t%d\nW3: head_offset\t\t\t%d",
@@ -588,6 +591,12 @@ nix_lf_sq_dump(__io struct nix_cn20k_sq_ctx_s *ctx, uint32_t *sqb_aura_p, FILE *
 		 ctx->vfi_lso_sizem1);
 	nix_dump(file, "W9: vfi_lso_total\t\t%d", ctx->vfi_lso_total);

+	nix_dump(file, "W10: sq_count_iova \t\t0x%" PRIx64 "", (uint64_t)ctx->sq_count_iova);
+	sq_cnt_ptr = (int64_t *)(uintptr_t)(ctx->sq_count_iova << 3);
+	if (sq_cnt_ptr && ctx->update_sq_count)
+		nix_dump(file, "sq_count value \t\t0x%" PRIx64 "",
+			 plt_atomic_load_explicit((uint64_t __plt_atomic *)sq_cnt_ptr,
+						  plt_memory_order_relaxed));
 	nix_dump(file, "W10: scm_lso_rem \t\t0x%" PRIx64 "", (uint64_t)ctx->scm_lso_rem);
 	nix_dump(file, "W11: octs \t\t\t0x%" PRIx64 "", (uint64_t)ctx->octs);
 	nix_dump(file, "W12: pkts \t\t\t0x%" PRIx64 "", (uint64_t)ctx->pkts);
--
2.34.1

