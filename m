Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54931D72373
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 10:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AACD94026F;
	Fri, 23 Jan 2026 11:56:56 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B9A5B40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 11:56:54 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60N9CCQf631345; Fri, 23 Jan 2026 02:56:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=FtD1QZ2I07ktHbljEpOkA3V
 awfpt5drx0F5dVb9PnEc=; b=My+JaesXKmvIbfOE5R8n0OV8S7cqZTs71rg1Nqm
 ddKr37cHEcUi7T+/RU8XvBtaRxpa6lQmQRiICnnQB5WhVvqziAstRpe7+mRld94s
 AaQqj+WPw1BMXo8NaD/Moyb8b0PetJ89KqBOoHx0vQi3MrZibStOWvA+knggF2YX
 kh8335PBWxsppCwsvSMtSCJlOPnp+fijyGvy61CuvcdS+pBmmVnmH6crqR+p36H9
 76gEAho+mH2XiSLN1XbfVAJBZkh1CxgHEfLbnPL1IsUdtFgclUIxgiMrzVCBj7G6
 NQW42epwqR9LHev2cg6KsRlkszHY139Tze/N4RxOEwJonrg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bv65504v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 02:56:53 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Jan 2026 02:56:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Jan 2026 02:56:53 -0800
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 871CD5B6963;
 Fri, 23 Jan 2026 02:56:51 -0800 (PST)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <ktejasree@marvell.com>, <gakhil@marvell.com>,
 <fanzhang.oss@gmail.com>
Subject: [PATCH] test/crypto: fix rsa sign data length
Date: Fri, 23 Jan 2026 10:56:50 +0000
Message-ID: <20260123105650.3764031-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4NyBTYWx0ZWRfX6Grs15sisw77
 mS2YfiUFYvhoRbo35DvUt9aDfXu5SayU3rRHY7jB3ygm7OwGs/7+PC5eeSEGrkKRb/izW41AxfQ
 E3n88CtkmwyKETXyq4jaarzi+zKYl/iDrPJykY4YoA3d++efdJ50nAG7kNSyiXhSs2COj6Kbz/Z
 X7VeMiVaXT+BkJqSAge/T83ozK7m4S8QcWoftqG2xER2ovtJ/zxnbQrNzyMrSmpAYLYC3n8Qu1x
 Cf6NHDUWNBaF5JymGPF/WkPwF8DKmih54Ig5aJevnHiK0yoC1GIU/E7XXV6AkBE6zqTRozmsQZB
 j+0NWGkb1j4B19NwfXOiiQsS2tEw5hfUk5DXeWlUTUrL/rQwDL1RJ/sQc2xmXTyDQY/Rga/UDVE
 k4haUxvQvrYDIqQa3cNWALEZZjOheMHCQ120+cuCz4GBC0nbgw8O20ancclWLUVbNFb7vcUuBH/
 l2fnszIaS+8UM5h45Eg==
X-Authority-Analysis: v=2.4 cv=EJILElZC c=1 sm=1 tr=0 ts=697353f5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=0P0Y2Pis_fuo5fHOqH8A:9 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: yq9xaGVU3LZkVibdjtqLB1sCHnDz_CZx
X-Proofpoint-ORIG-GUID: yq9xaGVU3LZkVibdjtqLB1sCHnDz_CZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
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

This patch fixes RSA sign data length assignment to correct value.
The length was previously altered during a test scenario and is
now restored to the proper value.

Fixes: 9682e8246ae2 ("test/crypto: add negative case for RSA verification")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 app/test/test_cryptodev_asym.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 111f675c94..34c15e26bc 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -139,6 +139,7 @@ queue_ops_rsa_sign_verify(void *sess)
 
 	/* Negative test */
 	result_op->asym->rsa.sign.data[0] ^= 0xff;
+	result_op->asym->rsa.sign.length = RTE_DIM(rsa_n);
 	if (rte_cryptodev_enqueue_burst(dev_id, 0, &result_op, 1) != 1) {
 		RTE_LOG(ERR, USER1, "Error sending packet for verify\n");
 		status = TEST_FAILED;
-- 
2.48.1

