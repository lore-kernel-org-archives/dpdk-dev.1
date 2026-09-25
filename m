Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBEFC9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:15:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4AFB40E09;
	Fri, 25 Sep 2026 10:15:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B86A440B9B
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:15:43 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4bih6507347; Fri, 25 Sep 2026 01:15:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 xRj96mFgI9MRqIfPFhMZGo7EjDnPR0iyTh7p2l37WM=; b=WuEKQ0XSQLRjtIhNJ
 wPB0i7ld2sXdZ+LKx5wX4kj6coFMJyMezEEOj2pqAhaNXplrnFma93RAjm1xufvt
 aCwf4C5/hhS2iOFuoeZcxw8Zx6MwmmFQg1RJhv3FXJRupU0wPYIIZBzIHLRE9HaV
 FarglJ5Rx018BjZAbopyhZsz9Yk3sPtJX+mkl2ZFPod+ykNYHVWHAnd5R+I8NG5T
 vheiZ5/43csebjvGVVBXaXw60UBDdlMe7JxQl2X2f3lhLdakxNo7HiBae6q4OOq2
 c1IB4rI1RjE/EeR1exQ845t8wQ94YqXSG7Php16KBHlvC7Rde+fw2dfzujkC6gkX
 xS/uQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gwdh71r9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:15:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Sep 2026 01:15:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 25 Sep 2026 01:15:42 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id C801C5B6954;
 Fri, 25 Sep 2026 01:15:38 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v3 3/8] crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
Date: Fri, 25 Sep 2026 08:14:55 +0000
Message-ID: <20260925081500.3848187-4-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925081500.3848187-1-ssarananaga@marvell.com>
References: <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260925081500.3848187-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B5ZqhfdyP4rOsvhWGITIPaU1E7rlxcd7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfXwGCyk/yeWX8X
 7gICTEAbnw8Kq/hXPG49TfR4WnK2yuGrwX5jV29ix0wnuC+0QIkGb4dHQaqWazOsqERIHx7ywyA
 0qks4S+oIxUbOiLjjEVfu9rmLaUmFdA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX3ICwNYLHy8cY
 JY3PJzVEXrwoYNCUdBWwlQsSPredkQfaggtjnw6Hap3pMcf6hfyeDimuzkLCIwh3ZgWJjffdcJm
 w3WCqxNHJ0epEUT1QEKfOc0CVxPCvSxUbdAblcr4TT2HYt866ypMBcb4RObGpbA88F21uvMmn18
 VTfLOfv41koSpUes9Lq1Vd4ZMqZHYVmH/HOnzWYAUQVLT+ho2vuVOqjeDsyzfsJCuF4Gq22sVvv
 F1ryeEFlEWbHMj2hXexyBlEx8SkM7gMiqs9GxvFlOPrEGlJ2ZUYXEGX5u5Oeik5bLGcHzqRBS/B
 14ocuZh4sEuMPVGDlgAeH2iNiLc4bIJYt+uCiN6pR+9I6EgtByqI5/y9wb4kwuuIPX/+OYuv/p2
 NgEKmH0BDLCWPYuH/bQJhmf5ZiWBj10zA7pHi+m1mDH+8EpSes3wCL8ciV6HBZfw3wcwJahNWKB
 NQJ4ItJcLSfJNHMtYDw==
X-Authority-Analysis: v=2.4 cv=OeINnRTY c=1 sm=1 tr=0 ts=6ab62daf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: B5ZqhfdyP4rOsvhWGITIPaU1E7rlxcd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
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

Update the CNXK cryptodev RSA asymmetric capability to use
rsa_capa and report supported padding schemes.

Advertise RTE_CRYPTO_RSA_PADDING_NONE and
RTE_CRYPTO_RSA_PADDING_PKCS1_5 via pad_types to match RSA
padding support in the PMD.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
index 736d588bde..577f080ba7 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
@@ -60,11 +60,15 @@ static const struct rte_cryptodev_capabilities caps_mul[] = {
 					(1 << RTE_CRYPTO_ASYM_OP_VERIFY) |
 					(1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
 					(1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
-				{.modlen = {
+				.rsa_capa = {
+				.modlen = {
 					.min = 17,
 					.max = 1024,
 					.increment = 1
-				}, }
+				},
+				.pad_types = ((1 << RTE_CRYPTO_RSA_PADDING_NONE) |
+					(1 << RTE_CRYPTO_RSA_PADDING_PKCS1_5)),
+				},
 			}
 		}, }
 	},
-- 
2.54.0

