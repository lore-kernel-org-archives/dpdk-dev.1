Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A493CA0EED
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 10:23:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B2D2402D9;
	Tue, 19 Aug 2025 12:23:10 +0200 (CEST)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50]) by mails.dpdk.org (Postfix) with ESMTP id 80A1D40289
 for <dev@dpdk.org>; Tue, 19 Aug 2025 12:23:06 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eJiaSGI_1755598984 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 19 Aug 2025 18:23:05 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Kyo Liu <kyo.liu@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v5 01/17] net/nbl: add doc and minimum nbl build framework
Date: Tue, 19 Aug 2025 03:22:21 -0700
Message-Id: <20250819102237.3067518-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

add minimum PMD code, doc and build infrastructure for nbl driver.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 .mailmap                                      |  4 +
 MAINTAINERS                                   |  9 ++
 doc/guides/nics/features/nbl.ini              |  9 ++
 doc/guides/nics/index.rst                     |  1 +
 doc/guides/nics/nbl.rst                       | 87 +++++++++++++++++++
 doc/guides/rel_notes/release_25_11.rst        |  4 +
 drivers/net/meson.build                       |  1 +
 drivers/net/nbl/meson.build                   | 11 +++
 drivers/net/nbl/nbl_ethdev.c                  |  3 +
 .../net/nbl/nbl_include/nbl_product_base.h    | 37 ++++++++
 10 files changed, 166 insertions(+)
 create mode 100644 doc/guides/nics/features/nbl.ini
 create mode 100644 doc/guides/nics/nbl.rst
 create mode 100644 drivers/net/nbl/meson.build
 create mode 100644 drivers/net/nbl/nbl_ethdev.c
 create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h

diff --git a/.mailmap b/.mailmap
index 293ec12da0..c9dc467182 100644
--- a/.mailmap
+++ b/.mailmap
@@ -375,6 +375,7 @@ Diana Wang <na.wang@corigine.com>
 Didier Pallard <didier.pallard@6wind.com>
 Dilshod Urazov <dilshod.urazov@oktetlabs.ru>
 Dima Ruinskiy <dima.ruinskiy@intel.com>
+Dimon Zhao <dimon.zhao@nebula-matrix.com>
 Ding Zhi <zhi.ding@6wind.com>
 Diogo Behrens <diogo.behrens@huawei.com>
 Dirk-Holger Lenz <dirk.lenz@ng4t.com>
@@ -857,6 +858,7 @@ Kumar Amber <kumar.amber@intel.com>
 Kumara Parameshwaran <kumaraparamesh92@gmail.com> <kparameshwar@vmware.com>
 Kumar Sanghvi <kumaras@chelsio.com>
 Kyle Larose <klarose@sandvine.com>
+Kyo Liu <kyo.liu@nebula-matrix.com>
 Lance Richardson <lance.richardson@broadcom.com>
 Laszlo Ersek <lersek@redhat.com>
 Laura Stroe <laura.stroe@intel.com>
@@ -871,6 +873,7 @@ Lei Gong <arei.gonglei@huawei.com>
 Lei Ji <jilei8@huawei.com>
 Lei Yao <lei.a.yao@intel.com>
 Leonid Myravjev <myravjev@amicon.ru>
+Leon Yu <leon.yu@nebula-matrix.com>
 Leo Xu <yongquanx@nvidia.com>
 Leszek Zygo <leszek.zygo@intel.com>
 Levend Sayar <levendsayar@gmail.com>
@@ -1389,6 +1392,7 @@ Saikrishna Edupuganti <saikrishna.edupuganti@intel.com>
 Saleh Alsouqi <salehals@nvidia.com> <salehals@mellanox.com>
 Salem Sol <salems@nvidia.com>
 Sam Andrew <samandrew@microsoft.com>
+Sam Chen <sam.chen@nebula-matrix.com>
 Sameh Gobriel <sameh.gobriel@intel.com>
 Sam Grove <sam.grove@sifive.com>
 Samik Gupta <samik.gupta@broadcom.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca98c537..edc93cdda0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1009,6 +1009,15 @@ F: drivers/net/rnp/
 F: doc/guides/nics/rnp.rst
 F: doc/guides/nics/features/rnp.ini
 
+Nebulamatrix nbl
+M: Dimon Zhao <dimon.zhao@nebula-matrix.com>
+M: Kyo Liu<kyo.liu@nebula-matrix.com>
+M: Leon Yu <leon.yu@nebula-matrix.com>
+M: Sam Chen <sam.chen@nebula-matrix.com>
+F: drivers/net/nbl
+F: doc/guides/nics/nbl.rst
+F: doc/guides/nics/features/nbl.ini
+
 Realtek r8169
 M: Howard Wang <howard_wang@realsil.com.cn>
 M: Chunhao Lin <hau@realtek.com>
diff --git a/doc/guides/nics/features/nbl.ini b/doc/guides/nics/features/nbl.ini
new file mode 100644
index 0000000000..6daabe6ed3
--- /dev/null
+++ b/doc/guides/nics/features/nbl.ini
@@ -0,0 +1,9 @@
+;
+; Supported features of the 'nbl' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux                = Y
+ARMv8                = Y
+x86-64               = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 57d161c526..84d4ece101 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -50,6 +50,7 @@ Network Interface Controller Drivers
     mvneta
     mvpp2
     netvsc
