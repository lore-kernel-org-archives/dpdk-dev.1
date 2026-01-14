Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D49D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A70940E4F;
	Wed, 14 Jan 2026 23:25:17 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id D3D8B40E4F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:15 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso519125e9.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429515;
 x=1769034315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6Q2Mveh8AdXryZbPjFgvgkigAxl3tgXTtY2E6aiPvQ=;
 b=m3d5tYUkZi+EGQD3tLSxk/JaB/KZgmAdf8mZp2nJDyeEh6/ZlJW86YftYtk+9QdhYn
 v0X8QBLQd+WAUsiWjft9XRMVx+n5rTvCiBlObMqSL+y8R7BQl7TGz4T2pYI2vx5wmwIR
 +6p24b1RNHxw5yb/hPun14+AGa6uZrV+4onXsoZHJXYyII2v/WdKx08woGo7Wb7BLmfe
 Ts09aDmxX/lyTxuvNDPS4fWA6m67Qu8hA5yXywWjTLkmnCldlR/MBHJE8FOpxBozbjVU
 UOE+zwGy+SzAIRDiR68zeF8oMKpvTqh8RZ5WpKOfX9Sl6rcuehNNY5Pg0zudFYh1qwHL
 PRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429515; x=1769034315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6Q2Mveh8AdXryZbPjFgvgkigAxl3tgXTtY2E6aiPvQ=;
 b=TXbQPUwUgfOE2VoFpH3u/zR9OO4u4MOfivCsntr3ipZ8iGNn2O0IxlC4vhuLB1zyBz
 Jfam1qRlJdxhhKXhDsKmwDOlU/U2idzW2EPLVoh+Fo8KEc3rxzRl1zd4FXIwck0xdC1W
 Qp1OzoTMawzWhwAlpZIvS1BSrkjXIiODgnt335IJTmybKhlhIrUIOu14Gk+knYxexywV
 +/6axnX4R4zsNnEDTFiPCaoBsX7TdhssuZYRTelXmBARwW0rTeRPHhLpJuIee6zMGYSz
 WNrcYWJTqzhPbUjDfzwJ5pt5oPkt5m6DtFZbMuR5FmAWZow9+kUOyShtmn0xaTfUXwxQ
 e4sg==
X-Gm-Message-State: AOJu0Yyg83g0GalQUrq1n+YXvBeUlSWe7hJWAi1y/jWPj7wsd6UDhXrA
 xEFwb8fhjCUCixHkOFPuvHqOo97ptZ1eYJ7RR6wplnI990di/dNmC+sHuHoFry7H3f4jPMizwq8
 4nzn5igM=
X-Gm-Gg: AY/fxX7S3fptcoAHosYhiOFAD2MljYXdm0VtVJtmVAAEs9tL8rnt1rmYzqhNqXWPti3
 qt/ltWWbkwAyeJDXBG+jv5qbvXxCbnXxcpMiXMDHikcDmCmP4+ezi9Sbi0tFdcw9qwnlWM4vvw6
 XJh5A438E0sKdhwHng14Q06mML6NFzr/BjOBZKVO/YmNAEXux46qrb51h+3o4gQipoYh6fPqpo4
 Ctx29bESADRnq6BSL2dCsJvo/Ij8oQYJZxRK7oEAptP6DbbwiFuFY4HMp1MK7Bq6d95nooM7dG3
 0jeJbcURHRrrWNkU4cgTUZEF6IdT1aLzDq4B3hOULDfC6FySGBUKQYICbiHaDH2RlZxHgOMOR8z
 uQW9jFx1oO1hd4JCvmSC+R+LghHq2k8emWjTmCQp9SKzR5idaJ2zD6NLMhP/FT2CSPngR8rnsQX
 7oLh2bcJM6VXPDLpKeJY/49pw77DzUCMmimoz3xZ6Y6dWrm57rug==
