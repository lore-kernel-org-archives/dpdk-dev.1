Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A1D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC01C410ED;
	Wed, 14 Jan 2026 23:25:24 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 88C11410E3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:24 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso3337085e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429524;
 x=1769034324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuMGaf32onpR5NITU9g727fZfjyVTeVjrojwaiycK9I=;
 b=Ca5WAhY9XNT9M6WfpASZHvgdUmB08canh5QqYMzq6ByEGQhkRfHRPTb+8N41e0jRnL
 2G2yA7CEkwGp4z8BzJXGBgWHhxDu9kFuXmrOYZAFf0JxVU3eHZ/LW857xlAugga4CrYP
 RayqRmCGcS6/ybtwdBGzqDvlIFRbpBkgZd+LEfreHhnfLZIRBZ6SPX34PH3akTyrxIDF
 pHLMcb39cKumyg4pi2pDm38DQlAGwenhMR8jrV+bjam2uzRwc9TZAhxKoGr0XOB3N9lC
 qgButWURD4XNQPsjxLLHfyrs0y0UC2kOogcvY9vUGbOS4j7tqHGATMOdxcPp9TkyWB6W
 jQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429524; x=1769034324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wuMGaf32onpR5NITU9g727fZfjyVTeVjrojwaiycK9I=;
 b=V6e5ooWANXEa+4mlpCeU0ODHIaWW15SSrEW8iveJ1MCwvt4BX5HbIgY1deza5SVpEB
 9/bXxnDhQDoFj7+OvX3uqJnObjwrcI6d5RyqrORAEMSpcqGz14KQCERKmm1Cm73yI4Yf
 GFjbxmTEyUjMDHWhYYN6iYsf4BRWGBmR+WR6tMpyv/xHxFnWnnZfdcVdKxySzH6Doblj
 bgrT1KKnhexzfzGCiUgkxz37tES6BGVCF+F1H6+uxM2HqTymAhGmsnEy3FFZL0uax+Qq
 oIY9pI/ZLzYInkEu8alHJJ8vgeAvvBxtjteC1IcgFntgL9VmeQ/xztO6/7TpHmkCKviq
 PPwg==
X-Gm-Message-State: AOJu0YzvtmfQX8Ym64y6u1zFdrg22NM5YUcs/2/uJi9XiZiL7fMF6uZ8
 MixdrrShIApifVIc6NLbR+Q6i0cxYPofyWkrFYOedIxmOjP3SE2mWmLLDe9khSOGr3T1me6dBkn
 mm2yddsQ=
X-Gm-Gg: AY/fxX5SCL+o37PLbIehS3Q4OqK02sHrZf5+5CJWpEEJ3NH2SnG8Gxw6uTmYog+gUm2
 BrBz7Ex2LtHcxRH0ncixgGuCToCm/qOIM4xZaVNcKfD8IhaEeiYsYQWvpo5RB+xX+HBYEaSZoCS
 N1qUHq6gVtnn73XEtC0C5VE4vHxvZ1TGFflHESMN5B99HceauuFgCSMB9kwZ1oklpWtkAgR6wWR
 1C0jRlbPMWM3pgS/Pk/jcd/TwAQUFlK1y5hC0XCldzljxEvwnix4GSQyQQ2aZt3NcekM6vyd3Er
 xSNoCQKAyvw/ccVAMRAiriR0vV3FWYCmsNRE6QEdZLp9qJig6Ayir7QFOAc59mtZz/Wnpg+BWLy
 2PB/4f8f/EYF1P0nwV04AExYP2nWQUMHFzhKaV6vnJfmWshjpdwwJ6tlJi8+Sc5HURaPkX9IbiW
 S/9jqae/jwhWaoMQG9CSw41yfUp1yffDDG6ez6BuP2/qWCzY1/pw==
X-Received: by 2002:a05:600c:a415:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-47ee7790531mr32105805e9.19.1768429523862; 
 Wed, 14 Jan 2026 14:25:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 12/29] examples/vhost: improve sample application documentation
Date: Wed, 14 Jan 2026 14:21:53 -0800
Message-ID: <20260114222458.87119-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rewrite the vhost, vhost_blk, and vhost_crypto documentation for
consistency, clarity, and correctness.

