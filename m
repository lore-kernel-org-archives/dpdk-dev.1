Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A0CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:33:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A863740262;
	Tue, 28 Oct 2025 09:33:36 +0100 (CET)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by mails.dpdk.org (Postfix) with ESMTP id 564A64021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:33:35 +0100 (CET)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwB3ZVzZfwBp5d54AA--.42770S2;
 Tue, 28 Oct 2025 16:33:29 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLOrXfwBpavZzAA--.54120S3;
 Tue, 28 Oct 2025 16:33:27 +0800 (CST)
From: Wencheng Li <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v11 3/3] net/macb: add necessary docs and update related files
Date: Tue, 28 Oct 2025 08:33:21 +0000
Message-Id: <1761640401-80633-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1755664500-9517-1-git-send-email-liwencheng@phytium.com.cn>
References: <1755664500-9517-1-git-send-email-liwencheng@phytium.com.cn>
X-CM-TRANSID: AQAAfwDHLOrXfwBpavZzAA--.54120S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrW5Ar4kGw4xWF4xZw48Crg_yoWfWw17pw
 sxAFyfWrZ7XrWfZr93ta18Zr4rua1vy3yUuF1xt34kXFn8Cr4FqF4xtrWrC397WFW3Aa1F
 q3W5Xry3ZFn5G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Signed-off-by: Wencheng Li <liwencheng@phytium.com.cn>
---
 MAINTAINERS                            |   6 ++
 doc/guides/nics/features/macb.ini      |  19 ++++
 doc/guides/nics/index.rst              |   1 +
 doc/guides/nics/macb.rst               | 181 +++++++++++++++++++++++++++++++++
 doc/guides/rel_notes/release_25_11.rst |   5 +
 5 files changed, 212 insertions(+)
 create mode 100644 doc/guides/nics/features/macb.ini
 create mode 100644 doc/guides/nics/macb.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f198bf..df4c2d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -930,6 +930,12 @@ F: doc/guides/platform/bluefield.rst
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
index 0000000..5e291e3
--- /dev/null
+++ b/doc/guides/nics/features/macb.ini
@@ -0,0 +1,19 @@
+;
+; Supported features of the 'macb' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+
+[Features]
+Speed capabilities   = Y
+Link status          = Y
+Link status event    = Y
+MTU update           = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+CRC offload          = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
+Scattered Rx         = Y
+Basic stats          = Y
+Linux                = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index b00ed99..d6ce39b 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -45,6 +45,7 @@ Network Interface Controller Drivers
     ionic
     ipn3ke
     ixgbe
+    macb
     mana
     memif
     mlx4
