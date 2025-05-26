Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0622C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:00:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98FDF40652;
	Mon, 26 May 2025 18:59:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C667E4028F
 for <dev@dpdk.org>; Mon, 26 May 2025 18:59:14 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QA8NG7022458
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
 p8FMjs2QWtjmX5vJH5LGltM/qSHhgbN9JOO1ESUzS8=; b=TP7H1sthuWd5UPsVb
 vJ5a83rTB+DsmJRNdRpQaZHgIXe3XU8T7LWVC1zXBM0ijAmjZlwIP7VO5TLT+3Ak
 zjIIXKfnDvLqSfmylAZp1Eepk/y1VytSxDU9SdchY9OZ5MwXnwDQj7D6jzuHyjPa
 15QeNaIVR197Vth3Rk2TIsNbqP415Ud2gk/ZBZ5XnkXURYEHDJKDFVuSTj7SypZ6
 Ov/o1JnihRjHOsSAfsUoBZRfQvAdfFmCb9M4wQMNF+Gp03nFFZX+KtbWMrXqvlSc
 7cPpglt0+3UteDeWWv04lu5U2I5toz/o/PzAtA93yP9OqQEcnXL9sbXsj1KKhct9
 jGqBg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vp9krp9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 09:59:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 09:59:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 09:59:12 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 9E41B3F7048;
 Mon, 26 May 2025 09:59:09 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>,
 "Nithinsen Kaithakadan" <nkaithakadan@marvell.com>, Rupesh Chiluka
 <rchiluka@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 15/40] crypto/cnxk: add rte security skeletion for cn20k
Date: Mon, 26 May 2025 22:27:54 +0530
Message-ID: <20250526165819.2197892-16-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=68349de1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=D_wUsvyuAj1PHHm8DI0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0MyBTYWx0ZWRfX/hxou3RnFuDd
 kwOqkZ4DX4h5K3RYPLix58txTwaFV7rCY1u3UROMGTpKJ+yQmah9bzAAk74HbkEz9sfo+4m9lsP
 oU9kwOCMVZbaGHE1wG0tXnXWAJx37jnJSXcTI30X87vB0XBsjCZhtQmG601NHoTznfF4QXQEv82
 K/bMIRKmoMOZBNc89m4xgjvftxy9CpRYH7wjqXXulpIzQsqmUtqHS6B3PeAbR3/BwWqjQXnhm28
 stf/EhpjSsizYGW676+XaDyOnH8XxL7fdifid7se+wG3ZW+Z0RejIdnMJaZ7cvouB6TcajeCj89
 wE2c8G9XVsXmoRJKmoTqsITuNZUGJmlvLJzMOkXHii1P1UiTZ0Zk8Gjnytr3/DJfn4DfO38rYn2
 ux4xxcU2Y7+foNCxGZSp4mzHJX8sFoc+BO3f3Zp56DiBywePhCQSdPnhvLbMNjpX9v1r6sGG
X-Proofpoint-ORIG-GUID: PUCQvqQMBPaIOAbwEvIKBiKwzpnR3OiZ
X-Proofpoint-GUID: PUCQvqQMBPaIOAbwEvIKBiKwzpnR3OiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

Add skeletion for rte sec for cn20k

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn20k_cryptodev.c     |   2 +
 drivers/crypto/cnxk/cn20k_cryptodev_sec.c | 106 ++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev_sec.h |  19 ++++
 drivers/crypto/cnxk/cn20k_ipsec.c         |  68 ++++++++++++++
 drivers/crypto/cnxk/cn20k_ipsec.h         |  41 +++++++++
 drivers/crypto/cnxk/meson.build           |   2 +
 6 files changed, 238 insertions(+)
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_sec.h
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.c
 create mode 100644 drivers/crypto/cnxk/cn20k_ipsec.h

diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
index 4c70c15ca9..7b8293cc05 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -12,6 +12,7 @@
 
 #include "cn20k_cryptodev.h"
 #include "cn20k_cryptodev_ops.h"
