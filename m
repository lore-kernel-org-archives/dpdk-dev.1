Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F57CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 17:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EBCA402DD;
	Wed, 20 Aug 2025 19:52:35 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 20F59402CC
 for <dev@dpdk.org>; Wed, 20 Aug 2025 19:52:33 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KHq5HP024613
 for <dev@dpdk.org>; Wed, 20 Aug 2025 10:52:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=b6tH92B6+Pjjm4OqFCpU0yv
 XBUr6bmiZabtowdaH1+o=; b=P2OFojEgw8FKqeOCJIUcYMXL6ueBvkOnwb/7rRu
 if3bcuhtBvUfxAJqUvBYSeIXJ5wF2sw8KkNRUUm4txmtr4ojOt6dYpRPO0UrxO2D
 dxAijr+gwpVczcZTH/TTYdH7G130OZrQK0H9RZFE6kQl5cAQRu0IrH3zMc7/WeWs
 1zULdJQWku7DkIdyyk7x2EPgr0gefscO4OZuVzKpciAWx433E1TNA/UbtyV7oQyE
 xniZd1i1U90yLhBauQ0C8e045Y/J0h2DKuk9DBbfZu9D3yDeg9WhDIN86MbaNHDM
 o0OwxoNTYmuyGAOzRngTblU/sJrXinPNHtWIxHUf5wFUBRw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nk4xg024-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 20 Aug 2025 10:52:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 10:52:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 10:52:36 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id A95CB5B692A;
 Wed, 20 Aug 2025 10:52:29 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <ktejasree@marvell.com>,
 <adwivedi@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH] crypto/cnxk: refactor rsa verification
Date: Wed, 20 Aug 2025 17:52:18 +0000
Message-ID: <20250820175218.2963352-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ev-PK-mIKEij-he7D4Hk3SycSzEtU5bq
X-Proofpoint-GUID: ev-PK-mIKEij-he7D4Hk3SycSzEtU5bq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDE1OCBTYWx0ZWRfX+dGwtenYNsgv
 cH0EW+QAX1EWh8jxeun+8ayzZKBsWsJpJ8mCbgfPH9somtk0xJMmhHNImL7saute/dE6FPCOrbw
 xcNT1Te95FZjTMa44Llnvkwc72bAEmNZqtdOFWAdwL4QkFnRVV34q5sNQRoDSVLRiDGB/ZM0UgR
 icbh3JyGk2QLI+GWvQNA6+ghoztlzudaZjs6/idW4AhDAv/u2Bf0w3esiTVkR/Uer/MlWsfobOH
 CEL+mo/snJRG0qx04ruUSOYLeVwdinvHL1sjxACJmO/megBcqYb24BOnLTJFOj8nOD4YAgSf65a
 LMcNm2VWro4ZeMhMeE4ZwPS6UgAHXlmTtmA/ndcohqNDx6nGzqp5+fGsXiJaTbr4qHtWT71xMUe
 knE3ciZfukk7xI/HZY5bWRfBw06Bq98globR/az5DaAEBLvW47oJCbT5HlQdmitHoNTEZ0w5
X-Authority-Analysis: v=2.4 cv=Z6W13HRA c=1 sm=1 tr=0 ts=68a60b61 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=XWf8bmjYm4pwaHeV5VkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
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

This patch avoid copying the decrypted message into
the signature buffer, which is actually an input to the
verify operation. This prevents overwriting the input
buffer unnecessarily.

Fixes: 6661bedf1605 ("crypto/cnxk: add asymmetric datapath")

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_ae.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index cd66f66e70..26a8f4544d 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -1583,20 +1583,18 @@ cnxk_ae_dequeue_rsa_op(struct rte_crypto_op *cop, uint8_t *rptr,
 	case RTE_CRYPTO_ASYM_OP_VERIFY:
 		if (rsa_ctx->padding.type == RTE_CRYPTO_RSA_PADDING_NONE) {
 			rsa->sign.length = rsa_ctx->n.length;
-			memcpy(rsa->sign.data, rptr, rsa->sign.length);
+			if (memcmp(rptr, rsa->message.data, rsa->message.length))
+				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 		} else {
 			/* Get length of signed output */
 			rsa->sign.length =
 				rte_cpu_to_be_16(*((uint16_t *)rptr));
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
2.49.0

