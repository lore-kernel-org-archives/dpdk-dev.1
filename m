Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA8606A329
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=qp4C65Rn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B93C540DF8;
	Thu,  5 Nov 2026 15:08:52 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTPS id C5EC44060F;
 Thu,  5 Nov 2026 15:08:49 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=z68a9mrJ2qHXuXpd5oOXkNqXMGVGGlZE5G8S8C8RLts=;
 b=qp4C65RnZ0NxfIdU14uKT3Nv0lK7c6oRxUgepB6EN7iFDbFJbcmcBPMQM2J+zgC3e92ox6aQb
 kKnOkEwq1gydB/w6eDdXJ/LHDjQqsUmEN9yWN4vQiVW9LtJfD7zrhBGBhTREjuE+/2Ufu2K/KKq
 gJOvN5HTp1ZOCABaohAvhHk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jL40W1DJPzKmZH;
 Thu,  5 Nov 2026 22:08:27 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 8EC2B4058C;
 Thu,  5 Nov 2026 22:08:33 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 5 Nov 2026 22:08:32 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Thomas Monjalon <thomas@monjalon.net>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangshuaisong@h-partners.com>,
 <yangxingui@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v3] common/mlx5: fix high SMMU TLB miss with mempool alignment
Date: Thu, 5 Nov 2026 22:08:23 +0800
Message-ID: <20261105140824.2094914-1-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
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

On Kunpeng SoC with mlx CX7, dpdk-l3fwd with intra-NUMA core pinning
under SMMU nonstrict/strict mode shows about 30% performance degradation
compared to cross-NUMA pinning. With SMMU disabled or passthrough mode,
intra-NUMA performs as expected (slightly better than cross-NUMA).

CX7 in NUMA1
NUMA node0 CPU(s):    0-39
NUMA node1 CPU(s):    40-79

intra-NUMA:
dpdk-l3fwd -l 40-55 -n 4 -a 0000:17:00.1,mprq_en=1 -- -p 0x1 -P \
   --config='(0,0,40),(0,1,41),(0,2,42),(0,3,43),(0,4,44),\
             (0,5,45),(0,6,46),(0,7,47),(0,8,48),(0,9,49),\
             (0,10,50),(0,11,51),(0,12,52),(0,13,53),\
             (0,14,54),(0,15,55)' \
   --rx-queue-size=4096 --tx-queue-size=4096 --rx-burst=64

cross-NUMA:
dpdk-l3fwd -l 11-26 -n 4 -a 0000:17:00.1,mprq_en=1 -- -p 0x1 -P \
   --config='(0,0,11),(0,1,12),(0,2,13),(0,3,14),(0,4,15),\
             (0,5,16),(0,6,17),(0,7,18),(0,8,19),(0,9,20),\
             (0,10,21),(0,11,22),(0,12,23),(0,13,24),\
             (0,14,25),(0,15,26)' \
   --rx-queue-size=4096 --tx-queue-size=4096 --rx-burst=64

The root cause is that under SMMU enabled mode, the mempool allocated
for intra-NUMA pinning is aligned to system page size instead of
hugepage size, while cross-NUMA pinning correctly uses hugepage size
alignment. This causes high TLB miss rates under SMMU.

For non-external memory, align all memory ranges to hugepage boundaries
during mempool registration to ensure hugepage_sz alignment, thereby
reducing TLB misses and fixing the intra-NUMA performance degradation.
External memory keeps the original behavior.

Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
Cc: stable@dpdk.org

Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>

---

v2:
- Address review comments from Slava:
  - Call rte_mem_virt2memseg_list() in a single point inside the loop.
  - Skip the alignment block when hugepage_sz equals rte_mem_page_size(),
    since mlx5_mempool_get_chunks() has already done the alignment.
  - Skip the alignment for external memory with early goto, since ranges
    are already aligned to the correct page size.
- Update function documentation and comments.

v3:
- Drop the "if (is_extmem) goto out;" early exit: external memory now
  follows the original behavior again (if the entire pool resides within
  a single hugepage, all ranges are combined into one of the hugepage
  size and share_hugepage is set), while non-external memory keeps the
  new hugepage alignment and adjacent ranges merging.
- Move the .mailmap entry to its alphabetical position.
---
 .mailmap                             |  1 +
 drivers/common/mlx5/mlx5_common_mr.c | 85 +++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/.mailmap b/.mailmap
index 754dd9e760..b4a4646568 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1584,6 +1584,7 @@ Shreyansh Jain <shreyansh.jain@nxp.com>
 Shrikrishna Khare <skhare@vmware.com>
 Shu Shen <shu.shen@radisys.com>
 Shuai Zhu <shuaix.zhu@intel.com>
