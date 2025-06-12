Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448DAC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 08:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1132840DF5;
	Thu, 12 Jun 2025 10:59:23 +0200 (CEST)
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com
 [115.124.28.197])
 by mails.dpdk.org (Postfix) with ESMTP id 45FB240DD7
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:59:18 +0200 (CEST)
Received: from localhost.localdomain(mailfrom:kyo.liu@nebula-matrix.com
 fp:SMTPD_---.dJxIn92_1749718754 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 12 Jun 2025 16:59:14 +0800
From: Kyo Liu <kyo.liu@nebula-matrix.com>
To: kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 01/17] net/nbl: add doc and minimum nbl build framework
Date: Thu, 12 Jun 2025 08:58:22 +0000
Message-ID: <20250612085840.729830-2-kyo.liu@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
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

Signed-off-by: Kyo Liu <kyo.liu@nebula-matrix.com>
---
 .mailmap                         |  5 ++++
 MAINTAINERS                      |  9 +++++++
 doc/guides/nics/features/nbl.ini |  9 +++++++
 doc/guides/nics/index.rst        |  1 +
 doc/guides/nics/nbl.rst          | 42 ++++++++++++++++++++++++++++++++
 drivers/net/meson.build          |  1 +
 drivers/net/nbl/meson.build      | 11 +++++++++
 drivers/net/nbl/nbl_ethdev.c     |  3 +++
 8 files changed, 81 insertions(+)
 create mode 100644 doc/guides/nics/features/nbl.ini
 create mode 100644 doc/guides/nics/nbl.rst
 create mode 100644 drivers/net/nbl/meson.build
 create mode 100644 drivers/net/nbl/nbl_ethdev.c

diff --git a/.mailmap b/.mailmap
index 3dec1492aa..c8b592e0de 100644
--- a/.mailmap
+++ b/.mailmap
@@ -362,6 +362,7 @@ Diana Wang <na.wang@corigine.com>
 Didier Pallard <didier.pallard@6wind.com>
 Dilshod Urazov <dilshod.urazov@oktetlabs.ru>
 Dima Ruinskiy <dima.ruinskiy@intel.com>
+Dimon Zhao <dimon.zhao@nebula-matrix.com>
 Ding Zhi <zhi.ding@6wind.com>
 Diogo Behrens <diogo.behrens@huawei.com>
 Dirk-Holger Lenz <dirk.lenz@ng4t.com>
@@ -832,6 +833,7 @@ Kumar Amber <kumar.amber@intel.com>
 Kumara Parameshwaran <kumaraparamesh92@gmail.com> <kparameshwar@vmware.com>
 Kumar Sanghvi <kumaras@chelsio.com>
 Kyle Larose <klarose@sandvine.com>
+Kyo Liu<kyo.liu@nebula-matrix.com>
 Lance Richardson <lance.richardson@broadcom.com>
 Laszlo Ersek <lersek@redhat.com>
 Laura Stroe <laura.stroe@intel.com>
@@ -846,6 +848,7 @@ Lei Gong <arei.gonglei@huawei.com>
 Lei Ji <jilei8@huawei.com>
 Lei Yao <lei.a.yao@intel.com>
 Leonid Myravjev <myravjev@amicon.ru>
+Leon Yu <leon.yu@nebula-matrix.com>
 Leo Xu <yongquanx@nvidia.com>
 Leszek Zygo <leszek.zygo@intel.com>
 Levend Sayar <levendsayar@gmail.com>
@@ -1351,6 +1354,7 @@ Saikrishna Edupuganti <saikrishna.edupuganti@intel.com>
 Saleh Alsouqi <salehals@nvidia.com> <salehals@mellanox.com>
 Salem Sol <salems@nvidia.com>
 Sam Andrew <samandrew@microsoft.com>
+Sam Chen <sam.chen@nebula-matrix.com>
 Sameh Gobriel <sameh.gobriel@intel.com>
 Sam Grove <sam.grove@sifive.com>
 Samik Gupta <samik.gupta@broadcom.com>
@@ -1849,3 +1853,4 @@ Ziye Yang <ziye.yang@intel.com>
 Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com> <zyta.szpak@semihalf.com>
+Leon Yu <leon.yu@nebula-matrix.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 57679d40bc..ec4cc568f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1026,6 +1026,15 @@ F: drivers/net/sfc/
 F: doc/guides/nics/sfc_efx.rst
 F: doc/guides/nics/features/sfc.ini
 
+nebulamatrix nbl
+M: Dimon Zhao <dimon.zhao@nebula-matrix.com>
+M: Kyo Liu<kyo.liu@nebula-matrix.com>
+M: Leon Yu <leon.yu@nebula-matrix.com>
+M: Sam Chen <sam.chen@nebula-matrix.com>
+F: drivers/net/nbl
+F: doc/guides/nics/nbl.rst
+F: doc/guides/nics/features/nbl.ini
+
 Wangxun ngbe
 M: Jiawen Wu <jiawenwu@trustnetic.com>
 F: drivers/net/ngbe/
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
index 618c52d618..a82dfcf5c7 100644
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
index 0000000000..6cd09fe97f
--- /dev/null
+++ b/doc/guides/nics/nbl.rst
@@ -0,0 +1,42 @@
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
+Limitations or Known Issues
+---------------------------
+
+32-bit architectures are not supported.
+
+Windows and BSD are not supported yet.
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
index 0000000000..4cfbdb023f
--- /dev/null
+++ b/drivers/net/nbl/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2025 NebulaMatrix Technology Co., Ltd.
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
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
-- 
2.43.0

