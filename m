Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111A8C021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 13:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02B1940A4B;
	Thu, 27 Feb 2025 14:28:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8F5CE4064F;
 Thu, 27 Feb 2025 14:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740662883; x=1772198883;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xuwHL5PyKX2M+eGTaxuRacOoE6yvNRar3vQscaT7AWk=;
 b=L7CNmSHWG3NP7n3MFixlp1a4sYvO7LjcWgj7e8fhRwmmSnFWIQTO3C5p
 AVC94xCMx/78vr6gllnSu4HuvKoj68saQGrALqrqvMwvve12oWGZJGhtm
 zGe9eN9RbUfXgfmZSqdvp+ckWW4HFpkbZCEeWowHtQoX05JMfxM7OgrH4
 zFFbBDCvZIOKz2sJZL4y+/UFFxroXv2PPRlsUx+rmBJxoJiqNlnZt2RJ7
 vvvHfch1d8tzrcYLe31WFvDBgvyMZ0bDsOnsONauIIo/ic0uCR5rzx6Au
 OzA6etqeF4E4KBO6OsubP2X6L5XlrFsukGEIoK+4hbeIzqUHaUmacMy+r g==;
X-CSE-ConnectionGUID: X4ZUwFU5TlG5yIHX66ooSA==
X-CSE-MsgGUID: nSSWhSpWSQKnbrn3ASav5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41253601"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="41253601"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 05:28:02 -0800
X-CSE-ConnectionGUID: xT/b+KbgTO2htbh48ConQQ==
X-CSE-MsgGUID: XoHkurpNSqmi7f6tVu/nVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117539364"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 05:28:01 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, fengchengwen@huawei.com,
 stable@dpdk.org, Kevin Laatz <kevin.laatz@intel.com>,
 Conor Walsh <conor.walsh@intel.com>
Subject: [PATCH] app/test: fix DMA API tests in IOVA as PA mode
Date: Thu, 27 Feb 2025 13:27:49 +0000
Message-ID: <20250227132749.753581-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When running without IOMMU for address translation, i.e. IOVAs are
physical rather than virtual addresses, we need to translate the
pointers to IOVAs for the completion API tests.

Fixes: 9942ebb9c698 ("test/dma: add dmadev API test")
Cc: fengchengwen@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_dmadev_api.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
index d40c05cfbf..fb49fcb56b 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
@@ -515,7 +515,9 @@ test_dma_completed(void)
 	setup_memory();
 
 	/* Check enqueue without submit */
-	ret = rte_dma_copy(test_dev_id, 0, (rte_iova_t)src, (rte_iova_t)dst,
+	ret = rte_dma_copy(test_dev_id, 0,
+			   rte_malloc_virt2iova(src),
+			   rte_malloc_virt2iova(dst),
 			   TEST_MEMCPY_SIZE, 0);
 	RTE_TEST_ASSERT_EQUAL(ret, 0, "Failed to enqueue copy, %d", ret);
 	rte_delay_us_sleep(TEST_WAIT_US_VAL);
@@ -537,7 +539,9 @@ test_dma_completed(void)
 	setup_memory();
 
 	/* Check for enqueue with submit */
-	ret = rte_dma_copy(test_dev_id, 0, (rte_iova_t)src, (rte_iova_t)dst,
+	ret = rte_dma_copy(test_dev_id, 0,
+			   rte_malloc_virt2iova(src),
+			   rte_malloc_virt2iova(dst),
 			   TEST_MEMCPY_SIZE, RTE_DMA_OP_FLAG_SUBMIT);
 	RTE_TEST_ASSERT_EQUAL(ret, 1, "Failed to enqueue copy, %d", ret);
 	rte_delay_us_sleep(TEST_WAIT_US_VAL);
@@ -572,7 +576,9 @@ test_dma_completed_status(void)
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to start, %d", ret);
 
 	/* Check for enqueue with submit */
-	ret = rte_dma_copy(test_dev_id, 0, (rte_iova_t)src, (rte_iova_t)dst,
+	ret = rte_dma_copy(test_dev_id, 0,
+			   rte_malloc_virt2iova(src),
+			   rte_malloc_virt2iova(dst),
 			   TEST_MEMCPY_SIZE, RTE_DMA_OP_FLAG_SUBMIT);
 	RTE_TEST_ASSERT_EQUAL(ret, 0, "Failed to enqueue copy, %d", ret);
 	rte_delay_us_sleep(TEST_WAIT_US_VAL);
@@ -591,7 +597,9 @@ test_dma_completed_status(void)
 	RTE_TEST_ASSERT_EQUAL(cpl_ret, 0, "Failed to completed status");
 
 	/* Check for enqueue with submit again */
-	ret = rte_dma_copy(test_dev_id, 0, (rte_iova_t)src, (rte_iova_t)dst,
+	ret = rte_dma_copy(test_dev_id, 0,
+			   rte_malloc_virt2iova(src),
+			   rte_malloc_virt2iova(dst),
 			   TEST_MEMCPY_SIZE, RTE_DMA_OP_FLAG_SUBMIT);
 	RTE_TEST_ASSERT_EQUAL(ret, 1, "Failed to enqueue copy, %d", ret);
 	rte_delay_us_sleep(TEST_WAIT_US_VAL);
-- 
2.43.0

