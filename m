Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09473C982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 16:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72ACC42E7D;
	Fri, 16 Jan 2026 17:44:56 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id E45F242DF1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 17:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768581885;
 bh=1LYTyfZk8pk6dWHCGhAaiKvhfzQSqQSMHQmgku5z0Xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RMGkpDowik77WKzjZeunbV+2+aQbfMbiPFiIXkNomzd67dOOB+XIeev4M8vhvBu/u
 8CfNxAtWhZFphsxbMyAtvlrB8u+Ue81U9UAZxEJVXH7TCimo7MGg/0/veXDVoUV99G
 lxc7gbZgfj6nGtykc+JeN/lRB4mJon7f5/xMutIHNjH1qDX0Vq8/JlVj7QY/P1CYPx
 OSs+Y8Bbo/J125rA9viWxeX1+SBl2UQxd8ZyKF+++vFKcGSXJkzx8HnMcTfKwR659P
 Wsj6tja8bV1/o0/POsdO2WlHYjldOQkw2U3XOppIthEMpS/dXmWqHfRtGaKy3iBSR6
 u01S9JkjV/jyw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id B098C118007E;
 Fri, 16 Jan 2026 17:44:45 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 8/8] doc/nfb: cleanup and update guide
Date: Fri, 16 Jan 2026 17:44:36 +0100
Message-ID: <20260116164436.1649047-9-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116164436.1649047-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260116164436.1649047-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

changes:
- overall cleanup
- added list of up-to-date cards and links for firmware download
- updated description of the port argument

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 doc/guides/nics/features/nfb.ini |   4 +
 doc/guides/nics/nfb.rst          | 187 ++++++++++++++-----------------
 2 files changed, 89 insertions(+), 102 deletions(-)

diff --git a/doc/guides/nics/features/nfb.ini b/doc/guides/nics/features/nfb.ini
index c77b592789..7ac89fc15f 100644
--- a/doc/guides/nics/features/nfb.ini
+++ b/doc/guides/nics/features/nfb.ini
@@ -9,9 +9,13 @@ Link status          = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+Unicast MAC filter   = Y
+Timestamp offload    = P
 Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
+FW version           = Y
+Multiprocess aware   = Y
 Linux                = Y
 x86-64               = Y
 Usage doc            = Y
diff --git a/doc/guides/nics/nfb.rst b/doc/guides/nics/nfb.rst
index a9b4049654..55a635d8d4 100644
--- a/doc/guides/nics/nfb.rst
+++ b/doc/guides/nics/nfb.rst
@@ -2,64 +2,101 @@
     Copyright 2019 Cesnet
     Copyright 2019 Netcope Technologies
 
-NFB poll mode driver library
-=================================
+NFB Poll Mode Driver
+====================
+
+The NFB PMD implements support for the FPGA-based
+programmable NICs running `CESNET-NDK <https://www.liberouter.org/ndk/>`_
+based firmware (formerly known as the NetCOPE platform). The CESNET Network Development Kit offers
+wide spectrum of supported cards, for example:
+N6010, FB2CGG3 (Silicom Denmark),
+IA-420F, IA-440i (BittWare),
+AGI-FH400G (ReflexCES),
+and `many more <https://github.com/CESNET/ndk-fpga/tree/devel/cards>`_.
+
+The CESNET-NDK framework is open source and
+can be found on `CESNET-NDK <https://github.com/CESNET/ndk-fpga>`_.
+Ready-to-use demo firmwares can be found on the `DYNANIC page <https://dyna-nic.com/try-now/>`_.
+
+Software compatibility and firmware for
+`historical cards <https://www.liberouter.org/technologies/cards/>`_
+are left unmaintained.
+
+Software prerequisites
+----------------------
 