Common changes across all files:
- Add Overview sections where missing
- Standardize section structure (Compiling, Running, Explanation)
- Standardize "QEMU" capitalization (was inconsistent "Qemu")
- Add missing commas after introductory clauses
- Use imperative mood for instructions
- Improve parameter formatting using RST definition lists

Changes to vhost.rst:
- Reorganize Testing Steps as a subsection under Overview
- Correct "bond" to "bound" for UIO driver binding
- Improve parameter descriptions with proper indentation
- Streamline packet injection instructions

Changes to vhost_blk.rst:
- Restructure QEMU requirements as a proper bulleted list
- Clarify reconnect and packed ring feature descriptions

Changes to vhost_crypto.rst:
- Reformat command-line options as definition list
- Clarify zero-copy experimental status warning
- Improve device initialization requirements description

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/vhost.rst        | 185 +++++++++++-----------
 doc/guides/sample_app_ug/vhost_blk.rst    |  58 ++++---
 doc/guides/sample_app_ug/vhost_crypto.rst |  94 +++++------
 3 files changed, 175 insertions(+), 162 deletions(-)

diff --git a/doc/guides/sample_app_ug/vhost.rst b/doc/guides/sample_app_ug/vhost.rst
index 4c944a844a..40de72be73 100644
--- a/doc/guides/sample_app_ug/vhost.rst
+++ b/doc/guides/sample_app_ug/vhost.rst
@@ -4,6 +4,9 @@
 Vhost Sample Application
 ========================
 
+Overview
+--------
+
 The vhost sample application demonstrates integration of the Data Plane
 Development Kit (DPDK) with the Linux* KVM hypervisor by implementing the
 vhost-net offload API. The sample application performs simple packet
@@ -13,27 +16,26 @@ traffic from an external switch is performed in hardware by the Virtual
 Machine Device Queues (VMDQ) and Data Center Bridging (DCB) features of
 the Intel® 82599 10 Gigabit Ethernet Controller.
 
-Testing steps
--------------
+Testing Steps
+~~~~~~~~~~~~~
 
-This section shows the steps how to test a typical PVP case with this
-dpdk-vhost sample, whereas packets are received from the physical NIC
-port first and enqueued to the VM's Rx queue. Through the guest testpmd's
-default forwarding mode (io forward), those packets will be put into
-the Tx queue. The dpdk-vhost example, in turn, gets the packets and
-puts back to the same physical NIC port.
+This section shows how to test a typical PVP case with the dpdk-vhost sample,
+where packets are received from the physical NIC port first and enqueued to the
+VM's Rx queue. Through the guest testpmd's default forwarding mode (io forward),
+those packets are put into the Tx queue. The dpdk-vhost example, in turn,
+gets the packets and puts them back to the same physical NIC port.
 
-Build
-~~~~~
+Compiling the Application
+-------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vhost`` sub-directory.
 
 .. note::
-   In this example, you need build DPDK both on the host and inside guest.
+   In this example, you need to build DPDK both on the host and inside guest.
 
-. _vhost_app_run_vm:
+.. _vhost_app_run_vm:
 
 Start the VM
 ~~~~~~~~~~~~
@@ -50,12 +52,12 @@ Start the VM
         ...
 
 .. note::
-    For basic vhost-user support, QEMU 2.2 (or above) is required. For
-    some specific features, a higher version might be need. Such as
-    QEMU 2.7 (or above) for the reconnect feature.
+    For basic vhost-user support, QEMU 2.2 or later is required. For
+    some specific features, a higher version might be needed. For example,
+    QEMU 2.7 or later is required for the reconnect feature.
 
 
-Start the vswitch example
+Start the vswitch Example
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
@@ -64,40 +66,44 @@ Start the vswitch example
              -- --socket-file /tmp/sock0 --client \
              ...
 
-Check the `Parameters`_ section for the explanations on what do those
-parameters mean.
+See the `Parameters`_ section for explanations of the command-line options.
+
+Running the Application
+-----------------------
 
 .. _vhost_app_run_dpdk_inside_guest:
 
-Run testpmd inside guest
+Run testpmd Inside Guest
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Make sure you have DPDK built inside the guest. Also make sure the
-corresponding virtio-net PCI device is bond to a UIO driver, which
-could be done by:
+Ensure DPDK is built inside the guest and that the corresponding virtio-net
+PCI device is bound to a UIO driver. This can be done as follows:
 
 .. code-block:: console
 
    modprobe vfio-pci
    dpdk/usertools/dpdk-devbind.py -b vfio-pci 0000:00:04.0
 
