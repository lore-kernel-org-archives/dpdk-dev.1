Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89756C0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 15:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B8254064E;
	Tue, 11 Feb 2025 16:07:06 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 262314060A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 16:07:03 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 534E6A3D9A; Tue, 11 Feb 2025 23:06:46 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v10 01/28] net/rnp: add skeleton
Date: Tue, 11 Feb 2025 23:06:11 +0800
Message-Id: <1739286398-61972-2-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739286398-61972-1-git-send-email-caowenbo@mucse.com>
References: <1739286398-61972-1-git-send-email-caowenbo@mucse.com>
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

Add basic PMD library and doc build infrastructure
Update maintainers file to claim responsibility.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Thomas Monjalon <thomas@monjalon.net>
---
 .mailmap                         |  1 +
 MAINTAINERS                      |  6 +++
 doc/guides/nics/features/rnp.ini |  8 ++++
 doc/guides/nics/index.rst        |  1 +
 doc/guides/nics/rnp.rst          | 82 ++++++++++++++++++++++++++++++++
 drivers/net/meson.build          |  1 +
 drivers/net/rnp/meson.build      | 18 +++++++
 drivers/net/rnp/rnp_ethdev.c     |  3 ++
 8 files changed, 120 insertions(+)
 create mode 100644 doc/guides/nics/features/rnp.ini
 create mode 100644 doc/guides/nics/rnp.rst
 create mode 100644 drivers/net/rnp/meson.build
 create mode 100644 drivers/net/rnp/rnp_ethdev.c

diff --git a/.mailmap b/.mailmap
index 818798273f..5860c743a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1651,6 +1651,7 @@ Wei Xie <weix.xie@intel.com>
 Weiyuan Li <weiyuanx.li@intel.com>
 Wei Zhao <wei.zhao1@intel.com>
 Wen Chiu <wchiu@brocade.com>
+Wenbo Cao <caowenbo@mucse.com>
 Wen-Chi Yang <wolkayang@gmail.com>
 Wenfeng Liu <liuwf@arraynetworks.com.cn>
 Wenjie Li <wenjiex.a.li@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f940ad713..f9e0a312db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1011,6 +1011,12 @@ F: drivers/net/r8169/
 F: doc/guides/nics/r8169.rst
 F: doc/guides/nics/features/r8169.ini
 
+Mucse rnp
+M: Wenbo Cao <caowenbo@mucse.com>
+F: drivers/net/rnp
+F: doc/guides/nics/rnp.rst
+F: doc/guides/nics/features/rnp.ini
+
 Solarflare sfc_efx
 M: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
 F: drivers/common/sfc_efx/
diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
new file mode 100644
index 0000000000..2ad04ee330
--- /dev/null
+++ b/doc/guides/nics/features/rnp.ini
@@ -0,0 +1,8 @@
+;
+; Supported features of the 'rnp' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux                = Y
+x86-64               = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 50688d9f64..6ce7ef24df 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -61,6 +61,7 @@ Network Interface Controller Drivers
     pfe
     qede
     r8169
+    rnp
     sfc_efx
     softnic
     tap
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
new file mode 100644
index 0000000000..4b78a492d4
--- /dev/null
+++ b/doc/guides/nics/rnp.rst
@@ -0,0 +1,82 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2023 Mucse IC Design Ltd.
+
+RNP Poll Mode driver
+====================
+
+The RNP ETHDEV PMD (**librte_net_rnp**) provides poll mode ethdev
+driver support for the inbuilt network device found in the **Mucse RNP**
+
+Prerequisites
+-------------
+More information can be found at `Mucse, Official Website
+<https://mucse.com/en/pro/pro.aspx>`_.
+For English version you can download the below pdf.
+`<https://muchuang-bucket.oss-cn-beijing.aliyuncs.com/aea70403c0de4fa58cd507632009103dMUCSE%20Product%20Manual%202023.pdf>`
+
+Supported Chipsets and NICs
+---------------------------
+
+- MUCSE Ethernet Controller N10 Series for 10GbE or 40GbE (Dual-port)
+
+Chip Basic Overview
+-------------------
+N10 isn't normal with traditional PCIe network card, The chip only have two pcie physical function.
+The Chip max can support eight ports.
+
+.. code-block:: console
+
+  +------------------------------------------------+
+  |                      OS                        |
+  |                   PCIE (PF0)                   |
+  |    |            |            |            |    |
+  +----|------------|------------|------------|----+
+       |            |            |            |
+     +-|------------|------------|------------|-+
+     |                Extend Mac                |
+     |          VLAN/Unicast/multicast          |
+     |             Promisc Mode  Ctrl           |
+     |                                          |
+     +-|------------|------------|------------|-+
+       |            |            |            |
+   +---|---+    +---|---+    +---|---+    +---|---+
+   |       |    |       |    |       |    |       |
+   | MAC 0 |    | MAC 1 |    | MAC 2 |    | MAC 3 |
+   |       |    |       |    |       |    |       |
+   +---|---+    +---|---+    +---|---+    +---|---+
+       |            |            |            |
+   +---|---+    +---|---+    +---|---+    +---|---+
+   |       |    |       |    |       |    |       |
+   | PORT 0|    | PORT 1|    | PORT 2|    | PORT 3|
+   |       |    |       |    |       |    |       |
+   +-------+    +-------+    +-------+    +-------+
+
+  +------------------------------------------------+
+  |                       OS                       |
+  |                   PCIE (PF1)                   |
+  |    |            |            |            |    |
+  +----|------------|------------|------------|----+
+       |            |            |            |
+     +-|------------|------------|------------|-+
+     |                Extend Mac                |
+     |           VLAN/Unicast/multicast         |
+     |             Promisc Mode  Ctrl           |
+     |                                          |
+     +-|------------|------------|------------|-+
+       |            |            |            |
+   +---|---+    +---|---+    +---|---+    +---|---+
+   |       |    |       |    |       |    |       |
+   | MAC 4 |    | MAC 5 |    | MAC 6 |    | MAC 7 |
+   |       |    |       |    |       |    |       |
+   +---|---+    +---|---+    +---|---+    +---|---+
+       |            |            |            |
+   +---|---+    +---|---+    +---|---+    +---|---+
+   |       |    |       |    |       |    |       |
+   | PORT 4|    | PORT 5|    | PORT 6|    | PORT 7|
+   |       |    |       |    |       |    |       |
+   +-------+    +-------+    +-------+    +-------+
+
+Limitations or Known issues
+---------------------------
+
+BSD are not supported yet.
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index dafd637ba4..2e2327c760 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -54,6 +54,7 @@ drivers = [
         'qede',
         'r8169',
         'ring',
+        'rnp',
         'sfc',
         'softnic',
         'tap',
diff --git a/drivers/net/rnp/meson.build b/drivers/net/rnp/meson.build
new file mode 100644
index 0000000000..8f8c4b12e3
--- /dev/null
+++ b/drivers/net/rnp/meson.build
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(C) 2023 Mucse IC Design Ltd.
+#
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+    subdir_done()
+endif
+
+if arch_subdir == 'riscv'
+    build = false
+    reason = 'not supported on RISC-V'
+    subdir_done()
+endif
+
+sources = files(
+                'rnp_ethdev.c',
+)
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
new file mode 100644
index 0000000000..9ce3c0b497
--- /dev/null
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
-- 
2.34.1

