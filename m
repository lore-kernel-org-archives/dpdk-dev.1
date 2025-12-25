Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99400E7AD41
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Dec 2025 08:32:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E148D4029A;
	Thu, 25 Dec 2025 09:32:56 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id E3DAE4025E
 for <dev@dpdk.org>; Thu, 25 Dec 2025 09:32:54 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-01 (Coremail) with SMTP id qwCowAB3Im609kxpGXXHAQ--.22806S2;
 Thu, 25 Dec 2025 16:32:52 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v13 01/13] net/sxe: add base driver directory and doc
Date: Thu, 25 Dec 2025 16:32:40 +0800
Message-Id: <20251225083252.189884-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
References: <20250728090517.1811244-13-liujie5@linkdatatechnology.com>
X-CM-TRANSID: qwCowAB3Im609kxpGXXHAQ--.22806S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWrWFyDXFWxZw1kZF4ruFg_yoW3Cw4fpa
 1kCFWSkr1fJay7X3Zxt3WUCF1rAa1vya4Uuw1I934FqF98Cry8Xr4UtFy8t3srWFyYv34F
 vF1avrW7uF15X3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9q14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I
 0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
 GVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
 0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
 rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
 4UJbIYCTnIWIevJa73UjIFyTuYvjfU15l1DUUUU
X-Originating-IP: [221.238.36.162]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Adding a minimum maintainable directory structure for the
network driver and request maintenance of the sxe driver.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 MAINTAINERS                            |  6 +++
 doc/guides/nics/features/sxe.ini       | 55 ++++++++++++++++++++
 doc/guides/nics/features/sxe_vf.ini    | 37 ++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/nics/sxe.rst                | 71 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  4 ++
 drivers/net/sxe/meson.build            |  9 ++++
 drivers/net/sxe/pf/sxe_ethdev.c        |  3 ++
 drivers/net/sxe/pf/sxe_ethdev.h        |  3 ++
 9 files changed, 189 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe.ini
 create mode 100644 doc/guides/nics/features/sxe_vf.ini
 create mode 100644 doc/guides/nics/sxe.rst
 create mode 100644 drivers/net/sxe/meson.build
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d7d8dbdb25..034dea8908 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -859,6 +859,12 @@ F: drivers/net/intel/ipn3ke/
 F: doc/guides/nics/ipn3ke.rst
 F: doc/guides/nics/features/ipn3ke.ini
 
+Linkdata sxe
+M: Jie Li <lijie@linkdatatechnology.com>
+F: drivers/net/sxe/
+F: doc/guides/nics/sxe.rst
+F: doc/guides/nics/features/sxe*.ini
+
 Marvell cnxk
 M: Nithin Dabilpuram <ndabilpuram@marvell.com>
 M: Kiran Kumar K <kirankumark@marvell.com>
diff --git a/doc/guides/nics/features/sxe.ini b/doc/guides/nics/features/sxe.ini
new file mode 100644
index 0000000000..a700ba3dc9
--- /dev/null
+++ b/doc/guides/nics/features/sxe.ini
@@ -0,0 +1,55 @@
+;
+; Supported features of the 'sxe' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Speed capabilities   = Y
+Link speed configuration = Y
+Link status          = Y
+Link status event    = Y
+Rx interrupt         = Y
+Queue start/stop     = Y
+Power mgmt address monitor = Y
+MTU update           = Y
+Scattered Rx         = Y
+LRO                  = Y
+TSO                  = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+Multicast MAC filter = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VMDq                 = Y
+SR-IOV               = Y
+DCB                  = Y
+VLAN filter          = Y
+Flow control         = Y
+Rate limitation      = Y
+Traffic manager      = Y
+Inline crypto        = Y
+CRC offload          = P
+VLAN offload         = P
+QinQ offload         = P
+L3 checksum offload  = P
+L4 checksum offload  = P
+MACsec offload       = P
+Inner L3 checksum    = P
+Inner L4 checksum    = P
+Packet type parsing  = Y
+Timesync             = Y
+Rx descriptor status = Y
+Tx descriptor status = Y
+Basic stats          = Y
+Extended stats       = Y
+Stats per queue      = Y
+FW version           = Y
+EEPROM dump          = Y
+Module EEPROM dump   = Y
+Registers dump       = Y
+Multiprocess aware   = Y
+Linux                = Y
+ARMv8                = Y
+x86-64               = Y
diff --git a/doc/guides/nics/features/sxe_vf.ini b/doc/guides/nics/features/sxe_vf.ini
new file mode 100644
index 0000000000..7caf5435ae
--- /dev/null
+++ b/doc/guides/nics/features/sxe_vf.ini
@@ -0,0 +1,37 @@
+;
+; Supported features of the 'sxe_vf' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Link status          = Y
+Rx interrupt         = Y
+Power mgmt address monitor = Y
+MTU update           = Y
+Scattered Rx         = Y
+LRO                  = Y
+TSO                  = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Inline crypto        = Y
+CRC offload          = P
+VLAN offload         = P
+QinQ offload         = P
+L3 checksum offload  = P
+L4 checksum offload  = P
+Inner L3 checksum    = P
+Inner L4 checksum    = P
+Packet type parsing  = Y
+Rx descriptor status = Y
+Tx descriptor status = Y
+Basic stats          = Y
+Extended stats       = Y
+Registers dump       = Y
+Linux                = Y
+ARMv8                = Y
+x86-64               = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index b00ed998c5..3d9e359f6b 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -67,6 +67,7 @@ Network Interface Controller Drivers
     rnp
     sfc_efx
     softnic
