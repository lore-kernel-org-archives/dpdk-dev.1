Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E34CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 08:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5351640290;
	Thu, 21 May 2026 10:26:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1A74028D;
 Thu, 21 May 2026 10:26:55 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L17gtM2256088; Thu, 21 May 2026 01:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=KQoi/Nu5bNnj+c9jBdWXAeP
 SIhYfGUL4N2C4ckD9kuY=; b=fvRQwasDdbCeRyCywVB1UpECbSqQWVR/npnsLnZ
 rkWL86s8bFO5ptu53N5xAYFMG71i/Y+AiGVoWeCmLhm9Ht3ZdysOX/wlDh117O9Y
 Wla4M/jdsn9o8hMK+UyxDwl6J0FIMk3l431UxMpB7BgD3/BWwOiehAk1fuPscCw4
 CvlesLCSwYz24V3Y21+YBTUnbvf8apxcpkpvQewvY2BFStHzQsBBJKwJpibecAuU
 0mvIXEnyTXxLjI/4bHplrkZBKunlJvD2toV52DUexviv1+2m53LPg5aB2KnE2vo+
 vVknNloENEyhxVjmaARTqtUtLqVdN3QCN/Vcpqqdl0Ys1LQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94eume3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 01:26:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 21 May 2026 01:26:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 21 May 2026 01:26:53 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id AF61B3F7065;
 Thu, 21 May 2026 01:26:49 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Tejasree Kondoj
 <ktejasree@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 <stable@dpdk.org>
Subject: [PATCH] common/cnxk: fix VFIO MSI-X interrupt setup
Date: Thu, 21 May 2026 13:56:46 +0530
Message-ID: <20260521082647.71442-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MSBTYWx0ZWRfXyddpRtlMBG/Q
 5K+zW54+o3gXVAXfmFXuuqtcf0Nv+US9bqCjsncEWyADS8GkgFLrftXWabSec8A1cfFMmRyYJ/C
 JIvDMSu48F44gx1ERnQW6SHY26hU2hV7Gn/2dJ4PEY5PlyJlsTzFANpuhQQwCKd7wQrNY8S2xAT
 zjaefh6ETkNWw6j8pwgUfLNqgihFPbPpAaes9LlsqB4HICCq6e+zjhfWGmqeFvdr+9bAqkSa4BN
 KkBaEVhaQiHQ7ZoN2K4szwJF1tLThYtp3n/XvmclLY9tY0B5TmRl9MDarz0UzAN9KxpMIUUVdOb
 C/DilV0Y42onka5xU+1JOSLNb4wd/aWCxvs3GPQ03f5RgDgKVLSnCbpB68tBARELCb1EnQE4gH/
 WUi2nGnqFSWoIVrefv6ISOlkB5NXPSVdq5dfwmqp/tr+VkBQcOZYUedCJdr/CBBk3y9pxy4nkt4
 55iw0BNZ74XdzW56qsQ==
X-Proofpoint-ORIG-GUID: Q5ss18V9eyFTPn3ft1fCON0uLWiDf7VY
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0ec1ce cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=H8NQ2H_DFaoksX-EoNIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: Q5ss18V9eyFTPn3ft1fCON0uLWiDf7VY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Use heap allocation sized by the configured maximum interrupt count for the
VFIO irq_set buffer, correct handling when irq.count is zero, and use a
minimal stack buffer for per-vector configuration.

Fixes: 1fb9f4ab14b3 ("common/cnxk: remove VLA in interrupt configuration")
Cc: stable@dpdk.org

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/common/cnxk/roc_platform.c | 39 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index 1fdbf8f05143..59d662fab43b 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -13,13 +13,11 @@
 #if defined(__linux__)
 
 #include <inttypes.h>
+#include <stdlib.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#define MSIX_IRQ_SET_BUF_LEN							\
-	(sizeof(struct vfio_irq_set) + sizeof(int) * PLT_MAX_RXTX_INTR_VEC_ID)
-
 static int
 irq_get_info(struct plt_intr_handle *intr_handle)
 {
@@ -39,11 +37,12 @@ irq_get_info(struct plt_intr_handle *intr_handle)
 		     irq.count, PLT_MAX_RXTX_INTR_VEC_ID);
 
 	if (irq.count == 0) {
-		plt_err("HW max=%d > PLT_MAX_RXTX_INTR_VEC_ID: %d", irq.count,
-			PLT_MAX_RXTX_INTR_VEC_ID);
-		plt_intr_max_intr_set(intr_handle, PLT_MAX_RXTX_INTR_VEC_ID);
+		plt_warn("VFIO MSI-X irq.count is 0; using PLT_MAX_RXTX_INTR_VEC_ID=%u",
+			 PLT_MAX_RXTX_INTR_VEC_ID);
+		if (plt_intr_max_intr_set(intr_handle, PLT_MAX_RXTX_INTR_VEC_ID))
+			return -1;
 	} else {
-		if (plt_intr_max_intr_set(intr_handle, irq.count))
+		if (plt_intr_max_intr_set(intr_handle, (int)irq.count))
 			return -1;
 	}
 
@@ -53,7 +52,7 @@ irq_get_info(struct plt_intr_handle *intr_handle)
 static int
 irq_config(struct plt_intr_handle *intr_handle, unsigned int vec)
 {
-	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
+	char irq_set_buf[sizeof(struct vfio_irq_set) + sizeof(int32_t)];
 	struct vfio_irq_set *irq_set;
 	int len, rc, vfio_dev_fd;
 	int32_t *fd_ptr;
@@ -89,23 +88,34 @@ irq_config(struct plt_intr_handle *intr_handle, unsigned int vec)
 static int
 irq_init(struct plt_intr_handle *intr_handle)
 {
-	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
+	int max_intr, len, rc, vfio_dev_fd;
 	struct vfio_irq_set *irq_set;
-	int len, rc, vfio_dev_fd;
+	char *irq_set_buf = NULL;
 	int32_t *fd_ptr;
-	uint32_t i;
+	int i;
 
-	len = sizeof(struct vfio_irq_set) + sizeof(int32_t) * plt_intr_max_intr_get(intr_handle);
+	max_intr = plt_intr_max_intr_get(intr_handle);
+	if (max_intr <= 0) {
+		plt_err("Invalid max_intr %d for irq init", max_intr);
+		return -EINVAL;
+	}
+
+	len = sizeof(struct vfio_irq_set) + sizeof(int32_t) * max_intr;
+	irq_set_buf = malloc((size_t)len);
+	if (irq_set_buf == NULL) {
+		plt_err("Failed to alloc irq_set_buf len=%d", len);
+		return -ENOMEM;
+	}
 
 	irq_set = (struct vfio_irq_set *)irq_set_buf;
 	irq_set->argsz = len;
 	irq_set->start = 0;
-	irq_set->count = plt_intr_max_intr_get(intr_handle);
+	irq_set->count = (uint32_t)max_intr;
 	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
 	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
 
 	fd_ptr = (int32_t *)&irq_set->data[0];
-	for (i = 0; i < irq_set->count; i++)
+	for (i = 0; i < max_intr; i++)
 		fd_ptr[i] = -1;
 
 	vfio_dev_fd = plt_intr_dev_fd_get(intr_handle);
@@ -113,6 +123,7 @@ irq_init(struct plt_intr_handle *intr_handle)
 	if (rc)
 		plt_err("Failed to set irqs vector rc=%d", rc);
 
+	free(irq_set_buf);
 	return rc;
 }
 
-- 
2.50.1 (Apple Git-155)

