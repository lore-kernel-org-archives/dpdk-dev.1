Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B4C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 13:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8CFD42DC1;
	Fri,  7 Feb 2025 14:45:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0B51742DBE
 for <dev@dpdk.org>; Fri,  7 Feb 2025 14:45:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517AkLIb011482;
 Fri, 7 Feb 2025 05:45:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=o088O69SIGKnq3liK80FGV5
 gzHXWHtX4D0i7Ni4yXxM=; b=WnMvHok4Y4jeFZc2+x0TJcBEVmsxRYxD5Rne7fH
 U8o7d1wYlF1oBgVNWjefLLsXAm08mssTv/JZIT84VBPx2x9DIhvqaFH0FxxRyVdQ
 SOyv6G+IURC51zPh+acqh1GYwIukshzzkxRZLb6SZ5OYkBR1JFKtImSyrdHMgzh/
 TZbIwKFXSxkVb0KM4Dic1LJFfskPWbP7NmrFLNUrpf/pTolmGSyvLkeb0OkWjqtT
 nyLkf571HJ7kyoBn787q5p3dKERjj75GbjWRZpcQ8QJlfsiFvXkwP5/kcc96MpU9
 of5cUjfxwtF9ipnb43pFLj3knJGVgqqbw4OZg7ib0Nu7RFQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44ngqeg9ft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Feb 2025 05:45:50 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 7 Feb 2025 05:45:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 7 Feb 2025 05:45:49 -0800
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 277BB3F706D;
 Fri,  7 Feb 2025 05:45:46 -0800 (PST)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH] examples/ipsec-secgw: fix iv len in ctr 192/256
Date: Fri, 7 Feb 2025 13:45:43 +0000
Message-ID: <20250207134545.63820-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6DvZR5ZOmeHrDFZi-PK_vIgxujhcnEJO
X-Proofpoint-GUID: 6DvZR5ZOmeHrDFZi-PK_vIgxujhcnEJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
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

This patch fixes IV length to 8 in case of AES-CTR 192/256.

Fixes: 9413c3901f31 ("examples/ipsec-secgw: support additional algorithms")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 examples/ipsec-secgw/sa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/ipsec-secgw/sa.c b/examples/ipsec-secgw/sa.c
index 425bfbf590..313919b4b5 100644
--- a/examples/ipsec-secgw/sa.c
+++ b/examples/ipsec-secgw/sa.c
@@ -104,14 +104,14 @@ const struct supported_cipher_algo cipher_algos[] = {
 	{
 		.keyword = "aes-192-ctr",
 		.algo = RTE_CRYPTO_CIPHER_AES_CTR,
-		.iv_len = 16,
+		.iv_len = 8,
 		.block_size = 16,
 		.key_len = 28
 	},
 	{
 		.keyword = "aes-256-ctr",
 		.algo = RTE_CRYPTO_CIPHER_AES_CTR,
-		.iv_len = 16,
+		.iv_len = 8,
 		.block_size = 16,
 		.key_len = 36
 	},
-- 
2.45.2

