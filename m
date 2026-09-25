Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB02C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:15:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDF2440DD8;
	Fri, 25 Sep 2026 10:15:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F1BEC40B9B
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:15:36 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4aBpp2352472; Fri, 25 Sep 2026 01:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 LkxKLREdtviXtdPuC/EWjEzXTJvsHwfUIcfEkknIME=; b=d5Oq6kgojHc99rmQw
 +f8g24KRFRPq1oe7EJenQvG+mz52/GVLWGW05iNbZMkvtWNiNvFSPCxVGq5qBMEa
 23QK2E0XAtjThCvkd3ROAhybXkqKWvldknUUbKJ1RZFia67AuzfOdaFckksnXTv6
 a1xeMBN55+meDIHR4nERuNHtcg6BkWAOcdxQYs/vM7X8vIBx6yxG7OckEoz/GqjV
 NbGaNJDxzP2sG17TPs6if8uwvz1RiJPFD1c6sWkeKf7ju+NoXgz9zPxvMTMuTXdt
 DysPz1AcGSw7Dgb3aCQEEnza+FeLOvXa/5+/+XSmLUJQ0bQgFPzIyUJBXaSfbvHp
 dr+JA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gw75busxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:15:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Sep 2026 01:15:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 25 Sep 2026 01:15:33 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id ACAB65B6954;
 Fri, 25 Sep 2026 01:15:30 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v3 2/8] crypto/octeontx: advertise RSA PKCS#1 v1.5 padding
 support
Date: Fri, 25 Sep 2026 08:14:54 +0000
Message-ID: <20260925081500.3848187-3-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925081500.3848187-1-ssarananaga@marvell.com>
References: <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260925081500.3848187-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=M5jYuCws c=1 sm=1 tr=0 ts=6ab62da8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX1gRzf8C0FiYM
 Z3M1NHBz995MMgHJtwkOSoxWOUrM1+QKoFUjvhiEO9HeC5FVKU1eveluFWap0ff6+pq2cZc+q40
 ZY0jAin2IGrgd+KA+0ZEE/g82/7R3is=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfXzngL//QlNq4T
 2FgGzw8i0zoGLydlY6nFiKkh7WqqD2HlD2OLeo27Q94DmT3IKaFhR2PbbF8ROjoh3Fx6kFaRIY3
 P4Akj5xCjjE/ZXJx55sGhyRmPoKs1Hj5UnIgGZZS7z0zt9EFwlLd34Us2RV0G/5bAN8zTdXrvkx
 yTPRTzQ9ZHcY+K3hKZJ/sMIZOB9l5t87aafOGJLrNPJSkxkGS6CvTQ8THOXyiqz+i7GfC8jCs1D
 +tZhVsEXlytbIZcIqid3XiWEXtDlp0Xdp/mLLjZualFEiQzsWs9YzByFYqnYXt3KKaSrIDcQwRl
 Yv4NMQzEfGZYVrVrRDaTKW6CWYMIcqwtfSY1H6/43BEh+ppSnrSijwOZkPUHec4uGEi1CPZQE/4
 xZYcNIBMgDcF1YOr3/ZUp9H+aW0Gezoj27hqwLcAb8vZMkqDuRAoxF1TSuFF3Xd9iNg03J8XqgE
 15LLwQN/KWRXIyi7eEg==
X-Proofpoint-GUID: T-aZe5FpHahLMQmjKydNKdng0Qmq_DEN
X-Proofpoint-ORIG-GUID: T-aZe5FpHahLMQmjKydNKdng0Qmq_DEN
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

