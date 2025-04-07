Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623AFC3601A
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 06:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE31740156;
	Mon,  7 Apr 2025 08:40:51 +0200 (CEST)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by mails.dpdk.org (Postfix) with ESMTP id 52B0E40150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 08:40:50 +0200 (CEST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHzl5qc_NnFDSBEw--.39338S2;
 Mon, 07 Apr 2025 14:40:42 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHy4doc_Nn4KBiAA--.5065S3;
 Mon, 07 Apr 2025 14:40:41 +0800 (CST)
From: liwencheng <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v5 4/4] net/macb: add necessary docs and update related files
Date: Mon,  7 Apr 2025 06:40:35 +0000
Message-Id: <1744008035-4906-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1743577871-120091-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577871-120091-1-git-send-email-liwencheng@phytium.com.cn>
X-CM-TRANSID: AQAAfwDHy4doc_Nn4KBiAA--.5065S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFW3Xr1xKFW3KF1ftFWUurg_yoW5tr45pw
 s3AFWS9r9rJ34xZr9xt3WUAr4rAF4vy3y5uF1xJ34rXFn8Cr18Xr4UtryIy3yDWFyUZ3WF
 qF1Yqry3CF1DW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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

Added missing documentation in doc/guides/nics,
mailmap entry, and updated MAINTAINERS file.

v5:
* Add driver based on 25.07.

Signed-off-by: liwencheng <liwencheng@phytium.com.cn>
---
 MAINTAINERS                            |  6 ++++++
 doc/guides/nics/features/macb.ini      | 27 +++++++++++++++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/nics/macb.rst               | 26 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_25_07.rst |  4 ++++
 5 files changed, 64 insertions(+)
 create mode 100644 doc/guides/nics/features/macb.ini
 create mode 100644 doc/guides/nics/macb.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b01103..379645d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -920,6 +920,12 @@ F: doc/guides/platform/bluefield.rst
 F: doc/guides/nics/mlx5.rst
 F: doc/guides/nics/features/mlx5.ini
 
+Phytium macb
+M: Wencheng Li <liwencheng@phytium.com.cn>
+F: drivers/net/macb
+F: doc/guides/nics/macb.rst
+F: doc/guides/nics/features/macb.ini
+
 Microsoft mana
 M: Long Li <longli@microsoft.com>
 M: Wei Hu <weh@microsoft.com>
diff --git a/doc/guides/nics/features/macb.ini b/doc/guides/nics/features/macb.ini
new file mode 100644
index 0000000..cefc282
--- /dev/null
+++ b/doc/guides/nics/features/macb.ini
@@ -0,0 +1,27 @@
+;
+; Supported features of the 'macb' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+
+[Features]
+Speed capabilities   = Y
+Link status          = Y
+Queue start/stop     = Y
+MTU update           = Y
+Allmulticast mode    = Y
+CRC offload          = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
+Scattered Rx         = Y
+Rx descriptor status = Y
+Basic stats          = Y
+Linux                = Y
+
+[rte_flow items]
+eth                  = Y
+ipv4                 = Y
+ipv6                 = Y
+raw                  = Y
+tcp                  = Y
+udp                  = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 10a2eca..8ae1950 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -43,6 +43,7 @@ Network Interface Controller Drivers
     ionic
     ipn3ke
     ixgbe
+    macb
     mana
     memif
     mlx4
diff --git a/doc/guides/nics/macb.rst b/doc/guides/nics/macb.rst
new file mode 100644
index 0000000..5614a63
--- /dev/null
+++ b/doc/guides/nics/macb.rst
@@ -0,0 +1,26 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2022~2023 Phytium Technology Co., Ltd.
+
+MACB Poll Mode Driver
+=====================
+
+The MACB PMD provides poll mode driver support
+for the Ethernet interface MAC 1/2.5/10 Gbps adapter.
+
+Supported Chipsets and NICs
+---------------------------
+
+Phytium Ethernet interface cdns,phytium-gem-1.0
+Phytium Ethernet interface cdns,phytium-gem-2.0
+
+Features
+--------
+
+Features of the MACB PMD are:
+
+* Speed capabilities
+* Link status
+* Tx Queue start/stop
+* Multiple queues for TX and RX
+* CRC offload
+* Jumbo frames supported
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index cd1025a..9298dc1 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added Phytium macb net driver.**
+
+  Added a new network PMD which supports Phytium 1 and 10 Gigabit
+  Ethernet NICs.
 
 Removed Items
 -------------
-- 
2.7.4

