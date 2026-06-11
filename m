Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33642CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:33:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2972E42EDB;
	Thu, 11 Jun 2026 09:33:42 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 624C342ED6
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:33:40 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0QWHK757722 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 zwWKAokVQIdouoH1ybMVdG3s3kWvnOoRZn+Gx8F5u0=; b=LfnVAMNOh51WjrAQ6
 kvuMgy+Eg8VTfBVR8PGy/PMmE3fVa/FT6a1AgwCObhA4yWbJlM8pckOtlu/j9aKN
 o7CSHzEtv/Er/Ok0BrURgJfVeSBvPKlmma7iQ0CP5YznKr6nUtm0e+xp8JYwoHzc
 lpkh5jK9TVSJkWe2R4210EYCIgk0FLcUg7zAxKW3+lk5krtcmqwEL8C/KVyOvmSw
 TUMjKzW51VqdRCuc6L6ZxuTslj7J5VkM+uKhdL5u2Duc3KrXWAA/C0vL3zS+AZJr
 Hbj3YS9bvwnXRYU31lhNBgirFmFIQej+BhdctawJnP+i5GD6anzNwm3f5Z/b4eky
 hDl4Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w1xpe-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 11 Jun 2026 00:33:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:33:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:33:37 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id D23DC5B6973;
 Thu, 11 Jun 2026 00:33:34 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 03/17] common/cnxk: additional NIX SQ ctx fields prints
Date: Thu, 11 Jun 2026 13:02:57 +0530
Message-ID: <20260611073311.3129711-3-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX9Bi+MUO7GdoS
 Cco9DKKVaLPas3ivKsM+pfw0xRwczy2huM8NVk+1zaVtGsgKL5GezkDSwemru/5TCyjQZuD4qXD
 iTrDfr7NLPeZyyKeoystuA3/b2brFRRkqtFTAoiEuVBX4fKGQriSfTk36HT0/gOuqS1FdxnLM4l
 V2aFnOnQ9+YbIpjk2f2Bnw0txxYtPZwc28onn/9o/L6Wesz1pzV8Txe4dqBsj3RP1p5UneuSkVq
 p57tIwG8oPHTE/FQ/5JHnAKjOQMSpgBfT1WN6VfRhet6ozPlnhIEFzwYs2O5zWh1vdlmv5OHc2r
 DxHCp+qrMVbe2rgOvA0Jaw4h+FO8qBIQWrzX9kIr6Zj/4t5b5VNDw/2IWd1ErcNNyj2D/2S3/qk
 Jzu5NOIVhj2IXRqUxd54gl6x4PuV71WJIjn5NMqYv1OysUmLVXK+HxrMUv7axabc6VjBWaRcY6F
 QmJzoEtEbFt7bNhCNSw==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2a64d3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=ZpN07vpPjGnXzvhiFWsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX2dkAS+4HH7ep
 E8ktvS+lK7//wCc2l6TR53VoFKcNBmfP9UdgD8zMZqVfwJ192x+hjfRszsqzjoHiWjedCD6vHlv
 Oy2Uy4/2plLNUN6KHjM3BOfNn+XX5oQ=
X-Proofpoint-GUID: hBInXoJnBhJO_Di6-jp0AUt9_YqGTSh4
X-Proofpoint-ORIG-GUID: hBInXoJnBhJO_Di6-jp0AUt9_YqGTSh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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
 drivers/common/cnxk/roc_nix_debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index 11994bf131..07a18d4503 100644
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
@@ -588,6 +591,11 @@ nix_lf_sq_dump(__io struct nix_cn20k_sq_ctx_s *ctx, uint32_t *sqb_aura_p, FILE *
 		 ctx->vfi_lso_sizem1);
 	nix_dump(file, "W9: vfi_lso_total\t\t%d", ctx->vfi_lso_total);
 
+	nix_dump(file, "W10: sq_count_iova \t\t0x%" PRIx64 "", (uint64_t)ctx->sq_count_iova);
+	sq_cnt_ptr = (int64_t *)(uintptr_t)(ctx->sq_count_iova << 3);
+	if (sq_cnt_ptr && ctx->update_sq_count)
+		nix_dump(file, "sq_count value \t\t0x%" PRIx64 "",
+			 plt_atomic_load_explicit(sq_cnt_ptr, plt_memory_order_relaxed));
 	nix_dump(file, "W10: scm_lso_rem \t\t0x%" PRIx64 "", (uint64_t)ctx->scm_lso_rem);
 	nix_dump(file, "W11: octs \t\t\t0x%" PRIx64 "", (uint64_t)ctx->octs);
 	nix_dump(file, "W12: pkts \t\t\t0x%" PRIx64 "", (uint64_t)ctx->pkts);
-- 
2.34.1

