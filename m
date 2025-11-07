Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C36CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 10:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F5F040A80;
	Fri,  7 Nov 2025 11:48:54 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0740940B9B
 for <dev@dpdk.org>; Fri,  7 Nov 2025 11:48:52 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A75X6gM1492965; Fri, 7 Nov 2025 02:48:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 b+9WrZBgxBOMzD6AbKLYpefMk51FkimcADca2jGqGs=; b=lI+Mz0BugFuGlmgOj
 oHxZTan1ewu0SHGCXuY5BRzYKLxBNYPlCvzttmVZ5k41WD+h7p/9ePyNm+RrYAX7
 rhdw/K0Vx3u1HUFxTPXmvAEd52hkdClxalzqotzNCxow/MkoGa2euYt4e8KD3362
 kSD74h79stiCknkLqRB17HtdCAUH3+3GbhhuzDpHK+7KP+43g5b+zRxawvYCUmIV
 w+IEAwWDnYM9FNwwKdDd99JO9iO7y1Kwk6LcORQiqVnGsS75KbJ90IAjaHHIG65x
 d2I49Gget1WR56ACd5qxJVrocPZjVKtF7vzi78u7MbgHm3gKNPhzcAFV5xRptoZm
 LUpxg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9aqkgvsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 02:48:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 7 Nov 2025 02:49:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 7 Nov 2025 02:49:02 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 803763F70C7;
 Fri,  7 Nov 2025 02:48:48 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Aarnav JP <ajp@marvell.com>
Subject: [PATCH v4 19/23] common/cnxk: fix format specifier for bandwidth
 profile ID
Date: Fri, 7 Nov 2025 16:17:43 +0530
Message-ID: <20251107104747.1131008-19-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107104747.1131008-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251107104747.1131008-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XvD3+FF9 c=1 sm=1 tr=0 ts=690dce94 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=02K0Y2VpAAAA:8
 a=yBKhqCqsAAAA:8 a=20KFwNOVAAAA:8 a=z1O4CprIpd04LJALuYwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=SVpKTQGeYiyENV88YW8K:22 a=u5H4eTi2zCHWd_3L5ZMT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX/ZFJAS6uVa0l
 M4nf/qPvjVLA+kRx8Qqc6KC+sdgfYXqwcg6NZ19vEsdvpMtzSZznx657N5QKtfQMjTE9pgPh6Wz
 DDscq2fMt10zSGCEwdJ5NaCrC0cI0f3EacIql9DYkEuogOqZSLnK4HigkgGJOUPghTXYH6LG++l
 7WelkNPhm0aLuFIxzYMP4FlvVfOHVrcQtCbhfxSlRJD5NBT7tj4eAjZVIuRkOrBNGckdSFAPk/5
 HeR/N0uU7P8bNwiijZEXFFLCwmbHjlTKt+u0syZjF9665xknAttYIqhdZW6nyq0JQoq2NVych1z
 7PeiPw/srwJQeTfZEwwASRXk38IRuHbZCwREzvK2X6L1L5X+lwXA2c3+MZmONtwG8muh0293/Eo
 cON3HVQhQAsOlVc3gwanbNQnYIfp9Q==
X-Proofpoint-ORIG-GUID: KuQH4otjpkoxtQbUSBRI0gTGeHzAzGi6
X-Proofpoint-GUID: KuQH4otjpkoxtQbUSBRI0gTGeHzAzGi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
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