-Then start testpmd for packet forwarding testing.
+Then, start testpmd for packet forwarding testing.
 
 .. code-block:: console
 
     ./<build_dir>/app/dpdk-testpmd -l 0-1 -- -i
     > start tx_first
 
-For more information about vIOMMU and NO-IOMMU and VFIO please refer to
-:doc:`/../linux_gsg/linux_drivers` section of the DPDK Getting started guide.
+For more information about vIOMMU, NO-IOMMU, and VFIO, see the
+:doc:`/../linux_gsg/linux_drivers` section of the DPDK Getting Started Guide.
 
-Inject packets
---------------
+Explanation
+-----------
 
-While a virtio-net is connected to dpdk-vhost, a VLAN tag starts with
-1000 is assigned to it. So make sure configure your packet generator
-with the right MAC and VLAN tag, you should be able to see following
-log from the dpdk-vhost console. It means you get it work::
+Inject Packets
+~~~~~~~~~~~~~~
+
+When a virtio-net device connects to dpdk-vhost, a VLAN tag starting with
+1000 is assigned to it. Configure your packet generator with the appropriate
+MAC and VLAN tag. The following log message should appear on the dpdk-vhost
+console::
 
     VHOST_DATA: (0) mac 52:54:00:00:00:14 and vlan 1000 registered
 
@@ -105,88 +111,86 @@ log from the dpdk-vhost console. It means you get it work::
 .. _vhost_app_parameters:
 
 Parameters
-----------
+~~~~~~~~~~
 
 **--socket-file path**
-Specifies the vhost-user socket file path.
+    Specifies the vhost-user socket file path.
 
 **--client**
-DPDK vhost-user will act as the client mode when such option is given.
-In the client mode, QEMU will create the socket file. Otherwise, DPDK
-will create it. Put simply, it's the server to create the socket file.
-
+    DPDK vhost-user acts as the client when this option is given.
+    In client mode, QEMU creates the socket file. Otherwise, DPDK
+    creates it. The server always creates the socket file.
 
 **--vm2vm mode**
-The vm2vm parameter sets the mode of packet switching between guests in
-the host.
+    Sets the mode of packet switching between guests in the host.
 
-- 0 disables vm2vm, implying that VM's packets will always go to the NIC port.
-- 1 means a normal mac lookup packet routing.
-- 2 means hardware mode packet forwarding between guests, it allows packets
-  go to the NIC port, hardware L2 switch will determine which guest the
-  packet should forward to or need send to external, which bases on the
-  packet destination MAC address and VLAN tag.
+    - 0 disables vm2vm, meaning VM packets always go to the NIC port.
+    - 1 enables normal MAC lookup packet routing.
+    - 2 enables hardware mode packet forwarding between guests. Packets
+      can go to the NIC port, and the hardware L2 switch determines which
+      guest the packet should be forwarded to or whether it needs to be
+      sent externally, based on the packet destination MAC address and
+      VLAN tag.
 
 **--mergeable 0|1**
-Set 0/1 to disable/enable the mergeable Rx feature. It's disabled by default.
+    Set to 0 to disable or 1 to enable the mergeable Rx feature.
+    Disabled by default.
 
 **--stats interval**
-The stats parameter controls the printing of virtio-net device statistics.
-The parameter specifies an interval (in unit of seconds) to print statistics,
-with an interval of 0 seconds disabling statistics.
+    Controls the printing of virtio-net device statistics.
+    The parameter specifies an interval in seconds to print statistics.
+    An interval of 0 disables statistics.
 
 **--rx-retry 0|1**
-The rx-retry option enables/disables enqueue retries when the guests Rx queue
-is full. This feature resolves a packet loss that is observed at high data
-rates, by allowing it to delay and retry in the receive path. This option is
-enabled by default.
+    Enables or disables enqueue retries when the guest's Rx queue
+    is full. This feature resolves packet loss observed at high data
+    rates by allowing delay and retry in the receive path. Enabled by default.
 
 **--rx-retry-num num**
-The rx-retry-num option specifies the number of retries on an Rx burst, it
-takes effect only when rx retry is enabled.  The default value is 4.
+    Specifies the number of retries on an Rx burst. Takes effect only when
+    rx-retry is enabled. The default value is 4.
 
 **--rx-retry-delay msec**
