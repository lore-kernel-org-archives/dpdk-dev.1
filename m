Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B4FC88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39851427A8;
	Tue, 15 Sep 2026 13:35:06 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id F073C41157;
 Tue, 15 Sep 2026 13:35:02 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA165200061;
 Tue, 15 Sep 2026 13:35:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91593200053;
 Tue, 15 Sep 2026 13:35:02 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0D1DB18000BA;
 Tue, 15 Sep 2026 19:35:00 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v3-S2 01/13] net/dpaa2: fix integer overflow in CCSR region
 mapping
Date: Tue, 15 Sep 2026 17:04:47 +0530
Message-ID: <20260915113459.4166621-2-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
References: <20260910135158.2181141-48-prashant.gupta_3@nxp.com>
 <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

In lsx_ccsr_map_region, PAGE_SIZE is defined as sysconf(_SC_PAGESIZE)
which may be negative on error. The value was used directly in size_t
comparisons and passed to mmap, causing an integer overflow (Coverity
CID 49765682).

Use sysconf() explicitly with a signed long, check for errors, and
compute map_len separately with unsigned arithmetic before passing to
mmap.

Coverity issue: 49765682
Fixes: f023d059769f ("net/dpaa2: support recycle loopback port")
Cc: stable@dpdk.org
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_recycle.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index f78d12362e..f1a234deae 100644
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
@@ -183,20 +186,28 @@ static void *lsx_ccsr_map_region(uint64_t addr, size_t len)
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
+	len = len & page_mask;
+
+	map_len = len;
+	if (map_len < (size_t)page_size)
+		map_len = (size_t)page_size;
 
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

