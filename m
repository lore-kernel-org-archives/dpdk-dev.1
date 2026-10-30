Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF03606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=HwLrBOvP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDE084027B;
	Fri, 30 Oct 2026 07:39:23 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 209694025A
 for <dev@dpdk.org>; Fri, 30 Oct 2026 07:39:23 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5DXa31210303 for <dev@dpdk.org>; Thu, 29 Oct 2026 23:39:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=fXza/ivtbnmkvLeXKW9FAd7
 nG2gHeBLmNqz0lmF5y1E=; b=HwLrBOvPvFKM3OQ/j5HXNlMIYONztvULRriIfhb
 VTjBeqUxKZGx1ZjfUAY0h/4UjQXJWwD+2IgtD4Nji4ypsJ801e2EP1eT4e2Dl5Ao
 DK4N/bbIRaT3SY/4xGyJTvmYcWW8iO+RiaIV+yPd7q7XJOVwP9Fc/SXh9GG9idVT
 CvtX4QR9Spd/jOzEgKpkbErP2uFRxVm07rJVLZaR1Bwqa4FTEh85NsZjXPiLyFIi
 aBRjZ61905wXxODnPhfInClUM2kGijEWzLzzAzWJR6SfZoMu+PQL169tcUYOqdHX
 PddbMjhV4GkMJ6JUiyA/Z1JG+Wa1PjthZqKYT/fnw5VvPdw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hme5t1jmp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 29 Oct 2026 23:39:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 Oct 2026 23:39:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 29 Oct 2026 23:39:21 -0700
Received: from cavium-DT-30.. (unknown [10.28.36.108])
 by maili.marvell.com (Postfix) with ESMTP id 175185B6950;
 Thu, 29 Oct 2026 23:39:17 -0700 (PDT)
From: Nawal Kishor <nkishor@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, <asekhar@marvell.com>, Nawal Kishor
 <nkishor@marvell.com>
Subject: [PATCH] common/cnxk: disable flow control on pool destroy
Date: Fri, 30 Oct 2026 12:09:12 +0530
Message-ID: <20261030063915.1016749-1-nkishor@marvell.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyNiBTYWx0ZWRfX2Q1YsjGDVkOs
 NluKeg1MLAa1UhXD92HVM1YqReeLyRROQNyZSx8qu5vXDm8X1PDRlXCenyck53K6UhsVnAXW69p
 JPz6rNAG6R6M07FYJi9VJe21HcmGlBzxiE5S7VjCBJeNJtm0HNRkW65bLL/BhKp5EKJhJm6aJ0i
 GMnxss80QqHCBR+Gs+MXowqrbBjk4W7qj21oZ+XbHhS8nbhhV6D+Ao+VeO/xNEFE481lgnJ2BNm
 0FtS+lp+YI1kOIAoZb2peiVtbWwCIzaFZU0Kt0pweLlXsqGg5+8wZ6f5m/eBpOMDOZjKA0KrqJb
 ipWDQ4ylgtiRl0HDKbX+bCoTHzCRVLKL4CBjXkpyJRhainSGb2vk1IfYQ27npjhYkWYqbUOGG6y
 uFEmBeCHuQp5PE/mfcSTZUHo9TIiipwlKge40hY+jZF3FHrZsvQz3TkxphBryPjSSQn8wt8yobH
 mBDQGllNvUCC8TNfDxw==
X-Proofpoint-ORIG-GUID: jW3CXBQsAOLuqdAZuCzUAxEdLKCrk3aE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyNiBTYWx0ZWRfXz/sjeH69feQm
 Ru7EPdGkKg2UhutAs1xRvcLmegCboSy4JLTjViDEAF2SxhYLdlc1uqQ3uftRt43mHAOYXqhasP1
 btnZLBRwT/InOwXrQnPmlUUdl6Q8+FI=
X-Authority-Analysis: v=2.4 cv=G/yJgNk5 c=1 sm=1 tr=0 ts=6ae43b99 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=wtwrdZLKO400_f9xmhQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: jW3CXBQsAOLuqdAZuCzUAxEdLKCrk3aE
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

Disable flow control by clearing fc_ena together with ena in the
pool and aura contexts in npa_aura_pool_fini().

Signed-off-by: Nawal Kishor <nkishor@marvell.com>
---
 drivers/common/cnxk/roc_npa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.c
index 5075067cbd..425bbc782b 100644
--- a/drivers/common/cnxk/roc_npa.c
+++ b/drivers/common/cnxk/roc_npa.c
@@ -366,6 +366,8 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 	pool_req->op = NPA_AQ_INSTOP_WRITE;
 	pool_req->pool.ena = 0;
 	pool_req->pool_mask.ena = ~pool_req->pool_mask.ena;
+	pool_req->pool.fc_ena = 0;
+	pool_req->pool_mask.fc_ena = ~pool_req->pool_mask.fc_ena;
 
 	if (roc_model_is_cn20k()) {
 		struct npa_cn20k_aq_enq_req *aura_req_cn20k;
@@ -381,6 +383,8 @@ npa_aura_pool_fini(struct mbox *m_box, uint32_t aura_id, uint64_t aura_handle)
 	aura_req->op = NPA_AQ_INSTOP_WRITE;
 	aura_req->aura.ena = 0;
 	aura_req->aura_mask.ena = ~aura_req->aura_mask.ena;
+	aura_req->aura.fc_ena = 0;
+	aura_req->aura_mask.fc_ena = ~aura_req->aura_mask.fc_ena;
 	if (roc_model_is_cn20k()) {
 		__io struct npa_cn20k_aura_s *aura_cn20k, *aura_mask_cn20k;
 
-- 
2.48.1

