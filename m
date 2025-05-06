Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3062C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 12:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B706F40269;
	Tue,  6 May 2025 14:49:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9FDD440150
 for <dev@dpdk.org>; Tue,  6 May 2025 14:49:29 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5460ZPPN002892;
 Tue, 6 May 2025 05:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
 YoA2pncIY2c/CikUearahTuDBhfDsiwhX/3m6MG5AA=; b=QkDCeiz14XRePNHB+
 iSTPbGGHKH2m/3TdcOPWSxkNpdXRAYOmTDHb4VuPVqkVwfB0KTdfXNrYAO4RT+rJ
 reA4a9JIaXlyrgsoJY6LSRvlOJvgtVXlg6H6bKtrtCyO+MBK6iV7VVol4GhEWsop
 tmPWkXn+C8KkNPfqNQkJHQbHAiL8DsJZr0maB3088v30sekWYOCNMoVS8f2WJE/x
 ldIrTTVEwBRjVQC3fswjTCM2dmyD+IEcs9t6JnzBUXTle1ATE/bShwAEkiWG3JAL
 SKThLCUpwWOt+llpTpjP9MHYegAzy0UEObSXz6JwnBSk8jR8qBvslfMmoFTBQto6
 bb1ZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46djnjnfkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 05:49:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 May 2025 05:49:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 May 2025 05:49:27 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 267F13F706B;
 Tue,  6 May 2025 05:49:24 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v2] test/crypto: increment dequeue timeout
Date: Tue, 6 May 2025 18:19:14 +0530
Message-ID: <20250506124918.2018-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250421064708.1777-1-gmuthukrishn@marvell.com>
References: <20250421064708.1777-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEyMyBTYWx0ZWRfX2hxy/QvldBBe
 Ey/Q3X3Cf6zhu9oCgBUL5iKogv5axHc0biHgxRcY5llcyrUwoWxQYp8Zt3f7P5KGGFYK58ifCBB
 KRP6EH0fgBmRIU1VdjECMnHqCe3x07YZMeQ6C2QZiQmjnFQLykFy4Pj60kQ0/eL6Q5JYOUzFeRa
 ipoDSUgYrbUewAVIpQDcIjkc0ccG4+jDI4O8I1rr+yBuz+YfxFXjN/gyeRk3fy9rUqtO71Q9c7M
 /AML9+9JaUiF9ciVxyUIK4yRoNTLpTwCHPSV9Y9t9C7UXROlwZ8R+aDv0qs9au9eB2difO0IyJu
 MwQW322u28K8boJw9Hof/XEYjUkDkQWnFtQTVL9xrEbnDetK8WWvIHXZqNjxHgBWHGlw9TgRsUa
 txq+FqlNIGaEHSXjDTM2c5p5/otOxL8k5VVnRppY9cYFmRy07AWyNQvL8zF/wyO+XEf6hfBf
X-Proofpoint-ORIG-GUID: ESB7mqUdrBMZhBEs0UWaA5_Jd7uOL_oB
X-Proofpoint-GUID: ESB7mqUdrBMZhBEs0UWaA5_Jd7uOL_oB
X-Authority-Analysis: v=2.4 cv=XNwwSRhE c=1 sm=1 tr=0 ts=681a0558 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=3O7H7lqxqWkCj1SWBtEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
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

Increment dequeue timeout to allow implementations taking
longer cycles.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v2:
 - no changes. only for CI.
---
 app/test/test_cryptodev_asym.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 6b74dd9a73..226270556d 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -35,7 +35,7 @@
 #endif
 #define ASYM_TEST_MSG_LEN 256
 #define TEST_VECTOR_SIZE 256
-#define DEQ_TIMEOUT 50
+#define DEQ_TIMEOUT 10000
 
 static int gbl_driver_id;
 static struct crypto_testsuite_params_asym {
-- 
2.25.1

