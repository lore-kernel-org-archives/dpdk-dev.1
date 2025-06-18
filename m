Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35221C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:54:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90FB542DD3;
	Wed, 18 Jun 2025 14:54:24 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F2A7642DD3;
 Wed, 18 Jun 2025 14:54:22 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNSaTc016705;
 Wed, 18 Jun 2025 05:54:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 j57azhCoHHCUfnteAI4R8qurufVbxHC10zLulfB8/Q=; b=LqDRtS6/Md1tVr0Vv
 ba6J9D3OylowmWwyhDhxf3q4b4xWv7jPAI8MXy4YEMBtpxDDeXUbwm+RuhC1rIhQ
 XBkP0blRwGGCUQYqHEuobzwmBWT11dfCd/uGJtY1uYQc8p0i46pYn68i8ZHIVKYS
 qPZfBww2Xuv9t8SNPUG18ZSSexOGKBSM5GSuG9AMTa8TXRzH4snetcJzlyScnX+W
 9E/zjpnfjOLWn/yxrCOg4rgS9bJ3d5r4FI4TcZsh7XJSzqzNiT42Ar7M3X5jhCdh
 pqCd2MBZdhAo4Rrg7F+ynZyikMzAxHnUpT1GGxJ+sd5znX++I5rFleB0HwxmdfoK
 yxrdQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bj2khf9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 05:54:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 05:54:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 05:54:20 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id EDC033F7043;
 Wed, 18 Jun 2025 05:54:17 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>, <stable@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>, <fanzhang.oss@gmail.com>
Subject: [PATCH 2/3] test/crypto: set iv len to 32B for auth and cipher
Date: Wed, 18 Jun 2025 12:54:08 +0000
Message-ID: <20250618125410.767919-3-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250618125410.767919-1-nkaithakadan@marvell.com>
References: <20250618125410.767919-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q9jS452a c=1 sm=1 tr=0 ts=6852b6fd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=gtl2RS3WAvePAPUvIvwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwOSBTYWx0ZWRfX8c5IgwBfbPj9
 sD6HXt/U8XPaxjLuHIR8yK8yicnLXbXfRluoYwIKgdt3mUyA+sExu66KNOqO0W2Z1kimgYbb0YE
 QDG9zHCgDjg9zuHjr21BBwTBLbc9l/JmGcFDk/5xM9MeDxy0WJ41pW0/lziZ6ZGffdxQewJlczR
 5nnS2o65Ce6B9nMdyMd6tIOo9Qtlxv5LtWrV5/YQLHuORcgybSVUHbFehBpmyHHOavmlH+M8NL0
 KdRAHrzMgLA5rGyknQqsY8KmV3KnP2eacon1E3PDDey8EEIdVmb/cXS560VDWk4TbLLmt6xrR/k
 uGkNQN25L1ShruiXVlWVK3Mxi9vkymkupAIwzuZoipVu+TZuLTnUg3s6vwjHTIWxNiEaaPvFpOJ
 fZsgWI4BCH3nvdGBpV9yYoQSo7BZ4XsJKlx/06GdDGAADk7jgFKs4yGv1BVxm9ykCmbGkeqE
X-Proofpoint-GUID: 2rxWm4JYZJz1hdP9w4epEJGqZLxrAct1
X-Proofpoint-ORIG-GUID: 2rxWm4JYZJz1hdP9w4epEJGqZLxrAct1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
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

Set maximum IV length to 32 bytes to include both auth IV
and cipher IV.

Fixes: fd01a9be38d5 ("test/crypto: move IV to crypto op private data")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 app/test/test_cryptodev.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index a80c11baf4..e243cf945a 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -40,7 +40,11 @@
 #define TRUNCATED_DIGEST_BYTE_LENGTH_SHA384		(24)
 #define TRUNCATED_DIGEST_BYTE_LENGTH_SHA512		(32)
 
-#define MAXIMUM_IV_LENGTH				(16)
+/*
+ * maximum IV length need to include both the
+ * auth IV length (16 bytes) and the cipher IV length (16 bytes)
+ */
+#define MAXIMUM_IV_LENGTH				(32)
 #define AES_GCM_J0_LENGTH				(16)
 
 #define IV_OFFSET			(sizeof(struct rte_crypto_op) + \
-- 
2.48.1

