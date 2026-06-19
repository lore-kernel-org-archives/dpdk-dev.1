Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91517CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 10:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3012240E5A;
	Fri, 19 Jun 2026 12:39:26 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7D7E240E43;
 Fri, 19 Jun 2026 12:39:22 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 604FF200248;
 Fri, 19 Jun 2026 12:39:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 28EEF20023A;
 Fri, 19 Jun 2026 12:39:22 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6E2C01800071;
 Fri, 19 Jun 2026 18:39:20 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 12/18] dma/dpaa: fix out-of-bounds access in SG descriptor
 enqueue
Date: Fri, 19 Jun 2026 16:08:55 +0530
Message-Id: <20260619103901.2274740-13-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
References: <20260619060916.485258-1-hemant.agrawal@nxp.com>
 <20260619103901.2274740-1-hemant.agrawal@nxp.com>
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

In fsl_qdma_enqueue_desc_sg(), the code accesses desc_ssge[num - 1]
without validating num first. If pending_num is 0, num will be 0 and
the access underflows. Add a bounds check to return -EINVAL when num
is 0 or exceeds FSL_QDMA_SG_MAX_ENTRY.

Fixes: a77261f61245 ("dma/dpaa: support scatter-gather")
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/dma/dpaa/dpaa_qdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index 74e23d2ee5..b20ff24ab6 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2021-2024 NXP
+ * Copyright 2021-2026 NXP
  */
 
 #include <bus_dpaa_driver.h>
@@ -827,6 +827,11 @@ fsl_qdma_enqueue_desc_sg(struct fsl_qdma_queue *fsl_queue)
 		}
 	}
 
+	if (num == 0 || num > FSL_QDMA_SG_MAX_ENTRY) {
+		DPAA_QDMA_ERR("Invalid scatter-gather entry count: num=%u", num);
+		return -EINVAL;
+	}
+
 	ft->desc_ssge[num - 1].final = 1;
 	ft->desc_dsge[num - 1].final = 1;
 	csgf_src->length = total_len;
-- 
2.43.0

