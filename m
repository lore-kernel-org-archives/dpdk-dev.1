Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F54CD6E60
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C87C40658;
	Mon,  1 Jun 2026 12:16:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A63D840658
 for <dev@dpdk.org>; Mon,  1 Jun 2026 12:16:35 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64VMB7CE1251586 for <dev@dpdk.org>; Mon, 1 Jun 2026 03:16:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
 6tlZbymavMNbezrUIpPuVk/tapiyCi/9Sm8tefcuos=; b=UUPGorlQ0r24Nf8Qd
 MREUPNEARK9OkXR3cLnKVyg2F3Llr4mPz70l5SPVG10XEraRYIfdleFFkeFOg8a9
 6rcVpt/WBWaNS3wsvi/371uDL7vLvtSiD8zz9h46CfrBc2Aphab4x0xZleriOUIC
 NkCM1/V2433i6vvPFGyHJerxb+sQ9t7cIF56z+9cS7/9lzZLfEVxtiNd0welLyGU
 3FbZjZIKXFujIgoMGcUnM0m/TdfA7tKJlxE6j3dTUUdpWm0YUKqK10QbeTSyWvi7
 8J4Vk/8BemxKlXM0fY4sLaiBN+Er/asexvc9y/bol9nUOldy/IC/7Coxun1DknTq
 IH30g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3b40k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Jun 2026 03:16:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 03:16:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 03:16:34 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 8E1173F7053;
 Mon,  1 Jun 2026 03:16:32 -0700 (PDT)
From: Shijith Thotton <sthotton@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>
CC: <dev@dpdk.org>, Shijith Thotton <sthotton@marvell.com>
Subject: [PATCH v1 2/2] dma/odm: avoid zero length DMA transfers
Date: Mon, 1 Jun 2026 15:45:59 +0530
Message-ID: <20260601101559.1925302-3-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260601101559.1925302-1-sthotton@marvell.com>
References: <20260601101559.1925302-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEwMyBTYWx0ZWRfX7UA9OA21GF0Z
 YtGrxkIboBkaz6N+is47FdikUImCxxfQ1sa7u2NnwDq1McF8hrGuo5RNQCZz2aH7Kj0nFDe75Ax
 2nVEfhoTKFakyEB74Cib6aXciYia1zW3vz1Ue1Kb6eIO0TxqhRJDL0WA0tyBRZT9J5jthYfT4AP
 N0rfn6Vx6sXkQj/SmExSeRMU2T2CGp4/pB4xgBXb3QiN4YRN6sLi7XI5d+5W7pjQyos8Xx25a/J
 AJMKzbzg2vTSw2rX315UX62xvXtkgfGD8bZICn1BgPgsUyhoIUoqGKMzB0FQjpPeXdhd9d0/4ij
 YrhkbWiiGSCHtDzCZ+qHJMn6WIZEFZpOcdZ9rjXQruREgdEMyiQ8WU5TE9bA6EICzm2DcbhQlME
 M9xOxXW30Cmw0LRDPRmMar36KKLWgK8bplqBWe+PQjA+kPA1Lg/pz34d+Oav7k3YqfErqBfXTcY
 XdA/IyINxNxm3P+v+nw==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1d5c02 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ZTsfstNl9sPyvf5yVl8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jZUqgmoG6oY6jaB54KHcxNsDb_cfIknL
X-Proofpoint-GUID: jZUqgmoG6oY6jaB54KHcxNsDb_cfIknL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
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

Add validation to reject zero-length DMA operations early
with -EINVAL, preventing queue disable.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/dma/odm/odm_dmadev.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
index 0211133bd4..7488b960fd 100644
--- a/drivers/dma/odm/odm_dmadev.c
+++ b/drivers/dma/odm/odm_dmadev.c
@@ -110,6 +110,9 @@ odm_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t ds
 	vq = &odm->vq[vchan];
 	hdr.s.xtype = vq->xtype;
 
+	if (unlikely(!length))
+		return -EINVAL;
+
 	h = length;
 	h |= ((uint64_t)length << 32);
 
@@ -262,14 +265,20 @@ odm_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge *
 	pending_submit_len = vq->pending_submit_len;
 	pending_submit_cnt = vq->pending_submit_cnt;
 
-	if (unlikely(nb_src > 4 || nb_dst > 4))
+	if (unlikely(!nb_src || nb_src > 4 || !nb_dst || nb_dst > 4))
 		return -EINVAL;
 
-	for (i = 0; i < nb_src; i++)
+	for (i = 0; i < nb_src; i++) {
+		if (unlikely(!src[i].length))
+			return -EINVAL;
 		s_sz += src[i].length;
+	}
 
-	for (i = 0; i < nb_dst; i++)
+	for (i = 0; i < nb_dst; i++) {
+		if (unlikely(!dst[i].length))
+			return -EINVAL;
 		d_sz += dst[i].length;
+	}
 
 	if (s_sz != d_sz)
 		return -EINVAL;
@@ -342,6 +351,9 @@ odm_dmadev_fill(void *dev_private, uint16_t vchan, uint64_t pattern, rte_iova_t
 		.s.nlst = 1,
 	};
 
+	if (unlikely(!length))
+		return -EINVAL;
+
 	h = (uint64_t)length;
 
 	switch (pattern) {
-- 
2.25.1

