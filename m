Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE45C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 May 2025 10:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9AF94025D;
	Sat, 10 May 2025 12:46:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C5AE24025A
 for <dev@dpdk.org>; Sat, 10 May 2025 12:46:00 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AAYJju022515;
 Sat, 10 May 2025 03:46:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=CrqPyflGDimox0PMbjnJ4BR
 yMTSvJNr0jS/hoQY8vsY=; b=M+tEybu1oJh40nJ2ozDod3rHosgVlxW9kZ5QVb+
 SbQ5E5QPYPmtiGMf5B+HdNA1bULhWI+28fks2AmT6gUz/dzCnI2+dzSHd4fKj4Mv
 ZNeMeWtqGNTjSTcza98GqQsV7vWMpPms+3p7qAflr867ruyWy1pqIcTgLL+qEzdW
 bZDB/K56Zqj9CObtcDBQLNofQ1G59PJ5XmnbS9eAwX9vQ0hzoODEqzPiAusvn9M5
 wf9BXlafFSSYvJRLNTxKoqFWMfLnj/w2R0jKYnmfsthI/Mx34saXhrrPQbb0zIm6
 Z0Nw2K3cjWJVANQUVDv3ZH4BOsNY/YpBekjXKvapiIit7ew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46ht1m8sha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 10 May 2025 03:45:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 03:45:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 03:45:58 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id B015A3F7045;
 Sat, 10 May 2025 03:45:56 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <anoobj@marvell.com>
Subject: [PATCH] test/crypto: fix return value in RSA verify test
Date: Sat, 10 May 2025 16:15:49 +0530
Message-ID: <20250510104553.2246-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m73Lh7VljUTw0X-MeMW5RWKORPHUR4o0
X-Authority-Analysis: v=2.4 cv=PoqTbxM3 c=1 sm=1 tr=0 ts=681f2e68 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=55YVfXhggWhydvCemTQA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDEwOCBTYWx0ZWRfX6e2wCuiWbXC8
 g4EHABuZ4j8Xl+lrMpgxUSxnvkjhbjVBI19FNanRtiOe5kyJoS2ML1rThAJTUQDolwCTlvV2cSt
 mVZ3Gk+Ar5g/UVsCMLE0hLY9L9ApYpbYX2IspKKb4PSpWjLmuX8GOaGzysZCLHfOoPmDZIxhFMW
 Y4C/QA2sYk7GKkwqs0xV4Ues8cPdmW4I8XU5sjfUKo4iZDbmCwClEXo6wRD0xUgz/HjY5OIudeA
 uja18wE+DZmHpt1KEC1SHRQ64hYzsOhnoAJg3LudKSfqyrdDPzfHSBGF40FYq3tbyeEmGzOW9H7
 Usod83bMXFTfdqjaV4orV5eowRCif3vglnh2K1jDBbpE7j0sqHjCdkFYc2xmPwW4nfaksWDxaEb
 hG6ZR2RmRcg6LI0cY+0fD9GxPRAiMbj1ziQ12XayZK5QMmEzUhRFcLZGqnbWU7wmGs5D8vxZ
X-Proofpoint-GUID: m73Lh7VljUTw0X-MeMW5RWKORPHUR4o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_03,2025-05-09_01,2025-02-21_01
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

This patch fixes incorrect return value when RSA negative
test scenario is validated.

Coverity-issue: 457463
Fixes: 9682e8246ae ("test/crypto: add negative case for RSA verification")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index cd4fe7e14e..f87cd72df1 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -155,6 +155,7 @@ queue_ops_rsa_sign_verify(void *sess)
 	if (result_op->status != RTE_CRYPTO_OP_STATUS_ERROR) {
 		RTE_LOG(ERR, USER1, "Failed to process sign-verify op\n");
 		status = TEST_FAILED;
+		goto error_exit;
 	}
 
 	status = TEST_SUCCESS;
-- 
2.25.1