-The rx-retry-delay option specifies the timeout (in micro seconds) between
-retries on an RX burst, it takes effect only when rx retry is enabled. The
-default value is 15.
+    Specifies the timeout in microseconds between retries on an Rx burst.
+    Takes effect only when rx-retry is enabled. The default value is 15.
 
 **--builtin-net-driver**
-A very simple vhost-user net driver which demonstrates how to use the generic
-vhost APIs will be used when this option is given. It is disabled by default.
+    Uses a simple vhost-user net driver that demonstrates how to use the
+    generic vhost APIs. Disabled by default.
 
 **--dmas**
-This parameter is used to specify the assigned DMA device of a vhost device.
-Async vhost-user net driver will be used if --dmas is set. For example
---dmas [txd0@00:04.0,txd1@00:04.1,rxd0@00:04.2,rxd1@00:04.3] means use
-DMA channel 00:04.0/00:04.2 for vhost device 0 enqueue/dequeue operation
-and use DMA channel 00:04.1/00:04.3 for vhost device 1 enqueue/dequeue
-operation. The index of the device corresponds to the socket file in order,
-that means vhost device 0 is created through the first socket file, vhost
-device 1 is created through the second socket file, and so on.
+    Specifies the assigned DMA device of a vhost device.
+    The async vhost-user net driver is used when --dmas is set. For example,
+    ``--dmas [txd0@00:04.0,txd1@00:04.1,rxd0@00:04.2,rxd1@00:04.3]`` means
+    DMA channel 00:04.0/00:04.2 is used for vhost device 0 enqueue/dequeue
+    operations and DMA channel 00:04.1/00:04.3 is used for vhost device 1
+    enqueue/dequeue operations. The index of the device corresponds to the
+    socket file in order: vhost device 0 is created through the first socket
+    file, vhost device 1 is created through the second socket file, and so on.
 
 **--total-num-mbufs 0-N**
-This parameter sets the number of mbufs to be allocated in mbuf pools,
-the default value is 147456. This is can be used if launch of a port fails
-due to shortage of mbufs.
+    Sets the number of mbufs to be allocated in mbuf pools.
+    The default value is 147456. This option can be used if port launch fails
+    due to shortage of mbufs.
 
 **--tso 0|1**
-Disables/enables TCP segment offload.
+    Disables or enables TCP segment offload.
 
 **--tx-csum 0|1**
-Disables/enables TX checksum offload.
+    Disables or enables TX checksum offload.
 
 **-p mask**
-Port mask which specifies the ports to be used
+    Port mask specifying the ports to be used.
 
 Common Issues
--------------
+~~~~~~~~~~~~~
 
-* QEMU fails to allocate memory on hugetlbfs, with an error like the
+* QEMU fails to allocate memory on hugetlbfs and shows an error like the
   following::
 
       file_ram_alloc: can't mmap RAM pages: Cannot allocate memory
 
-  When running QEMU the above error indicates that it has failed to allocate
+  When running QEMU, the above error indicates that it has failed to allocate
   memory for the Virtual Machine on the hugetlbfs. This is typically due to
   insufficient hugepages being free to support the allocation request. The
   number of free hugepages can be checked as follows:
@@ -200,23 +204,22 @@ Common Issues
 
 * Failed to build DPDK in VM
 
-  Make sure "-cpu host" QEMU option is given.
+  Ensure the ``-cpu host`` QEMU option is given.
 
-* Device start fails if NIC's max queues > the default number of 128
+* Device start fails if NIC's max queues exceeds the default of 128
 
-  mbuf pool size is dependent on the MAX_QUEUES configuration, if NIC's
-  max queue number is larger than 128, device start will fail due to
-  insufficient mbuf. This can be adjusted using ``--total-num-mbufs``
-  parameter.
+  The mbuf pool size depends on the MAX_QUEUES configuration. If the NIC's
+  max queue number is larger than 128, device start fails due to
+  insufficient mbufs. Adjust using the ``--total-num-mbufs`` parameter.
 
-* Option "builtin-net-driver" is incompatible with QEMU
+* Option ``builtin-net-driver`` is incompatible with QEMU
 