X-Received: by 2002:a7b:c3d7:0:b0:47d:87ac:73ef with SMTP id
 5b1f17b1804b1-47f42902e49mr6484285e9.13.1768429515121; 
 Wed, 14 Jan 2026 14:25:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 07/29] doc/guides: improve VMDq sample application
 documentation
Date: Wed, 14 Jan 2026 14:21:48 -0800
Message-ID: <20260114222458.87119-8-stephen@networkplumber.org>
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

Revise VMDq and VMDq/DCB Forwarding sample documentation for clarity,
accuracy, and compliance with technical writing standards.

Common changes to both files:
- Add technology overview sections explaining VMDq hardware packet sorting
- Fix contradictory statements about command-line options
- Create dedicated Command-Line Options sections
- Add Supported Configurations sections for hardware details
- Improve sentence structure and readability
- Fix RST formatting issues
- Convert warnings to RST note directives

vmdq_forwarding.rst:
- Update application name from vmdq_app to dpdk-vmdq

vmdq_dcb_forwarding.rst:
- Add DCB/QoS explanation using VLAN user priority fields
- Correct typo: "VMD queues" -> "VMDq queues"
- Correct capitalization: "linux" -> "Linux"
- Add sub-headings for traffic class and MAC address sections

The technology context is based on Intel's VMDq Technology paper and
helps readers understand hardware-based packet classification benefits
in virtualized environments.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../sample_app_ug/vmdq_dcb_forwarding.rst     | 193 +++++++++++-------
 doc/guides/sample_app_ug/vmdq_forwarding.rst  | 144 +++++++------
 2 files changed, 207 insertions(+), 130 deletions(-)

diff --git a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
index efb133c11c..9d01901f0c 100644
--- a/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
@@ -1,150 +1,197 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-VMDQ and DCB Forwarding Sample Application
+VMDq and DCB Forwarding Sample Application
 ==========================================
 
-The VMDQ and DCB Forwarding sample application is a simple example of packet processing using the DPDK.
-The application performs L2 forwarding using VMDQ and DCB to divide the incoming traffic into queues.
-The traffic splitting is performed in hardware by the VMDQ and DCB features of the Intel® 82599 and X710/XL710 Ethernet Controllers.
+The VMDq and DCB Forwarding sample application demonstrates packet processing using the DPDK.
+The application performs L2 forwarding using Intel VMDq (Virtual Machine Device Queues) combined
+with DCB (Data Center Bridging) to divide incoming traffic into queues. The traffic splitting
+is performed in hardware by the VMDq and DCB features of Intel 82599 and X710/XL710
+Ethernet Controllers.
 
 Overview
 --------
 
-This sample application can be used as a starting point for developing a new application that is based on the DPDK and
-uses VMDQ and DCB for traffic partitioning.
+This sample application can serve as a starting point for developing DPDK applications
+that use VMDq and DCB for traffic partitioning.
 
-The VMDQ and DCB filters work on MAC and VLAN traffic to divide the traffic into input queues on the basis of the Destination MAC
-address, VLAN ID and VLAN user priority fields.
-VMDQ filters split the traffic into 16 or 32 groups based on the Destination MAC and VLAN ID.
-Then, DCB places each packet into one of queues within that group, based upon the VLAN user priority field.
+About VMDq and DCB Technology
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-All traffic is read from a single incoming port (port 0) and output on port 1, without any processing being performed.
-With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
-multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
+VMDq is a silicon-level technology that offloads network I/O packet sorting from the
+Virtual Machine Monitor (VMM) to the network controller hardware. This reduces CPU
+overhead in virtualized environments by performing Layer 2 classification in hardware.
 
-As supplied, the sample application configures the VMDQ feature to have 32 pools with 4 queues each as indicated in :numref:`figure_vmdq_dcb_example`.
-The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 8 queues. While the
-Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDQ pools of 4 or 8 queues each. For simplicity, only 16
-or 32 pools is supported in this sample. And queues numbers for each VMDQ pool can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM
-in config/rte_config.h file.
-The nb-pools, nb-tcs and enable-rss parameters can be passed on the command line, after the EAL parameters:
+DCB (Data Center Bridging) extends VMDq by adding Quality of Service (QoS) support.
+DCB uses the VLAN user priority field (also called Priority Code Point or PCP) to
+classify packets into different traffic classes, enabling bandwidth allocation and
+priority-based queuing.
 
