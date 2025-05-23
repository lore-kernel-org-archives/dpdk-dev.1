Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5EC54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:51:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 203FD40A67;
	Fri, 23 May 2025 15:51:45 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9364E40A71
 for <dev@dpdk.org>; Fri, 23 May 2025 15:51:43 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NB9k71030030
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 LWcdKlagQFkRbCmNgAJLqBRtQNsGzHxOiGBstPD6Qk=; b=Eh3Fh95tPi2eWh9Or
 xfXD6MN2RFmH+qsrOH+arCo66ZZAkGniLtXczeTENp/9XEGUJcy8sm75h0gr4YKY
 GqiMQ6DG69QIkfyBaX8UEOvDtu06YQeS2RGpRGfk5Om7I/vgJzaHcQwuII25h+yL
 AudXA2IHnelrpO6Ttgnmo0dpmisiMZI086tndCGPZB813u+sFH1zagihLO9nvkJ4
 jyTyhGySXG1q9fAQTDirnyfv7rmuf/+aogrN5WEUMWgMc4HLMqakiHOedDFvft+9
 0oHAfyonJR5N3kEIYa4iG39mNUAsicGZE2cGYRAGmEE7mfihBUY5xim1HTVqlRXz
 3abnw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:51:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:51:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:51:41 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 4B2FA3F7041;
 Fri, 23 May 2025 06:51:38 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 08/40] crypto/cnxk: add ops skeleton for cn20k
Date: Fri, 23 May 2025 19:20:39 +0530
Message-ID: <20250523135111.2178408-9-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307d6e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=6hli1bLTE9R2aqulzRgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX9foM8a2gSYZi
 q4ZfSo1l3kXxFGtRLZFhjebM37IwCoXCbHOAdzFNnkaK56OBAVnTwxvIX1222NDErr0LTVjf6q+
 92h27Q3AokOjg6IeIJdriEU2FDgVSqi7RY2azes1oVk1IHXjqNbWfNS9CBwJAU2mxfsw0vb9u9w
 SeQrWSM8wTBOxj46qYpGYb4mxpsH/hkS4uwsjRQmKMm8Rp387TQnFPbjb08e+6CbZ3fM3/yWFz+
 YxR/XBjRGZZW4h8/yJmUE0asvkbX/hiTBrHz9ikSXwiVBfZ1dy+O1n50h020ofyAfNxpi/jMnsz
 iLQyqyjp0HDwMMSY2AQ/86l8fBx6H3LGjhyk9/PxiJa2XPFuGJ/enpwExsQPeShaQdp3xueySo7
 V1Dac8yKwtwgf1LLil8pCnlzgkugyGOtPuOcQhZk2Hdl/6xRPTGXFsLPKwDSCumA/Lejh5TB
X-Proofpoint-GUID: GuruyCumYeAaZGux3CQHVqu-clsADdnm
X-Proofpoint-ORIG-GUID: GuruyCumYeAaZGux3CQHVqu-clsADdnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add ops skeletion for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev.c     |  3 +
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 92 +++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_ops.h | 23 ++++++
 drivers/crypto/cnxk/meson.build           |  1 +
 4 files changed, 119 insertions(+)
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_ops.h

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
index e52336c2b7..980ea7df97 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -11,6 +11,7 @@
 #include <rte_pci.h>
 
 #include "cn20k_cryptodev.h"
+#include "cn20k_cryptodev_ops.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_capabilities.h"
 #include "cnxk_cryptodev_ops.h"
@@ -86,6 +87,8 @@ cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_
 
 	cnxk_cpt_caps_populate(vf);
 
