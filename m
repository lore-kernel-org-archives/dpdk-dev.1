Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472CCC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 08:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5331A40B9D;
	Thu, 15 May 2025 10:06:42 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 158EA402C2;
 Thu, 15 May 2025 10:06:39 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ENSowu004920;
 Thu, 15 May 2025 01:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=1CWrckaChQ6m++C4naF30ls
 MO+mBCovle8ZsiA+KkZ8=; b=AMC/nfEktVuIh+3yOD5Kf7JIF/ZogHHWfdE7D8R
 Qv6AZvAMUSY9UroIn+zYNtOipfLMbDGJYJpGf14JIjNSl+Lq6k5diaCAGJbk4Bsu
 UMesK33VrS8Vt7yHC8gZoHI+I/fRFt/dkKK1DTtbr7fJlvQKjVtkg6Em8azhWeu5
 RqMtDMsrHJjCjvSA9b3RtSLNStsUrO1bJHB2VJ0U+o/93E6W2/RhYZK2o5vHkPvY
 EqWbfcnmXGM5/nOkurBV0OJN31snD2OwVOCjRQNQT4qElMxl7yxYFCL2oBgJ9mx6
 6+HwQ4TpxEKS98r+TYMagkFDuwbxTTtMw1/FiUJf/vUy1Dw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vtgu68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 01:06:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 15 May 2025 01:06:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 May 2025 01:06:37 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 3124E3F707E;
 Thu, 15 May 2025 01:06:34 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 "Gowrishankar Muthukrishnan" <gmuthukrishn@marvell.com>
CC: Akhil Goyal <gakhil@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] crypto/cnxk: fix uninitialized scalar variable
Date: Thu, 15 May 2025 13:36:29 +0530
Message-ID: <20250515080632.1676-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3ZGO1lKFTvr2ZS5y0F3wDsErKtQWVOPZ
X-Authority-Analysis: v=2.4 cv=RMCzH5i+ c=1 sm=1 tr=0 ts=6825a08f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=51u6RY_R4sLumjSoTgkA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3ZGO1lKFTvr2ZS5y0F3wDsErKtQWVOPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3OCBTYWx0ZWRfX0hHEFtv/R4Bl
 U8EzhczVmlZrn0Sasja5LAgk0747grzvJS6SIGHo5eB8dxqCoeNxi4G1tn3pPCKzWdb5u/pZr8Z
 hxliVUul21MXqnSMWw9i8A+rwSpXPrsQ69hzpbmJ2YTt5nXOw0G18YrN2jbgRuNkmu5hkMz9Ueb
 zGZ7uYM/p1MjB5ccgByySbqzuKzpTI9eia/X9BvknUZQku3dAuUUaS4sh/h0qKSiiEdrQ6YgPQq
 KClYzFM75ICx7CDjdNDQ9bg8F4HsuYddU/W/1drEl21i+7ZUwTWPeS9uD4Y1hE4Es01iM2rqZ3X
 zE2hzAOIIVoS6g9xOwmFsn97sMat8IX8WXiomEYPwHDrQMiORd6HShFfEZNkdr86Pcmr9hrYZzI
 arh53Qa2i5uty/ZMTUEqz44W8lSAyJMjRfZLQrmkNjJ14/uN+VtRXiXvRVEUpH8ULz+ZfhOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
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

This change fixes an uninitialized local variable as reported
in coverity issue 445390.

Coverity-issue: 445390
Fixes: a8ebe94f8cc ("crypto/cnxk: support EdDSA")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/cnxk/cnxk_ae.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_ae.h b/drivers/crypto/cnxk/cnxk_ae.h
index 75d6a536ae..8508ab8736 100644
--- a/drivers/crypto/cnxk/cnxk_ae.h
+++ b/drivers/crypto/cnxk/cnxk_ae.h
@@ -191,7 +191,7 @@ static __rte_always_inline int
 cnxk_ae_fill_ec_params(struct cnxk_ae_sess *sess, struct rte_crypto_asym_xform *xform)
 {
 	struct roc_ae_ec_ctx *ec = &sess->ec_ctx;
-	union cpt_inst_w4 w4;
+	union cpt_inst_w4 w4 = {0};
 
 	switch (xform->ec.curve_id) {
 	case RTE_CRYPTO_EC_GROUP_SECP192R1:
-- 
2.25.1