-.. code-block:: console
+How VMDq and DCB Filtering Works
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The VMDq and DCB filters work together on MAC and VLAN traffic to divide packets into
+input queues:
+
+1. **VMDq filtering**: Splits traffic into 16 or 32 groups based on the destination
+   MAC address and VLAN ID.
+
+2. **DCB classification**: Places each packet into one of the queues within its VMDq
+   group based on the VLAN user priority field.
 
-    ./<build_dir>/examples/dpdk-vmdq_dcb [EAL options] -- -p PORTMASK --nb-pools NP --nb-tcs TC --enable-rss
+All traffic is read from a single incoming port (port 0) and output on port 1 without
+modification. For the Intel 82599 NIC, traffic is split into 128 queues on input.
+Each application thread reads from multiple queues. When running with 8 threads
+(using the ``-c FF`` option), each thread receives and forwards packets from 16 queues.
 
-where, NP can be 16 or 32, TC can be 4 or 8, rss is disabled by default.
+:numref:`figure_vmdq_dcb_example` illustrates the packet flow through the application.
 
 .. _figure_vmdq_dcb_example:
 
 .. figure:: img/vmdq_dcb_example.*
 
-   Packet Flow Through the VMDQ and DCB Sample Application
+   Packet Flow Through the VMDq and DCB Sample Application
 
+Supported Configurations
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-In Linux* user space, the application can display statistics with the number of packets received on each queue.
-To have the application display the statistics, send a SIGHUP signal to the running application process.
+The sample application supports the following configurations:
 
-The VMDQ and DCB Forwarding sample application is in many ways simpler than the L2 Forwarding application
-(see :doc:`l2_forward_real_virtual`)
-as it performs unidirectional L2 forwarding of packets from one port to a second port.
-No command-line options are taken by this application apart from the standard EAL command-line options.
+- **Intel 82599 10 Gigabit Ethernet Controller**: 32 pools with 4 queues each (default),
+  or 16 pools with 8 queues each.
+
+- **Intel X710/XL710 Ethernet Controllers**: Multiple configurations of VMDq pools
+  with 4 or 8 queues each. For simplicity, this sample supports only 16 or 32 pools.
+  The number of queues per VMDq pool can be changed by setting
+  ``RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM`` in ``config/rte_config.h``.
 
 .. note::
 
-    Since VMD queues are being used for VMM, this application works correctly
-    when VTd is disabled in the BIOS or Linux* kernel (intel_iommu=off).
+    Since VMDq queues are used for virtual machine management, this application works
+    correctly when VT-d is disabled in the BIOS or Linux kernel (``intel_iommu=off``).
 
 Compiling the Application
 -------------------------
 
-
-
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vmdq_dcb`` sub-directory.
 
 Running the Application
 -----------------------
 
-To run the example in a linux environment:
+To run the example in a Linux environment:
+
+.. code-block:: console
+
+    ./<build_dir>/examples/dpdk-vmdq_dcb -l 0-3 -- -p 0x3 --nb-pools 32 --nb-tcs 4
+
+Command-Line Options
+~~~~~~~~~~~~~~~~~~~~
+
+The following application-specific options are available after the EAL parameters:
+
+``-p PORTMASK``
+    Hexadecimal bitmask of ports to configure.
+
+``--nb-pools NP``
+    Number of VMDq pools. Valid values are 16 or 32.
+
+``--nb-tcs TC``
+    Number of traffic classes. Valid values are 4 or 8.
+
+``--enable-rss``
+    Enable Receive Side Scaling. RSS is disabled by default.
+
+Example:
 
 .. code-block:: console
 