+Shuaisong Yang <yangshuaisong@h-partners.com>
 Shuanglin Wang <shuanglin.wang@broadcom.com>
 Shujing Dong <shujing.dong@corigine.com>
 Shuki Katzenelson <shuki@lightbitslabs.com>
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index cf39aa93e7..c215ef2bb6 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -1524,7 +1524,11 @@ mlx5_get_mempool_ranges(struct rte_mempool *mp, bool is_extmem,
  * @param[in] is_extmem
  *   Whether the pool is contains only external pinned buffers.
  * @param[out] out
- *   Receives memory ranges to register, aligned to the system page size.
+ *   Receives memory ranges to register. For non-external memory, ranges
+ *   are aligned to the hugepage size if all ranges are on hugepages
+ *   of the same size, otherwise aligned to the system page size.
+ *   For external memory, if the entire pool resides within a single
+ *   hugepage, all ranges are combined into one of the hugepage size.
  *   The caller must release them with free().
  * @param[out] out_n
  *   Receives the number of @p out items.
@@ -1541,7 +1545,8 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bool is_extmem,
 {
 	struct mlx5_range *ranges = NULL;
 	unsigned int i, ranges_n = 0;
-	struct rte_memseg_list *msl;
+	uint64_t hugepage_sz = 0;
+	bool same_hugepage_sz = true;
 
 	if (mlx5_get_mempool_ranges(mp, is_extmem, &ranges, &ranges_n) < 0) {
 		DRV_LOG(ERR, "Cannot get address ranges for mempool %s",
@@ -1550,33 +1555,69 @@ mlx5_mempool_reg_analyze(struct rte_mempool *mp, bool is_extmem,
 	}
 	/* Check if the hugepage of the pool can be shared. */
 	*share_hugepage = false;
-	msl = rte_mem_virt2memseg_list((void *)ranges[0].start);
-	if (msl != NULL) {
-		uint64_t hugepage_sz = 0;
+	/* Check that all ranges are on pages of the same size. */
+	for (i = 0; i < ranges_n; i++) {
+		struct rte_memseg_list *range_msl;
+		range_msl = rte_mem_virt2memseg_list((void *)ranges[i].start);
+		if (range_msl == NULL) {
+			same_hugepage_sz = false;
+			break;
+		}
+		if (hugepage_sz == 0)
+			hugepage_sz = range_msl->page_sz;
+		else if (range_msl->page_sz != hugepage_sz) {
+			same_hugepage_sz = false;
+			break;
+		}
+	}
+	/*
+	 * For non-external memory, align ranges to the hugepage boundaries
+	 * and merge adjacent ones. If the entire pool fits in a single
+	 * hugepage, the MR for this hugepage can be shared across mempools.
+	 */
+	if (!is_extmem && same_hugepage_sz &&
+	    hugepage_sz > rte_mem_page_size()) {
+		unsigned int orig_ranges_n = ranges_n;
 
-		/* Check that all ranges are on pages of the same size. */
 		for (i = 0; i < ranges_n; i++) {
-			if (hugepage_sz != 0 && hugepage_sz != msl->page_sz)
-				break;
-			hugepage_sz = msl->page_sz;
+			ranges[i].start = RTE_ALIGN_FLOOR(ranges[i].start,
+							  hugepage_sz);
+			ranges[i].end = RTE_ALIGN_CEIL(ranges[i].end,
+							hugepage_sz);
 		}
-		if (i == ranges_n) {
-			/*
-			 * If the entire pool is within one hugepage,
-			 * combine all ranges into one of the hugepage size.
-			 */
-			uintptr_t reg_start = ranges[0].start;
-			uintptr_t reg_end = ranges[ranges_n - 1].end;
-			uintptr_t hugepage_start =
-				RTE_ALIGN_FLOOR(reg_start, hugepage_sz);
-			uintptr_t hugepage_end = hugepage_start + hugepage_sz;
-			if (reg_end < hugepage_end) {
-				ranges[0].start = hugepage_start;
+		ranges_n = 1;
+		for (i = 1; i < orig_ranges_n; i++) {
+			if (ranges[ranges_n - 1].end >= ranges[i].start)
+				ranges[ranges_n - 1].end =
+					RTE_MAX(ranges[ranges_n - 1].end,
+						ranges[i].end);
+			else
+				ranges[ranges_n++] = ranges[i];
+		}
+		if (ranges_n == 1) {
+			uintptr_t hugepage_end = ranges[0].start + hugepage_sz;
+
+			if (ranges[0].end <= hugepage_end) {
 				ranges[0].end = hugepage_end;
-				ranges_n = 1;
 				*share_hugepage = true;
 			}
 		}
+	} else if (is_extmem && same_hugepage_sz && hugepage_sz > 0) {
+		/*
+		 * If the entire pool is within one hugepage,
+		 * combine all ranges into one of the hugepage size.
+		 */
+		uintptr_t reg_start = ranges[0].start;
+		uintptr_t reg_end = ranges[ranges_n - 1].end;
+		uintptr_t hugepage_start =
+			RTE_ALIGN_FLOOR(reg_start, hugepage_sz);
+		uintptr_t hugepage_end = hugepage_start + hugepage_sz;
+		if (reg_end < hugepage_end) {
+			ranges[0].start = hugepage_start;
+			ranges[0].end = hugepage_end;
+			ranges_n = 1;
+			*share_hugepage = true;
+		}
 	}
 	*out = ranges;
 	*out_n = ranges_n;
-- 
2.33.0

