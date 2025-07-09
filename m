Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA895C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 08:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06BA3402AE;
	Wed,  9 Jul 2025 10:43:22 +0200 (CEST)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
 by mails.dpdk.org (Postfix) with ESMTP id 30C984021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 10:43:19 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [60.29.3.194])
 by APP-05 (Coremail) with SMTP id zQCowADnPl+lK25oVRxmAg--.757S2;
 Wed, 09 Jul 2025 16:43:17 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v4 1/2] net/sxe: add base driver directory and doc
Date: Wed,  9 Jul 2025 04:43:01 -0400
Message-ID: <20250709084315.9940-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADnPl+lK25oVRxmAg--.757S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWrWFy8Aw1DXFyDKw1kAFb_yoWxKw1Dpa
 18CFWSkr1fJay7X3Zxta1UGF1rAa1vya4UCw1xK34YqF98Cry8Xr45tFy0y3srXFyjv34F
 vF1avry7uF1rXaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU04E_DUUUU
X-Originating-IP: [60.29.3.194]
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

Adding a minimum maintainable directory structure for the
network driver and request maintenance of the sxe driver.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 MAINTAINERS                         |  6 +++
 doc/guides/nics/features/sxe.ini    | 78 +++++++++++++++++++++++++++++
 doc/guides/nics/features/sxe_vf.ini | 37 ++++++++++++++
 doc/guides/nics/index.rst           |  1 +
 doc/guides/nics/sxe.rst             | 71 ++++++++++++++++++++++++++
 drivers/net/sxe/meson.build         |  9 ++++
 drivers/net/sxe/pf/sxe_ethdev.c     |  3 ++
 drivers/net/sxe/pf/sxe_ethdev.h     |  3 ++
 8 files changed, 208 insertions(+)
 create mode 100644 doc/guides/nics/features/sxe.ini
 create mode 100644 doc/guides/nics/features/sxe_vf.ini
 create mode 100644 doc/guides/nics/sxe.rst
 create mode 100644 drivers/net/sxe/meson.build
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.c
 create mode 100644 drivers/net/sxe/pf/sxe_ethdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 82f6e2f917..f92f4fea81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2055,3 +2055,9 @@ F: examples/vmdq/
 F: doc/guides/sample_app_ug/vmdq_forwarding.rst
 F: examples/vmdq_dcb/
 F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
+
+Linkdata sxe
+M: Jie Li <lijie@linkdatatechnology.com>
+F: drivers/net/sxe/
+F: doc/guides/nics/sxe.rst
+F: doc/guides/nics/features/sxe*.ini
diff --git a/doc/guides/nics/features/sxe.ini b/doc/guides/nics/features/sxe.ini
new file mode 100644
index 0000000000..cf5a68c5bb
--- /dev/null
+++ b/doc/guides/nics/features/sxe.ini
@@ -0,0 +1,78 @@
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
+
+[rte_flow items]
+eth                  = P
+e_tag                = Y
+fuzzy                = Y
+ipv4                 = Y
+ipv6                 = Y
+nvgre                = Y
+raw                  = Y
+sctp                 = Y
+tcp                  = Y
+udp                  = Y
+vlan                 = P
+vxlan                = Y
+
+[rte_flow actions]
+drop                 = Y
+mark                 = Y
+pf                   = Y
+queue                = Y
+rss                  = Y
+security             = Y
+vf                   = Y
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
index 10a2eca3b0..18b7483078 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -61,6 +61,7 @@ Network Interface Controller Drivers
     pfe
     qede
     r8169
+    sxe
     sfc_efx
     softnic
     tap
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
2.18.4

