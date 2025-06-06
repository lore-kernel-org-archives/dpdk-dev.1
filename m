Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C32C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 09:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F1A140265;
	Fri,  6 Jun 2025 11:08:16 +0200 (CEST)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net
 [129.150.39.64]) by mails.dpdk.org (Postfix) with ESMTP id 1DDEE40150
 for <dev@dpdk.org>; Fri,  6 Jun 2025 11:08:13 +0200 (CEST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHDvL6r0JogTGdAA--.13518S2;
 Fri, 06 Jun 2025 17:08:10 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB3CiTyr0JocXFNAA--.405S3;
 Fri, 06 Jun 2025 17:08:03 +0800 (CST)
From: Wencheng Li <liwencheng@phytium.com.cn>
To: dev@dpdk.org
Subject: [PATCH v9 3/3] net/macb: add necessary docs and update related files
Date: Fri,  6 Jun 2025 09:07:55 +0000
Message-Id: <1749200875-53516-1-git-send-email-liwencheng@phytium.com.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1749020509-44160-1-git-send-email-liwencheng@phytium.com.cn>
References: <1749020509-44160-1-git-send-email-liwencheng@phytium.com.cn>
X-CM-TRANSID: AQAAfwB3CiTyr0JocXFNAA--.405S3
X-CM-SenderInfo: polzv0xfkh0wo6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liwencheng
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKrW5Ary8tr4xXw1xur1Dtrb_yoWfXw17pw
 43AFyfWrZ7XrWfZ3s3ta18Zr4F9a1vy3yUuF1xt34kXFn8Cr4FqF4xtrWrC397XFW3Aa1F
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
 doc/guides/rel_notes/release_25_07.rst |   4 +
 5 files changed, 211 insertions(+)
 create mode 100644 doc/guides/nics/features/macb.ini
 create mode 100644 doc/guides/nics/macb.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 57d378e..35dec12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -916,6 +916,12 @@ F: doc/guides/platform/bluefield.rst
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
index 618c52d..837f948 100644
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
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index a4962e4..346e7fd 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -87,6 +87,10 @@ New Features
 
   See the :doc:`../cryptodevs/zsda` guide for more details on the new driver.
 
+* **Added Phytium macb net driver.**
+
+  Added a new network PMD which supports Phytium 1 and 10 Gigabit
+  Ethernet NICs.
 
 Removed Items
 -------------
-- 
2.7.4

