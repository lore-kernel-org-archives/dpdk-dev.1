Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FE2CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 07:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79DEF40611;
	Mon, 13 Oct 2025 09:00:13 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AA7E840611;
 Mon, 13 Oct 2025 09:00:11 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNj19I030341;
 Mon, 13 Oct 2025 00:00:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 I4Ox9OPjGLqq3QjLNxBHAN+zVij0kUv+UoF7xBpZE0=; b=bD1UyO29hdwuVic6T
 4avoDtFNWk1ITKWuMPJHUdfzZCbwn2PYypQbNwpiUC18PbzpkaaVzCJR1npzjEBD
 Z7wZ5CeetlskUKbFMAwkpVts8hvB7g2xRSz2ZhwLry2br4BGBDNkzaw90Y/eu4J0
 92TDSEdUpPeNqc7n02az4zzHi7aKfHen+X2+1yohWkyXNjwXP77TrG8IjY4KaINs
 svARmhah5eg1BujriigzZ8ylVurpmkA1Yf8CPDZKEhJDQYnWoLUWjZrKT1hwPduL
 6G6bw95R973nd5ImRgC635DXIyVNNxjp7vVWY2zQoAVYn6sLFVtTE1hAZAymCwDG
 9l2lg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49r8069fec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 00:00:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Oct 2025 00:00:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Oct 2025 00:00:21 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 0FC703F70C0;
 Mon, 13 Oct 2025 00:00:06 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <dev@dpdk.org>, Monendra Singh Kushwaha
 <kmonendra@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 05/19] common/cnxk: fix inline device API
Date: Mon, 13 Oct 2025 12:29:35 +0530
Message-ID: <20251013065949.200414-5-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013065949.200414-1-ndabilpuram@marvell.com>
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251013065949.200414-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=68eca37a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=a_7jAOaszgFUf3AtnaMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: loIWNPsrwZATpX8JzMAHzNEpImAi6Yji
X-Proofpoint-GUID: loIWNPsrwZATpX8JzMAHzNEpImAi6Yji
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA0MCBTYWx0ZWRfXxSf76vE1dSgd
 xvSNTo8RS/tayr1njmZCO1BA0YjMesaWIhoPHDzbYTdmm7ttAx4XRsvvarFRa9mYfRTayQBRqw9
 xhmaFFnrDT9/YWhiMycMgEJAwp9dt/MQdCRa1EdMQ7PLRjL908QCRTggMep+c4fCwK8ZbZ4HtWD
 dWbTRlCgzY1A3/Kz5K/tMHyPoTQT6m2z06FOm4ywRrylqatLVgP/0zq11khsD7gBheIAi0uBGWZ
 jZsddOMod3Dsk7UtUUtmQVHy/+SpanYqsPVV36aR5h78YLdwyhPyO82Bi1W2IA4jgLhsZtZUuBy
 6wnC3NURiRHRblPww1FQV/DbSdbI7pNeYyGBs5a0OZWt9Hb1tqZannHOr9rRwff8ELfe1AN+g+r
 ljFSinxDhCQpLCRL5Pjkw0ryeX0zSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
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

From: Monendra Singh Kushwaha <kmonendra@marvell.com>

This patch fixes the inline device functions to work
when roc_nix is NULL.

Fixes: f81ee7133b48 ("common/cnxk: support inline SA context invalidate")
Cc: stable@dpdk.org

Signed-off-by: Monendra Singh Kushwaha <kmonendra@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index c7637ddbdc..a5fc33b5c9 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -2324,7 +2324,7 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void *sa_dptr, void *sa_cptr,
 	if (outb_lf == NULL)
 		goto exit;
 
-	if (roc_model_is_cn10k() || roc_nix->use_write_sa) {
+	if (roc_model_is_cn10k() || (roc_nix && roc_nix->use_write_sa)) {
 		rbase = outb_lf->rbase;
 		flush.u = 0;
 
-- 
2.34.1