-    user@target:~$ ./<build_dir>/examples/dpdk-vmdq_dcb -l 0-3 -- -p 0x3 --nb-pools 32 --nb-tcs 4
+    ./<build_dir>/examples/dpdk-vmdq_dcb [EAL options] -- -p 0x3 --nb-pools 32 --nb-tcs 4 --enable-rss
 
-Refer to the *DPDK Getting Started Guide* for general information on running applications and
-the Environment Abstraction Layer (EAL) options.
+Refer to the *DPDK Getting Started Guide* for general information on running applications
+and the Environment Abstraction Layer (EAL) options.
 
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
+The following sections explain the code structure.
 
 Initialization
 ~~~~~~~~~~~~~~
 
-The EAL, driver and PCI configuration is performed largely as in the L2 Forwarding sample application,
-as is the creation of the mbuf pool.
-See :doc:`l2_forward_real_virtual`.
-Where this example application differs is in the configuration of the NIC port for RX.
+The EAL, driver, and PCI configuration is performed similarly to the L2 Forwarding sample
+application, as is the creation of the mbuf pool. See :doc:`l2_forward_real_virtual` for details.
+
+This example application differs in the configuration of the NIC port for RX. The VMDq and
+DCB hardware features are configured at port initialization time by setting appropriate values
+in the ``rte_eth_conf`` structure passed to the ``rte_eth_dev_configure()`` API.
 
-The VMDQ and DCB hardware feature is configured at port initialization time by setting the appropriate values in the
-rte_eth_conf structure passed to the rte_eth_dev_configure() API.
-Initially in the application,
-a default structure is provided for VMDQ and DCB configuration to be filled in later by the application.
+Initially, the application provides a default structure for VMDq and DCB configuration:
 
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
     :language: c
     :start-after: Empty vmdq+dcb configuration structure. Filled in programmatically. 8<
     :end-before: >8 End of empty vmdq+dcb configuration structure.
 
-The get_eth_conf() function fills in an rte_eth_conf structure with the appropriate values,
-based on the global vlan_tags array,
-and dividing up the possible user priority values equally among the individual queues
-(also referred to as traffic classes) within each pool. With Intel® 82599 NIC,
-if the number of pools is 32, then the user priority fields are allocated 2 to a queue.
-If 16 pools are used, then each of the 8 user priority fields is allocated to its own queue within the pool.
-With Intel® X710/XL710 NICs, if number of tcs is 4, and number of queues in pool is 8,
-then the user priority fields are allocated 2 to one tc, and a tc has 2 queues mapping to it, then
-RSS will determine the destination queue in 2.
-For the VLAN IDs, each one can be allocated to possibly multiple pools of queues,
-so the pools parameter in the rte_eth_vmdq_dcb_conf structure is specified as a bitmask value.
-For destination MAC, each VMDQ pool will be assigned with a MAC address. In this sample, each VMDQ pool
-is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, that is,
-the MAC of VMDQ pool 2 on port 1 is 52:54:00:12:01:02.
+Traffic Class and Queue Assignment
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``get_eth_conf()`` function fills in the ``rte_eth_conf`` structure with appropriate
+values based on the global ``vlan_tags`` array. The function divides user priority values
+among individual queues (traffic classes) within each pool.
+
+For Intel 82599 NICs:
+
+- With 32 pools: User priority fields are allocated 2 per queue.
+- With 16 pools: Each of the 8 user priority fields is allocated to its own queue.
+
+For Intel X710/XL710 NICs:
+
+- With 4 traffic classes and 8 queues per pool: User priority fields are allocated
+  2 per traffic class, with 2 queues mapped to each traffic class. RSS determines
+  the destination queue within each traffic class.
+
+For VLAN IDs, each ID can be allocated to multiple pools of queues, so the ``pools``
+parameter in the ``rte_eth_vmdq_dcb_conf`` structure is specified as a bitmask.
 
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
     :language: c
     :start-after: Dividing up the possible user priority values. 8<
     :end-before: >8 End of dividing up the possible user priority values.
 
