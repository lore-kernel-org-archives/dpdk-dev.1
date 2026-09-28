Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18321C98328
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2089C40685;
	Mon, 28 Sep 2026 07:04:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 18B4240685
 for <dev@dpdk.org>; Mon, 28 Sep 2026 07:04:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RLfcX01042510; Sun, 27 Sep 2026 22:04:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 LkxKLREdtviXtdPuC/EWjEzXTJvsHwfUIcfEkknIME=; b=LjK872S8mz+fMF5tW
 +fCVo1qo52/Nbv3XeaRsdNxVXAVgavMGVPs3lTHOMZFoBL75Yns6vPBg1IK88lD3
 RAd7lxoAEh7L2GJ7Ztct7PjS2c7dZ8Pik1HQ4lpouq03hTgJXSZadpTsVnwH4twc
 r41Xb4gEWyBo0IAFji4kvklRqQWPi5lJckB1b3PhUvdSKcdTGXfopmzxofbtRRsR
 QwIhhs2/xfCvDhWoJdEjPWhD723UlgvArlwpXd/Ty84omFtc3sTyFH7adXBn5Req
 E3fUtBHhhFSGoOAcQQXknU7SXQQAgyg/uMSJxgbEgaVUAgUcoxvavwYJfeMhNq7a
 /Z1uQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gy2a6huds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 22:04:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 22:04:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 22:04:45 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id E722F3F70BD;
 Sun, 27 Sep 2026 22:04:41 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v4 2/8] crypto/octeontx: advertise RSA PKCS#1 v1.5 padding
 support
Date: Mon, 28 Sep 2026 05:04:06 +0000
Message-ID: <20260928050412.276760-3-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928050412.276760-1-ssarananaga@marvell.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TzxLT166OUBQVUHxi2sPFamvLnZWbdFK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX9XmPT51WrwJn
 DnYB48L4Fzn8HA6h0zYHHkSPi2/OyOYceKb2ohveEeBV5Yf0A/GxuUEpgX503wpci9Pm00nVx4w
 akis/242RMsE3VHFmyNEf/CWSKPKh4g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAxOSBTYWx0ZWRfX4EefcVNBEvRj
 +q76QiA2aukF1ypbvLw0F2NI3+gTPWIFrAy53cSXPciop28Wr3TdWXJejHa0JFI4yGbH0ywxvjN
 jgVkbWrAm22aSjYMlizcl3f+rAp2j+sW5fHRUTMSPE3s+Susj8y3Mk1CkQqhll3w4RJMDJwcN8t
 KI7fnWhogagf7IpztWWbE8DSXrFzlWptvDrjx0IQ3Vn6R9CYNygyEEqDC6kAd9S2BS8x7gAIysZ
 HbEBQJUveR3W+JcOAsXsNyby1z6Lbg3EW8VUqr8sDOUW7Lml9XaIr7TRiJ01FmvTjTWRilUi0Za
 rumRAAOFellaDSW2BjuzNWRJt6ukDrZcVdhTIaIrtBG77JFWIum+j6HLBzmsy1zO8qHTe/RxBFA
 O3wT3qXUtrT2p97pd9d6BULaD92Mrg0KYx+B+iMEI7kCruFx4xPuxDFhFNuvAkPRGy0KFv8dISG
 4LjCNFrxAz5vA82KzXw==
X-Proofpoint-ORIG-GUID: TzxLT166OUBQVUHxi2sPFamvLnZWbdFK
X-Authority-Analysis: v=2.4 cv=DJIacCNb c=1 sm=1 tr=0 ts=6ab9f56e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

