Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9170CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 04:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A0A940280;
	Wed, 27 May 2026 06:13:21 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AEC724021E;
 Wed, 27 May 2026 06:13:19 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QNclxf505553; Tue, 26 May 2026 21:13:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 tkNqrC0QxqGt1dkT02SxdGVyWW24rO1CN7ZsCWbUDs=; b=iDRPJnvV62uA/IbCC
 CDa0aIZD83xZaPrAX4/ezU6fH2ZHw4EcT49NwgQnakLM9OCIt2qKO+VABFemM2nG
 hw6NNKQqET9T9oE8tDpm+5uuB8tbuGuPboCIskQkobs2xwERvWg5cDAY4larTrYz
 aR+5yT3BECi5f+RiEV4rfflB1d9vQzRwSwfR+7ic/366kY4R3kkhHvIYJZy33fHj
 Jgpo0/iu2HMzEorxHdculiicqXO+3WLQQC5mZcWf8C2VjavcgeTDE/czLDROpyiE
 sphoWHU6528L1kllUPgzfTpS+KU3o8WFDuwpu5DCTRnwyUbneXV0/GGMSs3wm00B
 A0Nnw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4edncfgjq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 21:13:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 21:13:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 21:13:17 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.167.66])
 by maili.marvell.com (Postfix) with ESMTP id F1B553F7073;
 Tue, 26 May 2026 21:13:15 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <stable@dpdk.org>
Subject: [v2] crypto: update asym xform strings array
Date: Wed, 27 May 2026 09:43:08 +0530
Message-ID: <20260527041312.1801-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260430120533.2004-1-gmuthukrishn@marvell.com>
References: <20260430120533.2004-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDAzOCBTYWx0ZWRfXxicwpbvx7CpZ
 ombqppy0pzLbfrmzazeRhBhP2p+JTS025RV44MSybbfDvSydHSIaZGUw7S4IZfrx3FB04jCVtvt
 wgIOCLN4Q9Gcy4jrxnGzq2pRawqcIfffpjxtHbahckMPGcuVcMAG8FdG3LmGKwbqw+IV5fyWcmC
 Plu1XNqzOIZ23BwyObAZxCt87bnY3UjvI8KJow+ukYNYQWZsTpRhU3l0+La7f4/W13W+aPGAhTs
 fOZmCXOEyhpPCTbLFlSTBmO1q4KMzdw0cET3CjZjuqIgwJ9l/P6dHhSIdrPpCpeyZ4+qHMQyJFv
 VDMv+MTx1lbaQ7HbatlBLlzlXLYDEnSGPfHNPMwpy+L9QRrV6LfZG+U37nS6/lhwQhixV+IyVcu
 8gEQlCTdIm38N/TmrN8DWiH4mjaGlwJJ7q8WyMF5p+LjqaPioLTwSlolz+PrVbFzAgJmBpLhMin
 s6x1bvPN29RTmsH0Grw==
X-Proofpoint-GUID: QkZ4xYKF18TXfadB6fTQQkA1Ll2Fs_DU
X-Proofpoint-ORIG-GUID: QkZ4xYKF18TXfadB6fTQQkA1Ll2Fs_DU
X-Authority-Analysis: v=2.4 cv=C6vZDwP+ c=1 sm=1 tr=0 ts=6a166f5e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=pUfJzdPplwL8KQ8WlckA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
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

Update xform strings array for missing algorithms.

Fixes: bd3745e29065 ("cryptodev: add PQC ML algorithms")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 lib/cryptodev/rte_cryptodev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 50071935c2..53210e52d6 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -214,8 +214,13 @@ crypto_asym_xform_strings[] = {
 	[RTE_CRYPTO_ASYM_XFORM_DH]	= "dh",
 	[RTE_CRYPTO_ASYM_XFORM_DSA]	= "dsa",
 	[RTE_CRYPTO_ASYM_XFORM_ECDSA]	= "ecdsa",
+	[RTE_CRYPTO_ASYM_XFORM_ECDH]	= "ecdh",
 	[RTE_CRYPTO_ASYM_XFORM_ECPM]	= "ecpm",
+	[RTE_CRYPTO_ASYM_XFORM_ECFPM]	= "ecfpm",
+	[RTE_CRYPTO_ASYM_XFORM_EDDSA]	= "eddsa",
 	[RTE_CRYPTO_ASYM_XFORM_SM2]	= "sm2",
+	[RTE_CRYPTO_ASYM_XFORM_ML_KEM]	= "ml-kem",
+	[RTE_CRYPTO_ASYM_XFORM_ML_DSA]	= "ml-dsa",
 };
 
 /**
-- 
2.37.1

