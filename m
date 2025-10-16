Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E89CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 01:52:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0A4B40ED2;
	Thu, 16 Oct 2025 03:52:34 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id DDCD440269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 03:52:30 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XwW/thrTZkSRURJeT+5Ke79HW7OeGc7MquehScRBPyU=;
 b=Lb5iBDKF3rYvbTmZ2g7qU0W7gyg8OQjXs9LPIJ+8MtnGO79mnGt+8ba31LNLE9zjer0X6cyR6
 st36NbzBqVVNJJiho6XAW+n0U/s/tzlu0yKwAuk8gIY1nDXKOc7FYdKUoACzsdElrz9zPf/IRbl
 f9jGD3SHk4YfayE3bb8O3tA=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cn9t70jTZz1T4KD;
 Thu, 16 Oct 2025 09:51:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 874011401F0;
 Thu, 16 Oct 2025 09:52:28 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 09:52:28 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH v5 4/4] dma/hisi_acc: add doc
Date: Thu, 16 Oct 2025 09:52:21 +0800
Message-ID: <20251016015221.1423-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016015221.1423-1-fengchengwen@huawei.com>
References: <20250827092729.10719-1-fengchengwen@huawei.com>
 <20251016015221.1423-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This commit adds document for Hisilicon accelerator DMA driver.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 MAINTAINERS                            |  1 +
 doc/guides/dmadevs/hisi_acc.rst        | 63 ++++++++++++++++++++++++++
 doc/guides/dmadevs/index.rst           |  1 +
 doc/guides/rel_notes/release_25_11.rst |  6 +++
 4 files changed, 71 insertions(+)
 create mode 100644 doc/guides/dmadevs/hisi_acc.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index b5e3479203..ce038822c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1369,6 +1369,7 @@ F: doc/guides/dmadevs/hisilicon.rst
 HiSilicon Accelerator DMA
 M: Chengwen Feng <fengchengwen@huawei.com>
 F: drivers/dma/hisi_acc/
+F: doc/guides/dmadevs/hisi_acc.rst
 
 Marvell CNXK DPI DMA
 M: Vamsi Attunuru <vattunuru@marvell.com>
diff --git a/doc/guides/dmadevs/hisi_acc.rst b/doc/guides/dmadevs/hisi_acc.rst
new file mode 100644
index 0000000000..41fc24877f
--- /dev/null
+++ b/doc/guides/dmadevs/hisi_acc.rst
@@ -0,0 +1,63 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright (c) 2025 HiSilicon Technologies Co., Ltd. All rights reserved.
+
+HISILICON Accelerator DMA Driver
+================================
+
+Kunpeng SoC has an internal accelerator unit which includes zip function, and
+the zip also supports data copy and fill. This driver exposes this capability to
+DPDK application.
+
+
+Supported Kunpeng SoCs
+----------------------
+
+* Kunpeng 920
+
+
+Device Setup
+-------------
+
+In order to use the device in DPDK, user should insmod uacce.ko, hisi_qm.ko and
+hisi_zip.ko(with module parameter uacce_mode=1), then there will be several
+subdirectories whose names start with hisi_zip in /sys/class/uacce/ directory.
+
+Device Probing and Initialization
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+User should use following method to probe device::
+
+        $ dpdk-app -a uacce:hisi_zip-0,queues=2 ...
+
+hisi_zip-0 is the directory name in the /sys/class/uacce/ directory, queues is
+runtime config parameter which indicates how many dmadevs are created.
+
+If the probe is successful, two dmadevs are created, named "hisi_zip-0-dma0"
+and "hisi_zip-0-dma1".
+
+.. note::
+        In the /sys/class/uacce/hisi_zip-x/ directory, user could query api and
+        algorithms, this driver can only match the device whose api is
+        hisi_qm_v5 and algorithms contain udma.
+
+Device Configuration
+~~~~~~~~~~~~~~~~~~~~~
+
+Configuration requirements:
+
+* ``ring_size`` obtain from UACCE API and is a fixed value.
+* Only one ``vchan`` is supported per ``dmadev``.
+* Silent mode is not supported.
+* The transfer direction must be set to ``RTE_DMA_DIR_MEM_TO_MEM``.
+
+
+Device Datapath Capability and Limitation
+-----------------------------------------
+
+Support memory copy and fill operations.
+
+.. note::
+        Currently, the maximum size of the operation data is limited to 16MB-1B
+        in the driver. The device actually supports operations in a larger data
+        size, but the driver requires complex operations in the datapth. If you
+        have such requirement, please contact the maintainers.
diff --git a/doc/guides/dmadevs/index.rst b/doc/guides/dmadevs/index.rst
index 15ddaf5192..86dcdbb412 100644
--- a/doc/guides/dmadevs/index.rst
+++ b/doc/guides/dmadevs/index.rst
@@ -14,6 +14,7 @@ an application through DMA API.
    cnxk
    dpaa
    dpaa2
+   hisi_acc
    hisilicon
    idxd
    ioat
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 3c32b26e3b..3c93c19c0d 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -71,6 +71,12 @@ New Features
   Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
   and some devices already support this speed.
 
+* **Add Hisilicon Accelerator DMA Driver.**
+
+  Kunpeng SoC has an internal accelerator unit which includes zip function,
+  and the zip also support data copy and fill. This driver exposes this
+  capability to DPDK application.
+
 * **Updated NXP DPAA2 ethernet driver.**
 
   * Enabled software taildrop for ordered queues.
-- 
2.17.1

