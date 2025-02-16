Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E650C02198
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 14:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EAC640156;
	Sun, 16 Feb 2025 15:25:21 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D3DE940150
 for <dev@dpdk.org>; Sun, 16 Feb 2025 15:25:19 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GE0Mb1001133
 for <dev@dpdk.org>; Sun, 16 Feb 2025 06:25:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=VFCdY4+vjiYUl/vaMO2GqZ9
 G59TaKXGW+lBSXDHZqAw=; b=AML35j7cUjTquyomLhvQL8NR1plK/jUPPIIU4GW
 /onwD0didXAXIfGfYPHJJwnJ6N1SMerdotD+RQpaH1I3J+Paqn5mardXpRlZxUVY
 u/vJQyFi4QMWFZ/j/A7mk9qMdAREIJCh84QQHQdMiNBU83NIDKZ7NRDkcU8Y32Rx
 +yFsy/KJmiuV2NZGC3qNuzuSyFR7c7TCS0GyRdbx5yHhx5ktuHQQhPEzFYx7/bGL
 Ske/dBD4EZGIet1fETXyk2qwN0fJC0T2VFrrKgHl11aQE8WX2n/7PG48kqUKLIQt
 Lx8ZYDPGeJBXc9Q0r7Qw5l/1I28lc9D5DsLqD8mWnbdqBvg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ug2bg40j-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Sun, 16 Feb 2025 06:25:18 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 16 Feb 2025 06:25:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 16 Feb 2025 06:25:17 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.24])
 by maili.marvell.com (Postfix) with ESMTP id B293F3F705D;
 Sun, 16 Feb 2025 06:25:14 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: [PATCH] crypto/cnxk: fix status code in asymmetric operation
Date: Sun, 16 Feb 2025 19:55:07 +0530
Message-ID: <20250216142510.1467-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XO970V-UIMu-DS-T3glvYvO5R9bSdARm
X-Proofpoint-ORIG-GUID: XO970V-UIMu-DS-T3glvYvO5R9bSdARm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_05,2025-02-13_01,2024-11-22_01
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

Return error code in an asymmetric operation status
when none of the known conditions met.

Fixes: d29c4e0a4bea ("crypto/cnxk: fix ECDH public key verification")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index 8d10bc9f9b..2b1bd70c6d 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -529,6 +529,8 @@ cn9k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
 						cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 						return;
 					}
+				} else {
+					cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
 				}
 			} else
 				cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-- 
2.25.1

