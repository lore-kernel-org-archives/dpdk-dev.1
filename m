Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC702C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 03:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B4EE4067B;
	Mon,  9 Jun 2025 05:03:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E0A5D4067D
 for <dev@dpdk.org>; Mon,  9 Jun 2025 05:03:31 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558NhA1l012341;
 Sun, 8 Jun 2025 20:03:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
 2zdVEX9W0B4FxK6EZXBOm8wb4KV7ETT5cP9wKM8S5w=; b=Eo/fOpLfdBlapTZzB
 taut9fCmYMiPy3lRZKT5WUbKVH158QSZ/mEh7yWomaeXasJ5fv1MXhWnf+GHfMUF
 fDrl28r3DBUVDlUbbgu9k5BBqlp/LGiKAg293A5cftvoNOBrM3FeuIa2923XQe76
 2BF4cn8W1aWNU8F/zI3ax4WiS+SpRj6sqlTrKcM19Kn/1hFxsqe214A95AokejX+
 4VjpNEvar//RhKi7RJMuSdX8wZcSyJ5eSVFqIZfJC0VlTh4Z8MR28VmYCERNw72Y
 Ys9OAQ2sp82Z2n85t1NpKOqhLv3fh1IV4nDjqoMBYevb+N3+1DR+bhKG/d4vGgSR
 98DdA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 474mxka47g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 20:03:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 8 Jun 2025 20:03:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 8 Jun 2025 20:03:29 -0700
Received: from localhost.localdomain (unknown [10.28.36.179])
 by maili.marvell.com (Postfix) with ESMTP id 85D8F3F707B;
 Sun,  8 Jun 2025 20:03:26 -0700 (PDT)
From: Vidya Sagar Velumuri <vvelumuri@marvell.com>
To: Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <gakhil@marvell.com>, <jerinj@marvell.com>, <anoobj@marvell.com>,
 <vvelumuri@marvell.com>, <asasidharan@marvell.com>, <dev@dpdk.org>, "Amit
 Prakash Shukla" <amitprakashs@marvell.com>
Subject: [PATCH v4 2/2] test/dma: add functions to verify zero and one fill
Date: Sun, 8 Jun 2025 20:03:14 -0700
Message-ID: <20250609030314.4098409-2-vvelumuri@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609030314.4098409-1-vvelumuri@marvell.com>
References: <20250606094031.2961842-1-vvelumuri@marvell.com>
 <20250609030314.4098409-1-vvelumuri@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAyNCBTYWx0ZWRfX+EZJMEch9Aug
 UvlUQ+LLZCAl5e0XiMzWuDrXU2JVgDyKkgzV0kO60oR7NiALIzcbE6wp8wLESuKe5u4O84C4zRP
 i5Y0xRgcjDJZq5XS5zhEcMU+hJviQlwAVKgWlRoAebrrS7MykhvdJZhyGD1p0Z1Awv+L7xrANRH
 3aEMCpRA8UsNZShAMb2eOCi+El7cU7zqyBvdn8lKn+dJNpVL8nfgQJeikq0A7T2a2VP0/ODJCYg
 Bh0AsAw3o30lQjyTcZHj74ZlXo798h32hyU7nJJZmK4WKRi2S1mAYGb6luyprcaV3iH0tfKqNiL
 qJnANbXsNmOVUc+/XsU5mGQRgJVQNi/hEUophZuyBioZhFInpiHB/X48wrg9crgPF9Y3r9HZ69b
 8WSEflT64WjROUjeutNBNuqpD//uVhEGqBZF2BkcF36KrG5/ajm+Swfa75RYkfozTN8zGqFT
X-Proofpoint-GUID: THx7DkBstqE8WuZZRgcl__F0mOmV7vKX
X-Authority-Analysis: v=2.4 cv=Lq6Symdc c=1 sm=1 tr=0 ts=68464f03 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=u4PnTDvp6VjNND2LJ98A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: THx7DkBstqE8WuZZRgcl__F0mOmV7vKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_01,2025-06-05_01,2025-03-28_01
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
Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 88c3d02fd6..0c67aaceb2 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -872,42 +872,51 @@ test_completion_handling(int16_t dev_id, uint16_t vchan)
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
+	for (k = 0; k < RTE_DIM(pattern); k++) {
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
+					break;
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
2.25.1

