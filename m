Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F3CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 12:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB01402A0;
	Thu, 30 Apr 2026 14:05:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A6D0B4021F;
 Thu, 30 Apr 2026 14:05:46 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U60n8U2477642; Thu, 30 Apr 2026 05:05:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=TMBgAI+g6c+z6/urfYh1u/o
 dcWzHUHCn3lXXxfuzo8g=; b=Y9/oOEKX3xcyIZsWXjrK0/V14jJeb1l/Nn7qCOt
 v3n2jhW3vy9PxqmOwAWY1m9q4XClAoR1Gr+6tsFkFKT9WqWDE/KWm1QcE9Ar3fdq
 D7bbrG0anUQNE7iQh0prAMrQyXTYoqVqzQuuzY+CfEqT95q75eXq7ExXc+mxs4Tx
 27jJNk7OdEIqUjtq+saufXJAy6gS3GnYlbeyJ4Q34B6Hwqit5X//6bvTLLXCzQsP
 AiAQLAkO1N9i948jVhVf/fVKN6bsnrXYUA+57YRafXoLMhnx+wJcO2BF1Q9Rmu2q
 /t8rqejGCEkR/l7KliNHG4tC7LYBPCaTPTMvpVsZT+N/rTw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dun98jujj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 05:05:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 30 Apr 2026 05:05:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 30 Apr 2026 05:05:45 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.74.195])
 by maili.marvell.com (Postfix) with ESMTP id 4D9103F7079;
 Thu, 30 Apr 2026 05:05:40 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <stable@dpdk.org>
Subject: [PATCH] cryptodev: update xform string array
Date: Thu, 30 Apr 2026 17:35:25 +0530
Message-ID: <20260430120533.2004-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=69f34599 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=dMpIRCrA1JucY64CYjEA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEyMyBTYWx0ZWRfX1+PbnrCwe0hU
 c+93dL8zIS4jO2UVHhDHZU9WzHT768iBI6x7cy3hyDqi+xWW/Mq3/t97+8i8kTuefXLu3AoZIA0
 232g2Q5Asvra2bqQg+92+ilS8kOrPAfi9uesOKye4TIhPNxu6oVVUaaOEcxpfBOCtAJaS00BzDE
 d7tSypOXO/6w3+ZRGnIBJaU6o0GLdzis3/mZq07roSN2Yv8De5a0FnlfDoYc7MsfzgKJiUHoJKS
 NoenKdPaBFE/gqBWWuGAx3EmvD9AzSnb/nDaRhryF0fwbHGCHXlhqLdWmOsscB8/DgMX01pl45m
 ymkz5pxjxG7S15kXNGk9zIbtiJkzP+gWJyBtVQzQVm2J9nTyxutvtslsgUCKllu6Ocq6n8swowZ
 nIAfhX2P+YprSOwYgUBiXg45mq9OfOyeoemJHbdaFInRYeCH0+DMbfdpngJ3ACMcevtb3qXQ1p2
 5jR+QVaecLDquvNdIzQ==
X-Proofpoint-GUID: xOZCKb46hyyltOK64doyr6Q13lRqMDJw
X-Proofpoint-ORIG-GUID: xOZCKb46hyyltOK64doyr6Q13lRqMDJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
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

Update xform string array for ML-KEM and ML-DSA algorithms.

Fixes: bd3745e29065 ("cryptodev: add PQC ML algorithms")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 lib/cryptodev/rte_cryptodev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 50071935c2..91f86c1590 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -216,6 +216,8 @@ crypto_asym_xform_strings[] = {
 	[RTE_CRYPTO_ASYM_XFORM_ECDSA]	= "ecdsa",
 	[RTE_CRYPTO_ASYM_XFORM_ECPM]	= "ecpm",
 	[RTE_CRYPTO_ASYM_XFORM_SM2]	= "sm2",
+	[RTE_CRYPTO_ASYM_XFORM_ML_KEM]	= "ml-kem",
+	[RTE_CRYPTO_ASYM_XFORM_ML_DSA]	= "ml-dsa",
 };
 
 /**
-- 
2.37.1

