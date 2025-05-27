Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB4C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 11:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE30040664;
	Tue, 27 May 2025 13:02:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C0D7A40664
 for <dev@dpdk.org>; Tue, 27 May 2025 13:02:14 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6slSv019159
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 LWcdKlagQFkRbCmNgAJLqBRtQNsGzHxOiGBstPD6Qk=; b=PvsB5akmuMrbAqcwc
 Rn69JgyuRt4TQxx81wbueC7bSFEmiIwUBnkddEPbUoBeBvpSkJU5h5C2JuyKXQV7
 W4XmWT5u5DaBQVgaguWXWeXGYzEbpqnL0gpSL7ysBSt36XK8XB/GVYr0zB2B9t5c
 KX3Guls3KaSsNGnfJc7T0n++9tdVWGxFtoidJDyazfea4AcqPmxBnMxbgu1VpzZ/
 0P7/NmBotjFJbOdM7ncEGxCYAB1SK/+pFfyH7dw3s/W65YqKFJEBzP892FDFAEDe
 aURExI1yMnPA6tJRwbZP755nAK5/JJwQr/vMvJHbGJuTjPytZASUdmfs8Ff843+V
 fzK7g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w8hq8djh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 04:02:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 04:02:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 04:02:13 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 4F4243F7061;
 Tue, 27 May 2025 04:02:11 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 02/25] crypto/cnxk: add ops skeleton for cn20k
Date: Tue, 27 May 2025 16:31:42 +0530
Message-ID: <20250527110205.2300800-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527110205.2300800-1-ktejasree@marvell.com>
References: <20250527110205.2300800-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5MCBTYWx0ZWRfX7LqbtaAFpw7W
 STseawfs0e5ygXm3yhBn1sy96/QhN08J3VUs8kGE9R+MSI5Iz93ZmmVPhmYP79H6aUDFedASrKH
 EOzhCawuGlO8Z1KYyZnUQrumQtvrqIN9AUgz437VwV3lotcHn7+UIEyj2/Fka2UDqbNB5DV0e9r
 MQlWRcGugxvq7ESSsEQzjlDsWqydnP67qEqcwZu/1ZJPagVrFA2juC8nmljI592FnSOE9V8UL63
 dqgj29PVPvAB7bmDCDzK5fPluEeG/CZUEgHOKQgEhbzkYSqm1UzUtVnJKafQUCxk16H9rePrCKm
 o4J9iX6H/0RztaFjTxxxcFwwgfrek08efhMQLnFB3rBcPQGBVB33rnQ4dC3Tt+ihGGjhtVDmKiV
 4qQXqIqDGtdTqPr/TOh5LIzJxj2EKnJCzu2C1M6DZLLEN7Qa27Mcm2S3pT6I3m63+KIXgvzR
X-Authority-Analysis: v=2.4 cv=D89HKuRj c=1 sm=1 tr=0 ts=68359bb5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=6hli1bLTE9R2aqulzRgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: sMaHzQcVv83Nu0PqKagMl0eTk8eruGmw
X-Proofpoint-ORIG-GUID: sMaHzQcVv83Nu0PqKagMl0eTk8eruGmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
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

