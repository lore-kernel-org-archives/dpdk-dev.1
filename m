Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5096ECD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48FA0406B7;
	Mon, 15 Jun 2026 18:27:13 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3B1CC40693;
 Mon, 15 Jun 2026 18:27:11 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFcCU81075350; Mon, 15 Jun 2026 09:27:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 BJagHbGFSkGDgldARe6ERizNfNY6ZIwLKs1l2rk+ck=; b=feZSIpZ7OOyo8RnfL
 6Zq60ckncVSZgvu2qwWEd9ECDrgIbLk61X4j+DWW2cNEFJreU7xyrctt/zYpAL9/
 OkAMLVpPxByjmQJRBfE+2I9ucVejbWQBE3cWipuYRa/mssL06N1MJT5bn5hu0s0m
 ll4rmhfItz5enUJt0KYQ+moHjiKcYZU2Tw/8r9SoPozhyDHpMv0OOwmhz/NQ8l9v
 lG0KI1wlkKyqfqHUnUhaOy5Yf8edeFIwDY0L73lHTeH0rvwoO/OXp6feJMJSg0Z5
 tWeeOG9URd1Gdd5eaIwZlPsOyyx5hJadNdZANqtdgVJ380ufv4qSMqWeNrOnnxJk
 0U9Yw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qefvkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:27:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:27:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:27:09 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id C639B3F7063;
 Mon, 15 Jun 2026 09:27:05 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 15/20] common/cnxk: add cipher key length check in key set
Date: Mon, 15 Jun 2026 21:54:41 +0530
Message-ID: <20260615162446.578336-15-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VSFp0eeeGVYuJhpGX6lA3uDnV5hxr9be
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfXyGXLQ1M7dqWU
 NWC0lh6ulrAnX6zLNZGQ6n7TBqqLNb77lDMkGgBCC4EBHWlfotcFXEriQEVi0a8/PSl+qoultcv
 wdDdu77f8rWNwBEiNrWaigz1oCuDeXQ=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a3027de cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=iCcN1LmKdQXulA6Z3XIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: VSFp0eeeGVYuJhpGX6lA3uDnV5hxr9be
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX3AcU9XbTTNVu
 ax8j10w3t2feIFZWFMvwu5bZnDzedW8LqeKB8baWfDdsL5Xxr3fTJ1s1sA5Zh5B4SSyEhdxOZd7
 eNCeKcXiNoQQvzJDQ4e4/RIQ7ee4ev9CIlfiMojyU7Wat8CUnReEopoHaHh7ShroEdELqaWQXf5
 prEzRf9v1EVeughp/fOc5AAiOjgGkzeXJMMxxsK3itVamLFxQpqfUooFfKhUWTtb78unEALgRBo
 PuTGHzjgU6mtOlIdjb0mOA0WKA9pVNP2y0uePGxvwA6zFU7tfQpk7VcO14C4L+m5TwKBylGug3c
 uBEZrYrChZRnr/GNob8HpNFsTvz8ySkM74BkmDslDvyIREcn51STr97cOsm0tGMEMl1bFyfQ1BF
 /Sgce+kwirGcIo4Xno/fxPgxHzPxotwraUEEosqfvMdJ5HROs5KAcJQafVGZOb/j8nTbyvBl4KU
 L+Gme2QmcJQACuzz0Qw==
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
Changes in v3: No change.
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