+	dev->dev_ops = &cn20k_cpt_ops;
+	dev->driver_id = cn20k_cryptodev_driver_id;
 	dev->feature_flags = cnxk_cpt_default_ff_get();
 
 	dev->qp_depth_used = cnxk_cpt_qp_depth_used;
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
new file mode 100644
index 0000000000..64ab285235
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <cryptodev_pmd.h>
+#include <rte_cryptodev.h>
+
+#include "roc_cpt.h"
+#include "roc_idev.h"
+
+#include "cn20k_cryptodev.h"
+#include "cn20k_cryptodev_ops.h"
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_se.h"
+
+#include "rte_pmd_cnxk_crypto.h"
+
+static int
+cn20k_cpt_crypto_adapter_ev_mdata_set(struct rte_cryptodev *dev __rte_unused, void *sess,
+				      enum rte_crypto_op_type op_type,
+				      enum rte_crypto_op_sess_type sess_type, void *mdata)
+{
+	(void)dev;
+	(void)sess;
+	(void)op_type;
+	(void)sess_type;
+	(void)mdata;
+
+	return 0;
+}
+
+static void
+cn20k_cpt_dev_info_get(struct rte_cryptodev *dev, struct rte_cryptodev_info *info)
+{
+	(void)dev;
+	(void)info;
+}
+
+static int
+cn20k_sym_get_raw_dp_ctx_size(struct rte_cryptodev *dev __rte_unused)
+{
+	return 0;
+}
+
+static int
+cn20k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
+			       struct rte_crypto_raw_dp_ctx *raw_dp_ctx,
+			       enum rte_crypto_op_sess_type sess_type,
+			       union rte_cryptodev_session_ctx session_ctx, uint8_t is_update)
+{
+	(void)dev;
+	(void)qp_id;
+	(void)raw_dp_ctx;
+	(void)sess_type;
+	(void)session_ctx;
+	(void)is_update;
+	return 0;
+}
+
+struct rte_cryptodev_ops cn20k_cpt_ops = {
+	/* Device control ops */
+	.dev_configure = cnxk_cpt_dev_config,
+	.dev_start = cnxk_cpt_dev_start,
+	.dev_stop = cnxk_cpt_dev_stop,
+	.dev_close = cnxk_cpt_dev_close,
+	.dev_infos_get = cn20k_cpt_dev_info_get,
+
+	.stats_get = NULL,
+	.stats_reset = NULL,
+	.queue_pair_setup = cnxk_cpt_queue_pair_setup,
+	.queue_pair_release = cnxk_cpt_queue_pair_release,
+	.queue_pair_reset = cnxk_cpt_queue_pair_reset,
+
+	/* Symmetric crypto ops */
+	.sym_session_get_size = cnxk_cpt_sym_session_get_size,
+	.sym_session_configure = cnxk_cpt_sym_session_configure,
+	.sym_session_clear = cnxk_cpt_sym_session_clear,
+
+	/* Asymmetric crypto ops */
+	.asym_session_get_size = cnxk_ae_session_size_get,
+	.asym_session_configure = cnxk_ae_session_cfg,
+	.asym_session_clear = cnxk_ae_session_clear,
+
+	/* Event crypto ops */
+	.session_ev_mdata_set = cn20k_cpt_crypto_adapter_ev_mdata_set,
+	.queue_pair_event_error_query = cnxk_cpt_queue_pair_event_error_query,
+
+	/* Raw data-path API related operations */
+	.sym_get_raw_dp_ctx_size = cn20k_sym_get_raw_dp_ctx_size,
+	.sym_configure_raw_dp_ctx = cn20k_sym_configure_raw_dp_ctx,
+};
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.h b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
new file mode 100644
index 0000000000..d7c3aed22b
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef _CN20K_CRYPTODEV_OPS_H_
+#define _CN20K_CRYPTODEV_OPS_H_
+
+#include <cryptodev_pmd.h>
+#include <rte_compat.h>
+#include <rte_cryptodev.h>
+#include <rte_eventdev.h>
+
+#if defined(__aarch64__)
+#include "roc_io.h"
+#else
+#include "roc_io_generic.h"
+#endif
+
+#include "cnxk_cryptodev.h"
+
+extern struct rte_cryptodev_ops cn20k_cpt_ops;
+
+#endif /* _CN20K_CRYPTODEV_OPS_H_ */
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index 886bb5c428..0b078b4d06 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -18,6 +18,7 @@ sources = files(
         'cn10k_ipsec.c',
         'cn10k_tls.c',
         'cn20k_cryptodev.c',
+        'cn20k_cryptodev_ops.c',
         'cnxk_cryptodev.c',
         'cnxk_cryptodev_capabilities.c',
         'cnxk_cryptodev_devargs.c',
-- 
2.25.1

