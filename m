Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD865105F79E
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Mar 2026 08:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EB5F4064A;
	Sat, 14 Mar 2026 09:52:17 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6D650402E6
 for <dev@dpdk.org>; Sat, 14 Mar 2026 09:52:09 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-03 (Coremail) with SMTP id rQCowAB3ktm2IbVp1GKhCg--.37229S3;
 Sat, 14 Mar 2026 16:52:06 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v19 01/13] net/sxe: add base driver directory and doc
Date: Sat, 14 Mar 2026 16:51:53 +0800
Message-Id: <20260314085205.2419952-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
References: <20260303091057.2952214-14-liujie5@linkdatatechnology.com>
 <20260314085205.2419952-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: rQCowAB3ktm2IbVp1GKhCg--.37229S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWrWFyrAFW8ur1xtw1kXwb_yoW3Cr13pa
 18CrWSkr1fJa47X3Zxt3WUuF1rAa1vya4Uuw1I934fXF98Cry8Zr45KFy8t3srXFyYvw1F
 vF1avry7CF15X3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
 xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
 vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
 r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY02Avz4
 vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYUDG
 UUUUU
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
 doc/guides/nics/features/sxe.ini       | 51 ++++++++++++++++++
 doc/guides/nics/features/sxe_vf.ini    | 37 ++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/nics/sxe.rst                | 71 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  6 +++
 drivers/net/sxe/meson.build            |  9 ++++
 drivers/net/sxe/pf/sxe_ethdev.c        |  3 ++
 drivers/net/sxe/pf/sxe_ethdev.h        |  3 ++
 9 files changed, 187 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe.ini
 create mode 100644 doc/guides/nics/features/sxe_vf.ini
 create mode 100644 doc/guides/nics/sxe.rst
 create mode 100644 drivers/net/sxe/meson.build
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eb8e9dc22..13341e9bcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -858,6 +858,12 @@ F: drivers/net/intel/ipn3ke/
 F: doc/guides/nics/ipn3ke.rst
 F: doc/guides/nics/features/ipn3ke.ini
 
+Linkdata sxe
+M: Jie Liu <liujie5@linkdatatechnology.com>
+F: drivers/net/sxe/
+F: doc/guides/nics/sxe.rst
+F: doc/guides/nics/features/sxe*.ini
+
 Marvell cnxk
 M: Nithin Dabilpuram <ndabilpuram@marvell.com>
 M: Kiran Kumar K <kirankumark@marvell.com>
diff --git a/doc/guides/nics/features/sxe.ini b/doc/guides/nics/features/sxe.ini
new file mode 100644
index 0000000000..e01d8b0f53
--- /dev/null
+++ b/doc/guides/nics/features/sxe.ini
@@ -0,0 +1,51 @@
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
+CRC offload          = P
+VLAN offload         = P
+QinQ offload         = P
+L3 checksum offload  = P
+L4 checksum offload  = P
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
index cb818284fe..ace3caa8c4 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -68,6 +68,7 @@ Network Interface Controller Drivers
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
index f6801c41b6..64595054a0 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -122,6 +122,12 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Added Linkdata sxe ethernet driver.**
+
+  Added support for Linkdata NIC series, including 1160-2X (supporting 10G).
+  As these new models share hardware similarities with the existing 10G Sapphire NICs,
+  many of the existing configurations and practices are expected to apply.
+
 Removed Items
 -------------
 
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
new file mode 100644
index 0000000000..c2460c7229
--- /dev/null
+++ b/drivers/net/sxe/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright (C), 2022, Linkdata Technology Co., Ltd.
+
+deps += ['hash']
+sources = files(
+        'pf/sxe_ethdev.c',
+)
+
+includes += include_directories('pf')
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
new file mode 100644
index 0000000000..bcd91b6a8c
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
diff --git a/drivers/net/sxe/pf/sxe_ethdev.h b/drivers/net/sxe/pf/sxe_ethdev.h
new file mode 100644
index 0000000000..bcd91b6a8c
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_ethdev.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
-- 
2.18.2