+MAC Address Assignment
+^^^^^^^^^^^^^^^^^^^^^^
+
+Each VMDq pool is assigned a MAC address using the format ``52:54:00:12:<port_id>:<pool_id>``.
+For example, VMDq pool 2 on port 1 uses the MAC address ``52:54:00:12:01:02``.
+
 .. literalinclude:: ../../../examples/vmdq_dcb/main.c
     :language: c
     :start-after: Set mac for each pool. 8<
     :end-before: >8 End of set mac for each pool.
     :dedent: 1
 
-Once the network port has been initialized using the correct VMDQ and DCB values,
-the initialization of the port's RX and TX hardware rings is performed similarly to that
-in the L2 Forwarding sample application.
+After the network port is initialized with VMDq and DCB values, the port's RX and TX
+hardware rings are initialized similarly to the L2 Forwarding sample application.
 See :doc:`l2_forward_real_virtual` for more information.
 
 Statistics Display
 ~~~~~~~~~~~~~~~~~~
 
-When run in a linux environment,
-the VMDQ and DCB Forwarding sample application can display statistics showing the number of packets read from each RX queue.
-This is provided by way of a signal handler for the SIGHUP signal,
-which simply prints to standard output the packet counts in grid form.
-Each row of the output is a single pool with the columns being the queue number within that pool.
+When running in a Linux environment, the application can display statistics showing the
+number of packets read from each RX queue. The application uses a signal handler for the
+SIGHUP signal that prints packet counts in grid form, with each row representing a single
+pool and each column representing a queue number within that pool.
 
-To generate the statistics output, use the following command:
+To generate the statistics output:
 
 .. code-block:: console
 
-    user@host$ sudo killall -HUP vmdq_dcb_app
+    sudo killall -HUP dpdk-vmdq_dcb
+
+.. note::
 
-Please note that the statistics output will appear on the terminal where the vmdq_dcb_app is running,
-rather than the terminal from which the HUP signal was sent.
+    The statistics output appears on the terminal where the application is running,
+    not on the terminal from which the HUP signal was sent.
diff --git a/doc/guides/sample_app_ug/vmdq_forwarding.rst b/doc/guides/sample_app_ug/vmdq_forwarding.rst
index c998a5a223..f100d965cd 100644
--- a/doc/guides/sample_app_ug/vmdq_forwarding.rst
+++ b/doc/guides/sample_app_ug/vmdq_forwarding.rst
@@ -2,50 +2,60 @@
     Copyright(c) 2020 Intel Corporation.
 
 VMDq Forwarding Sample Application
-==========================================
+==================================
 
-The VMDq Forwarding sample application is a simple example of packet processing using the DPDK.
-The application performs L2 forwarding using VMDq to divide the incoming traffic into queues.
-The traffic splitting is performed in hardware by the VMDq feature of the Intel® 82599 and X710/XL710 Ethernet Controllers.
+The VMDq Forwarding sample application demonstrates packet processing using the DPDK.
+The application performs L2 forwarding using Intel VMDq (Virtual Machine Device Queues)
+to divide incoming traffic into queues. The traffic splitting is performed in hardware
+by the VMDq feature of Intel 82599 and X710/XL710 Ethernet Controllers.
 
 Overview
 --------
 
-This sample application can be used as a starting point for developing a new application that is based on the DPDK and
-uses VMDq for traffic partitioning.
+This sample application can serve as a starting point for developing DPDK applications
+that use VMDq for traffic partitioning.
 
-VMDq filters split the incoming packets up into different "pools" - each with its own set of RX queues - based upon
-the MAC address and VLAN ID within the VLAN tag of the packet.
+About VMDq Technology
+~~~~~~~~~~~~~~~~~~~~~
 
-All traffic is read from a single incoming port and output on another port, without any processing being performed.
-With Intel® 82599 NIC, for example, the traffic is split into 128 queues on input, where each thread of the application reads from
-multiple queues. When run with 8 threads, that is, with the -c FF option, each thread receives and forwards packets from 16 queues.
+VMDq is a silicon-level technology designed to improve network I/O performance in
+virtualized environments. In traditional virtualized systems, the Virtual Machine Monitor
+(VMM) must sort incoming packets and route them to the correct virtual machine, consuming
+significant CPU cycles. VMDq offloads this packet sorting to the network controller hardware,
+freeing CPU resources for application workloads.
 
