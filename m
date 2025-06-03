Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B81EC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 11:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB31840697;
	Tue,  3 Jun 2025 13:50:35 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E5B2240697
 for <dev@dpdk.org>; Tue,  3 Jun 2025 13:50:33 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553A4v2G012356
 for <dev@dpdk.org>; Tue, 3 Jun 2025 04:50:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 WXyt7xrNmCWGMvl+b857amZE/LN/I2lZ3RqOQ7VoB0=; b=Lalfg3V5OTGt/dG5f
 cT+uhRei419EAJ/NcTeKS5w8lwadbOxvVgNytIbABqwBZ9BTHhbuzj8DxAyDBuyV
 lN3Y/Vk17fyS6b+aUTSXMg4+mfgMeHTf1CauQ6h7rWPo6uos7kYMB0tcIyxqL4yv
 d1zwqFePZk7US4PIPUXtiXa50H8OPQAOaMwmTjr5c/RYaYlPbJ0e/dnj4oJcUJJa
 e2LFNraZLd6Hbyt2ZcxSe+CVaeN0idhMXuiFBSYbWtAwUh54uHCIlTG8V6TCG340
 oNGznCbGcCtxqfXLMIHwcDM3sfBjuJwpUW+Y3XSil/IrnL7Ippb8tSBBgFm4ou7M
 V1juA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471xyyg5ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 03 Jun 2025 04:50:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 04:50:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Jun 2025 04:50:31 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id ACFD23F7041;
 Tue,  3 Jun 2025 04:50:29 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 01/25] crypto/cnxk: probe cn20k device
