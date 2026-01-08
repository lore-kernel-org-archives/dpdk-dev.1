Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A35D1D493
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 20:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B63E84027A;
	Thu,  8 Jan 2026 21:24:48 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id A54054013F
 for <dev@dpdk.org>; Thu,  8 Jan 2026 21:24:47 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so28448655e9.3
 for <dev@dpdk.org>; Thu, 08 Jan 2026 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767903887;
 x=1768508687; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lB/UCzyI63llfsrlJNv4xgqakHPHc2OVVMpfTMvb5CA=;
 b=YKP7iqE57r7r35ILdGRCCXL9T1iykBYjhbU0UHezSuRW6qD76eTeZw3aPf4UbLQQSB
 rFoN6zpYbhsDkg26/M6DWbIKo+E+uHqRtZhpzFCDnDIJEKxFJW4TG/laExn5qj6/SHVE
 4cqOO1PkGZSpQXza3htlJCpxVoa1ewKJz3r5GFN/9rVuZ0AP80Mu8Of8pZHXjRLAfInk
 WBpBGg23VyJyRTqtvMxrNyrVd3vChCAx77lvULhvKA3/ASCeBebdmF3GIy8sQHMA50T8
 ZdNkMD16xG/iMFDusw09gvV9la6vvBjwVPngcrt1ldprYCnjzKAf5fDMbvieDFfgp1b3
 BKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903887; x=1768508687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB/UCzyI63llfsrlJNv4xgqakHPHc2OVVMpfTMvb5CA=;
 b=Pvr7b9+XC43OnKtGNdsRGJUyHKYgtXyyRF4ARVsyrMu/1L6gSBBiY1EMi/DCpBfX1D
 ecrgiuXaXLWIj8ecRHuQzOyMzVK00dypYblabgJgx9eTDjpEgB7MK7/Lw/uauD0St8dU
 qXbh7GtcvVN2KLVfD94HZHYB4Rm8b/zKULqof42eWbi9pYsm33Y6zNzQREwCj/2P6UoC
 +Xy8PTlv/dJYxi5HkFPT7tsm1Gk9U6E027AKgB0qg64QA7QE2OwXSQYvGFLqk2mzFrCy
 s81VYgkXgejtiPI/jlTgPPQzJ/R/jhKpi4OazNHVY7+z2Hq+hwouzX0Q3/DjN7JYin2B
 lyQQ==
X-Gm-Message-State: AOJu0Ywoy3cdZaRBZwi/qHzlPAt6Ax6wkhtQuAgSXFD8dnGS4DVOpVXX
 VxHZdoR1fQRTg3lAAn13+bvWGTlTZgOibVgVOmGJXMs3Jg5xe0s2ME3sKt2m1XEFXC5sjAFJJvq
 6eRaS4EA=
X-Gm-Gg: AY/fxX65WfLaV9+n1St6P9HfT7MobcLrSw2UkYhTsxB/Xxh+ufojOpTewdS/NU/V7iR
 Dg0OdPmcx0pFXdkXHMEEtleSZuWJDeh+F6nn54IDqPp+t3u4oQ+oXBV3HXQycADySKjMqxwAfAF
 nx0yTVzz0GeyobfcFAvSH789GHv9mLbdR3F+1qL6fSgvUlklL6Xj+4T2BVdKTivwh24HJsC6yLi
 cH1c2BkIUDWdPz90vEccyQ0CqBm6R9VbjkNnXFYFeSMcbP3EtocqJ4sXoZgbpIut13DZjTcSN9J
 BFA9NNfwKHz17lp4U4PP2lyTMgdBQlEEtbpDRFpf6FGsD4PozXGIODtv1QwnI5SmcZiPEdCF60m
 Tzim4oNUg7+7YPQKfp6bPoCp6u2sH5yliWKXjWs6HnZJLR4fUa2LJuWsDGhJAq/IwpcyGbxuiep
 r/0KmTPF4YLigO5qoRTXgPAnRaM5mKIZUhslL1y/38QL4hAJfpACyR0bJkldWQ