-As supplied, the sample application configures the VMDq feature to have 32 pools with 4 queues each.
-The Intel® 82599 10 Gigabit Ethernet Controller NIC also supports the splitting of traffic into 16 pools of 2 queues.
-While the Intel® X710 or XL710 Ethernet Controller NICs support many configurations of VMDq pools of 4 or 8 queues each.
-And queues numbers for each VMDq pool can be changed by setting RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM
-in config/rte_config.h file.
-The nb-pools and enable-rss parameters can be passed on the command line, after the EAL parameters:
+When packets arrive at a VMDq-enabled network adapter, a Layer 2 classifier in the controller
+sorts packets based on MAC addresses and VLAN tags, then places each packet in the receive
+queue assigned to the appropriate destination. This hardware-based pre-sorting reduces the
+overhead of software-based virtual switches.
 
-.. code-block:: console
+How VMDq Filtering Works
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+VMDq filters split incoming packets into different pools, each with its own set of RX queues,
+based on the MAC address and VLAN ID within the VLAN tag of the packet.
 
-    ./<build_dir>/examples/dpdk-vmdq [EAL options] -- -p PORTMASK --nb-pools NP --enable-rss
+All traffic is read from a single incoming port and output on another port without modification.
+For the Intel 82599 NIC, traffic is split into 128 queues on input. Each application thread
+reads from multiple queues. When running with 8 threads (using the ``-c FF`` option), each
+thread receives and forwards packets from 16 queues.
 
-where, NP can be 8, 16 or 32, rss is disabled by default.
+Supported Configurations
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-In Linux* user space, the application can display statistics with the number of packets received on each queue.
-To have the application display the statistics, send a SIGHUP signal to the running application process.
+The sample application supports the following configurations:
 
-The VMDq Forwarding sample application is in many ways simpler than the L2 Forwarding application
-(see :doc:`l2_forward_real_virtual`)
-as it performs unidirectional L2 forwarding of packets from one port to a second port.
-No command-line options are taken by this application apart from the standard EAL command-line options.
+- **Intel 82599 10 Gigabit Ethernet Controller**: 32 pools with 4 queues each (default),
+  or 16 pools with 2 queues each.
+
+- **Intel X710/XL710 Ethernet Controllers**: Multiple configurations of VMDq pools
+  with 4 or 8 queues each. The number of queues per VMDq pool can be changed by setting
+  ``RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM`` in ``config/rte_config.h``.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``vmdq`` sub-directory.
 
@@ -56,40 +66,60 @@ To run the example in a Linux environment:
 
 .. code-block:: console
 
-    user@target:~$ ./<build_dir>/examples/dpdk-vmdq -l 0-3 -- -p 0x3 --nb-pools 16
+    ./<build_dir>/examples/dpdk-vmdq -l 0-3 -- -p 0x3 --nb-pools 16
+
+Command-Line Options
+~~~~~~~~~~~~~~~~~~~~
+
+The following application-specific options are available after the EAL parameters:
+
+``-p PORTMASK``
+    Hexadecimal bitmask of ports to configure.
+
+``--nb-pools NP``
+    Number of VMDq pools. Valid values are 8, 16, or 32.
+
+``--enable-rss``
+    Enable Receive Side Scaling. RSS is disabled by default.
 
-Refer to the *DPDK Getting Started Guide* for general information on running applications and
-the Environment Abstraction Layer (EAL) options.
+Example:
+
+.. code-block:: console
+
+    ./<build_dir>/examples/dpdk-vmdq [EAL options] -- -p 0x3 --nb-pools 32 --enable-rss
+
+Refer to the *DPDK Getting Started Guide* for general information on running applications
+and the Environment Abstraction Layer (EAL) options.
 
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
+The following sections explain the code structure.
 
 Initialization
 ~~~~~~~~~~~~~~
 
