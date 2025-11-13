Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8611BCD4F2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 04:40:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF8C940ED0;
	Thu, 13 Nov 2025 05:40:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6036140E3A
 for <dev@dpdk.org>; Thu, 13 Nov 2025 05:40:00 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD2diZQ203421; Wed, 12 Nov 2025 20:39:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 b+9WrZBgxBOMzD6AbKLYpefMk51FkimcADca2jGqGs=; b=j83x/1PLkISOli4oX
 DGXdLtGk069c/zZcOr9rnT/K46w7lF3/M/LXZcvS3KLAYPY+R827SB0p49eECDn2
 owDMsQ5WtvLDrMinrH6/v00Mb/EpKdJC7Wbh6ksaA3q8q3gD91LYbbPJvbudduIR
 s9SYMbDUox4M8CGUg06C5LFbNTQr4WPM62TfbDn2YFJ0ZL15EBLzhgi3lv8SMRfW
 nW8meG5vwGSU754VXCe5SmT5e1fs29FSoAx5kwQ/ZzExgS2j7GGm6eRLuVtK7iIN
 qtiQ/cnHtP8VwC1MqAXNTSus0Pjzz3HGwjQOy9xHI4HKidb0fLidsT/pUIbc1cLr
 1wU6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ad6r6g6n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 20:39:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 20:40:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 20:40:09 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 603B03F7076;
 Wed, 12 Nov 2025 20:39:55 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v5 19/23] common/cnxk: fix format specifier for bandwidth
 profile ID
Date: Thu, 13 Nov 2025 10:08:04 +0530
Message-ID: <20251113043808.1180851-19-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113043808.1180851-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ePp4s9AOrgpG5DTWB7E3OOy-LJKyGkeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDAyOCBTYWx0ZWRfXxZVMVEv4Hvmx
 jK3YFL9JMroSu7gUz8IFIDSsWpCQc7acofLJYhhLcSzMKIRNTmian2+bXuHoihpb8mr76LzSgOm
 Z4NxGz1IsDTVwkm+ZuFFb55s4u6EOUvZbyseYlzcGD/38XIob9QZcn2ZbJjSx8cT70kIngRsxid
 pXGqVgdhB+QM3xP+m0r3cLaWxtxABSy6lqEtH8uMp1jNtla4ubgaOlT4FnVVPABB86M4EKbkkkA
 7YyvhbgA8bYGfQ+Tf3aOmN9tlk6MUil3Dd/GK03g5MXbl2DYwgBwOtJ0+lixSkFwwo2/imC8Gck
 pYForurG5t6ramqo4iobWKmeeVEoxl2n6aEErd/nFpoQs8tJLLcelhS/ZEuqEvnQ1hQr6OQxAaR
 FqjJn4OTy3FH6qJGw0xqEjV4YPaXcA==
X-Proofpoint-ORIG-GUID: ePp4s9AOrgpG5DTWB7E3OOy-LJKyGkeT
X-Authority-Analysis: v=2.4 cv=Ic+KmGqa c=1 sm=1 tr=0 ts=6915611f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=02K0Y2VpAAAA:8
 a=yBKhqCqsAAAA:8 a=20KFwNOVAAAA:8 a=z1O4CprIpd04LJALuYwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=SVpKTQGeYiyENV88YW8K:22 a=u5H4eTi2zCHWd_3L5ZMT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Fix format specifier for bandwidth profile ID.

Fixes: db5744d3cd23 ("common/cnxk: support NIX debug for CN20K")

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
 .mailmap                            | 1 +
 drivers/common/cnxk/roc_nix_debug.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 10c37a97a6..46053e419c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,4 +1,5 @@
 Aakash Sasidharan <asasidharan@marvell.com>
+Aarnav JP <ajp@marvell.com>
 Aaro Koskinen <aaro.koskinen@nsn.com>
 Aaron Campbell <aaron@arbor.net>
 Aaron Conole <aconole@redhat.com>
diff --git a/drivers/common/cnxk/roc_nix_debug.c b/drivers/common/cnxk/roc_nix_debug.c
index f9294e693b..11994bf131 100644
--- a/drivers/common/cnxk/roc_nix_debug.c
+++ b/drivers/common/cnxk/roc_nix_debug.c
@@ -769,8 +769,8 @@ nix_lf_rq_dump(__io struct nix_cn20k_rq_ctx_s *ctx, FILE *file)
 
 	nix_dump(file, "W2: xqe_hdr_split \t\t%d\nW2: xqe_imm_copy \t\t%d",
 		 ctx->xqe_hdr_split, ctx->xqe_imm_copy);
-	nix_dump(file, "W2: band_prof_id\t\t%d\n",
-		 ((ctx->band_prof_id_h << 10) | ctx->band_prof_id_l));
+	nix_dump(file, "W2: band_prof_id\t\t0x%" PRIx64 "\n",
+		 (uint64_t)((ctx->band_prof_id_h << 10) | ctx->band_prof_id_l));
 	nix_dump(file, "W2: xqe_imm_size \t\t%d\nW2: later_skip \t\t\t%d",
 		 ctx->xqe_imm_size, ctx->later_skip);
 	nix_dump(file, "W2: sso_bp_ena\t\t%d\n", ctx->sso_bp_ena);
-- 
2.34.1

