Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A3DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:44:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85A3340A80;
	Mon, 29 Sep 2025 11:44:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0C93440A70;
 Mon, 29 Sep 2025 11:44:20 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T4Wj0n032672;
 Mon, 29 Sep 2025 02:44:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 uh84Wj+qk5pjqmv/UdRzTOewcVqvLipOQKaAggroU0=; b=PZwV1ue/rKFP3TYl2
 cmEZ1AlI0yGc86MfOeo0ATGnYhmzEmmBawP7aO+/Cy6uQjJN2zQ+5pt5fDz7dWhx
 ihjxIQTn+xRCZ2CDvdeCOhHhLaOSKcBk8AuzHN5C+A8AkgUIibiMPC/UHDtYX2sQ
 Pd0oTZ0pkb8230FHEHjUn97xZ0RMy4rtQWJgfchgjMqPqxJF11rNNuXTZtitZo2K
 qHGQuGxb+0C5z8+CW70XIwKjoJk8b3pEv5ivCSyDMTKdZbuAmYLGp3Dvgqm7j57+
 wvedUAKVXt/Iw88F4W5ArsdScFemxIldZkgyGoQIpdQg49Xbaa4fgD0vcH03SF6H
 TSseg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ed9hkk1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 02:44:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:44:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:44:28 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 462F63F7059;
 Mon, 29 Sep 2025 02:44:16 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH v3 06/10] crypto/cnxk: refactor rsa verification
Date: Mon, 29 Sep 2025 15:13:49 +0530
Message-ID: <20250929094353.1027744-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=b7W/I9Gx c=1 sm=1 tr=0 ts=68da54f4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=pLuP44-dxEB3wbVIfBYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: bCKFuXKOjPA8f9L-dAkKsnxou1DOb6Fu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4OSBTYWx0ZWRfX7cIjHKPj+Me5
 fzH5lMDxfd1LdFICgOXeDPvxfjvhdxY1a8492ou/lpmTs1yydCVGeITYFnh9AM1LPIoY+rXQQ3u
 bPL6jbvyoyBjDerkWzhMtvX5vkRdqQaLgN/qcKg9S/L9Frj6bB+qqwGd8DKFBXGf/CJg6GBZ0+W
 u4czImwBczz9WwGaKykRGD8EyXyljnJPSd7lYkb6QKrGx6S1IfQ2jioEhWEjmB9kHJUg1Io8ZiR
 1N1d7V2jo1uInJKmyj7zyNJsCpR5gNJ9/bDWbFZQJnIsNS7orgGCJAUF7PLY8gHNU6Mjem1/32M
 hjgm8IsSuZE4+KyhcG7p56QbVXL9DbjRoqQfqbF7X7ML5O+QLLCpNCnjWIi4ZWfBkLt/UXFr45O
 7ptcLBTnLCqFO6n4eSafb8OtWiRBLg==
X-Proofpoint-ORIG-GUID: bCKFuXKOjPA8f9L-dAkKsnxou1DOb6Fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
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

From: Sucharitha Sarananaga <ssarananaga@marvell.com>

This patch avoid copying the decrypted message into
the signature buffer, which is actually an input to the
verify operation. This prevents overwriting the input
buffer unnecessarily.

Fixes: 6661bedf1605 ("crypto/cnxk: add asymmetric datapath")
Cc: stable@dpdk.org

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_ae.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index 8508ab8736..912a2a9496 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -1592,20 +1592,17 @@ cnxk_ae_dequeue_rsa_op(struct rte_crypto_op *cop, uint8_t *rptr,
 	case RTE_CRYPTO_ASYM_OP_VERIFY:
 		if (rsa_ctx->padding.type == RTE_CRYPTO_RSA_PADDING_NONE) {
 			rsa->sign.length = rsa_ctx->n.length;
-			memcpy(rsa->sign.data, rptr, rsa->sign.length);
+			if (memcmp(rptr, rsa->message.data, rsa->message.length))
+				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 		} else {
 			/* Get length of signed output */
-			rsa->sign.length =
-				rte_cpu_to_be_16(*((uint16_t *)rptr));
+			rsa->sign.length = rte_cpu_to_be_16(*((uint16_t *)rptr));
 			/*
 			 * Offset output data pointer by length field
-			 * (2 bytes) and copy signed data.
+			 * (2 bytes) and compare signed data.
 			 */
-			memcpy(rsa->sign.data, rptr + 2, rsa->sign.length);
-		}
-		if (memcmp(rsa->sign.data, rsa->message.data,
-			   rsa->message.length)) {
-			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			if (memcmp(rptr + 2, rsa->message.data, rsa->message.length))
+				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 		}
 		break;
 	default:
-- 
2.25.1