-The EAL, driver and PCI configuration is performed largely as in the L2 Forwarding sample application,
-as is the creation of the mbuf pool.
-See :doc:`l2_forward_real_virtual`.
-Where this example application differs is in the configuration of the NIC port for RX.
+The EAL, driver, and PCI configuration is performed similarly to the L2 Forwarding sample
+application, as is the creation of the mbuf pool. See :doc:`l2_forward_real_virtual` for details.
 
-The VMDq hardware feature is configured at port initialization time by setting the appropriate values in the
-rte_eth_conf structure passed to the rte_eth_dev_configure() API.
-Initially in the application,
-a default structure is provided for VMDq configuration to be filled in later by the application.
+This example application differs in the configuration of the NIC port for RX. The VMDq
+hardware feature is configured at port initialization time by setting appropriate values
+in the ``rte_eth_conf`` structure passed to the ``rte_eth_dev_configure()`` API.
+
+Initially, the application provides a default structure for VMDq configuration:
 
 .. literalinclude:: ../../../examples/vmdq/main.c
     :language: c
     :start-after: Default structure for VMDq. 8<
     :end-before: >8 End of Empty vdmq configuration structure.
 
-The get_eth_conf() function fills in an rte_eth_conf structure with the appropriate values,
-based on the global vlan_tags array.
-For the VLAN IDs, each one can be allocated to possibly multiple pools of queues.
-For destination MAC, each VMDq pool will be assigned with a MAC address. In this sample, each VMDq pool
-is assigned to the MAC like 52:54:00:12:<port_id>:<pool_id>, that is,
-the MAC of VMDq pool 2 on port 1 is 52:54:00:12:01:02.
+The ``get_eth_conf()`` function fills in the ``rte_eth_conf`` structure with appropriate
+values based on the global ``vlan_tags`` array. Each VLAN ID can be allocated to multiple
+pools of queues.
+
+For destination MAC addresses, each VMDq pool is assigned a MAC address using the format
+``52:54:00:12:<port_id>:<pool_id>``. For example, VMDq pool 2 on port 1 uses the MAC address
+``52:54:00:12:01:02``.
 
 .. literalinclude:: ../../../examples/vmdq/main.c
     :language: c
@@ -106,25 +136,25 @@ the MAC of VMDq pool 2 on port 1 is 52:54:00:12:01:02.
     :start-after: Building correct configuration for vdmq. 8<
     :end-before: >8 End of get_eth_conf.
 
-Once the network port has been initialized using the correct VMDq values,
-the initialization of the port's RX and TX hardware rings is performed similarly to that
-in the L2 Forwarding sample application.
+After the network port is initialized with VMDq values, the port's RX and TX hardware rings
+are initialized similarly to the L2 Forwarding sample application.
 See :doc:`l2_forward_real_virtual` for more information.
 
 Statistics Display
 ~~~~~~~~~~~~~~~~~~
 
-When run in a Linux environment,
-the VMDq Forwarding sample application can display statistics showing the number of packets read from each RX queue.
-This is provided by way of a signal handler for the SIGHUP signal,
-which simply prints to standard output the packet counts in grid form.
-Each row of the output is a single pool with the columns being the queue number within that pool.
+When running in a Linux environment, the application can display statistics showing the
+number of packets read from each RX queue. The application uses a signal handler for the
+SIGHUP signal that prints packet counts in grid form, with each row representing a single
+pool and each column representing a queue number within that pool.
 
-To generate the statistics output, use the following command:
+To generate the statistics output:
 
 .. code-block:: console
 
-    user@host$ sudo killall -HUP vmdq_app
+    sudo killall -HUP dpdk-vmdq
+
+.. note::
 
-Please note that the statistics output will appear on the terminal where the vmdq_app is running,
-rather than the terminal from which the HUP signal was sent.
+    The statistics output appears on the terminal where the application is running,
+    not on the terminal from which the HUP signal was sent.
-- 
2.51.0

