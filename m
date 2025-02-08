Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC24C02199
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 02:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FDDE402DD;
	Sat,  8 Feb 2025 03:44:32 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 2506B402DD
 for <dev@dpdk.org>; Sat,  8 Feb 2025 03:44:30 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 68D1A91451; Sat,  8 Feb 2025 10:44:14 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v7 01/28] net/rnp: add skeleton
Date: Sat,  8 Feb 2025 10:43:38 +0800
Message-Id: <1738982645-34550-2-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
References: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
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
 MAINTAINERS                      |  6 +++
 doc/guides/nics/features/rnp.ini |  8 ++++
 doc/guides/nics/index.rst        |  1 +
 doc/guides/nics/rnp.rst          | 82 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/meson.build          |  1 +
 5 files changed, 98 insertions(+)
 create mode 100644 doc/guides/nics/features/rnp.ini
 create mode 100644 doc/guides/nics/rnp.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 812463f..cf4806e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -974,6 +974,12 @@ F: drivers/net/qede/
 F: doc/guides/nics/qede.rst
 F: doc/guides/nics/features/qede*.ini
 
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
index 0000000..2ad04ee
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
index c14bc79..b12f409 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -60,6 +60,7 @@ Network Interface Controller Drivers
     pcap_ring
     pfe
     qede
+    rnp
     sfc_efx
     softnic
     tap
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
new file mode 100644
index 0000000..618baa8
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
+<https://mucse.com/productDetail>`_.
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
index fb6d34b..9308577 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -53,6 +53,7 @@ drivers = [
         'pfe',
         'qede',
         'ring',
+        'rnp',
         'sfc',
         'softnic',
         'tap',
-- 
1.8.3.1

