Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8EFCD98E4
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 03:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67723402E5;
	Mon, 22 Jun 2026 05:06:33 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D0148402E1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 05:06:31 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65LNo6Nl112101; Sun, 21 Jun 2026 20:06:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 NFHVpyE6WanxCey63lDuLea4kjaBUJsa8kxhITyLvE=; b=Qfg1h3NpMigclBkL9
 lDAdkbpPrqxW1m2cv55ANlzxxojK7vFoHDloA+ZDpA+G24Gg/EWjEOPX2F6DceEA
 WC0T/A9F2tp3aiUlstLSOI3TGjwBCC6PI+KJ4vpCf9xxtMffnhADyFwNs57KiYcC
 U0Qddpa/GEI03eVJXyolPVNUu8IseO7M0Cbqaa0sWOwrsE5F5gjQBklXM19O4P2N
 oHkWcd5cSV7nNNMIuhbx/bpgfPrQimT4qKwn9ny3zJn8icl8Ni/mk4X4DXmpvnE8
 woVfLJiSimqJkVps5RfJgaPCWbOblEZJgCtzEtyUuNuZpxooQ25UeporFETjE2m5
 w9B1Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4exf48sgx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 21 Jun 2026 20:06:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Jun 2026 20:06:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Jun 2026 20:06:29 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 2286E3F704C;
 Sun, 21 Jun 2026 20:06:26 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 1/2] test/dma: update the sg test to verify wrap around case
Date: Mon, 22 Jun 2026 08:36:22 +0530
Message-ID: <20260622030623.86094-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622030623.86094-1-ktejasree@marvell.com>
References: <20260622030623.86094-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: daLGvL8JsYCuBpSXaoAnZR6z8HKV-bwa
X-Proofpoint-GUID: daLGvL8JsYCuBpSXaoAnZR6z8HKV-bwa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAyOCBTYWx0ZWRfX2e4MtqCgBMi9
 puprCZuuKjKVt9B0KCufxO/aSxKdokAivCkucmjHl9wCVPjjPy+koCdFz//DaknENOzknl+2wlJ
 SMVVTiqffjjkw8i6asAfFmZ3SZ5BIHE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAyOCBTYWx0ZWRfX5f/zySi6Vqzp
 rmnAjo8llh7YM6fV/YS0+q/WDDAbxIcxpqVVr5+It6hY1C7hucSxUeopTVEqGoqLu2k7Zhk1/MB
 kLWfkWN5DTQJUA8Hl2rf9hESsuVI45YzuW2dFqWeEdyYbBX2YrO3HnvDKnLRGLH/UeYsYBT+L9y
 gQ+hEel/xIUjNCf6fAtiTfeiTGuPvMiW4o/0S4Ep0fx/Z1JgpzZadw2PE6c3lQIFVTNGC6EdEL6
 /FSVwkTmAt1UUx76tvnp8ODkCbtJWtq5fgH1RMwL0Om/TUx+fEgUUWfYfROaB0xdjub4M/qQ4B4
 toEytH4yDHLXp8ZBsZ+PtDUCRoAF1qLvV2Mnj97Q5VPr+bZ8BHYDLWw/ID2k3fZnM5hnhWNpZ8H
 VG50u6JLZgCxAhiLd5DzMeMFowwNrjSc3lWVdUfHsKKfVyNdhWJV1JXGjiFLfhqppgo8GlurdEr
 JnWssU1ibkfHv5OP88w==
X-Authority-Analysis: v=2.4 cv=J9uaKgnS c=1 sm=1 tr=0 ts=6a38a6b6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=iHgLnrOxfg0iJxBGLQYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Run the sg test in a loop to verify wrap around case.
Total number commands submitted to be more than the number descriptors
allocated to verify the scenario.

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 app/test/test_dmadev.c     | 45 ++++++++++++++++++++++++--------------
 app/test/test_dmadev_api.c |  1 -
 app/test/test_dmadev_api.h |  2 ++
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 5488a1af33..b30f2214e5 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -393,36 +393,28 @@ test_stop_start(int16_t dev_id, uint16_t vchan)
 }
 
 static int
