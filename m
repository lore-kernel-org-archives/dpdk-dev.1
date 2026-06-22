Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E079CD98E4
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 03:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A5440611;
	Mon, 22 Jun 2026 05:06:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0DBBB402EB
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:06:33 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65LNql4H1262930; Sun, 21 Jun 2026 20:06:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
 Bbr/jGw37xC7fDhd8czKholmhae0U3OxkZcillpk6Y=; b=Rknf8OJPG7fEQqDrD
 g1CpZN6Xc5RMhsLEmOJGOFfQ+9hffBIJsV3Zx0l+2SliySzU9DOFFThF8IKVgErI
 o/bkAY8v2s50toktzuyOCQU4L6iVwCncw321MmmYcJS0dmpcD8iVIg4KzcsQbgro
 OM8FLo5La50UmlYFcqSDXJxdHgN71zRi8C+tFOUfH6QOlAa0tLJDwZupP/ONnBm7
 EiG0rccUL5fcX4IkvVBjUaRYbKZFcMLkPZd6cbqwus/50sSy5Czxm+mKNYYolNvR
 y20HRKhjYeJV20pG+far6D/kaQkfE/O87uYvvPB2eIiSrE8K/razVNTluh6ZH4/v
 fhPiA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7hc1kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 21 Jun 2026 20:06:33 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Jun 2026 20:06:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Jun 2026 20:06:32 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 004233F704C;
 Sun, 21 Jun 2026 20:06:29 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 2/2] test/dma: add functions to verify zero and one fill
Date: Mon, 22 Jun 2026 08:36:23 +0530
Message-ID: <20260622030623.86094-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622030623.86094-1-ktejasree@marvell.com>
References: <20260622030623.86094-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAyOCBTYWx0ZWRfX8HJ6DOXdvcnT
 X43bIC/iEu2rF8BgzYBhGiB1RZQAe97dMJpLJuh1lC7ZRixdz4RM3vYNjZcEhuURQs+uQuyqm4g
 9KVIL98LhvwFthwLEVCeuPxpbkIixovB4y4rA/qisZTuA4kwXANFcOSWsQx1Mz+OWyP+OKtX+fy
 nKCsvwxEzAdfPl5xWrUz1g7shZJnTU6IsYLXa92AEO+IDykoyIMVpmAoyOBLccAY0A4N+CIWXH6
 2pB+7ni9tQ9MCawSD0ZRKEDtaQ1HEplTctj8uLhl/9qxKXaXQtf2sWlSKabiXMQ+LQIa3ILcjyJ
 +YG9ao7P5RwTOs2h9lrk5BK7nLy3V1tg2R22f/8PvOpLDqY+u+GxTsYpPBBkp3douGu9ta94/Ca
 lvYWk4UWu1O4orrxir1i8c0G0LeVkMVoCBDjhe6r4Io+iiy8oMfgFjif3SwoldNxeVTtYqaqaW/
 jEr/Zum2+ri63eUJJ1g==
X-Proofpoint-ORIG-GUID: YYu-inuWv0mASFKKAwOucIB3vXIcjC2t
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a38a6b9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=u4PnTDvp6VjNND2LJ98A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAyOCBTYWx0ZWRfXybszHUCJ0bTD
 OachpFkmtBwyvX8G1+HvC4RNgXelKGVCTNls9hDqRskOv5dbzM2ie/zFiP+R4ZWqOE7SkZCPcEG
 tFWLgAc/ONt0ZL6iKM9tX4VhZwHKiOY=
X-Proofpoint-GUID: YYu-inuWv0mASFKKAwOucIB3vXIcjC2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
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

Add test cases to verify zero fill and one fill

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 app/test/test.h        |  4 +++
 app/test/test_dmadev.c | 57 ++++++++++++++++++++++++------------------
 2 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397..5fc2d7d048 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -28,6 +28,10 @@
 
 #include <rte_test.h>
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
 #define TEST_ASSERT RTE_TEST_ASSERT
 
 #define TEST_ASSERT_EQUAL RTE_TEST_ASSERT_EQUAL
diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index b30f2214e5..d4299e501d 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -931,42 +931,51 @@ test_completion_handling(int16_t dev_id, uint16_t vchan)
 static int
 test_enqueue_fill(int16_t dev_id, uint16_t vchan)
 {
+	uint64_t pattern[3] = {0x0, 0xfedcba9876543210, 0xffffffffffffffff};
 	const unsigned int lengths[] = {8, 64, 1024, 50, 100, 89};
+	unsigned int i, j, k;
 	struct rte_mbuf *dst;
 	char *dst_data;
-	uint64_t pattern = 0xfedcba9876543210;
-	unsigned int i, j;
 
 	dst = rte_pktmbuf_alloc(pool);
 	if (dst == NULL)
 		ERR_RETURN("Failed to allocate mbuf\n");
 	dst_data = rte_pktmbuf_mtod(dst, char *);
 
-	for (i = 0; i < RTE_DIM(lengths); i++) {
-		/* reset dst_data */
-		memset(dst_data, 0, rte_pktmbuf_data_len(dst));
+	for (k = 0; k < ARRAY_SIZE(pattern); k++) {
+		for (i = 0; i < RTE_DIM(lengths); i++) {
+			/* reset dst_data */
+			memset(dst_data, 0, rte_pktmbuf_data_len(dst));
+
+			/* perform the fill operation */
+			int id = rte_dma_fill(dev_id, vchan, pattern[k],
+					rte_pktmbuf_iova(dst), lengths[i], RTE_DMA_OP_FLAG_SUBMIT);
+			if (id < 0) {
+				if (id == -ENOTSUP) {
+					rte_pktmbuf_free(dst);
+					return 0;
+				}
+				ERR_RETURN("Error with rte_dma_fill\n");
+			}
+			await_hw(dev_id, vchan);
 
-		/* perform the fill operation */
-		int id = rte_dma_fill(dev_id, vchan, pattern,
-				rte_pktmbuf_iova(dst), lengths[i], RTE_DMA_OP_FLAG_SUBMIT);
-		if (id < 0)
-			ERR_RETURN("Error with rte_dma_fill\n");
-		await_hw(dev_id, vchan);
+			if (rte_dma_completed(dev_id, vchan, 1, NULL, NULL) != 1)
+				ERR_RETURN("Error: fill operation failed (length: %u)\n",
+					   lengths[i]);
+			/* check the data from the fill operation is correct */
+			for (j = 0; j < lengths[i]; j++) {
+				char pat_byte = ((char *)&pattern[k])[j % 8];
 
-		if (rte_dma_completed(dev_id, vchan, 1, NULL, NULL) != 1)
-			ERR_RETURN("Error: fill operation failed (length: %u)\n", lengths[i]);
-		/* check the data from the fill operation is correct */
-		for (j = 0; j < lengths[i]; j++) {
-			char pat_byte = ((char *)&pattern)[j % 8];
-			if (dst_data[j] != pat_byte)
-				ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
-						lengths[i], dst_data[j], pat_byte);
+				if (dst_data[j] != pat_byte)
+					ERR_RETURN("Error with fill operation (lengths = %u): got (%x), not (%x)\n",
+							lengths[i], dst_data[j], pat_byte);
+			}
+			/* check that the data after the fill operation was not written to */
+			for (; j < rte_pktmbuf_data_len(dst); j++)
+				if (dst_data[j] != 0)
+					ERR_RETURN("Error, fill operation wrote too far (lengths = %u): got (%x), not (%x)\n",
+							lengths[i], dst_data[j], 0);
 		}
-		/* check that the data after the fill operation was not written to */
-		for (; j < rte_pktmbuf_data_len(dst); j++)
-			if (dst_data[j] != 0)
-				ERR_RETURN("Error, fill operation wrote too far (lengths = %u): got (%x), not (%x)\n",
-						lengths[i], dst_data[j], 0);
 	}
 
 	rte_pktmbuf_free(dst);
-- 
2.34.1

