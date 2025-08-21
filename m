Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19F9CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 04:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76A0240672;
	Thu, 21 Aug 2025 06:53:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 842F540676;
 Thu, 21 Aug 2025 06:53:34 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L0p5rH017209;
 Wed, 20 Aug 2025 21:53:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 uh84Wj+qk5pjqmv/UdRzTOewcVqvLipOQKaAggroU0=; b=QEW+7iVQKYG+Hipql
 Cui/O/AzTF8LT1e6yhQ8SbwarscOuEncVT/+kuT/WF2g1Bc+BBZvTF6wfkyDJZ+7
 1SY6Z1WyR6EhCYvs1kaeu+v4rBOj50zbaelSQ5KYF6IZ1HKWfwNvFs6CTDvHSSow
 dqu6rh/kAyfAlQQZid4Ummu1AFwrmURiQg32DCUQsRBYpZmpEZhhAEyxrXDqIyXA
 zspamdvD7xzDvvC4YRHg0ZWAbTOz/bayTtt4liUS2mGftkapFDEXjTA1YRbuv2To
 drtGdU5w4H2dwURL+5FTfsxv73fOkbhVE9Y+Z+qm9mWiWhHOx2CimRCos+Fx37oQ
 baqhQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nr3g0j0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 21:53:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 21:53:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 21:53:37 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id EFAFA3F708F;
 Wed, 20 Aug 2025 21:53:28 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH 6/8] crypto/cnxk: refactor rsa verification
Date: Thu, 21 Aug 2025 10:22:58 +0530
Message-ID: <20250821045300.3787899-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821045300.3787899-1-ktejasree@marvell.com>
References: <20250821045300.3787899-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=St/JKPO0 c=1 sm=1 tr=0 ts=68a6a64d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=pLuP44-dxEB3wbVIfBYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: URCjfqm1XYdDqHs9878CfMJwQjyeYyDn
X-Proofpoint-ORIG-GUID: URCjfqm1XYdDqHs9878CfMJwQjyeYyDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDAzNiBTYWx0ZWRfX2Gnu7j+ZvLQB
 z9NXu9whFjQHpEv3a8NvT3oEyuDfvOxX+1YlFMCZ6WQMbk+jPSGTilmGaPRinuwx5kWu8qVteej
 oeDK/F2QjqT3Vf8d0Wf/iEbWrCXznsSHpizt2rFDOXZolitu1ZDE+eKEEj2rSWnaRdjG8xgq7z+
 pKE8KXJw2QIjMhATeqwL9bNC3MxKJdReLu5biuUPO6jFzajRyS7l8TRDCXnRtpUA34QANConf0e
 2fXNDCjOzIK0rFeNaRuTPvGac5po9X/20rlWG7d4HH62JL8xSRpK6Nu2MOhZGEOlWMMH8YcZEeA
 b1WJ1a4dKgPVY4pH7Wo59l0UjD4jBZ1rmzKBm5pTFmc6de70EPAp30w1MUZQ88AvMnTKfO5aNLS
 rs/ovsykq8ze9ixqHOi2iE1XkHQhb2teBbRMR7dRf+RjLgio/bdT2DUsyRmVQONb9yzcCDNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

