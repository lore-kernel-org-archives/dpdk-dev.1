Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58047C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06B5740655;
	Mon, 31 Aug 2026 12:23:57 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E124D40655
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:23:55 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V860UZ204322; Mon, 31 Aug 2026 03:23:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
 LkxKLREdtviXtdPuC/EWjEzXTJvsHwfUIcfEkknIME=; b=isyoQGkskc1Ky9fNW
 WDNBrnT6rBHmwdhSz0vxq0UQDCSO0b3hwYV997ZF5Jbf4pySIH5w6fcgnYe5UZIO
 7pOQKFKYIQ7FdeRzbRTmcJUs3duYZ2t9NgGTT37fyEPF1fHQsv+H05bZOgAnNB/4
 c9K4gEieDb8GVKPK/4JzLpRuSQp6rhOKGraxvZoae2D/c57AI5QV0BERu9+JFhEe
 sBbJM3EhSneMxno/roN0lWzi+hCjkX0iBrYTETeB5ZyG/nWvS+yhhJNrqh/uwUEr
 Fd0emeVDx0zJy717GyopufudMNw+37AYFrTifXSrc+i/xRNLqzt3ciOOKAZ2FQjA
 GbxFw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8j3d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:23:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:23:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:23:53 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 435273F704C;
 Mon, 31 Aug 2026 03:23:50 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 03/10] crypto/octeontx: advertise RSA PKCS#1 v1.5 padding
 support
Date: Mon, 31 Aug 2026 10:23:21 +0000
Message-ID: <20260831102328.2813604-4-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX5jYG9gB9PYE8
 g71Cz9U2hu368jGr2ZPuNDm1gs8BVwWZtXw69YV1s5Hn7IL4Y/lq208xdjCfBiSfFH8YcF2xv+w
 pcSGO6GaFZGCpp/aNoYXAuNXftQZ0crFhA3VXXHqO85Yuu7XQK15sBqiVPv8irxfBLlAEpPreaF
 4FHu8XuouTxNcYIDsY4lbBqyArux9TiVpqvXWhaDbMiNl4aU2eLzW3Xi0mtYJ7+erv27slBcfen
 ac+aEZteE97FAKNhzBoZ/vEE5QTJeKKS//jDbHPE/zostC5uJtfH7r8293D1AaFZaVC1Rhq9Yxn
 KKF5e2XJKs3RXRudxqB/pef3+xtIocBoCteFtmlAz515qMTLVJ9hshS3zECpyHr2dD89aHQJZyz
 4Yl8X+RC2+9OX+DimIT2GsqsbUQYQivnsZll/TB5QXBcxfGCLb/I6sA2kX/yAtiDvSGW8Phn0tP
 uBMwjPCIOnCg+O3VyjQ==
X-Proofpoint-GUID: TRF0fDrewnuvfgObl3edH9aedkxkKFgn
X-Proofpoint-ORIG-GUID: TRF0fDrewnuvfgObl3edH9aedkxkKFgn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX/AfSUAj9MZWW
 8IqEZ3F5fwHzAwqUCCNnMfICNh1mOsEdkcBK+MYkzh64tEkuLEvKhVBHR9RdR20xsqeBheW95bz
 ilXPOw8CFmbaYFfbW7PjOcQvzsMbOR0=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a95563a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=fIrzOnsVuvAh4eYyrfwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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

