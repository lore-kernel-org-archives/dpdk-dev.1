Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BECD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CF87427CE;
	Thu, 11 Jun 2026 16:21:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C92CC427CE
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:21:00 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXWVJ2190497 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 NXItnnPXzB/DOjrIjE6p5R6AXlLTKeB8HZjGiOcxJQ=; b=eSNcPViPXMnL1rruD
 yjNincRV8FJ6iiYl5Gf3DxG9fAUrxq1PjF/UzRJuglTVGLSbcvV3VWotw8Cq1ClR
 rPSvYQYm6zzMJhrSEBAVNo/4GeOXMifJSFPc81wDf3yJWfwc7s8Zpxfvc+EEsGYi
 ibjLFzUgIIdz8STA/tQvPdFvt+Y4uTXns6mMtaEmnJx7PZD1PE3hXNqbEQwYzoAJ
 aqnRwuhZS5dHTSqcsbC1tuxqXlzrhliFpWOnsVj78WffyokkwH6YqxCgApd6p3wI
 Py8d7LX0iiVlXPxWF9UvFOShcOKyDlQz4D9nYIn/yjFkSSsmDCENMPuFKmxDxyqT
 g5pTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb7tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:21:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:20:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:20:58 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 0E10C5B6974;
 Thu, 11 Jun 2026 07:20:55 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v2 03/22] common/cnxk: additional NIX SQ ctx fields prints
Date: Thu, 11 Jun 2026 19:50:10 +0530
Message-ID: <20260611142029.3351415-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac44c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=ZpN07vpPjGnXzvhiFWsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: pveiJt1qPINFqM0wlSBiNf4rApX7Y8RX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MyBTYWx0ZWRfX+hr3FuPod5cs
 kkVr5C9K0kJ39/RMgS0K7EqL+WSj/9kfuqGEkYxctysSB2UFhEwC4Lli8jExTtQ6w9kpSliXz3S
 96JCgbvMnnSS3uHyXmyiZUOJGmbMTwI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MyBTYWx0ZWRfX6b/vGuptDpci
 IHDCQtTEm9g8sR+kTxy/WTUiGmp8ZY2Ka+sCc0RkjYQ4NKn/TWeGnmAYsbGuDzJHe+WvdYiOXWK
 sUAYGYBTFo4QlnxN4IywyakxOEMtcBcxgF63YnAKKKJWFs3kGOJdik4ReBKYNcERmN9fR4Ur4Rl
 r7UWHI3De1GtRLG2i9QtpZzJ5xs7zM0B+95Qk6RHh4GyIpfq0Z7o9lQRzEu84WkQ4/S5rEXf5nm
 zZzwWV4xNUg0tPzguNCvW4zXY7fhCefUSCcAjcCSwgxn8iSUHm8KDp6QvQTRRUiyiGKoYGKn78r
 JKA1NAqd74Z9L8jAcszrRSpFr3drms/lSbw27nmCtZX6lpPE0PIuORy681e7S/KKsrzotxFk5fr
 +xM5CG+aVbtKd+zon+SKd90TBm2O5E8KOI1FtG4KUg1DyIgn5XG3sID6/QPXc5duLi6XTbH890r
 kPy/JFGQdE6SeWF8dCQ==
X-Proofpoint-ORIG-GUID: pveiJt1qPINFqM0wlSBiNf4rApX7Y8RX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