+    sxe
     tap
     thunderx
     txgbe
diff --git a/doc/guides/nics/sxe.rst b/doc/guides/nics/sxe.rst
new file mode 100644
index 0000000000..6f8b56d91c
--- /dev/null
+++ b/doc/guides/nics/sxe.rst
@@ -0,0 +1,71 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright (C), 2022, Linkdata Technology Co., Ltd.
+
+SXE Poll Mode Driver
+======================
+
+The SXE PMD (librte_pmd_sxe) provides poll mode driver support
+for Linkdata 1160-2X 10GE Ethernet Adapter.
+
+Features
+--------
+- PXE boot
+- PTP(Precision Time Protocol)
+- VMDq(Virtual Machine Device Queues)
+- SR-IOV,max 2PF,63VF per PF
+- 128 L2 Ethernet MAC Address Filters (unicast and multicast)
+- 64 L2 VLAN filters
+- pldm over mctp over smbus
+- 802.1q VLAN
+- Low Latency Interrupts
+- LRO
+- Promiscuous mode
+- Multicast mode
+- Multiple queues for TX and RX
+- Receiver Side Scaling (RSS)
+- MAC/VLAN filtering
+- Packet type information
+- Checksum offload
+- VLAN/QinQ stripping and inserting
+- TSO offload
+- Port hardware statistics
+- Link state information
+- Link flow control
+- Interrupt mode for RX
+- Scattered and gather for TX and RX
+- DCB
+- IEEE 1588
+- FW version
+- Generic flow API
+
+Configuration
+-------------
+
+Dynamic Logging Parameters
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+One may leverage EAL option "--log-level" to change default levels
+for the log types supported by the driver. The option is used with
+an argument typically consisting of two parts separated by a colon.
+
+SXE PMD provides the following log types available for control:
+
+- ``pmd.net.sxe.drv`` (default level is **INFO**)
+
+  Affects driver-wide messages unrelated to any particular devices.
+
+- ``pmd.net.sxe.init`` (default level is **INFO**)
+
+  Extra logging of the messages during PMD initialization.
+
+- ``pmd.net.sxe.rx`` (default level is **INFO**)
+
+  Affects rx-wide messages.
+- ``pmd.net.sxe.tx`` (default level is **INFO**)
+
+  Affects tx-wide messages.
+
+------------------------------
+
+Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+for details.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..fd8fc0c2e4 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -54,7 +54,11 @@ New Features
      This section is a comment. Do not overwrite or remove it.
      Also, make sure to start the actual text at the margin.
      =======================================================
+* **Updated Linkdata sxe ethernet driver.**
 
+  Added support for Linkdata NIC series, including 1160-2X (supporting 10G).
+  As these new models share hardware similarities with the existing 10G Sapphire NICs,
+  many of the existing configurations and practices are expected to apply.
 
 Removed Items
 -------------
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
new file mode 100644
index 0000000000..dad9ee44a0
--- /dev/null
+++ b/drivers/net/sxe/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (C), 2020, Wuxi Stars Micro System Technologies Co., Ltd.
+
+deps += ['hash']
+sources = files(
+        'pf/sxe_ethdev.c',
+)
+
+includes += include_directories('pf')
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
new file mode 100644
index 0000000000..e31a23deeb
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2024
+ */
diff --git a/drivers/net/sxe/pf/sxe_ethdev.h b/drivers/net/sxe/pf/sxe_ethdev.h
new file mode 100644
index 0000000000..e31a23deeb
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_ethdev.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2024
+ */
-- 
2.18.2

