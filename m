Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37102C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 04:01:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 946164066E;
	Tue, 27 May 2025 06:00:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E83CE40669
 for <dev@dpdk.org>; Tue, 27 May 2025 06:00:49 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNUDr6005432
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 ID+OeGZtbNNevou5zbNsxCA7KEHchVTlFMK3cj/PTc=; b=Nr8zSsym6OSBhTS+Y
 Sq2IYmGsqn2xQ74reQEY+IswnfnbBVzE7FkMgH21+Qf2fOt7CIqrDap9UeqtLOp6
 nCej84kRQp0jREEVWu6GPguB3xt5EfG8rC2Ba01cgzUOl4FCFjEKIkDFn9/5zJ2Y
 hKci/kcczjKe3BMAlnOVokxd4SWWWibspOkOKMjoFBqubTZUDaE9pd6xgG5A/Ivb
 09mdEBd5iKk6f2wpOk6Y4cOCwYEWV0EIxn2cO2MMHBu7I2r8LS/pauXZY03vEh6J
 8FWBNDZtQ4NMbIg4OzPzoVhGidl/BRvQHLJfv70bGuQOpeA9Q9OF6SGViTJWfm5q
 /l0Gg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w2148buh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 21:00:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 21:00:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 21:00:47 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 953925B6922;
 Mon, 26 May 2025 21:00:45 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 3/6] crypto/cnxk: fix qp stats PMD API
Date: Tue, 27 May 2025 09:30:33 +0530
Message-ID: <20250527040036.2280893-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527040036.2280893-1-ktejasree@marvell.com>
References: <20250527040036.2280893-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ozX5dBKf67YKzBux23X_Pbf2LKDTyYrY
X-Authority-Analysis: v=2.4 cv=a+gw9VSF c=1 sm=1 tr=0 ts=683538f1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=awJWYGnfD9vRpg5u9u8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ozX5dBKf67YKzBux23X_Pbf2LKDTyYrY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAyOSBTYWx0ZWRfXx+wci7aw2fbY
 Mv6QudK0XxnpQrDzoKzCAFoBXBDbmTcA22XQTAlRUUnAdxo++IAC0DnI2Sj1Aw5uqR74RYyVDb+
 KT3PtRBada3N6QzI9rAMXLVld6uyyHZ5a62h384Sm89vX6EF6Z74wD8qGeXMIfSJMvVCMPE3KgG
 VtlI4jLMmQ1AYdwpJePsR8vGltzfMxDVkl+GTSE/c7gpvW9b8kgK2r7FBdssDfBhSiBSsRlq4kF
 AKhZSob4COKQDbjI7QGThbm3Mx6shBkCQx4n0k2ml0yKQhTlfSvq01FwNlTZGcdOFQVG9vxOlX6
 Qf2KQ4pVzn02jv0kLF77ZKpoaZ1tQlyVOhSAL3dqPtRG/FeVGDkRjCDwdkfTgWcSYBfNGqHhOIm
 Xmg1huigGtStovI4o86eNhquXnQF2YNFLPjCtB5Qzl6uAIbbgbJDYrfd0UlOhQVJHvzsbFG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

Fixing qp stats PMD API.

Fixes: bf52722b9377 ("crypto/cnxk: add PMD API to get queue stats")

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 613ce11ec1..61f3e135aa 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -1218,7 +1218,7 @@ rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 
 	stats->ctx_enc_pkts = plt_read64(lf->rbase + CPT_LF_CTX_ENC_PKT_CNT);
 	stats->ctx_enc_bytes = plt_read64(lf->rbase + CPT_LF_CTX_ENC_BYTE_CNT);
-	stats->ctx_dec_bytes = plt_read64(lf->rbase + CPT_LF_CTX_DEC_BYTE_CNT);
+	stats->ctx_dec_pkts = plt_read64(lf->rbase + CPT_LF_CTX_DEC_PKT_CNT);
 	stats->ctx_dec_bytes = plt_read64(lf->rbase + CPT_LF_CTX_DEC_BYTE_CNT);
 
 	return 0;
-- 
2.25.1