+    nbl
     nfb
     nfp
     ngbe
diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
new file mode 100644
index 0000000000..fa5dfaecdc
--- /dev/null
+++ b/doc/guides/nics/nbl.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2025 Nebulamatrix Technology Co., Ltd
+
+NBL Poll Mode Driver
+====================
+
+The NBL PMD (**librte_net_nbl**) provides poll mode driver support for
+10/25/50/100/200 Gbps Nebulamatrix Series Network Adapters.
+
+
+Features
+--------
+
+Features of the NBL PMD are:
+
+- Multiple queues for TX and RX
+- Receiver Side Scaling (RSS). Currently does not support user-configured RSS and only supports packet spraying via RSS.
+- Jumbo frames
+
+
+Supported NICs
+--------------
+
+The following Nebulamatrix device models are supported by the same nbl driver:
+
+  - S1205CQ-A00CHT
+  - S1105AS-A00CHT
+  - S1055AS-A00CHT
+  - S1052AS-A00CHT
+  - S1051AS-A00CHT
+  - S1045XS-A00CHT
+  - S1205CQ-A00CSP
+  - S1055AS-A00CSP
+  - S1052AS-A00CSP
+
+
+Linux Prerequisites
+~~~~~~~~~~~~~~~~~~~
+
+This driver relies on kernel drivers for resources allocations and initialization.
+The following dependencies are not part of DPDK and must be installed separately:
+
+- **Kernel modules**
+
+  They provide low level device drivers that manage actual hardware initialization
+  and resources sharing with user-space processes.
+
+  Unlike most other PMDs, these modules must remain loaded and bound to
+  their devices:
+
+  - ``nbl_core``: hardware driver managing Ethernet kernel network devices.
+
+Because the nbl_core kernel driver code has not been upstreamed to the Linux kernel community, it cannot be provided by standard Linux distributions.
+However, the nbl_core kernel driver has been upstreamed to the openEuler and Anolis communities. You can obtain the nbl_core code from the following links:
+
+openEuler community:
+https://gitee.com/openeuler/kernel/pulls/11667
+
+Anolis community:
+https://gitee.com/anolis/cloud-kernel/pulls/5185
+https://gitee.com/anolis/cloud-kernel/pulls/5059
+
+Alternatively, you can contact us to obtain the nbl_core code and installation package.
+
+
+Prerequisites
+-------------
+
+- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
+  to setup the basic DPDK environment.
+
+- Learn about `Nebulamatrix Series NICs
+  <https://www.nebula-matrix.com/main>`_.
+
+
+Multiple Processes
+~~~~~~~~~~~~~~~~~~
+
+The NBL PMD does not support Multiple Processes.
+
+
+Limitations or Known Issues
+---------------------------
+
+32-bit architectures are not supported.
+
+Windows and BSD are not supported yet.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 122029b3c8..b8f2f78239 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -64,6 +64,10 @@ New Features
 
   * Enabled software taildrop for ordered queues.
 
+* **Added Nebulamatrix nbl net driver.**
+
+    * Added the PMD for Nebulamatrix NICs.
+
 Removed Items
 -------------
 
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 61f8cddb30..517e78d18b 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -40,6 +40,7 @@ drivers = [
         'mlx5',
         'mvneta',
         'mvpp2',
+        'nbl',
         'netvsc',
         'nfb',
         'nfp',
diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
new file mode 100644
index 0000000000..68c045a48c
--- /dev/null
+++ b/drivers/net/nbl/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2025 NebulaMatrix Technology Co., Ltd.
+
+if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
+    build = false
+    reason = 'only supported on 64bit Linux'
+endif
+
+sources = files(
+        'nbl_ethdev.c',
+)
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
new file mode 100644
index 0000000000..3ad8e4033a
--- /dev/null
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
diff --git a/drivers/net/nbl/nbl_include/nbl_product_base.h b/drivers/net/nbl/nbl_include/nbl_product_base.h
new file mode 100644
index 0000000000..0acc749059
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_product_base.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_PRODUCT_BASE_H_
+#define _NBL_DEF_PRODUCT_BASE_H_
+
+#include "nbl_include.h"
+
+struct nbl_product_core_ops {
+	int (*hw_init)(void *p);
+	void (*hw_remove)(void *p);
+	int (*res_init)(void *p, struct rte_eth_dev *eth_dev);
+	void (*res_remove)(void *p);
+	int (*chan_init)(void *p);
+	void (*chan_remove)(void *p);
+};
+
+struct nbl_product_dev_ops {
+	int (*dev_init)(void *adapter);
+	void (*dev_uninit)(void *adapter);
+	int (*dev_start)(void *adapter);
+	void (*dev_stop)(void *adapter);
+};
+
+struct nbl_product_dispatch_ops {
+	int (*dispatch_init)(void *mgt);
+	int (*dispatch_uninit)(void *mgt);
+};
+
+struct nbl_product_dev_external_ops {
+	int (*external_pf_ops_get)(struct rte_eth_dev *dev, void *arg);
+	int (*external_rep_ops_get)(struct rte_eth_dev *dev, void *arg);
+	int (*external_bond_ops_get)(struct rte_eth_dev *dev, void *arg);
+};
+
+#endif
-- 
2.34.1