diff --git a/doc/guides/nics/macb.rst b/doc/guides/nics/macb.rst
new file mode 100644
index 0000000..6eca2af
--- /dev/null
+++ b/doc/guides/nics/macb.rst
@@ -0,0 +1,181 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2022~2023 Phytium Technology Co., Ltd.
+
+MACB Poll Mode Driver
+=====================
+
+The MACB PMD provides poll mode driver support
+for the Ethernet interface MAC 1/2.5/10 Gbps adapter.
+
+
+Supported Chipsets and NICs
+---------------------------
+
+Phytium Ethernet interface cdns,phytium-gem-1.0
+Phytium Ethernet interface cdns,phytium-gem-2.0
+
+
+Features
+--------
+
+Features of the MACB PMD are:
+
+- Speed capabilities
+- Link status
+- Set link down or up
+- MTU update
+- Multiple queues for TX and RX
+- CRC offload
+- Scatter and gather for Tx and Rx
+- Jumbo frames supported
+- Promiscuous mode
+- Allmulticast mode
+- Basic stats
+
+
+Runtime Configuration
+---------------------
+
+The following ``devargs`` options can be enabled at runtime. They can
+be passed as part of EAL arguments. For example,
+
+Run the command in non-vector mode:
+
+.. code-block:: console
+
+   ./dpdk-testpmd -l 0,3 --vdev=net_macb0,device=3200c000.ethernet,usephydrv=0 \
+    --vdev=net_macb1,device=3200e000.ethernet,usephydrv=0 --iova-mode=pa -- -i \
+    -a --rxq=1 --txq=1 --rxd=128 --txd=128
+
+- ``device`` (mandatory, with no default value)
+
+  The name of port (owned by Phytium) that should be enabled in DPDK.
+  This options can be repeated resulting in a list of ports to be
+  enabled.  For instance below will enable ``eth0`` and ``eth1`` ports.
+  Use the network interface 3200c000.ethernet as eth0,
+  and the network interface 3200e000.ethernet as eth1.
+
+- ``--vdev=net_macb0, device=3200c000.ethernet, usephydrv=0`` (no default value)
+
+  --vdev specifies the MACB driver, and device specifies the virtual device to be used. The options
+  --vdev=net_macb0,device=3200c000.ethernet and --vdev=net_macb1,device=3200e000.ethernet
+  can also be written as: --vdev=net_macb,device=3200c000.ethernet,device=3200e000.ethernet.
+
+- ``usephydrv`` (Default value: true)
+  The specified macb device does not have an external phy chip.
+  If there is indeed a device with phy, this parameter is not added.
+
+Run the command in vector mode:
+
+.. code-block:: console
+
+   ./dpdk-testpmd -l 0,3 --vdev=net_macb0,device=3200c000.ethernet,usephydrv=0 \
+    --vdev=net_macb1,device=3200e000.ethernet,usephydrv=0 --iova-mode=pa -- -i \
+    -a --rxq=1 --txq=1 --rxd=128 --txd=128 --rxfreet=32 --txrst=32
+
+- ``--rxfreet`` (Default value: 16)
+  Enable the optimization of sending vector instructions.
+
+- ``--txrst`` (Default value: 16)
+  Enable the optimization of receiving vector instructions.
+
+
+Usage Example
+-------------
+
+MACB PMD requires extra out of tree kernel modules to function properly. The macb_uio
+module can be found in the repository `<https://github.com/dpdk-kmods/macb_uio>`.
+It can be loaded as shown below:
+
+.. code-block:: console
+
+   git clone https://github.com/dpdk-kmods/macb_uio.git
+   cd macb_uio && make
+   modprobe uio
+   insmod macb_uio.ko
+
+Bind the network interface to the macb_uio driver:
+
+.. code-block:: console
+
+   ./dpdk-pdevbind.sh --bind macb_uio 3200c000.ethernet
+   ./dpdk-pdevbind.sh --bind macb_uio 3200e000.ethernet
+
+In order to run testpmd example application following command can be used:
+
+.. code-block:: console
+
+   ./app/dpdk-testpmd -l 0,3 --vdev=net_macb0,device=3200c000.ethernet \
+    --vdev=net_macb1,device=3200e000.ethernet --iova-mode=pa -- -i -a
+
+Example output:
+
+.. code-block:: console
+
+   [...]
+   EAL: Detected CPU lcores: 4
+   EAL: Detected NUMA nodes: 1
+   EAL: Detected static linkage of DPDK
+   EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
+   EAL: Selected IOVA mode 'PA'
+   MACB: Phytium mac driver v5.8
+   MACB: macb_get_fixed_link_speed_info(): speed info is unknown.
+   MACB: Phytium mac driver v5.8
+   MACB: macb_get_fixed_link_speed_info(): speed info is unknown.
+   Interactive-mode selected
+   Auto-start selected
+   testpmd: create a new mbuf pool <mb_pool_0>: n=155456, size=2176, socket=0
+   testpmd: preferred mempool ops selected: ring_mp_mc
+   Configuring Port 0 (socket 0)
+   MACB: Rx Burst Bulk Alloc Preconditions: rxq->rx_free_thresh=16, MACB_MAX_RX_BURST=32
+   MACB: queue[0] doesn't meet Rx Bulk Alloc preconditions - canceling the feature for port[0]
+   MACB: Port[0] doesn't meet Vector Rx preconditions
+   Port 0: 24:DC:0F:54:E5:D0
+   Configuring Port 1 (socket 0)
+   MACB: Rx Burst Bulk Alloc Preconditions: rxq->rx_free_thresh=16, MACB_MAX_RX_BURST=32
+   MACB: queue[0] doesn't meet Rx Bulk Alloc preconditions - canceling the feature for port[1]
+   MACB: Port[1] doesn't meet Vector Rx preconditions
+   Port 1: 24:DC:0F:54:E5:D1
+   Checking link statuses...
+   MACB: Port 0: Link up at 10 Gbps FDX Autoneg
+
+   Port 0: link state change event
+   MACB: Port 1: Link up at 10 Gbps FDX Autoneg
+
+   Port 1: link state change event
+   Done
+   Start automatic packet forwarding
+   io packet forwarding - ports=2 - cores=1 - streams=2 - NUMA support enabled, MP allocation mode: native
+   Logical Core 3 (socket 0) forwards packets on 2 streams:
+     RX P=0/Q=0 (socket 0) -> TX P=1/Q=0 (socket 0) peer=02:00:00:00:00:01
+     RX P=1/Q=0 (socket 0) -> TX P=0/Q=0 (socket 0) peer=02:00:00:00:00:00
+
+     io packet forwarding packets/burst=32
+     nb forwarding cores=1 - nb forwarding ports=2
+     port 0: RX queue number: 1 Tx queue number: 1
+       Rx offloads=0xe Tx offloads=0x0
+       RX queue: 0
+         RX desc=512 - RX free threshold=16
+         RX threshold registers: pthresh=0 hthresh=0  wthresh=0
+         RX Offloads=0xe
+       TX queue: 0
+         TX desc=512 - TX free threshold=32
+         TX threshold registers: pthresh=0 hthresh=0  wthresh=0
+         TX offloads=0x0 - TX RS bit threshold=0
+     port 1: RX queue number: 1 Tx queue number: 1
+       Rx offloads=0xe Tx offloads=0x0
+       RX queue: 0
+         RX desc=512 - RX free threshold=16
+         RX threshold registers: pthresh=0 hthresh=0  wthresh=0
+         RX Offloads=0xe
+       TX queue: 0
+         TX desc=512 - TX free threshold=32
+         TX threshold registers: pthresh=0 hthresh=0  wthresh=0
+         TX offloads=0x0 - TX RS bit threshold=0
+   testpmd>
+
+
+Limitations
+-----------
+
+The driver is only available on the ARM64 architecture.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335..5278932 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added Phytium macb net driver.**
+
+  Added a new network PMD which supports Phytium 1 and 10 Gigabit
+  Ethernet NICs.
+
 * **Added automatic lcore-id remapping option.**
 
   Added the EAL option ``--remap-lcore-ids`` or ``-R``
-- 
2.7.4

