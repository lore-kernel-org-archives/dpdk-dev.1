Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60033606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C72540679;
	Tue, 20 Oct 2026 16:48:51 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A0DDD40297;
 Tue, 20 Oct 2026 16:48:47 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77C4E1A00B9;
 Tue, 20 Oct 2026 16:48:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 425021A00B4;
 Tue, 20 Oct 2026 16:48:47 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B9ED3180006C;
 Tue, 20 Oct 2026 22:48:45 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v14-S2 01/10] net/dpaa2: fix integer overflow in CCSR region
 mapping
Date: Tue, 20 Oct 2026 20:18:32 +0530
Message-ID: <20261020144841.506038-2-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020144841.506038-1-prashant.gupta_3@nxp.com>
References: <20261019183443.176790-1-prashant.gupta_3@nxp.com>
 <20261020144841.506038-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hemant Agrawal <hemant.agrawal@nxp.com>

In lsx_ccsr_map_region(), PAGE_SIZE is defined as
sysconf(_SC_PAGESIZE), which returns a signed long and may be
negative on error. The value was used directly in size_t
comparisons and mmap() length calculations, leading to an
integer overflow (Coverity CID 49765682).

The old code also computed the mapping length without taking
the address offset within the page into account. As a result,
regions crossing a page boundary might not be fully mapped.
The mapping size must cover the entire range from the
page-aligned start address through offset + len.

Fix by validating the page size returned by sysconf(),
deriving the page mask from the validated value, and using
RTE_ALIGN_CEIL(offset + len, page_size) to calculate the
mapping length.

Coverity issue: 49765682
Fixes: f023d059769f ("net/dpaa2: support recycle loopback port")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_recycle.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index f78d12362e..9b6ae3f515 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -176,6 +176,9 @@ static void *lsx_ccsr_map_region(uint64_t addr, size_t len)
 	void *tmp;
 	uint64_t start;
 	uint64_t offset;
+	uint64_t page_mask;
+	long page_size;
+	size_t map_len;
 
 	fd = open("/dev/mem", O_RDWR);
 	if (fd < 0) {
@@ -183,20 +186,24 @@ static void *lsx_ccsr_map_region(uint64_t addr, size_t len)
 		return NULL;
 	}
 
-	start = addr & PAGE_MASK;
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size <= 0) {
+		close(fd);
+		return NULL;
+	}
+	page_mask = ~((uint64_t)page_size - 1);
+	start = addr & page_mask;
 	offset = addr - start;
-	len = len & PAGE_MASK;
-	if (len < (size_t)PAGE_SIZE)
-		len = PAGE_SIZE;
+	map_len = RTE_ALIGN_CEIL(offset + len, (size_t)page_size);
 
-	tmp = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, start);
+	tmp = mmap(NULL, map_len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, start);
 
 	close(fd);
 
-	if (tmp != MAP_FAILED)
-		return (uint8_t *)tmp + offset;
-	else
+	if (tmp == MAP_FAILED)
 		return NULL;
+
+	return (uint8_t *)tmp + offset;
 }
 
 static const uint8_t ls_sd1_prot_idx_map[] = {
-- 
2.43.0

