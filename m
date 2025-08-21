Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF14CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 06:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F8414069F;
	Thu, 21 Aug 2025 08:14:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4A09C406B7;
 Thu, 21 Aug 2025 08:14:10 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L5wTtE031354;
 Wed, 20 Aug 2025 23:14:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 uh84Wj+qk5pjqmv/UdRzTOewcVqvLipOQKaAggroU0=; b=SrdHTYy3QJPEBV1aU
 SgZERrKcKkqSMo9Yuwhg4vCUQOmedhbBgwDS+E27eEpp5shiU95nSTms27aIEKao
 aMm3CFdmfKDrdBseppKSHt6Yvy7nXD/yR5+gwDrfb3VflptSPMw7Ps9u+Mw0rgB3
 NR9Te0JwVToFV4/mn4VlxWX76n6oMJYSOFfaiT3wy6VWf1ZY87Gao66ooJa2afGg
 wRs+pzuIDDzpm37/kw7s+6FhbwYwqTeZvvYaDeh2LkrTBhqaQyjGcbbaC9Tj1IRa
 xefL+GXgMgZ7eGVLX/xtiYcws+RX3xl+ohgs0x52m7UhKK5kcDGgYFu9JPDQ70bg
 Z8LUw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48nws6819f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 23:14:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 23:14:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 23:14:13 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id D018B3F7097;
 Wed, 20 Aug 2025 23:14:04 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH v2 6/8] crypto/cnxk: refactor rsa verification
Date: Thu, 21 Aug 2025 11:43:39 +0530
Message-ID: <20250821061341.3790775-7-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821061341.3790775-1-ktejasree@marvell.com>
References: <20250821061341.3790775-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UXBEWfDXrIcmPy7WdkF5riZpiTDSx6FP
X-Proofpoint-ORIG-GUID: UXBEWfDXrIcmPy7WdkF5riZpiTDSx6FP
X-Authority-Analysis: v=2.4 cv=A/k1/6WG c=1 sm=1 tr=0 ts=68a6b931 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=pLuP44-dxEB3wbVIfBYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0NCBTYWx0ZWRfX6cWmXRfKw1TW
 dszlE9/NG6jqB+auHjsgP021jrtYFx6yI2W+tKqaTXdX1GJApOQb7Pgppuu/sVuB7TaLML76ipn
 EM+vwKkMO8LFnmbilzJfDwR/7p0lr+BCb428965pZtrI0gAHBy56lOaTUFjeTrGRxT6NFHabZVU
 oHdhOnrLMB1e7gkjZnS/JUddk/LT5ZVN1zhnUC1lzKykKOetfM0YLpmfrI1MuaJzeYVpc1pgAIq
 G3zLigO+SWyeu5ZRJVY5D6Nj6wJbHeThaq5nIP9Yq+YCyurowr+b3wyjlsVeJNu2BwaqO3kOXC3
 bsb4EI1/pqCKny+uneoRlRYV9lVCDKBSUrjD5zNXFZ6GMmOZJ3nEjZUijOn7EyQKZIAo4mn5g23
 tIrU0wAYlLhrkHRfg2iu1Yxv1Gv3eNce8Gtkx5/4mg5ymfgNglqThRK8B8uHVwDBteal5qp+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
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