-The NFB poll mode driver library implements support for the Netcope
-FPGA Boards (**NFB-40G2, NFB-100G2, NFB-200G2QL**) and Silicom **FB2CGG3** card,
-FPGA-based programmable NICs. The NFB PMD uses interface provided by the libnfb
-library to communicate with these cards over the nfb layer.
+This PMD requires a Linux kernel module, which is responsible for initialization and
+allocation of resources needed for the nfb layer function.
+Communication between PMD and kernel modules is mediated by the libnfb library.
+The kernel module and library are not part of DPDK and must be installed
+separately. Dependencies can be found on GitHub:
+`nfb-framework <https://github.com/CESNET/ndk-sw>`_ as source code,
+or for RPM-based distributions, the prebuilt `nfb-framework` package on
+`Fedora Copr <https://copr.fedorainfracloud.org/coprs/g/CESNET/nfb-framework/>`_.
 
-More information about the
-`NFB cards <https://www.liberouter.org/technologies/cards/>`_
-and used technology
-(`Network Development Kit <https://www.liberouter.org/ndk/>`_)
-can be found on the `Liberouter website <http://www.liberouter.org/>`_.
+Before starting the DPDK, make sure that the kernel module is loaded (`sudo modprobe nfb`)
+and the card is running the CESNET-NDK based firmware (`nfb-info -l`).
 
 .. note::
 
-   Currently the driver is supported only on x86_64 architectures.
-   Only x86_64 versions of the external libraries are provided.
+   Currently, the driver is supported only on x86_64 architectures.
+
+NFB card architecture
+---------------------
+
+Ethernet Ports
+~~~~~~~~~~~~~~
+
+The NFB cards are multi-port multi-queue cards, where (generally) data from any
+Ethernet port may be sent by the firmware to any queue.
 
-Prerequisites
--------------
+The cards were historically represented in DPDK as a single port.
+Currently each Ethernet channel is represented as one DPDK port.
 
-This PMD requires kernel modules which are responsible for initialization and
-allocation of resources needed for nfb layer function.
-Communication between PMD and kernel modules is mediated by libnfb library.
-These kernel modules and library are not part of DPDK and must be installed
-separately:
+.. note::
 
-*  **libnfb library**
+   Normally, one port corresponds to one channel, but ports can often be configured in a separate
+   manner. For example one 100G port can be used as 4x25G or 4x10G independent Ethernet channels.
 
-   The library provides API for initialization of nfb transfers, receiving and
-   transmitting data segments.
+By default, all ports are initialized and used for the allowed PCI device.
+When this behaviour is limiting (e.g., for multiple instances of DPDK app on different ports
+of the same PCI device), ports can be specified by the `port` item in the `allow` argument:
 
-*  **Kernel modules**
+.. code-block:: console
 
-   * nfb
+   -a 0000:01:00.0,port=0,port=3
 
-   Kernel modules manage initialization of hardware, allocation and
-   sharing of resources for user space applications.
+PCIe slots
+~~~~~~~~~~
 
-Dependencies can be found here:
-`Netcope common <https://github.com/CESNET/ndk-sw>`_.
+Some cards employ more than one PCIe device for better data throughput. This can be achieved by
+slot bifurcation (only a minor improvement) or by an add-on cable connected to another PCIe slot.
+Both improvements can work together, as is, for example, in the case of the AGI-FH400G card.
 
-Versions of the packages
-~~~~~~~~~~~~~~~~~~~~~~~~
+Because primary and secondary slot(s) can be attached to different NUMA nodes
+(also applies for bifurcation on some HW), the data structures need to be correctly allocated.
+(Device-aware allocation matters also on IOMMU-enabled systems.)
+The firmware already provides DMA queue to PCI device mapping. The DPDK application just needs to
+use all PCI devices, otherwise some queues will not be available; provide all PCI endpoints
+listed in the `nfb-info -v` in the `allow` argument.
 
-The minimum version of the provided packages:
+.. note::
 
-* for DPDK from 19.05
+   For cards where the number of Ethernet ports is less than the number of PCI devices
+   (e.g., AGI-FH400G: 1 port, up to 4 PCI devices), the virtual DPDK ports are
+   created to achieve the best NUMA-aware throughput
+   (virtual ports lack a lot of configuration features).
 
-Configuration
--------------
+Features
+--------
 
 Timestamps
+~~~~~~~~~~
 
