Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB2CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB454327A;
	Thu, 11 Jun 2026 16:22:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8E1A8427D0;
 Thu, 11 Jun 2026 16:21:58 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXVH62190487; Thu, 11 Jun 2026 07:21:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 0W91uR4RII5eTpoNLemfr2OcpYYjz1nrHZX6JTHqFQ=; b=JhxYYKm4f1zAhG3AN
 WRO4tG+mYZMqQWecgJzxEBgrdgPfSaHRJGSiJyw2+gCCm3ZV2VyWhW2zAb97XF9m
 f8EHVeH36QTeK8iFQ0iVMu7/nRMcGItGkYMl30I38qGEWW0U3/2lX324ZBorUxpn
 SANO6wUacKW8PGJ8Q87fSp1W3uaE224YB5IHVmcO6wZ6RHu/vLh8S4++qNO3Vth5
 6E/BM0DyL9Mk7nFF3innUwAvqRWGhd1AGwHpb8GbCEzWEi3pyxk9AHca7ddYbHBK
 Z+AOjUGipZCDRtmEQb6eSE5pSiHMjwFgNsKS1Nm3GfE/SeYgp5x/GkVkESD3YjWf
 wYkCQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb80q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:21:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:21:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:21:56 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id D28015B6976;
 Thu, 11 Jun 2026 07:21:52 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Akhil Goyal
 <gakhil@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 15/22] common/cnxk: add cipher key length check in key set
Date: Thu, 11 Jun 2026 19:50:22 +0530
Message-ID: <20260611142029.3351415-15-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac485 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=iCcN1LmKdQXulA6Z3XIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: -jFx4M9GwD33ifuEDAfw1WAPz9YBTeG4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXxHSVIlB9LyV4
 FW8jJMJLz0onfS6Sl9L8uSvRLCQU3ERfoBLWuFdumuL6jmSQGaaI3j3EvSycm/l6zx88Z/nHWQN
 iH3XEtFQZnn3XW9t8sINnQUlEg8TydU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX/cI50oMzQBD+
 x47EYyIs+eQ3ARaC08pvcNezXTSnEypb0ryRvHAcJVdwQoG517GueM7TCGbsih6E5cAt4l757y3
 C+sQi9ylP1RK+NQUVlQ9MUhTL/cqBbhHZ8Z6wRfhGiCc+RL+eei6teFK28qn6rDzFaBZp8wZtZ4
 Z1aAwaSirV+ZBFxwRVmWYIv7z0cTT6twn16YJ3BvbYthRzjxiSlLeWwptTfHg7AWAnm0Ml/XWMk
 Jsu4irzg6BqIfw9eqV+Ssih8axfVGSLtHNmPhivS2gdNiIaS0Yhr5ZIPVUcBnS9PlXAytB+fJvC
 XO7DXBUZi1iXWq5IHf8FcCNHkoZKTJKKZBiadpRuu2UpGCKfMvOGSXsE0mMT7HUtHYjvR+wPfMn
 Gi9t9czRblSlKxWYiA9q1C+IKO32k1IKW/VSviEF0sPx1x0oCmlCIMHseXU8dK6v0cs3faNpXcJ
 Kj43cf0Dz/f2ATGNPhQ==
X-Proofpoint-ORIG-GUID: -jFx4M9GwD33ifuEDAfw1WAPz9YBTeG4
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

From: Aarnav JP <ajp@marvell.com>

Add upper-bound checks before memcpy into encr_key[32]
in roc_se_ciph_key_set() to prevent buffer overflow into
adjacent encr_iv[16]. Covers all write paths including
AES-DOCSISBPI and DES-DOCSISBPI branches that bypass
the generic copy via goto.

Fixes: 5e076b609f2a ("common/cnxk: add SE set key for crypto")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v2: No change.

 drivers/common/cnxk/roc_se.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
index d841a926a4..1cec536169 100644
--- a/drivers/common/cnxk/roc_se.c
+++ b/drivers/common/cnxk/roc_se.c
@@ -545,12 +545,22 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 		 * less than 128. Pass it as regular AES-CBC cipher to CPT, but keep type in
 		 * se_ctx as AES_DOCSISBPI to skip block size checks in instruction preparation.
 		 */
+		if (key_len > sizeof(fctx->enc.encr_key)) {
+			plt_err("Cipher key length %u exceeds max %zu", key_len,
+				sizeof(fctx->enc.encr_key));
+			return -1;
+		}
 		cpt_ciph_aes_key_type_set(fctx, key_len);
 		fctx->enc.enc_cipher = ROC_SE_AES_CBC;
 		memcpy(fctx->enc.encr_key, key, key_len);
 		goto success;
 	case ROC_SE_DES_DOCSISBPI:
 		/* See case ROC_SE_DES3_CBC: for explanation */
+		if (key_len * 3 > sizeof(fctx->enc.encr_key)) {
+			plt_err("DES-DOCSISBPI key length %u exceeds max %zu", key_len,
+				sizeof(fctx->enc.encr_key) / 3);
+			return -1;
+		}
 		for (i = 0; i < 3; i++)
 			memcpy(fctx->enc.encr_key + key_len * i, key, key_len);
 		/*
@@ -628,6 +638,11 @@ roc_se_ciph_key_set(struct roc_se_ctx *se_ctx, roc_se_cipher_type type, const ui
 	if (se_ctx->hash_type != ROC_SE_GMAC_TYPE)
 		fctx->enc.enc_cipher = type;

+	if (key_len > sizeof(fctx->enc.encr_key)) {
+		plt_err("Cipher key length %u exceeds max %zu", key_len,
+			sizeof(fctx->enc.encr_key));
+		return -1;
+	}
 	memcpy(fctx->enc.encr_key, key, key_len);

 success:
--
2.34.1