-  QEMU vhost net device start will fail if protocol feature is not negotiated.
-  DPDK virtio-user PMD can be the replacement of QEMU.
+  The QEMU vhost net device start fails if the protocol feature is not
+  negotiated. DPDK virtio-user PMD can be used as a replacement for QEMU.
 
-* Device start fails when enabling "builtin-net-driver" without memory
+* Device start fails when enabling ``builtin-net-driver`` without memory
   pre-allocation
 
-  The builtin example doesn't support dynamic memory allocation. When vhost
-  backend enables "builtin-net-driver", "--numa-mem" option should be
-  added at virtio-user PMD side as a startup item.
+  The builtin example does not support dynamic memory allocation. When the
+  vhost backend enables ``builtin-net-driver``, the ``--numa-mem`` option
+  should be added at the virtio-user PMD side as a startup item.
diff --git a/doc/guides/sample_app_ug/vhost_blk.rst b/doc/guides/sample_app_ug/vhost_blk.rst
index 788eef0d5f..aedf146375 100644
--- a/doc/guides/sample_app_ug/vhost_blk.rst
+++ b/doc/guides/sample_app_ug/vhost_blk.rst
@@ -2,37 +2,41 @@
     Copyright(c) 2010-2017 Intel Corporation.
 
 Vhost_blk Sample Application
-=============================
+============================
 
-The vhost_blk sample application implemented a simple block device,
-which used as the  backend of Qemu vhost-user-blk device. Users can extend
-the exist example to use other type of block device(e.g. AIO) besides
-memory based block device. Similar with vhost-user-net device, the sample
-application used domain socket to communicate with Qemu, and the virtio
-ring (split or packed format) was processed by vhost_blk sample application.
+Overview
+--------
 