X-Google-Smtp-Source: AGHT+IEjqX3iK5sY4oAW/Ae5KDyRGmoT4jKaqwPjOk6VEeb3lEH1rsIG29oDW6/kSsw/FkhnIYQbbQ==
X-Received: by 2002:a05:600c:4f53:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47d84b5b496mr75599705e9.26.1767903886457; 
 Thu, 08 Jan 2026 12:24:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865e3d22sm46179245e9.1.2026.01.08.12.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 12:24:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] doc/guides/nics: split pcap_ring into separate documentation
 files
Date: Thu,  8 Jan 2026 12:24:41 -0800
Message-ID: <20260108202441.173351-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The documentation had combined to unrelated drivers together.
Use AI to split into two separate files:
pcap.rst for the pcap PMD and ring.rst for the ring PMD.

Changes to pcap.rst:
- Use "pcap" consistently instead of mixed "libpcap/pcap/PCAP" naming
- Remove Linux-specific references; document support for Linux, FreeBSD,
  and Windows
- Add reference to upstream libpcap documentation
- Add multi-queue support section explaining queue count determination
  and file handle limitations
- Use ``--vdev=net_pcap0`` format consistently
- Remove deprecated rte_eth_from_pcaps() API section
- Improve technical documentation style throughout

Changes to ring.rst:
- Use ``--vdev=net_ring0`` format consistently
- Fix inconsistent "Rings-based/Ring-based" naming
- Retain rte_eth_from_rings() API section with usage examples
- Improve technical documentation style throughout

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/index.rst     |   3 +-
 doc/guides/nics/pcap.rst      | 220 +++++++++++++++++++++++
 doc/guides/nics/pcap_ring.rst | 318 ----------------------------------
 doc/guides/nics/ring.rst      | 116 +++++++++++++
 4 files changed, 338 insertions(+), 319 deletions(-)
 create mode 100644 doc/guides/nics/pcap.rst
 delete mode 100644 doc/guides/nics/pcap_ring.rst
 create mode 100644 doc/guides/nics/ring.rst

diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index b00ed998c5..cb818284fe 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -60,10 +60,11 @@ Network Interface Controller Drivers
     null
     octeon_ep
     octeontx
-    pcap_ring
+    pcap
     pfe
     qede
     r8169
+    ring
     rnp
     sfc_efx
     softnic
diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
new file mode 100644
index 0000000000..7d8bc4f05a
--- /dev/null
+++ b/doc/guides/nics/pcap.rst
@@ -0,0 +1,220 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2010-2015 Intel Corporation.
+
+Pcap Poll Mode Driver
+=====================
+
+The pcap-based PMD (**librte_net_pcap**) reads and writes packets using the pcap library,
+both from files on disk and from physical NIC devices using standard kernel drivers.
+
+For more information about the pcap library, see the
+`libpcap documentation <https://www.tcpdump.org/manpages/pcap.3pcap.html>`_.
+
+.. note::
+
+    The pcap-based PMD requires the libpcap development files to be installed.
+    This applies to all supported operating systems: Linux, FreeBSD, and Windows.
+
+Using the Driver from the EAL Command Line
+------------------------------------------
+
+The DPDK EAL has been extended to allow pseudo-Ethernet devices,
+using the pcap driver, to be created at application startup time during EAL initialization.
+
+To do so, pass the ``--vdev=net_pcap0`` parameter to the EAL.
+This parameter accepts options to allocate and use pcap-based Ethernet transparently by the application.
+This can be used, for example, for testing on a virtual machine where there are no Ethernet ports.
+
+Pcap-based PMD
+~~~~~~~~~~~~~~
+
+Pcap-based devices can be created using the virtual device ``--vdev=net_pcap0`` option.
+The device name must start with the net_pcap prefix followed by numbers or letters.
+The name must be unique for each device. Each device can have multiple stream options and multiple devices can be used.
+Multiple device definitions can be specified using multiple ``--vdev`` arguments.
+Device name and stream options must be separated by commas as shown below:
+
+.. code-block:: console
+
+   ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+       --vdev 'net_pcap0,stream_opt0=..,stream_opt1=..' \
+       --vdev='net_pcap1,stream_opt0=..'
+
+Device Streams
+^^^^^^^^^^^^^^
+
+Stream definitions can be combined as long as one of the following two rules is met:
+
+*   A device is provided with two different streams - reception and transmission.
+
+*   A device is provided with one network interface name used for reading and writing packets.
+
+The stream types are:
+
+*   rx_pcap: Defines a reception stream based on a pcap file.
+    The driver reads each packet within the given pcap file as if it was receiving it from the wire.
+    The value is a path to a valid pcap file.
+
+        rx_pcap=/path/to/file.pcap
+
+*   tx_pcap: Defines a transmission stream based on a pcap file.
+    The driver writes each received packet to the given pcap file.
+    The value is a path to a pcap file.
+    The file is overwritten if it already exists and it is created if it does not.
+
+        tx_pcap=/path/to/file.pcap
+
+*   rx_iface: Defines a reception stream based on a network interface name.
+    The driver reads packets from the given interface using the kernel driver for that interface.
+    The driver captures both the incoming and outgoing packets on that interface.
+    The value is an interface name.
+
+        rx_iface=eth0
+
+*   rx_iface_in: Defines a reception stream based on a network interface name.
+    The driver reads packets from the given interface using the kernel driver for that interface.
+    The driver captures only the incoming packets on that interface.
+    The value is an interface name.
+
+        rx_iface_in=eth0
+
+*   tx_iface: Defines a transmission stream based on a network interface name.
+    The driver sends packets to the given interface using the kernel driver for that interface.
+    The value is an interface name.
+
+        tx_iface=eth0
+
+*   iface: Defines a device mapping a network interface.
+    The driver both reads and writes packets from and to the given interface.
+    The value is an interface name.
+
+        iface=eth0
+
+Multi-queue Support
+^^^^^^^^^^^^^^^^^^^
+
+The pcap PMD supports multiple receive and transmit queues.
+The number of receive queues is determined by the number of rx_pcap or rx_iface arguments provided.
+Similarly, the number of transmit queues is determined by the number of tx_pcap or tx_iface arguments.
+
+Using the same file for multiple queues is not supported because the underlying
+pcap library does not support concurrent access to a single file handle.
+
+Runtime Config Options
+^^^^^^^^^^^^^^^^^^^^^^
+
+- Use pcap interface physical MAC
+
+ When the ``iface=`` configuration is set, the selected interface's physical MAC
+ address can be used. This can be done with the ``phy_mac`` devarg, for example::
+
+   --vdev 'net_pcap0,iface=eth0,phy_mac=1'
+
+- Use the RX pcap file to infinitely receive packets
+
+ When the ``rx_pcap=`` configuration is set, the selected pcap file can be used for basic
+ performance testing. This can be done with the ``infinite_rx`` devarg, for example::
+
+   --vdev 'net_pcap0,rx_pcap=file_rx.pcap,infinite_rx=1'
+
+ When this mode is used, it is recommended to drop all packets on transmit by not providing a tx_pcap or tx_iface.
+
+ This option is device-wide, so all queues on a device will either have this enabled or disabled.
+ This option should only be provided once per device.
+
+- Drop all packets on transmit
+
+ To drop all packets on transmit for a device, do not provide a tx_pcap or tx_iface, for example::
+
+   --vdev 'net_pcap0,rx_pcap=file_rx.pcap'
+
+ In this case, one tx drop queue is created for each rxq on that device.
+
+- Receive no packets on Rx
+
+ To run without receiving any packets on Rx, do not provide a rx_pcap or rx_iface, for example::
+
+   --vdev 'net_pcap0,tx_pcap=file_tx.pcap'
+
+ In this case, one dummy rx queue is created for each tx queue argument passed.
+
+Examples of Usage
+^^^^^^^^^^^^^^^^^
+
+Read packets from one pcap file and write them to another:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_pcap=file_tx.pcap' \
+        -- --port-topology=chained
+
+Read packets from a network interface and write them to a pcap file:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,rx_iface=eth0,tx_pcap=file_tx.pcap' \
+        -- --port-topology=chained
+
+Read packets from a pcap file and write them to a network interface:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_iface=eth1' \
+        -- --port-topology=chained
+
+Forward packets through two network interfaces:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,iface=eth0' --vdev='net_pcap1,iface=eth1'
+
+Enable 2 tx queues on a network interface:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,rx_iface=eth1,tx_iface=eth1,tx_iface=eth1' \
+        -- --txq 2
+
+Read only incoming packets from a network interface and write them back to the same network interface:
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,rx_iface_in=eth1,tx_iface=eth1'
+
+Using Pcap-based PMD with the testpmd Application
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+One of the first things that testpmd does before starting to forward packets is to flush the RX streams
+by reading the first 512 packets on every RX stream and discarding them.
+When using a pcap-based PMD, this behavior can be turned off using the ``--no-flush-rx`` option:
+
+.. code-block:: console
+
+    --no-flush-rx
+
+This option is also available in the runtime command line:
+
+.. code-block:: console
+
+    set flush_rx on/off
+
+It is useful for the case where the rx_pcap is being used and no packets are meant to be discarded.
+Otherwise, the first 512 packets from the input pcap file will be discarded by the RX flushing operation.
+
+.. code-block:: console
+
+    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
+        --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_pcap=file_tx.pcap' \
+        -- --port-topology=chained --no-flush-rx
+
+.. note::
+
+   The network interface provided to the PMD should be up. The PMD will return
+   an error if interface is down, and the PMD itself won't change the status
+   of the external network interface.
diff --git a/doc/guides/nics/pcap_ring.rst b/doc/guides/nics/pcap_ring.rst
deleted file mode 100644
index 6955e91130..0000000000
--- a/doc/guides/nics/pcap_ring.rst
+++ /dev/null
@@ -1,318 +0,0 @@
-..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright(c) 2010-2015 Intel Corporation.
-
-Libpcap and Ring Based Poll Mode Drivers
-========================================
-
-In addition to Poll Mode Drivers (PMDs) for physical and virtual hardware,
-the DPDK also includes pure-software PMDs, two of these drivers are:
-
-*   A libpcap -based PMD (**librte_net_pcap**) that reads and writes packets using libpcap,
-    - both from files on disk, as well as from physical NIC devices using standard Linux kernel drivers.
-
-*   A ring-based PMD (**librte_net_ring**) that allows a set of software FIFOs (that is, rte_ring)
-    to be accessed using the PMD APIs, as though they were physical NICs.
-
-.. note::
-
-    The libpcap -based PMD has an external dependency on the libpcap development files which must
-    be installed on the board.
-
-Using the Drivers from the EAL Command Line
--------------------------------------------
-
-For ease of use, the DPDK EAL also has been extended to allow pseudo-Ethernet devices,
-using one or more of these drivers,
-to be created at application startup time during EAL initialization.
-
-To do so, the --vdev= parameter must be passed to the EAL.
-This takes take options to allow ring and pcap-based Ethernet to be allocated and used transparently by the application.
-This can be used, for example, for testing on a virtual machine where there are no Ethernet ports.
-
-Libpcap-based PMD
-~~~~~~~~~~~~~~~~~
-
-Pcap-based devices can be created using the virtual device --vdev option.
-The device name must start with the net_pcap prefix followed by numbers or letters.
-The name is unique for each device. Each device can have multiple stream options and multiple devices can be used.
-Multiple device definitions can be arranged using multiple --vdev.
-Device name and stream options must be separated by commas as shown below:
-
-.. code-block:: console
-
-   ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-       --vdev 'net_pcap0,stream_opt0=..,stream_opt1=..' \
-       --vdev='net_pcap1,stream_opt0=..'
-
-Device Streams
-^^^^^^^^^^^^^^
-
-Multiple ways of stream definitions can be assessed and combined as long as the following two rules are respected:
-
-*   A device is provided with two different streams - reception and transmission.
-
-*   A device is provided with one network interface name used for reading and writing packets.
-
-The different stream types are:
-
-*   rx_pcap: Defines a reception stream based on a pcap file.
-    The driver reads each packet within the given pcap file as if it was receiving it from the wire.
-    The value is a path to a valid pcap file.
-
-        rx_pcap=/path/to/file.pcap
-
-*   tx_pcap: Defines a transmission stream based on a pcap file.
-    The driver writes each received packet to the given pcap file.
-    The value is a path to a pcap file.
-    The file is overwritten if it already exists and it is created if it does not.
-
-        tx_pcap=/path/to/file.pcap
-
-*   rx_iface: Defines a reception stream based on a network interface name.
-    The driver reads packets from the given interface using the Linux kernel driver for that interface.
-    The driver captures both the incoming and outgoing packets on that interface.
-    The value is an interface name.
-
-        rx_iface=eth0
-
-*   rx_iface_in: Defines a reception stream based on a network interface name.
-    The driver reads packets from the given interface using the Linux kernel driver for that interface.
-    The driver captures only the incoming packets on that interface.
-    The value is an interface name.
-
-        rx_iface_in=eth0
-
-*   tx_iface: Defines a transmission stream based on a network interface name.
-    The driver sends packets to the given interface using the Linux kernel driver for that interface.
-    The value is an interface name.
-
-        tx_iface=eth0
-
-*   iface: Defines a device mapping a network interface.
-    The driver both reads and writes packets from and to the given interface.
-    The value is an interface name.
-
-        iface=eth0
-
-Runtime Config Options
-^^^^^^^^^^^^^^^^^^^^^^
-
-- Use PCAP interface physical MAC
-
- In case ``iface=`` configuration is set, user may want to use the selected interface's physical MAC
- address. This can be done with a ``devarg`` ``phy_mac``, for example::
-
-   --vdev 'net_pcap0,iface=eth0,phy_mac=1'
-
-- Use the RX PCAP file to infinitely receive packets
-
- In case ``rx_pcap=`` configuration is set, user may want to use the selected PCAP file for rudimental
- performance testing. This can be done with a ``devarg`` ``infinite_rx``, for example::
-
-   --vdev 'net_pcap0,rx_pcap=file_rx.pcap,infinite_rx=1'
-
- When this mode is used, it is recommended to drop all packets on transmit by not providing a tx_pcap or tx_iface.
-
- This option is device wide, so all queues on a device will either have this enabled or disabled.
- This option should only be provided once per device.
-
-- Drop all packets on transmit
-
- The user may want to drop all packets on tx for a device. This can be done by not providing a tx_pcap or tx_iface, for example::
-
-   --vdev 'net_pcap0,rx_pcap=file_rx.pcap'
-
- In this case, one tx drop queue is created for each rxq on that device.
-
- - Receive no packets on Rx
-
- The user may want to run without receiving any packets on Rx. This can be done by not providing a rx_pcap or rx_iface, for example::
-
-   --vdev 'net_pcap0,tx_pcap=file_tx.pcap'
-
-In this case, one dummy rx queue is created for each tx queue argument passed
-
-Examples of Usage
-^^^^^^^^^^^^^^^^^
-
-Read packets from one pcap file and write them to another:
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_pcap=file_tx.pcap' \
-        -- --port-topology=chained
-
-Read packets from a network interface and write them to a pcap file:
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,rx_iface=eth0,tx_pcap=file_tx.pcap' \
-        -- --port-topology=chained
-
-Read packets from a pcap file and write them to a network interface:
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_iface=eth1' \
-        -- --port-topology=chained
-
-Forward packets through two network interfaces:
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,iface=eth0' --vdev='net_pcap1,iface=eth1'
-
-Enable 2 tx queues on a network interface:
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,rx_iface=eth1,tx_iface=eth1,tx_iface=eth1' \
-        -- --txq 2
-
-Read only incoming packets from a network interface and write them back to the same network interface:
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,rx_iface_in=eth1,tx_iface=eth1'
-
-Using libpcap-based PMD with the testpmd Application
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-One of the first things that testpmd does before starting to forward packets is to flush the RX streams
-by reading the first 512 packets on every RX stream and discarding them.
-When using a libpcap-based PMD this behavior can be turned off using the following command line option:
-
-.. code-block:: console
-
-    --no-flush-rx
-
-It is also available in the runtime command line:
-
-.. code-block:: console
-
-    set flush_rx on/off
-
-It is useful for the case where the rx_pcap is being used and no packets are meant to be discarded.
-Otherwise, the first 512 packets from the input pcap file will be discarded by the RX flushing operation.
-
-.. code-block:: console
-
-    ./<build_dir>/app/dpdk-testpmd -l 0-3 \
-        --vdev 'net_pcap0,rx_pcap=file_rx.pcap,tx_pcap=file_tx.pcap' \
-        -- --port-topology=chained --no-flush-rx
-
-.. note::
-
-   The network interface provided to the PMD should be up. The PMD will return
-   an error if interface is down, and the PMD itself won't change the status
-   of the external network interface.
-
-
-Rings-based PMD
-~~~~~~~~~~~~~~~
-
-To run a DPDK application on a machine without any Ethernet devices, a pair of ring-based rte_ethdevs can be used as below.
-The device names passed to the --vdev option must start with net_ring and take no additional parameters.
-Multiple devices may be specified, separated by commas.
-
-.. code-block:: console
-
-    ./dpdk-testpmd -l 1-3 --vdev=net_ring0 --vdev=net_ring1 -- -i
-    ...
-    Interactive-mode selected
-    Configuring Port 0 (socket 0)
-    Configuring Port 1 (socket 0)
-    Checking link statuses...
-    Port 0 Link Up - speed 10000 Mbps - full-duplex
-    Port 1 Link Up - speed 10000 Mbps - full-duplex
-    Done
-
-    testpmd> start tx_first
-    io packet forwarding - CRC stripping disabled - packets/burst=16
-    nb forwarding cores=1 - nb forwarding ports=2
-    RX queues=1 - RX desc=128 - RX free threshold=0
-    RX threshold registers: pthresh=8 hthresh=8 wthresh=4
-    TX queues=1 - TX desc=512 - TX free threshold=0
-    TX threshold registers: pthresh=36 hthresh=0 wthresh=0
-    TX RS bit threshold=0 - TXQ flags=0x0
-
-    testpmd> stop
-    Telling cores to stop...
-    Waiting for lcores to finish...
-
-.. image:: img/forward_stats.*
-
-.. code-block:: console
-
-    +++++++++++++++ Accumulated forward statistics for allports++++++++++
-    RX-packets: 462384736  RX-dropped: 0 RX-total: 462384736
-    TX-packets: 462384768  TX-dropped: 0 TX-total: 462384768
-    +++++++++++++++++++++++++++++++++++++++++++++++++++++
-
-    Done.
-
-
-Using the Poll Mode Driver from an Application
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Both drivers can provide similar APIs to allow the user to create a PMD, that is,
-rte_ethdev structure, instances at run-time in the end-application,
-for example, using rte_eth_from_rings() or rte_eth_from_pcaps() APIs.
-For the rings-based PMD, this functionality could be used, for example,
-to allow data exchange between cores using rings to be done in exactly the
-same way as sending or receiving packets from an Ethernet device.
-For the libpcap-based PMD, it allows an application to open one or more pcap files
-and use these as a source of packet input to the application.
-
-Usage Examples
-^^^^^^^^^^^^^^
-
-To create two pseudo-Ethernet ports where all traffic sent to a port is looped back
-for reception on the same port (error handling omitted for clarity):
-
-.. code-block:: c
-
-    #define RING_SIZE 256
-    #define NUM_RINGS 2
-    #define SOCKET0 0
-
-    struct rte_ring *ring[NUM_RINGS];
-    int port0, port1;
-
-    ring[0] = rte_ring_create("R0", RING_SIZE, SOCKET0, RING_F_SP_ENQ|RING_F_SC_DEQ);
-    ring[1] = rte_ring_create("R1", RING_SIZE, SOCKET0, RING_F_SP_ENQ|RING_F_SC_DEQ);
-
-    /* create two ethdev's */
-
-    port0 = rte_eth_from_rings("net_ring0", ring, NUM_RINGS, ring, NUM_RINGS, SOCKET0);
-    port1 = rte_eth_from_rings("net_ring1", ring, NUM_RINGS, ring, NUM_RINGS, SOCKET0);
-
-
-To create two pseudo-Ethernet ports where the traffic is switched between them,
-that is, traffic sent to port 0 is read back from port 1 and vice-versa,
-the final two lines could be changed as below:
-
-.. code-block:: c
-
-    port0 = rte_eth_from_rings("net_ring0", &ring[0], 1, &ring[1], 1, SOCKET0);
-    port1 = rte_eth_from_rings("net_ring1", &ring[1], 1, &ring[0], 1, SOCKET0);
-
-This type of configuration could be useful in a pipeline model, for example,
-where one may want to have inter-core communication using pseudo Ethernet devices rather than raw rings,
-for reasons of API consistency.
-
-Enqueuing and dequeuing items from an rte_ring using the rings-based PMD may be slower than using the native rings API.
-This is because DPDK Ethernet drivers make use of function pointers to call the appropriate enqueue or dequeue functions,
-while the rte_ring specific functions are direct function calls in the code and are often inlined by the compiler.
-
-   Once an ethdev has been created, for either a ring or a pcap-based PMD,
-   it should be configured and started in the same way as a regular Ethernet device, that is,
-   by calling rte_eth_dev_configure() to set the number of receive and transmit queues,
-   then calling rte_eth_rx_queue_setup() / tx_queue_setup() for each of those queues and
-   finally calling rte_eth_dev_start() to allow transmission and reception of packets to begin.
diff --git a/doc/guides/nics/ring.rst b/doc/guides/nics/ring.rst
new file mode 100644
index 0000000000..d4f080c818
--- /dev/null
+++ b/doc/guides/nics/ring.rst
@@ -0,0 +1,116 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2010-2015 Intel Corporation.
+
+Ring Based Poll Mode Driver
+===========================
+
+The ring-based PMD (**librte_net_ring**) allows software FIFOs (rte_ring) to be accessed
+using the PMD APIs, as though they were physical NICs.
+
+Using the Driver from the EAL Command Line
+------------------------------------------
+
+The DPDK EAL has been extended to allow pseudo-Ethernet devices,
+using the ring driver, to be created at application startup time during EAL initialization.
+
+To do so, pass the ``--vdev=net_ring0`` parameter to the EAL.
+This parameter accepts options to allocate and use ring-based Ethernet transparently by the application.
+This can be used, for example, for testing on a virtual machine where there are no Ethernet ports.
+
+Ring-based PMD
+~~~~~~~~~~~~~~
+
+To run a DPDK application on a machine without any Ethernet devices, a pair of ring-based rte_ethdevs can be used as below.
+The device names passed to the ``--vdev`` option must start with net_ring and take no additional parameters.
+Multiple devices may be specified using multiple ``--vdev`` arguments.
+
+.. code-block:: console
+
+    ./dpdk-testpmd -l 1-3 --vdev=net_ring0 --vdev=net_ring1 -- -i
+    ...
+    Interactive-mode selected
+    Configuring Port 0 (socket 0)
+    Configuring Port 1 (socket 0)
+    Checking link statuses...
+    Port 0 Link Up - speed 10000 Mbps - full-duplex
+    Port 1 Link Up - speed 10000 Mbps - full-duplex
+    Done
+
+    testpmd> start tx_first
+    io packet forwarding - CRC stripping disabled - packets/burst=16
+    nb forwarding cores=1 - nb forwarding ports=2
+    RX queues=1 - RX desc=128 - RX free threshold=0
+    RX threshold registers: pthresh=8 hthresh=8 wthresh=4
+    TX queues=1 - TX desc=512 - TX free threshold=0
+    TX threshold registers: pthresh=36 hthresh=0 wthresh=0
+    TX RS bit threshold=0 - TXQ flags=0x0
+
+    testpmd> stop
+    Telling cores to stop...
+    Waiting for lcores to finish...
+
+.. image:: img/forward_stats.*
+
+.. code-block:: console
+
+    +++++++++++++++ Accumulated forward statistics for allports++++++++++
+    RX-packets: 462384736  RX-dropped: 0 RX-total: 462384736
+    TX-packets: 462384768  TX-dropped: 0 TX-total: 462384768
+    +++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+    Done.
+
+
+Using the Ring-based PMD from an Application
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The driver provides APIs to create PMD (rte_ethdev structure) instances at run-time
+in the end-application using the rte_eth_from_rings() API.
+This functionality can be used to allow data exchange between cores using rings
+in the same way as sending or receiving packets from an Ethernet device.
+
+Usage Examples
+^^^^^^^^^^^^^^
+
+To create two pseudo-Ethernet ports where all traffic sent to a port is looped back
+for reception on the same port (error handling omitted for clarity):
+
+.. code-block:: c
+
+    #define RING_SIZE 256
+    #define NUM_RINGS 2
+    #define SOCKET0 0
+
+    struct rte_ring *ring[NUM_RINGS];
+    int port0, port1;
+
+    ring[0] = rte_ring_create("R0", RING_SIZE, SOCKET0, RING_F_SP_ENQ|RING_F_SC_DEQ);
+    ring[1] = rte_ring_create("R1", RING_SIZE, SOCKET0, RING_F_SP_ENQ|RING_F_SC_DEQ);
+
+    /* create two ethdev's */
+
+    port0 = rte_eth_from_rings("net_ring0", ring, NUM_RINGS, ring, NUM_RINGS, SOCKET0);
+    port1 = rte_eth_from_rings("net_ring1", ring, NUM_RINGS, ring, NUM_RINGS, SOCKET0);
+
+
+To create two pseudo-Ethernet ports where the traffic is switched between them
+(traffic sent to port 0 is read back from port 1 and vice-versa),
+the final two lines can be changed as follows:
+
+.. code-block:: c
+
+    port0 = rte_eth_from_rings("net_ring0", &ring[0], 1, &ring[1], 1, SOCKET0);
+    port1 = rte_eth_from_rings("net_ring1", &ring[1], 1, &ring[0], 1, SOCKET0);
+
+This type of configuration is useful in a pipeline model where inter-core communication
+using pseudo Ethernet devices is preferred over raw rings for API consistency.
+
+Enqueuing and dequeuing items from an rte_ring using the ring-based PMD may be slower than using the native rings API.
+DPDK Ethernet drivers use function pointers to call the appropriate enqueue or dequeue functions,
+while the rte_ring specific functions are direct function calls and are often inlined by the compiler.
+
+Once an ethdev has been created for a ring-based PMD,
+it should be configured and started in the same way as a regular Ethernet device:
+call rte_eth_dev_configure() to set the number of receive and transmit queues,
+then call rte_eth_rx_queue_setup() / tx_queue_setup() for each of those queues,
+and finally call rte_eth_dev_start() to allow transmission and reception of packets to begin.
-- 
2.51.0

