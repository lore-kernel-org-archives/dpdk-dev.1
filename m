Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D27C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B51240292;
	Mon, 16 Jun 2025 08:34:06 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B9B724027A;
 Mon, 16 Jun 2025 08:34:03 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNUlZc002932;
 Sun, 15 Jun 2025 23:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=6Q7loBDmekk21ZdGDVqIldL
 iYfECkcQHv/ZZaazDfuM=; b=czE+azJi6NX3cxGDdVuD7qOLtl6Tb1dsKYBB6IY
 Da0P0nqBzfV/L/8J9cwtZ0y8aLRF8bbPbHJ3hHSO4Hpf8OyT9IK/523mZR8P96T5
 mxB5ksGYRCmgbBogfv1oRbsLT0b7jHSJj01CSJx5fTR+PsOU2a6jpEbrI25qUtlX
 t05ylXabary+Bi9ny5wT4qfMQxlYetaOiKMvIYSiK1D+c8K989+sMmkjk6W8mO/y
 NYi2qg3jinc43wXXhYRHVrlKbMTyGYgPyu7N8fG2ItK1QLsZ1vO3iswi1bYbqqXz
 yEbMBonyor2iqk/Cxr7POv356PtJuTdD7vDkI0vBiNgAqIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47a7vqgkaq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:34:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:34:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:34:01 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 55F785E6875;
 Sun, 15 Jun 2025 23:33:54 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <anoobj@marvell.com>, <fanzhang.oss@gmail.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] app/test: update EdDSA test vector description
Date: Mon, 16 Jun 2025 06:33:50 +0000
Message-ID: <20250616063350.2507803-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: s_oupGitYZiSqEiyMyXGw3XM86-AV3pL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0MiBTYWx0ZWRfXxh6ZNXjXBgDW
 Tre8su4rbqpP3jhw7k3desD6Qlz2uwJuSpu17ZLnlNB4yreTAVzAzlaTEYwtaWevSIonTnyqcpG
 b9o+yFpL3KkJ02QNai+2ZLyVAtW8FmKz1uPfA3ihO5rXd8ZASQjG4Ef37+u1qBYYNRswZVhIlNT
 CGhkHBe0d8Ot8erpbH7NN9YcwMiR5cTYC/fFEi50Mm7Xcq+HWjzr053/woKBzlqYDitz+I/v3DJ
 mkKQjVVlkaJfYrMdGSGAZ5VLkCMCeuwz/ceGvtt088+AIZEpteupJa6OaNS46fnQ9WzWeWdnKyx
 Ebqe0x4Q0/EQ9njoWeALJ7+LiuWS7e9bUB1XHu+sDRr70KsuT8NPci9QlF5H8tRIoDx6RVdH4+2
 KBMsLYapTNkNm3s7xk//CdBd+nXzmGPlNta4kr3xEUBwF5lZwm5rxD5PxMeUSCoHqjwnfOz0
X-Authority-Analysis: v=2.4 cv=Q9jS452a c=1 sm=1 tr=0 ts=684fbada cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=KZLAmaRDJF1Z5URG2g8A:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: s_oupGitYZiSqEiyMyXGw3XM86-AV3pL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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

Changed the message parameter from 1 to 3 in the EdDSA 25519PH test
vector description.

Fixes: 2fba5232e77e ("test/crypto: add asymmetric EdDSA cases")
Cc: stable@dpdk.org

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 app/test/test_cryptodev_eddsa_test_vectors.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev_eddsa_test_vectors.h b/app/test/test_cryptodev_eddsa_test_vectors.h
index 047b667640..cb04f96834 100644
--- a/app/test/test_cryptodev_eddsa_test_vectors.h
+++ b/app/test/test_cryptodev_eddsa_test_vectors.h
@@ -340,7 +340,7 @@ crypto_testsuite_eddsa_params eddsa_test_params[] = {
 	.instance = RTE_CRYPTO_EDCURVE_25519CTX
 },
 {
-	.description = "EdDSA 25519PH (msg=1, ph=1)",
+	.description = "EdDSA 25519PH (msg=3, ph=1)",
 	.pkey = {
 		.data = {
 			0x83, 0x3f, 0xe6, 0x24, 0x09, 0x23, 0x7b, 0x9d,
-- 
2.49.0

