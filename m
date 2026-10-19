Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99746CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C4840B9A;
	Mon, 19 Oct 2026 15:08:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 34DC940689
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8O1On288002 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 6MJ97Wp02bjsc7UvnrWI9YqkuegofMfwh0uE3LyyCs=; b=BM2mt+FRKsb9wZz6p
 nKPHQ4+VLOcv+M+7TW1Ch0D1iZAoH1/2HMx/aqUHXrIjSlE5lOWJgCynOi7C6SZx
 1qV0tfqoGC1KOx1AtMQkn3ZwoWxwp0j3wCZ0w4SjtgDZkicy7ZKHWAA5vRtxDNJH
 Xz1R/L1xz7qNyZCpIN6pA3eKa3VsUXlm8NAcpbFxL2MhIeBADa1Wjg5P5ynGqGOq
 VpAl8e+0HR5KsprIP6UghmtsMIqsyPdBT4qJLnOkrd90BSj7co2DmCEemW8CkLTT
 NvgtzoW5U3CgZwU7Jr+zZbBOrNdbWP+QJJ6oFux8BN1nlp37f3a5FdEh4OOfQqMd
 wk+BA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hcss7b54a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:30 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 22A283F704D;
 Mon, 19 Oct 2026 06:08:27 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 10/16] crypto/cnxk: enable ctx cache for cn20k crypto
Date: Mon, 19 Oct 2026 18:37:51 +0530
Message-ID: <20261019130759.2181566-11-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RdAFmFtv c=1 sm=1 tr=0 ts=6ad6164f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=1u80aLLQ2hYdOIrON-wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX2mM9Q+S+GQYm
 sokVsyk6DAnyBeGCPvbqgKKlDjz/a9xFLLOLCg6GZ2Z2KGi5tMNoVK8ZleRdzXiLRlQ1xmeAPRA
 pZYtOt/RLtdbf5iXCS3YlG4xE75RrcU=
X-Proofpoint-ORIG-GUID: mf8W55vtB2aYu-VxFOb1m_hJRywRrXZN
X-Proofpoint-GUID: mf8W55vtB2aYu-VxFOb1m_hJRywRrXZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX/1cFxJ81vhp4
 z8QxanEKyU0v+NBlZynnp8Ttf27DaLnvl468keas40+Fxnbq+Vt+dmqEv1NywhKjRo3NuSYUg2u
 3nAwWXjgQIISNOeOhad+Rd1Hzr5pQfHK00KFq3neDa/P1bAorEMcuMy6eLCoCywqurX/lihyTZw
 wy5pXjGEzvVfXkIUIHE0fvF+pc7GjKkY9CbRFgZXwI3S2D5OLoXjQCbHyvWwcyOTKNurJB1c0bw
 6Mc2MenlVPUNaLUZZ4YfXlF+N7hpSvPbrG5piV4bTVlGkffLg3fwphPgOPjdlyBCRHR987Q9Xel
 pddDdp0pQ/x2SrQfgc8SOyl1MV/+8/zWx30xGEPhiQuhmB0sso1TyJb8c2Ym9y59wFHnTgRjwLa
 FHNnva9MZoosVkdp4LLCiKhjQGb6Hcm2ug71CdyWw6v7pOaDb/C7Gek7+rZ0GV2qw1Uxqv8gicI
 PuAzMaICEg2dC/l8Wcg==
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

Enable ctx cache for cn20k lookaside crypto.

Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 32fc7a26fc..7bf26d67dc 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -227,7 +227,7 @@ static __rte_always_inline bool
 hw_ctx_cache_enable(void)
 {
 	return roc_errata_cpt_hang_on_mixed_ctx_val() || roc_model_is_cn10ka_b0() ||
-	       roc_model_is_cn10kb_a0();
+	       roc_model_is_cn10kb_a0() || roc_model_is_cn20k();
 }
 
 static inline uint64_t
-- 
2.43.0