Date: Tue, 3 Jun 2025 17:20:02 +0530
Message-ID: <20250603115026.2664706-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603115026.2664706-1-ktejasree@marvell.com>
References: <20250603115026.2664706-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DsNW+H/+ c=1 sm=1 tr=0 ts=683ee188 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=zkyjEOYy4g67kIsTIeYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: OquxYR071kVQlGPWtcjl2hVlsSzPcA3m
X-Proofpoint-GUID: OquxYR071kVQlGPWtcjl2hVlsSzPcA3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDEwNCBTYWx0ZWRfX8oh5aJQ5cTRJ
 7PQ5zpxfurdQtJA/pTUcQKqqo51Ox2YarfoumDgqCuUiBfpKl84UDIWfv4CQIVaiMwfsahoCG82
 W0mZRaDTHx3E/jiWq2BSJihabS9XrA9IkF2Bd4ZSCJv2gLMzugfQz/7QkaqWyPBhW40kVmczT0E
 2803qmeVf3ibZJbBSHiFNM7Z3laKvhQTtAnuGJxt3mvBYGYCtb29gAJubXK9sQ9UZ/+pVI1vfqg
 goKPjZz66gOKwF6VRfKXEzXJNpct1SG3jbH31DlHOxToAmKlwTiD/6b/G4cuTpOov2mGtmDscGK
 /D6aV6Gx5feVbobat0xE7QtkqCsgwsN7S88m2du8r8L9tmnAB1jcw+b/KDZK8LNssK1GgK8/2YQ
 AN0mw1IGEOWXWJjr0B8wcOG3MoE2h3pcFeABEasECSgSP5LK9Wt0jvfI5qXLxbl2ke5Jdc0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Add probe for cn20k crypto device

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev.c |  12 +-
 drivers/crypto/cnxk/cn20k_cryptodev.c | 152 ++++++++++++++++++++++++++
 drivers/crypto/cnxk/cn20k_cryptodev.h |  13 +++
 drivers/crypto/cnxk/meson.build       |   1 +
 4 files changed, 170 insertions(+), 8 deletions(-)
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.c
 create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev.h

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev.c b/drivers/crypto/cnxk/cn10k_cryptodev.c
index 70bef13cda..598def51a5 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev.c
@@ -22,14 +22,10 @@
 uint8_t cn10k_cryptodev_driver_id;
 
 static struct rte_pci_id pci_id_cpt_table[] = {
-	{
-		RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
-			       PCI_DEVID_CN10K_RVU_CPT_VF)
-	},
-	/* sentinel */
-	{
-		.device_id = 0
-	},
+	CNXK_PCI_ID(PCI_SUBSYSTEM_DEVID_CN10KA, PCI_DEVID_CN10K_RVU_CPT_VF),
+	CNXK_PCI_ID(PCI_SUBSYSTEM_DEVID_CN10KAS, PCI_DEVID_CN10K_RVU_CPT_VF),
+	CNXK_PCI_ID(PCI_SUBSYSTEM_DEVID_CN10KB, PCI_DEVID_CN10K_RVU_CPT_VF),
+	{.vendor_id = 0},
 };
 
 static int
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.c b/drivers/crypto/cnxk/cn20k_cryptodev.c
new file mode 100644
index 0000000000..e52336c2b7
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.c
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#include <bus_pci_driver.h>
+#include <cryptodev_pmd.h>
+#include <dev_driver.h>
+#include <rte_common.h>
+#include <rte_crypto.h>
+#include <rte_cryptodev.h>
+#include <rte_pci.h>
+
+#include "cn20k_cryptodev.h"
+#include "cnxk_cryptodev.h"
+#include "cnxk_cryptodev_capabilities.h"
+#include "cnxk_cryptodev_ops.h"
+#include "cnxk_cryptodev_sec.h"
+
+#include "roc_api.h"
+
+uint8_t cn20k_cryptodev_driver_id;
+
+static struct rte_pci_id pci_id_cpt_table[] = {
+	CNXK_PCI_ID(PCI_SUBSYSTEM_DEVID_CN20KA, PCI_DEVID_CN20K_RVU_CPT_VF),
+	{.vendor_id = 0},
+};
+
+static int
+cn20k_cpt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused, struct rte_pci_device *pci_dev)
+{
+	struct rte_cryptodev_pmd_init_params init_params = {.name = "",
+							    .socket_id = rte_socket_id(),
+							    .private_data_size =
+								    sizeof(struct cnxk_cpt_vf)};
+	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
+	struct rte_cryptodev *dev;
+	struct roc_cpt *roc_cpt;
+	struct cnxk_cpt_vf *vf;
+	int rc;
+
+	rc = roc_plt_init();
+	if (rc < 0) {
+		plt_err("Failed to initialize platform model");
+		return rc;
+	}
+
+	rte_pci_device_name(&pci_dev->addr, name, sizeof(name));
+
+	dev = rte_cryptodev_pmd_create(name, &pci_dev->device, &init_params);
+	if (dev == NULL) {
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	/* Get private data space allocated */
+	vf = dev->data->dev_private;
+
+	roc_cpt = &vf->cpt;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		roc_cpt->pci_dev = pci_dev;
+
+		rc = cnxk_cpt_parse_devargs(dev->device->devargs, vf);
+		if (rc) {
+			plt_err("Failed to parse devargs rc=%d", rc);
+			goto pmd_destroy;
+		}
+
+		rc = roc_cpt_dev_init(roc_cpt);
+		if (rc) {
+			plt_err("Failed to initialize roc cpt rc=%d", rc);
+			goto pmd_destroy;
+		}
+
+		rc = cnxk_cpt_eng_grp_add(roc_cpt);
+		if (rc) {
+			plt_err("Failed to add engine group rc=%d", rc);
+			goto dev_fini;
+		}
+
+		/* Create security context */
+		rc = cnxk_crypto_sec_ctx_create(dev);
+		if (rc)
+			goto dev_fini;
+	}
+
+	cnxk_cpt_caps_populate(vf);
+
+	dev->feature_flags = cnxk_cpt_default_ff_get();
+
+	dev->qp_depth_used = cnxk_cpt_qp_depth_used;
+
+	rte_cryptodev_pmd_probing_finish(dev);
+
+	return 0;
+
+dev_fini:
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		roc_cpt_dev_fini(roc_cpt);
+pmd_destroy:
+	rte_cryptodev_pmd_destroy(dev);
+exit:
+	plt_err("Could not create device (vendor_id: 0x%x device_id: 0x%x)", pci_dev->id.vendor_id,
+		pci_dev->id.device_id);
+	return rc;
+}
+
+static int
+cn20k_cpt_pci_remove(struct rte_pci_device *pci_dev)
+{
+	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
+	struct rte_cryptodev *dev;
+	struct cnxk_cpt_vf *vf;
+	int ret;
+
+	if (pci_dev == NULL)
+		return -EINVAL;
+
+	rte_pci_device_name(&pci_dev->addr, name, sizeof(name));
+
+	dev = rte_cryptodev_pmd_get_named_dev(name);
+	if (dev == NULL)
+		return -ENODEV;
+
+	/* Destroy security context */
+	cnxk_crypto_sec_ctx_destroy(dev);
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		dev->dev_ops = NULL;
+		vf = dev->data->dev_private;
+		ret = roc_cpt_dev_fini(&vf->cpt);
+		if (ret)
+			return ret;
+	}
+
+	return rte_cryptodev_pmd_destroy(dev);
+}
+
+static struct rte_pci_driver cn20k_cryptodev_pmd = {
+	.id_table = pci_id_cpt_table,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_NEED_IOVA_AS_VA,
+	.probe = cn20k_cpt_pci_probe,
+	.remove = cn20k_cpt_pci_remove,
+};
+
+static struct cryptodev_driver cn20k_cryptodev_drv;
+
+RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CN20K_PMD, cn20k_cryptodev_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(CRYPTODEV_NAME_CN20K_PMD, pci_id_cpt_table);
+RTE_PMD_REGISTER_KMOD_DEP(CRYPTODEV_NAME_CN20K_PMD, "vfio-pci");
+RTE_PMD_REGISTER_CRYPTO_DRIVER(cn20k_cryptodev_drv, cn20k_cryptodev_pmd.driver,
+			       cn20k_cryptodev_driver_id);
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev.h b/drivers/crypto/cnxk/cn20k_cryptodev.h
new file mode 100644
index 0000000000..d8a84d5464
--- /dev/null
+++ b/drivers/crypto/cnxk/cn20k_cryptodev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef _CN20K_CRYPTODEV_H_
+#define _CN20K_CRYPTODEV_H_
+
+/* Marvell OCTEON CN20K Crypto PMD device name */
+#define CRYPTODEV_NAME_CN20K_PMD crypto_cn20k
+
+extern uint8_t cn20k_cryptodev_driver_id;
+
+#endif /* _CN20K_CRYPTODEV_H_ */
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index e9b67b4a14..886bb5c428 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -17,6 +17,7 @@ sources = files(
         'cn10k_cryptodev_sec.c',
         'cn10k_ipsec.c',
         'cn10k_tls.c',
+        'cn20k_cryptodev.c',
         'cnxk_cryptodev.c',
         'cnxk_cryptodev_capabilities.c',
         'cnxk_cryptodev_devargs.c',
-- 
2.25.1

