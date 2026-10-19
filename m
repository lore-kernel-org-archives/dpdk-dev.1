Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11539CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6562406BA;
	Mon, 19 Oct 2026 15:08:11 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1ED1340693
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:10 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OLnq110515 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
 HenqDp4AWNMfeNyhLOeTFfe4LNjU56HCiaKoybGbcs=; b=RmpACoM2DrlaNhIX3
 EiwgtuFLl+D0v5U8vAZ0gYIzq9IUgTBTDIXFBzJRVpko+tppZcimnSvVTtF/FjQS
 6ZptbvEzyzPzloxWBW9N4KcnGVpHQb+ZaSEbEtX9fSu+Sd/ceMm+NhtEwhqJiDfQ
 7UaOVFiFFWZ+vHBOKQD6Z0wo3jc3rGSJ1qU+TFyBW8GE7ECM4l1i29Fj6NAGoFo9
 YPL3nFJjscssi1f7Q8BVVaCUBM1ACQX/pMxASvk7MbbjRSuDELCNI3ZdhKfvFdfe
 DIc53s0ymEwi1CaWZs/T28OkLzbQMYf9deTS+8CO06wC5J4+JRBWJ7P+1KUtRoGd
 0I2/w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4ym0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:08 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 09ABC3F70B8;
 Mon, 19 Oct 2026 06:08:05 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 02/16] crypto/cnxk: return HW CPTR from cptr_get for cn20k
Date: Mon, 19 Oct 2026 18:37:43 +0530
Message-ID: <20261019130759.2181566-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tpuCJe1sRf1mWCiKvHyn2Xfl1Zah0hax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX3a2X6Lzbu23o
 xaWT7EvU9p4UsMiLAU+aGhhGRJJB4AAaJKwAKCDuDU211FBi/7IOGwuNVy4WBKVb69Rl3cLtBuy
 bKWnpH9QVSWPOvlLC/eX+wOub0mXy1m3WczM9YfAGR6TmY14vlxCJFJlQFHUI190vxqjVsJijRI
 rQfqusTQi6djjZ0+OXPgLXmzUvL5Xa+tWJRTHdUseqy+q6TR05OxI1/DP/0qTuHhue0FW/xW7ci
 Yac0OfLuVX19+SP/Xd8Q4XH/4Yog/w1HKqpeEoy4FV96GDJM/du53eefHjklwIvt8QPJ37JcWlK
 8ozvJGcYxXbH7yZNUYBMN6qKXOkr/NcUpbSF4j/hp+Uup+yMN8riRxVpmtW0vPtKVTUPwv43k3k
 pIlu4kO0curMQBH6RimFjSkMwnuxFObDBKVecJBexjiArdITWR7ebO/jXvLR8eXCjGLc+WsdRor
 lFxXkG8F43QlyWK4Wlg==
X-Proofpoint-GUID: tpuCJe1sRf1mWCiKvHyn2Xfl1Zah0hax
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXxSgW3OecMslx
 5/fF1W3aHAr0KnnUwHfJnjirnkZbbrDrHAcXXdYF0Drz0Tncl39Fzt9HuB2hbYPm67XURDDUWiJ
 K/07GPP1x2l1zqlYG0Io9fWdJU1C3To=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad61639 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=awJWYGnfD9vRpg5u9u8A:9
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

On cn20k, security session CPTR is allocated separately from the SA
wrapper. Return the HW context pointer so cptr_read/write use the
256-byte aligned buffer as documented by the API.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 4c9bacecdd..6553ac90a1 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -1294,7 +1294,7 @@ rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 		if (roc_model_is_cn20k()) {
 			struct cn20k_sec_session *sec_sess = PLT_PTR_CAST(rte_sess->sec_sess);
 
-			return PLT_PTR_CAST(&sec_sess->sa);
+			return PLT_PTR_CAST(sec_sess->sa.sa_ptr);
 		}
 
 		if (roc_model_is_cn10k()) {
-- 
2.43.0

