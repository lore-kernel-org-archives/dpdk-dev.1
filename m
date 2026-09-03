Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42556C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 08:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69E0E4113D;
	Thu,  3 Sep 2026 10:27:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B5B124113D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 10:27:16 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6835muJV157999; Thu, 3 Sep 2026 01:27:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 LkxKLREdtviXtdPuC/EWjEzXTJvsHwfUIcfEkknIME=; b=NpophqPsF/BuobsmJ
 g6QgmSEic9yS08b4s1v42bEprrl9/iX12g1x9/mjieMesHrBeO3nT/p+kpStljoN
 I8Qi5GR/I0UlBsBp3pKkvtajPNtwz1E3GmvPIBoCbjMHkgZe9nCR9rFFSPkki4iQ
 Bg6YHFPK6dpTs3904cQ+GjAC7MO/YdowRIi9FVfM+Hd3z+Vtwvp4JwRVahy6eVyb
 3L+ZI9GnjwVFKJiXcwP7PDzCO9md+MilXjjSrRs3sUbC/HHzbjh7yhjwnfBcMEGA
 9SPiPiRNzXTHJW3WK71MosxqG4w1eIcDLdVjREw2OtTfzVOANaqsh284htxO9yxM
 gtEoQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gegb63rqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 01:27:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 01:27:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 01:27:15 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id A6CDF3F7068;
 Thu,  3 Sep 2026 01:27:11 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v2 2/8] crypto/octeontx: advertise RSA PKCS#1 v1.5 padding
 support
Date: Thu, 3 Sep 2026 08:26:42 +0000
Message-ID: <20260903082648.3610676-3-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903082648.3610676-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfXzN0uGKPA2AeZ
 LDl3uBJnGyx4i7OJHbTvnLbXJ3m0RLam8qF/zCREr7dAJo4hoKfOjK3kbycKWnukT2YJByinp1j
 qKaycbrCTlNW9OC23wJAcqKxoID7aHxZ97nNBEI1pV3uKcss7OF6+ENbTHB5b+Zt1HxIDBbiEpa
 HCNtrUPrlBZzRj8EkzBRw+lf1pzJ9UdUTHWLCU/RHUKK8p3SANvPHFlUf3lvBHnnRL/dz10ZTbM
 feewxxcpX+cRHotb3Kp8B69K7fWd9gAmrzcHQI7nsXlBYE4qPvHid3E5j/f0xEHMC/jR8XZYq4/
 LIKNoJAgfIl6FkF8ZB9rPpD8ABsZfCWHwj3+bSqCZda2QhTAT4qpr4nxNbJUKf+AtMw8Ngnn7kK
 iLvmdzkw574kOzxy8USgdilPwUhvl2r3pGw8eAjBwhjRvdz4o4MtNcOZ2QMtWcKmsjiNamFiMzR
 kdBdiJ/vO6ljVGvZnTg==
X-Proofpoint-GUID: TEf2z0OS_I9U4c5rbnEYLv7AuDidK5nS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX+OdKzBZDhOMy
 +burFrcW/BEG4foj9mF/1xNkGlIi6DHy0sEF9m8uUBONbqwLfei1DRxbz40oy+HJOTx09ZFGk5Q
 IQ7Efwclv5ADw8aXYzaxG1GYON31BjM=
X-Authority-Analysis: v=2.4 cv=GpJyPE1C c=1 sm=1 tr=0 ts=6a992f64 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: TEf2z0OS_I9U4c5rbnEYLv7AuDidK5nS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
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

Update the OcteonTX cryptodev RSA asymmetric capability to use
rsa_capa and report supported padding schemes.

Advertise RTE_CRYPTO_RSA_PADDING_NONE and
RTE_CRYPTO_RSA_PADDING_PKCS1_5 via pad_types to match RSA
padding support in the PMD.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 drivers/crypto/octeontx/otx_cryptodev_capabilities.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev_capabilities.c b/drivers/crypto/octeontx/otx_cryptodev_capabilities.c
index 80a9fe2123..8a70f81e1f 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_capabilities.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_capabilities.c
@@ -608,11 +608,15 @@ static const struct rte_cryptodev_capabilities otx_asym_capabilities[] = {
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

