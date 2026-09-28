Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85205C98328
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:04:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1604D406FF;
	Mon, 28 Sep 2026 07:04:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4D6E74067C
 for <dev@dpdk.org>; Mon, 28 Sep 2026 07:04:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S1vvrx1520638; Sun, 27 Sep 2026 22:04:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 xRj96mFgI9MRqIfPFhMZGo7EjDnPR0iyTh7p2l37WM=; b=XcFO1Dhbu0bikXm6k
 NujgckL5BhR2Fz3kpVVSskkJhBLNCvWta/3YAGE+KWKK7clFIi+rUEb76qLbxDm3
 WeMV3lAjVVew2SY7OzoXZiueVcY1owe8cjuKj0szYgJXTlg2Xyi9vetooY+lO8Vt
 8pEPxjatn2DoBAXEy6M4K5R5u90MOMj/5jvQVhzr/D5ehCDO/nLEde8+X8/CsFy1
 YnBIAFWKYAhzaPo1Ce4zV7IM3wHJeo0ZublBTzjEF1B0kUI7920IApDqTEgASd0l
 HcazVlAUtYPOF2pTf2OiSWAXlDRbStxFi8gfuqwZAPoZ+m/wdkVknlOqyjkev21C
 2DJlA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxxt7syyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 22:04:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 22:04:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 22:04:49 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id EC79A3F70BD;
 Sun, 27 Sep 2026 22:04:45 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v4 3/8] crypto/cnxk: advertise RSA PKCS#1 v1.5 padding support
Date: Mon, 28 Sep 2026 05:04:07 +0000
Message-ID: <20260928050412.276760-4-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928050412.276760-1-ssarananaga@marvell.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfXyKX6e7+Pb78+
 8/gdEjWGDwI6XAkZaswwcGnNqlr4eH2PlZjHUfFV7jbjDWZAb9NwiiTXMz/Ljk9NsKVQPdJOANh
 V0cYSBykjijHX4otMtO5tm4lzU4D2r0MSHyKIS3CJ7PMzRnRLl8pX0EOrtO9PI7LmtXpboKAfcO
 B+4gHuOQhctrugvHMmYEQL/ar39JS3hDnAQY1VC7YaPS/J9Alkfp+hwPFxdqQpbkyz2OzJ/oC0/
 r0VSGAP2U3I52bxBCTHH45BHtTfjuUAFwaLGOAH7tUkUHhlhb+q+ow4xlz2FyHW82NA4JWl9XIv
 scgVX8BDLCcsoCD8da5rslIHv/mPCjVFmfZUuDs3ZX35jgXWpTPtYxIWuJh5MlcLeDBz2rdgaJn
 lt6XcMcyrzzhPmiOT5eAyguoKkPKw5btLgRZbIGJq8/LGXMfAFcw1iF9gc+QQviDiS79yDNdgzM
 qPlQXUAANL80UqsQCig==
X-Proofpoint-GUID: gYx7krj3aQlPGyDrLBQzVPIQ-YfFSgjy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX3++ypVLINP0s
 bniRgCH+2ff4lLeaIrWr39ne/ZJmt/WXNa9k/FguCeXmdA3y63DmbK69YRTZvOVPgLAXk8qlfVM
 B6dhe3QUdXr7i11PJWQ3YJC0zpg2XWY=
X-Authority-Analysis: v=2.4 cv=YaEodARf c=1 sm=1 tr=0 ts=6ab9f572 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: gYx7krj3aQlPGyDrLBQzVPIQ-YfFSgjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
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

