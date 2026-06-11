Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C0CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 389EE42EE4;
	Thu, 11 Jun 2026 09:34:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DC58742ED9
 for <dev@dpdk.org>; Thu, 11 Jun 2026 09:34:12 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0R7Hh728963; Thu, 11 Jun 2026 00:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 iG2e7n8eMKZOlds9RDceARGPA/RT5YXbrMPt+CLgh4=; b=GZCq48vWtgWNYls+x
 OfFt4H7dIp82DCKmntrh+7z2Aa+M1PEzX54Lw6EKWaONgNFijw5NLvHiTsnbK7BV
 O8ooeoXfG3ToTqYqSSsWyEd2uSgGF6hVPYJI6LmmiHE1YHd59Ti+oCOn6tPkwWFx
 si5M1ZpCZWc2Vag0PpTxhhTNv1lj+98Lwb/jqM2dWzJmOO+FqU+URU4TFwef4Rho
 s3z6RjMvTt3pr0+DZVY4V2WDUhWg0exjum8lOgujGEyVxMiKYXRJ/+3ryzssExCa
 JxFKXmRSzo7wffYZThNqyOZKAQsSpJhXP8YHtelH4dxRuxDAZy6kuWCw4FaD1bzQ
 bIbcg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5r1yap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 00:34:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:34:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:34:10 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E7F785B6973;
 Thu, 11 Jun 2026 00:34:07 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 10/17] common/cnxk: fix event type for soft expiry
Date: Thu, 11 Jun 2026 13:03:04 +0530
Message-ID: <20260611073311.3129711-10-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX8lY1/zHIrPex
 gS99cOmMKrBwTJ+Sybtke2QNM0+g1iiismsaJ8DpAhEJGL9bVRtv7YdPfACBpN1lCgSyxTGWUVR
 cK4Ueph1BWP5OVvqpAM3kc8oTla42U0=
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a2a64f4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=gDTjZsJq8AtFptEswDsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: lBkUjGLLASBiU6kzPrkMZKoCqRnzW7XM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX0W5bfxm0pBCf
 RoNVM5FhLwdSpMIH3P65vBZ5eYlIj44Qkeh4cQQWAI6kxdB2pQwKY0aEVy7m6sqtETE6yoG1yZF
 KwdEUq1bDL9dhXKR44CFBRfdcXk4HNFV89IUVa1vc6hEf4fV79K5ieMhLRn8t7himkbKxpuzp/+
 bHQuMYLsDzqnlkndFRRB4fsaPVNpBfzpIjN2Z/+SRwO4wAObbpuHR2Tdbo/78DBL0Bmqrk+Hncg
 NRDC1Gorxl9G+QJaV3Xpuues5u5F1lYR/4rbWRuUnH4WRwkHCpLSoB5MYCe4kxhOZLse4PmZekA
 FP7/kozrgIYCLZ1Td6/LMmiCmuuxG8gA5aDJ446dYQkTB5VpMGGPnShSrviPqMch8GBZgoLXlF2
 Eu3vqz9Qp3/aJR9yZotMCstd9amThuumUG1BdIZL0lkqky4jLk14MiAJrSPXVXRQR4q+AJ2TYKI
 Th9OE8VnN+BpC/OwGzQ==
X-Proofpoint-ORIG-GUID: lBkUjGLLASBiU6kzPrkMZKoCqRnzW7XM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

Fix event type to default for inline soft expiry processing.

Fixes: 4a6154a7bd27 ("common/cnxk: fix array out-of-bounds")

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/common/cnxk/roc_nix_inl_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/roc_nix_inl_dev.c
index 667209b8a0..bfdeef2688 100644
--- a/drivers/common/cnxk/roc_nix_inl_dev.c
+++ b/drivers/common/cnxk/roc_nix_inl_dev.c
@@ -1234,6 +1234,7 @@ inl_outb_soft_exp_poll(struct nix_inl_dev *inl_dev, uint32_t ring_idx)
 
 		if (sa != NULL) {
 			uint64_t tmp[2];
+			tmp[0] = ~0ULL;
 			inl_dev->work_cb(tmp, sa, NIX_INL_SOFT_EXPIRY_THRD, NULL, port_id);
 			__atomic_store_n(ring_base + tail_l + 1, 0ULL, __ATOMIC_RELAXED);
 			__atomic_fetch_add((uint32_t *)ring_base, 1, __ATOMIC_ACQ_REL);
-- 
2.34.1