-test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
+test_enqueue_sg(int16_t dev_id, uint16_t vchan, unsigned int n_sge, unsigned int test_len)
 {
-	unsigned int src_len, dst_len, n_sge, len, i, j, k;
 	char orig_src[COPY_LEN], orig_dst[COPY_LEN];
-	struct rte_dma_info info = { 0 };
+	unsigned int src_len, dst_len, i, j, k;
 	enum rte_dma_status_code status;
 	uint16_t id, n_src, n_dst;
 
-	if (rte_dma_info_get(dev_id, &info) < 0)
-		ERR_RETURN("Failed to get dev info");
-
-	if (info.max_sges < 2)
-		ERR_RETURN("Test needs minimum 2 SG pointers");
-
-	n_sge = info.max_sges;
-
 	for (n_src = 1; n_src <= n_sge; n_src++) {
 		for (n_dst = 1; n_dst <= n_sge; n_dst++) {
 			/* Normalize SG buffer lengths */
-			len = COPY_LEN;
-			len -= (len % (n_src * n_dst));
-			dst_len = len / n_dst;
-			src_len = len / n_src;
-
 			struct rte_dma_sge *sg_src = alloca(sizeof(struct rte_dma_sge) * n_sge);
 			struct rte_dma_sge *sg_dst = alloca(sizeof(struct rte_dma_sge) * n_sge);
 			struct rte_mbuf **src = alloca(sizeof(struct rte_mbuf *) * n_sge);
 			struct rte_mbuf **dst = alloca(sizeof(struct rte_mbuf *) * n_sge);
 			char **src_data = alloca(sizeof(char *) * n_sge);
 			char **dst_data = alloca(sizeof(char *) * n_sge);
+			unsigned int len = test_len - (test_len % (n_src * n_dst));
+
+			dst_len = len / n_dst;
+			src_len = len / n_src;
+			if (dst_len == 0 || src_len == 0)
+				continue;
 
 			for (i = 0 ; i < len; i++)
 				orig_src[i] = rte_rand() & 0xFF;
@@ -514,6 +506,27 @@ test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
 	return 0;
 }
 
+static int
+test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
+{
+	struct rte_dma_info info = { 0 };
+	unsigned int n_sge, len;
+	int loop_count = 0;
+
+	if (rte_dma_info_get(dev_id, &info) < 0)
+		ERR_RETURN("Failed to get dev info");
+
+	n_sge = RTE_MIN(info.max_sges, TEST_SG_MAX);
+	len = COPY_LEN;
+
+	do {
+		test_enqueue_sg(dev_id, vchan, n_sge, len);
+		loop_count++;
+	} while (loop_count * n_sge * n_sge < TEST_RINGSIZE * 3);
+
+	return 0;
+}
+
 static int
 test_single_sva_copy(int16_t dev_id, uint16_t vchan, const char *mem_src,
 		     char *src, char *dst, uint32_t len)
diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
index 1ba053696b..4bb8f9e820 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
@@ -16,7 +16,6 @@ extern int test_dma_api(uint16_t dev_id);
 
 #define TEST_MEMCPY_SIZE	1024
 #define TEST_WAIT_US_VAL	50000
-#define TEST_SG_MAX		64
 
 static int16_t test_dev_id;
 static int16_t invalid_dev_id;
diff --git a/app/test/test_dmadev_api.h b/app/test/test_dmadev_api.h
index 33fbc5bd41..a03f7acd4f 100644
--- a/app/test/test_dmadev_api.h
+++ b/app/test/test_dmadev_api.h
@@ -2,4 +2,6 @@
  * Copyright(c) 2021 HiSilicon Limited
  */
 
+#define TEST_SG_MAX		64
+
 int test_dma_api(uint16_t dev_id);
-- 
2.34.1