+#include "cn20k_cryptodev_sec.h"
 #include "cnxk_cryptodev.h"
 #include "cnxk_cryptodev_capabilities.h"
 #include "cnxk_cryptodev_ops.h"
@@ -93,6 +94,7 @@ cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_
 
 	dev->qp_depth_used = cnxk_cpt_qp_depth_used;
 	cn20k_cpt_set_enqdeq_fns(dev);
+	cn20k_sec_ops_override();
 
 	rte_cryptodev_pmd_probing_finish(dev);
 
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.c b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
new file mode 100644
index 0000000000..04c8e8f506
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <rte_security.h>
+
+#include "cn20k_cryptodev_ops.h"
+#include "cn20k_cryptodev_sec.h"
+#include "cnxk_cryptodev_ops.h"
+
+static int
+cn20k_sec_session_create(void *dev, struct rte_security_session_conf *conf,
+			 struct rte_security_session *sess)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(conf);
+	RTE_SET_USED(sess);
+
+	return -ENOTSUP;
+}
+
+static int
+cn20k_sec_session_destroy(void *dev, struct rte_security_session *sec_sess)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(sec_sess);
+
+	return -EINVAL;
+}
+
+static unsigned int
+cn20k_sec_session_get_size(void *dev __rte_unused)
+{
+	return 0;
+}
+
+static int
+cn20k_sec_session_stats_get(void *dev, struct rte_security_session *sec_sess,
+			    struct rte_security_stats *stats)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(sec_sess);
+	RTE_SET_USED(stats);
+
+	return -ENOTSUP;
+}
+
+static int
+cn20k_sec_session_update(void *dev, struct rte_security_session *sec_sess,
+			 struct rte_security_session_conf *conf)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(sec_sess);
+	RTE_SET_USED(conf);
+
+	return -ENOTSUP;
+}
+
+static int
+cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
+{
+	RTE_SET_USED(device);
+	RTE_SET_USED(port_id);
+	RTE_SET_USED(enable);
+
+	return -ENOTSUP;
+}
+
+#if defined(RTE_ARCH_ARM64)
+static uint16_t
+cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
+				  struct rte_security_session **sess, uint16_t nb_pkts)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(pkts);
+	RTE_SET_USED(sess);
+	RTE_SET_USED(nb_pkts);
+
+	return 0;
+}
+#else
+uint16_t __rte_hot
+cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
+				  struct rte_security_session **sess, uint16_t nb_pkts)
+{
+	RTE_SET_USED(dev);
+	RTE_SET_USED(sess);
+	RTE_SET_USED(nb_pkts);
+
+	return 0;
+}
+#endif
+
+/* Update platform specific security ops */
+void
+cn20k_sec_ops_override(void)
+{
+	/* Update platform specific ops */
+	cnxk_sec_ops.session_create = cn20k_sec_session_create;
+	cnxk_sec_ops.session_destroy = cn20k_sec_session_destroy;
+	cnxk_sec_ops.session_get_size = cn20k_sec_session_get_size;
+	cnxk_sec_ops.session_stats_get = cn20k_sec_session_stats_get;
+	cnxk_sec_ops.session_update = cn20k_sec_session_update;
+	cnxk_sec_ops.inb_pkt_rx_inject = cn20k_cryptodev_sec_inb_rx_inject;
+	cnxk_sec_ops.rx_inject_configure = cn20k_cryptodev_sec_rx_inject_configure;
+}
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_sec.h b/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
new file mode 100644
index 0000000000..5cd0e53017
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_sec.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __CN20K_CRYPTODEV_SEC_H__
+#define __CN20K_CRYPTODEV_SEC_H__
+
+#include <rte_common.h>
+#include <rte_security.h>
+
+#include "roc_constants.h"
+#include "roc_cpt.h"
+
+#include "cn20k_ipsec.h"
+
+#define SEC_SESS_SIZE sizeof(struct rte_security_session)
+
+void cn20k_sec_ops_override(void);
+#endif /* __CN20K_CRYPTODEV_SEC_H__ */
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.c b/drivers/crypto/cnxk/cn20k_ipsec.c
new file mode 100644
index 0000000000..da8f818d87
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_ipsec.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <cryptodev_pmd.h>
+#include <rte_esp.h>
+#include <rte_ip.h>
+#include <rte_malloc.h>
+#include <rte_security.h>
+#include <rte_security_driver.h>
+#include <rte_udp.h>
+
+#include "cn20k_cryptodev_ops.h"
+#include "cn20k_cryptodev_sec.h"
+#include "cn20k_ipsec.h"
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_ipsec.h"
+#include "cnxk_security.h"
+
+#include "roc_api.h"
+
+int
+cn20k_ipsec_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+			   struct rte_security_ipsec_xform *ipsec_xfrm,
+			   struct rte_crypto_sym_xform *crypto_xfrm,
+			   struct rte_security_session *sess)
+{
+	RTE_SET_USED(vf);
+	RTE_SET_USED(qp);
+	RTE_SET_USED(ipsec_xfrm);
+	RTE_SET_USED(crypto_xfrm);
+	RTE_SET_USED(sess);
+
+	return 0;
+}
+
+int
+cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess)
+{
+	RTE_SET_USED(qp);
+	RTE_SET_USED(sess);
+
+	return 0;
+}
+
+int
+cn20k_ipsec_stats_get(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess,
+		      struct rte_security_stats *stats)
+{
+	RTE_SET_USED(qp);
+	RTE_SET_USED(sess);
+	RTE_SET_USED(stats);
+
+	return 0;
+}
+
+int
+cn20k_ipsec_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+			   struct cn20k_sec_session *sess, struct rte_security_session_conf *conf)
+{
+	RTE_SET_USED(vf);
+	RTE_SET_USED(qp);
+	RTE_SET_USED(sess);
+	RTE_SET_USED(conf);
+
+	return 0;
+}
diff --git a/drivers/crypto/cnxk/cn20k_ipsec.h b/drivers/crypto/cnxk/cn20k_ipsec.h
new file mode 100644
index 0000000000..202d52405d
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_ipsec.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __CN20K_IPSEC_H__
+#define __CN20K_IPSEC_H__
+
+#include <rte_security.h>
+#include <rte_security_driver.h>
+
+#include "roc_constants.h"
+#include "roc_ie_ow.h"
+
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_ipsec.h"
+
+/* Forward declaration */
+struct cn20k_sec_session;
+
+struct __rte_aligned(ROC_ALIGN) cn20k_ipsec_sa
+{
+	union {
+		/** Inbound SA */
+		struct roc_ow_ipsec_inb_sa in_sa;
+		/** Outbound SA */
+		struct roc_ow_ipsec_outb_sa out_sa;
+	};
+};
+
+int cn20k_ipsec_session_create(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+			       struct rte_security_ipsec_xform *ipsec_xfrm,
+			       struct rte_crypto_sym_xform *crypto_xfrm,
+			       struct rte_security_session *sess);
+int cn20k_sec_ipsec_session_destroy(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess);
+int cn20k_ipsec_stats_get(struct cnxk_cpt_qp *qp, struct cn20k_sec_session *sess,
+			  struct rte_security_stats *stats);
+int cn20k_ipsec_session_update(struct cnxk_cpt_vf *vf, struct cnxk_cpt_qp *qp,
+			       struct cn20k_sec_session *sess,
+			       struct rte_security_session_conf *conf);
+#endif /* __CN20K_IPSEC_H__ */
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index 0b078b4d06..f8077e4d4c 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -19,6 +19,8 @@ sources = files(
         'cn10k_tls.c',
         'cn20k_cryptodev.c',
         'cn20k_cryptodev_ops.c',
+        'cn20k_cryptodev_sec.c',
+        'cn20k_ipsec.c',
         'cnxk_cryptodev.c',
         'cnxk_cryptodev_capabilities.c',
         'cnxk_cryptodev_devargs.c',
-- 
2.25.1