-The sample application reuse lots codes from SPDK(Storage Performance
-Development Kit, https://github.com/spdk/spdk) vhost-user-blk target,
-for DPDK vhost library used in storage area, user can take SPDK as
-reference as well.
+The vhost_blk sample application implements a simple block device
+used as the backend of a QEMU vhost-user-blk device. Users can extend
+the existing example to use other types of block devices (for example, AIO)
+in addition to memory-based block devices. Similar to the vhost-user-net
+device, the sample application uses a domain socket to communicate with QEMU,
+and the virtio ring (split or packed format) is processed by the vhost_blk
+sample application.
 
-Testing steps
--------------
+The sample application reuses code from SPDK (Storage Performance
+Development Kit, https://github.com/spdk/spdk) vhost-user-blk target.
+For DPDK vhost library use in storage applications, SPDK can also serve
+as a reference.
 
-This section shows the steps how to start a VM with the block device as
-fast data path for critical application.
+This section shows how to start a VM with the block device as a
+fast data path for critical applications.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
-You will also need to build DPDK both on the host and inside the guest
+You need to build DPDK both on the host and inside the guest.
 
-Start the vhost_blk example
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Running the Application
+-----------------------
+
+Start the vhost_blk Example
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
 
@@ -55,11 +59,13 @@ Start the VM
         ...
 
 .. note::
-    You must check whether your Qemu can support "vhost-user-blk" or not,
-    Qemu v4.0 or newer version is required.
-    reconnect=1 means live recovery support that qemu can reconnect vhost_blk
-    after we restart vhost_blk example.
-    packed=on means the device support packed ring but need the guest kernel
-    version >= 5.0.
-    Now Qemu commit 9bb73502321d46f4d320fa17aa38201445783fc4 both support the
+    Verify that your QEMU supports ``vhost-user-blk``. QEMU v4.0 or later
+    is required.
+
+    * ``reconnect=1`` enables live recovery support, allowing QEMU to reconnect
+      to vhost_blk after the vhost_blk example is restarted.
+    * ``packed=on`` enables packed ring support, which requires guest kernel
+      version 5.0 or later.
+
+    QEMU commit 9bb73502321d46f4d320fa17aa38201445783fc4 supports both
     vhost-blk reconnect and packed ring.
diff --git a/doc/guides/sample_app_ug/vhost_crypto.rst b/doc/guides/sample_app_ug/vhost_crypto.rst
index 5c4475342c..0c4ee3f25a 100644
--- a/doc/guides/sample_app_ug/vhost_crypto.rst
+++ b/doc/guides/sample_app_ug/vhost_crypto.rst
@@ -4,66 +4,70 @@
 Vhost_Crypto Sample Application
 ===============================
 
-The vhost_crypto sample application implemented a simple Crypto device,
-which used as the  backend of Qemu vhost-user-crypto device. Similar with
-vhost-user-net and vhost-user-scsi device, the sample application used
-domain socket to communicate with Qemu, and the virtio ring was processed
-by vhost_crypto sample application.
+Overview
+--------
 
-Testing steps
--------------
+The vhost_crypto sample application implements a crypto device used
+as the backend of a QEMU vhost-user-crypto device. Similar to the
+vhost-user-net and vhost-user-scsi devices, the sample application uses a
+domain socket to communicate with QEMU, and the virtio ring is processed
+by the vhost_crypto sample application.
 
-This section shows the steps how to start a VM with the crypto device as
-fast data path for critical application.
+This section shows how to start a VM with the crypto device as a
+fast data path for critical applications.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``examples`` sub-directory.
 
-Start the vhost_crypto example
+Running the Application
+-----------------------
+
+Start the vhost_crypto Example
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. code-block:: console
 
     ./dpdk-vhost_crypto [EAL options] --
-    		--config (lcore,cdev-id,queue-id)[,(lcore,cdev-id,queue-id)]
-    		--socket-file lcore,PATH
-    		[--zero-copy]
-    		[--guest-polling]
-    		[--asymmetric-crypto]
-
-where,
-
-* config (lcore,cdev-id,queue-id): build the lcore-cryptodev id-queue id
-  connection. Once specified, the specified lcore will only work with
-  specified cryptodev's queue.
-
-* socket-file lcore,PATH: the path of UNIX socket file to be created and
-  the lcore id that will deal with the all workloads of the socket. Multiple
-  instances of this config item is supported and one lcore supports processing
-  multiple sockets.
-
-* zero-copy: the presence of this item means the ZERO-COPY feature will be
-  enabled. Otherwise it is disabled. PLEASE NOTE the ZERO-COPY feature is still
-  in experimental stage and may cause the problem like segmentation fault. If
-  the user wants to use LKCF in the guest, this feature shall be turned off.
-
-* guest-polling: the presence of this item means the application assumes the
-  guest works in polling mode, thus will NOT notify the guest completion of
-  processing.
-
-* asymmetric-crypto: the presence of this item means
-  the application can handle the asymmetric crypto requests.
-  When this option is used,
-  symmetric crypto requests can not be handled by the application.
+            --config (lcore,cdev-id,queue-id)[,(lcore,cdev-id,queue-id)]
+            --socket-file lcore,PATH
+            [--zero-copy]
+            [--guest-polling]
+            [--asymmetric-crypto]
+
+where:
+
+**--config (lcore,cdev-id,queue-id)**
+    Builds the lcore-cryptodev-queue connection. When specified, the lcore
+    works only with the specified cryptodev's queue.
+
+**--socket-file lcore,PATH**
+    Specifies the path of the UNIX socket file to be created and the lcore
+    that handles all workloads for the socket. Multiple instances of this
+    option are supported, and one lcore can process multiple sockets.
+
+**--zero-copy**
+    Enables the zero-copy feature when present. Otherwise, zero-copy is
+    disabled. Note that the zero-copy feature is experimental and may cause
+    problems such as segmentation faults. If the user wants to use LKCF in
+    the guest, this feature should be disabled.
+
+**--guest-polling**
+    When present, the application assumes the guest works in polling mode
+    and does not notify the guest of processing completion.
+
+**--asymmetric-crypto**
+    When present, the application can handle asymmetric crypto requests.
+    When this option is used, symmetric crypto requests cannot be handled
+    by the application.
 
 The application requires that crypto devices capable of performing
-the specified crypto operation are available on application initialization.
-This means that HW crypto device/s must be bound to a DPDK driver or
-a SW crypto device/s (virtual crypto PMD) must be created (using --vdev).
+the specified crypto operation are available at initialization.
+This means that hardware crypto devices must be bound to a DPDK driver or
+software crypto devices (virtual crypto PMD) must be created using --vdev.
 
 .. _vhost_crypto_app_run_vm:
 
@@ -83,4 +87,4 @@ Start the VM
         ...
 
 .. note::
-    You must check whether your Qemu can support "vhost-user-crypto" or not.
+    Verify that your QEMU supports ``vhost-user-crypto``.
-- 
2.51.0

