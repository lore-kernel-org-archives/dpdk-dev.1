Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F33606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=J1ZD+L79
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F8334027B;
	Fri, 30 Oct 2026 06:38:05 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 09B674025A
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:38:02 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5DHnD508163 for <dev@dpdk.org>; Thu, 29 Oct 2026 22:38:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=XBcJPNVWi4Q26KZcBUwhpOo
 1bHduXnevtTGPI7TaTnQ=; b=J1ZD+L79pnSiw4R98svxmF3X+fQtMwtU6PyzKIT
 /qjmwNb7AqCopdK1g8Sgp4BgUR0f43uzx6+GLnpjVQUYSr7k30cRGWruoo2FP568
 3h1RYChDfvKlJ/9aGICNI2WRSdZlPpy4jfUHk4+PC7k0bZy/ZocS6oqSwW7A4MZd
 eJc3Esp+NoL9Xbv+XiUKntJ8mle9tdZSHz4j2mbBMW519I9qSfMsvse94lHW4395
 UO0lxcp5cFSd5YZJS+0L71n/qkuyFhbziDiUbftTis/hjIXOSuWqO2hjTHIEnXD0
 Kkdg1DgmSxA5JlkAEBIJi7vs83UkhTixxLpIIO2k/SyLeng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hme5ysfpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 29 Oct 2026 22:38:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Oct 2026 22:37:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Oct 2026 22:37:59 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id C912D5B6951;
 Thu, 29 Oct 2026 22:37:56 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH] common/cnxk: handle increased count eot width for cn20k
Date: Fri, 30 Oct 2026 11:07:50 +0530
Message-ID: <20261030053753.929279-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PIaaavqC c=1 sm=1 tr=0 ts=6ae42d38 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=k_itohQKRrvpbA88iAQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZmMIs9Jcrfs9zNceniFqOyvUsrSn0uim
X-Proofpoint-GUID: ZmMIs9Jcrfs9zNceniFqOyvUsrSn0uim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfX+Jj4uI8cnF+B
 tzrQULvM2vkoyWoAloPzFdhXelnmulLuwmCHrTnSE/K9ljCPorQ0aQYtwke/vG7Ls59jYAgCQtM
 LzJ9BUTkrAa8IfEAkY6uWA+MBSxfqpho5OCXl2iw8/gfSUfgUpXCOoOJ6fNP/2wLpFoL1a68OY1
 d+6ELcirJS4VJgYos0LFVWJYA7yaXPqHrSbXuiFdhlsm2J8gLRVkpP2OtNMxIK+kBCo2yy8z8+Z
 ZedC0bLTZIdRYVMn+O94yzG8DA/PTI4RDnxK/7YY3aOZEinwffLrAOMsSHNjdrsJWTDgqtdQkZX
 W/9MIySUnk2s9B5N2r73sL+5TqoC4XTJpT3vI2K2jWHtqGaXl1xvsyLoDdh+7XlH3s/Y70PtLRp
 5efcNySlZNQvuvIrfV0gGMimIlNCIVrfAmKCMTH2mML/aRx3wWlx0Lzk5nn+Nh+Z1gOcYFkaygL
 DQS5r+fpmNzONEPiX9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMSBTYWx0ZWRfXy3blBcRWmPz5
 1oS64aitsJ+hnR0/ObzCdEf3TsZKCAsEzcDNXQhYVVTe6Eeb9qhHdjkd84/jHgbK6iRrX2udx8k
 cTuhZKNZUNJHbFSMp9R624TwxbbsE6w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The COUNT_EOT field of NPA_LF_AURA_BATCH_FREE0 is 1 bit wide on CN10K
and 2 bits wide on CN20K. Extend roc_npa_aura_batch_free() and
roc_npa_aura_batch_free_burst() to write the 2-bit field.

Bit 33 is reserved on CN10K and is ignored by the hardware, so the same
value can be used on both models.

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_npa.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.h
index df68e13ec6..a31f908955 100644
--- a/drivers/common/cnxk/roc_npa.h
+++ b/drivers/common/cnxk/roc_npa.h
@@ -509,14 +509,20 @@ roc_npa_aura_batch_free(uint64_t aura_handle, uint64_t const *buf,
 	/*
 	 * NPA_LF_AURA_BATCH_FREE0
 	 *
-	 * 63   63 62  33 32       32 31  20 19    0
+	 * 63   63 62  34 33       32 31  20 19    0
 	 * -----------------------------------------
 	 * | FABS | Rsvd | COUNT_EOT | Rsvd | AURA |
 	 * -----------------------------------------
 	 */
 	free0 = roc_npa_aura_handle_to_aura(aura_handle);
-	free0 |= ((uint64_t)!!fabs << 63);
-	free0 |= ((uint64_t)(num & 0x1) << 32);
+	free0 |= ((uint64_t) !!fabs << 63);
+
+	/*
+	 * COUNT_EOT field is 1-bit wide in cn10k and is 2-bit wide in
+	 * cn20k. However we can consider it as 2-bit wide for all cases
+	 * as the upper bit is going to get ignored in cn10k.
+	 */
+	free0 |= ((uint64_t)(num & 0x3) << 32);
 
 	/* tar_addr[4:6] is LMTST size-1 in units of 128b */
 	tar_addr = addr | ((num >> 1) << 4);
@@ -546,14 +552,19 @@ roc_npa_aura_batch_free_burst(uint64_t aura_handle, uint64_t const *buf,
 	       NPA_LF_AURA_BATCH_FREE0;
 	tar_addr = addr | (0x7 << 4);
 
-	/* 63   63 62  33 32       32 31  20 19    0
+	/* 63   63 62  34 33       32 31  20 19    0
 	 * -----------------------------------------
 	 * | FABS | Rsvd | COUNT_EOT | Rsvd | AURA |
 	 * -----------------------------------------
 	 */
 	free0 = roc_npa_aura_handle_to_aura(aura_handle);
-	free0 |= ((uint64_t)!!fabs << 63);
-	free0 |= (0x1UL << 32);
+	free0 |= ((uint64_t) !!fabs << 63);
+	/*
+	 * COUNT_EOT field is 1-bit wide in cn10k and is 2-bit wide in
+	 * cn20k. However we can consider it as 2-bit wide for all cases
+	 * as the upper bit is going to get ignored in cn10k.
+	 */
+	free0 |= (0x3UL << 32);
 
 	/* Fill the lmt lines */
 	lmt_data = (uint64_t *)lmt_addr;
-- 
2.48.1