-The PMD supports hardware timestamps of frame receipt on physical network interface. In order to use
-the timestamps, the hardware timestamping unit must be enabled (follow the documentation of the NFB
-products). The standard `RTE_ETH_RX_OFFLOAD_TIMESTAMP` flag can be used for this feature.
+The PMD supports hardware timestamps of frame receipt on physical network interface.
+In order to use the timestamps, the hardware timestamping unit must be enabled
+(follow the documentation of the NFB products).
+The standard `RTE_ETH_RX_OFFLOAD_TIMESTAMP` flag can be used for this feature.
 
 When the timestamps are enabled, a timestamp validity flag is set in the MBUFs
 containing received frames and timestamp is inserted into the `rte_mbuf` struct.
@@ -67,72 +104,18 @@ containing received frames and timestamp is inserted into the `rte_mbuf` struct.
 The timestamp is an `uint64_t` field and holds the number of nanoseconds
 elapsed since 1.1.1970 00:00:00 UTC.
 
+Simulation
+~~~~~~~~~~
 
-Using the NFB PMD
-----------------------
-
-Kernel modules have to be loaded before running the DPDK application.
-
-NFB card architecture
----------------------
-
-The NFB cards are multi-port multi-queue cards, where (generally) data from any
-Ethernet port may be sent to any queue.
-They are represented in DPDK as a single port.
-
-NFB-200G2QL card employs an add-on cable which allows to connect it to two
-physical PCI-E slots at the same time (see the diagram below).
-This is done to allow 200 Gbps of traffic to be transferred through the PCI-E
-bus (note that a single PCI-E 3.0 x16 slot provides only 125 Gbps theoretical
-throughput).
-
-Although each slot may be connected to a different CPU and therefore to a different
-NUMA node, the card is represented as a single port in DPDK. To work with data
-from the individual queues on the right NUMA node, connection of NUMA nodes on
-first and last queue (each NUMA node has half of the queues) need to be checked.
-
-Limitations
------------
-
-Driver is usable only on Linux architecture, namely on CentOS.
-
-Since a card is always represented as a single port, but can be connected to two
-NUMA nodes, there is need for manual check where master/slave is connected.
-
-Example of usage
-----------------
-
-Read packets from 0. and 1. receive queue and write them to 0. and 1.
-transmit queue:
+The CESNET-NDK framework offers the possibility of simulating the firmware together with DPDK.
+This allows for easy debugging of a packet flow behaviour with a specific firmware configuration.
+The DPDK NFB driver can be connected to the simulator (Questa/ModelSim/nvc) via a virtual device:
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-testpmd -l 0-3 -n 2 \
-   -- --port-topology=chained --rxq=2 --txq=2 --nb-cores=2 -i -a
-
-Example output:
-
-.. code-block:: console
+   dpdk-testpmd
+      --vdev=eth_vdev_nfb,dev=libnfb-ext-grpc.so:grpc+dma_vas:localhost:50051,queue_driver=native
+      --iova-mode=va -- -i
 
-   [...]
-   EAL: PCI device 0000:06:00.0 on NUMA socket -1
-   EAL:   probe driver: 1b26:c1c1 net_nfb
-   PMD: Initializing NFB device (0000:06:00.0)
-   PMD: Available DMA queues RX: 8 TX: 8
-   PMD: NFB device (0000:06:00.0) successfully initialized
-   Interactive-mode selected
-   Auto-start selected
-   Configuring Port 0 (socket 0)
-   Port 0: 00:11:17:00:00:00
-   Checking link statuses...
-   Port 0 Link Up - speed 10000 Mbps - full-duplex
-   Done
-   Start automatic packet forwarding
-     io packet forwarding - CRC stripping disabled - packets/burst=32
-     nb forwarding cores=2 - nb forwarding ports=1
-     RX queues=2 - RX desc=128 - RX free threshold=0
-     RX threshold registers: pthresh=0 hthresh=0 wthresh=0
-     TX queues=2 - TX desc=512 - TX free threshold=0
-     TX threshold registers: pthresh=0 hthresh=0 wthresh=0
-     TX RS bit threshold=0 - TXQ flags=0x0
-   testpmd>
+More info about the simulation can be found int the CESNET-NDK `documentation
+<https://cesnet.github.io/ndk-fpga/devel/ndk_apps/minimal/tests/cocotb/readme.html>`_.
-- 
2.52.0

