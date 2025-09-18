Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0611CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 04:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B9F5402B7;
	Thu, 18 Sep 2025 06:15:43 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 5BD9C4027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 06:15:41 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cS2Hj2zWXzRkQG;
 Thu, 18 Sep 2025 12:10:57 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A7671402CC;
 Thu, 18 Sep 2025 12:15:35 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 12:15:34 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] test: support SVA copy for dmadev test
Date: Thu, 18 Sep 2025 12:15:34 +0800
Message-ID: <20250918041534.38227-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This commit supports SVA copy for dmadev test.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_dmadev.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 9cbb9a6552..dd4ace49ae 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -514,6 +514,65 @@ test_enqueue_sg_copies(int16_t dev_id, uint16_t vchan)
 	return 0;
 }
 
+static int
+test_single_sva_copy(int16_t dev_id, uint16_t vchan, const char *mem_src,
+		     char *src, char *dst, uint32_t len)
+{
+	uint16_t i, id;
+	int ret;
+
+	for (i = 0; i < len; i++)
+		src[i] = rte_rand() & 0xFF;
+
+	ret = rte_dma_copy(dev_id, vchan, (rte_iova_t)src, (rte_iova_t)dst,
+			len, RTE_DMA_OP_FLAG_SUBMIT);
+	if (ret != id_count)
+		ERR_RETURN("Error with %s rte_dma_copy, got %d expected %u\n",
+			mem_src, ret, id_count);
+
+	await_hw(dev_id, vchan);
+
+	id = ~id;
+	if (rte_dma_completed(dev_id, vchan, 1, &id, NULL) != 1)
+		ERR_RETURN("Error with %s rte_dma_completed\n", mem_src);
+	if (id != id_count)
+		ERR_RETURN("Error with %s rte_dma_completed: incorrect job id received, %u [expected %u]\n",
+			mem_src, id, id_count);
+	id_count++;
+
+	for (i = 0; i < len; i++)
+		if (dst[i] != src[i])
+			ERR_RETURN("Error with %s data mismatch at char %u [Got %02x not %02x]\n",
+				mem_src, i, dst[i], src[i]);
+
+	return 0;
+}
+
+static int
+test_enqueue_sva_copies(int16_t dev_id, uint16_t vchan)
+{
+	char *src_data = NULL, *dst_data = NULL;
+	char src[COPY_LEN], dst[COPY_LEN];
+	int ret;
+
+	/* test copy between buffer which malloced by libc. */
+	src_data = malloc(COPY_LEN);
+	dst_data = malloc(COPY_LEN);
+	if (src_data == NULL || dst_data == NULL) {
+		free(src_data);
+		free(dst_data);
+		ERR_RETURN("Error with malloc copy buffer!\n");
+	}
+	ret = test_single_sva_copy(dev_id, vchan, "libc", src_data, dst_data, COPY_LEN);
+	free(src_data);
+	free(dst_data);
+	if (ret != 0)
+		return ret;
+
+	/* test copy between buffer which belong stack. */
+	return test_single_sva_copy(dev_id, vchan, "stack", src, dst, COPY_LEN);
+}
+
 /* Failure handling test cases - global macros and variables for those tests*/
 #define COMP_BURST_SZ	16
 #define OPT_FENCE(idx) ((fence && idx == 8) ? RTE_DMA_OP_FLAG_FENCE : 0)
@@ -1063,6 +1122,21 @@ test_dmadev_sg_copy_setup(void)
 	return ret;
 }
 
+static int
+test_dmadev_sva_setup(void)
+{
+	int ret = TEST_SUCCESS;
+
+	if ((info.dev_capa & RTE_DMA_CAPA_SVA) == 0) {
+		RTE_LOG(ERR, USER1,
+			"DMA Dev %u: device does not support SVA, skipping SVA tests\n",
+			test_dev_id);
+		ret = TEST_SKIPPED;
+	}
+
+	return ret;
+}
+
 static int
 test_dmadev_burst_setup(void)
 {
@@ -1205,6 +1279,7 @@ test_dmadev_instance(int16_t dev_id)
 	enum {
 		  TEST_COPY = 0,
 		  TEST_COPY_SG,
+		  TEST_SVA_COPY,
 		  TEST_START,
 		  TEST_BURST,
 		  TEST_ERR,
@@ -1216,6 +1291,7 @@ test_dmadev_instance(int16_t dev_id)
 	static struct runtest_param param[] = {
 		{"copy", test_enqueue_copies, 640},
 		{"sg_copy", test_enqueue_sg_copies, 1},
+		{"sva_copy", test_enqueue_sva_copies, 1},
 		{"stop_start", test_stop_start, 1},
 		{"burst_capacity", test_burst_capacity, 1},
 		{"error_handling", test_completion_handling, 1},
@@ -1234,6 +1310,9 @@ test_dmadev_instance(int16_t dev_id)
 			TEST_CASE_NAMED_WITH_DATA("sg_copy",
 				test_dmadev_sg_copy_setup, NULL,
 				runtest, &param[TEST_COPY_SG]),
+			TEST_CASE_NAMED_WITH_DATA("sva_copy",
+				test_dmadev_sva_setup, NULL,
+				runtest, &param[TEST_SVA_COPY]),
 			TEST_CASE_NAMED_WITH_DATA("stop_start",
 				NULL, NULL,
 				runtest, &param[TEST_START]),
-- 
2.17.1

