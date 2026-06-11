Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C4CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C48B642EFD;
	Thu, 11 Jun 2026 09:34:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 68C7D42EF3;
 Thu, 11 Jun 2026 09:34:36 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0QiBk856212; Thu, 11 Jun 2026 00:34:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 gTDYmjAXbAWHopvJkFcz1LbmrDvA8HrbgalvwUQW/Q=; b=G1eqrSP0bAdISXok9
 ALZrO3W1OZRSnjL2k31MmgZksDPJ9qGQqsLZdv6YdH+tIlVY1RlF94+R3OCG7m0m
 TvXHJT/C0nWlDJj36aU16S88BPEZ1CgmXvFfnq+HwuVqUjsA7V0Iv5tXFkwoZJSE
 U7GprGIUsr5o2MBFF7x+BO2Rdp3oP1/zL89pfMy/yWH+oPzN9gms80ElwBZ/pYfz
 LxvBi551IokmQwMGffRga9LUuWozlojkdwrSaQk2G9n+boiX35KE2PkLW6oP8/dc
 vn2UoCrNTs9Gzb35gER1R2r5VTOWdrayFhHbkIeuIjoG4yaEos53iF/cFbjRsgxe
 4cOFw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r9ydt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 00:34:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:34:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:34:35 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 7F89E5B6973;
 Thu, 11 Jun 2026 00:34:31 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 15/17] common/cnxk: add cipher key length check in key set
Date: Thu, 11 Jun 2026 13:03:09 +0530
Message-ID: <20260611073311.3129711-15-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2a650b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=iCcN1LmKdQXulA6Z3XIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: EHwCYxnPLrn9ZPl2xmqWg0S7U_QfNqLX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX5huwhyswqvOt
 FY2qD2mcPUJVQi4AzIZqmoJv1fHfJn59L2zhCnEQtawpBjU8f0CjWS28ap84WQU0sinJNL+Iu9W
 +dchn6UenuHBQJ4MjbRMBICfLemfAuY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX07LTHfT9XXyn
 D+RK9GiX7tohwOdhGxLnpJvTZO6p/nOXMbAVUQWtOX7pDua8jEMCRHueUkZtw6VY29qaxaVFuYX
 TdGAI/zUZiN561bEFgXk0sUz6hkXU/ET5eSaK8y2kvTdKrqT9bGwz9P5uTBYHyt4qfgrJCAfnWX
 tS0MlIi1KooqD0ZR4p/jWhdzg7lQXyCkGpHtMVbHcXmm0Y5ZQtWDIKDbBe1nr3paQHex0PiFt9p
 pD1wFrwjgR69HoVYorHdRc+F4ZWmTP7HYjRLNgbO5sqXpGZQiWoOzFx0F/yi1YT5sygS1NdAHnP
 hgTrL6gJXx/eqT0YBJBOJxz3c1zEZ3YvFc5b3W1ZBNjbEymRHaPLFgoan+/uRrvBFJ4EYdwMI0b
 QzHy2/9M60n0vy1yY+Zhqf6j3owC3iJgSAv1VJtljdSgEw8QDbn8OCz00YRb0JpHCGCg9BOx+Pl
 DEnCMPTAsykpOlCUaVg==
X-Proofpoint-ORIG-GUID: EHwCYxnPLrn9ZPl2xmqWg0S7U_QfNqLX
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

