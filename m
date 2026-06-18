Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18ECD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F3FA40E6E;
	Thu, 18 Jun 2026 16:12:15 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EDC3140E27;
 Thu, 18 Jun 2026 16:12:08 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2DC3200028;
 Thu, 18 Jun 2026 16:12:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D247200004;
 Thu, 18 Jun 2026 16:12:08 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EE32C180004C;
 Thu, 18 Jun 2026 22:12:06 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v1 11/17] net/dpaa: fix coverity reported issues
Date: Thu, 18 Jun 2026 19:41:45 +0530
Message-Id: <20260618141151.3990283-12-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
References: <20260618141151.3990283-1-hemant.agrawal@nxp.com>
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

Fix several issues reported by Coverity static analysis:
- Add missing null checks in dpaa_flow.c
- Fix potential resource leak in dpaa_qdma.c

Fixes: e7665de896 ("net/dpaa: fix resource leak")
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/dma/dpaa/dpaa_qdma.c | 7 ++++++-
 drivers/net/dpaa/dpaa_flow.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index 74e23d2ee5..faf4a7bafe 100644
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
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 417b9b6fbb..f21950f64d 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -81,6 +81,10 @@ static void fm_prev_cleanup(void)
 		devid = fm_model.device_order[i];
 		/* FM Port Open */
 		fm_model.fm_port_params[devid].h_fm = fm_info.fman_handle;
+		if (dpaa_intf.port_handle) {
+			fm_port_close(dpaa_intf.port_handle);
+			dpaa_intf.port_handle = NULL;
+		}
 		dpaa_intf.port_handle =
 				fm_port_open(&fm_model.fm_port_params[devid]);
 		dpaa_intf.scheme_handle[0] = create_device(fm_info.pcd_handle,
-- 
2.43.0

