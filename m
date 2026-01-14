Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA9D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:28:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3AA84027D;
	Wed, 14 Jan 2026 23:28:30 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 4F77A4027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:28:29 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ed9b04365so2168155e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429709;
 x=1769034509; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pyNwauDCmqO1IvrqAuVXyQk61vTLpFmiyUTHIbMctYs=;
 b=fLFu5SJgVk5a0K3M65Z3Ex7rW1Qqc3aUhjebDN+7pcs5QbWiStaAN9j+vwuDdGWHoc
 AgGk4n90cUpnm2wa9+d7uP4v7DwCBKr6Hg67KpwPUGdsoQ50/FeYoZurtZYd2msccGbX
 hjiLWleAhrP2K4KVyVptGXLxK0UwyfJcoEZADoxxk8yMIVBP0RWeyhsO48Fngb9rE+qp
 6I3Wp24mpt9rtwW5vh9CcOBovFS6hFrcJM39HpB2E6kzCc/mm+S6gy20XLmKKWACb+EF
 17sGhEkB6OoIP9HrWOZJZU/KPOn4WS3mDm1xvMto4oQHy/sK3W0hr2d0conAjiCkwG04
 /0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429709; x=1769034509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pyNwauDCmqO1IvrqAuVXyQk61vTLpFmiyUTHIbMctYs=;
 b=FuF0OKjY3jSBBj8GYQm7C75Op17h/4CQcduoeJylbqxHyHSzXMry7yZix9/60iogAH
 YhMgQRM2KwE+T9nMhG43zOw0eP7aT968bvPr2TxxYEpU8gA2P8HzBKkR3cT8TLR/oa1u
 5CrsKH+wIZneMKxrv7BoCIx/HqrsEd/6T/A96b1+qVrm9PCWj/8iNpYfAMGPr8f1Ovu8
 3kts9qfQA6m5S/u0Bbnl4S+wwsG4DgIDpkrWp9d6lkFfCaxO4rB/4simS0ScnW6/pbeV
 HsKePZZ9Bp5w87ysIcOeMSgoof9gxIcay3u0HndfHj0lLG2bJI7AMYYWJTdCmo1CRhxd
 ryzw==
X-Gm-Message-State: AOJu0YwCQIMMCLensEU5F8lHGCflmE2/tm5bY7I3uwvz7zCfDwNUa4Wx
 mwMrC731gaqyHrJDqkSKUvNM0es6+sm9SnJwWBHgBgN+JPr30gAode/8pgMbi8plRX3gBbfWsQ0
 H4/Y/
X-Gm-Gg: AY/fxX5bf8bYnPKV65sMnw0S5earnuiyAzfaH74aQrdiQegGW0w0q6Cxx3I+U4L89D6
 PRuZlvpzPj/tqcP9WWA4J60aDWnk4fp4nl4/0Jn97ZfHpoQT7Kf+oG0n6lF0KrXSSJ1jp/GmIga
 KRSXwBcwBRRjJSh1ylxugRod7JFL8FJ9Dsnq2NL2lAhAmqsjB5qffau4QIu/D0YhAphaOnGsAjK
 FW9MQXkhNvWMMcc+j5cc0xRF70WXMpALRm4Bxbp5JTvMjy9A2gpD05RCk+eqwC/jd9GnvL4N3/+
 kRefMf5tsoE5PbXP39UvEqrvXw4CIkFFvOXhh0VJWdor0KrDjwEn8UmskesgWMLlmgf7OJp1H6V
 MmKnapENq2ab68zdHohEP7yTJBG+Fm5Wd6joTZQQJBlnkhAPsoziBA3BdKCbCHPkZuu9c4XOVCj
 eCyKiJDHMcAA/wNQ9PI5Duh1HCQH8umBshqZYTC77yLxtJ08+sfw==
X-Received: by 2002:a05:600c:1383:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-47ee3356543mr44466495e9.24.1768429708297; 
 Wed, 14 Jan 2026 14:28:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653632sm1757198f8f.11.2026.01.14.14.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:28:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v4 01/11] doc: correct grammar and punctuation errors in
 ethdev guide
Date: Wed, 14 Jan 2026 14:26:53 -0800
Message-ID: <20260114222821.87920-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222821.87920-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260114222821.87920-1-stephen@networkplumber.org>
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

Fix various grammar, punctuation, and typographical errors throughout
the Poll Mode Driver documentation.

- Fix extra spaces after emphasized terms
  (*run-to-completion*, *pipe-line*)
- Correct possessive forms
   ("port's" -> "ports'", "processors" -> "processor's")
- Fix subject-verb agreement ("VFs detects" -> "VFs detect")
- Add missing articles and words ("It is duty" -> "It is the duty",
  "allows the application create" -> "allows the application to create")
- Remove extraneous words ("release of all" -> "release all",
  "ensures sure" -> "ensures")
- Fix typos ("dev_unint()" -> "dev_uninit()", "receive of transmit" ->
  "receive or transmit", "UDP/TCP/ SCTP" -> "UDP/TCP/SCTP")
- Add missing punctuation (period at end of bullet point)
- Fix spacing around inline code markup
- Clarify awkward sentence about PROACTIVE vs PASSIVE error

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/ethdev.rst | 557 ++++++++++++------------
 1 file changed, 277 insertions(+), 280 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index daaf43ea3b..31b5e973ae 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -4,126 +4,134 @@
 Poll Mode Driver
 ================
 
-The DPDK includes 1 Gigabit, 10 Gigabit and 40 Gigabit and para virtualized virtio Poll Mode Drivers.
+The Data Plane Development Kit (DPDK) supports a wide range of Ethernet speeds,
+from 10 Megabits to 400 Gigabits, depending on hardware capability.
 
-A Poll Mode Driver (PMD) consists of APIs, provided through the BSD driver running in user space,
-to configure the devices and their respective queues.
-In addition, a PMD accesses the RX and TX descriptors directly without any interrupts
-(with the exception of Link Status Change interrupts) to quickly receive,
-process and deliver packets in the user's application.
-This section describes the requirements of the PMDs,
-their global design principles and proposes a high-level architecture and a generic external API for the Ethernet PMDs.
+DPDK's Poll Mode Drivers (PMDs) are high-performance, optimized drivers for various
+network interface cards that bypass the traditional kernel network stack to reduce
+latency and improve throughput. They access Rx and Tx descriptors directly in a polling
+mode without relying on interrupts (except for Link Status Change notifications), enabling
+efficient packet reception and transmission in user-space applications.
+
+This section outlines the requirements of Ethernet PMDs, their design principles,
+and presents a high-level architecture along with a generic external API.
 
 Requirements and Assumptions
 ----------------------------
 
-The DPDK environment for packet processing applications allows for two models, run-to-completion and pipe-line:
+The DPDK environment for packet processing applications supports two models: run-to-completion and pipeline.
 
-*   In the *run-to-completion*  model, a specific port's RX descriptor ring is polled for packets through an API.
-    Packets are then processed on the same core and placed on a port's TX descriptor ring through an API for transmission.
+*   In the *run-to-completion* model, a specific port's Rx descriptor ring is polled for packets through an API.
+    The application then processes packets on the same core and transmits them via the port's Tx descriptor ring using another API.
 
-*   In the *pipe-line*  model, one core polls one or more port's RX descriptor ring through an API.
-    Packets are received and passed to another core via a ring.
-    The other core continues to process the packet which then may be placed on a port's TX descriptor ring through an API for transmission.
+*   In the *pipeline* model, one core polls the Rx descriptor ring(s) of one or more ports via an API.
+    The application then passes received packets to another core via a ring for further processing,
+    which may include transmission through the Tx descriptor ring using an API.
 
-In a synchronous run-to-completion model,
-each logical core assigned to the DPDK executes a packet processing loop that includes the following steps:
+In a synchronous run-to-completion model, a logical core (lcore)
+assigned to DPDK executes a packet processing loop that includes the following steps:
 
-*   Retrieve input packets through the PMD receive API
+*   Retrieve input packets using the PMD receive API
 
-*   Process each received packet one at a time, up to its forwarding
+*   Process each received packet individually, up to its forwarding
 
-*   Send pending output packets through the PMD transmit API
+*   Transmit output packets using the PMD transmit API
 
-Conversely, in an asynchronous pipe-line model, some logical cores may be dedicated to the retrieval of received packets and
-other logical cores to the processing of previously received packets.
-Received packets are exchanged between logical cores through rings.
-The loop for packet retrieval includes the following steps:
+In contrast, the asynchronous pipeline model assigns some logical cores to retrieve packets
+and others to process them. The application exchanges packets between cores via rings.
+
+The packet retrieval loop includes:
 
 *   Retrieve input packets through the PMD receive API
 
 *   Provide received packets to processing lcores through packet queues
 
-The loop for packet processing includes the following steps:
-
-*   Retrieve the received packet from the packet queue
+The packet processing loop includes:
 
-*   Process the received packet, up to its retransmission if forwarded
+*   Dequeue received packets from the packet queue
 
-To avoid any unnecessary interrupt processing overhead, the execution environment must not use any asynchronous notification mechanisms.
-Whenever needed and appropriate, asynchronous communication should be introduced as much as possible through the use of rings.
+*   Process packets, including retransmission if forwarded
 
-Avoiding lock contention is a key issue in a multi-core environment.
-To address this issue, PMDs are designed to work with per-core private resources as much as possible.
-For example, a PMD maintains a separate transmit queue per-core, per-port, if the PMD is not ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable.
-In the same way, every receive queue of a port is assigned to and polled by a single logical core (lcore).
+To minimize interrupt-related overhead, the execution environment should avoid asynchronous
+notification mechanisms. When asynchronous communication is required, implement it
+using rings where possible. Minimizing lock contention is critical in multi-core environments.
+To support this, PMDs use per-core private resources whenever possible.
+For example, if a PMD does not support ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE``, it maintains a separate
+transmit queue per core and per port. Similarly, each receive queue is assigned to and polled by a single lcore.
 
-To comply with Non-Uniform Memory Access (NUMA), memory management is designed to assign to each logical core
-a private buffer pool in local memory to minimize remote memory access.
-The configuration of packet buffer pools should take into account the underlying physical memory architecture in terms of DIMMS,
-channels and ranks.
-The application must ensure that appropriate parameters are given at memory pool creation time.
+To support Non-Uniform Memory Access (NUMA), the memory management design assigns each logical
+core a private buffer pool in local memory to reduce remote memory access. Configuration of packet
+buffer pools should consider the underlying physical memory layout, such as DIMMs, channels, and ranks.
+The application must set proper parameters during memory pool creation.
 See :doc:`../mempool_lib`.
 
 Design Principles
 -----------------
 
-The API and architecture of the Ethernet* PMDs are designed with the following guidelines in mind.
+The API and architecture of the Ethernet PMDs follow these design principles:
 
-PMDs must help global policy-oriented decisions to be enforced at the upper application level.
-Conversely, NIC PMD functions should not impede the benefits expected by upper-level global policies,
-or worse prevent such policies from being applied.
+PMDs should support the enforcement of global, policy-driven decisions at the upper application level.
+At the same time, NIC PMD functions must not hinder the performance gains expected by these higher-level policies,
+or worse, prevent them from being implemented.
 
-For instance, both the receive and transmit functions of a PMD have a maximum number of packets/descriptors to poll.
-This allows a run-to-completion processing stack to statically fix or
-to dynamically adapt its overall behavior through different global loop policies, such as:
+For example, both the receive and transmit functions of a PMD define a maximum number of packets to poll.
+This enables a run-to-completion processing stack to either statically configure or dynamically adjust its
+behavior according to different global loop strategies, such as:
 
-*   Receive, process immediately and transmit packets one at a time in a piecemeal fashion.
+*   Receiving, processing, and transmitting packets one at a time in a piecemeal fashion
 
-*   Receive as many packets as possible, then process all received packets, transmitting them immediately.
+*   Receiving as many packets as possible, then processing and transmitting them all immediately
 
-*   Receive a given maximum number of packets, process the received packets, accumulate them and finally send all accumulated packets to transmit.
+*   Receiving a set number of packets, processing them, and batching them for transmission at once
 
-To achieve optimal performance, overall software design choices and pure software optimization techniques must be considered and
-balanced against available low-level hardware-based optimization features (CPU cache properties, bus speed, NIC PCI bandwidth, and so on).
-The case of packet transmission is an example of this software/hardware tradeoff issue when optimizing burst-oriented network packet processing engines.
-In the initial case, the PMD could export only an rte_eth_tx_one function to transmit one packet at a time on a given queue.
-On top of that, one can easily build an rte_eth_tx_burst function that loops invoking the rte_eth_tx_one function to transmit several packets at a time.
-However, an rte_eth_tx_burst function is effectively implemented by the PMD to minimize the driver-level transmit cost per packet through the following optimizations:
+To maximize performance, developers must consider overall software architecture and optimization techniques
+alongside available low-level hardware optimizations (e.g., CPU cache behavior, bus speed, and NIC PCI bandwidth).
 
-*   Share among multiple packets the un-amortized cost of invoking the rte_eth_tx_one function.
+Packet transmission in burst-oriented network engines illustrates this software/hardware tradeoff.
+A PMD could expose only the ``rte_eth_tx_one`` function to transmit a single packet at a time on a given queue.
+While it is possible to build an ``rte_eth_tx_burst`` function by repeatedly calling ``rte_eth_tx_one``,
+most PMDs implement ``rte_eth_tx_burst`` directly to reduce per-packet transmission overhead.
 
-*   Enable the rte_eth_tx_burst function to take advantage of burst-oriented hardware features (prefetch data in cache, use of NIC head/tail registers)
-    to minimize the number of CPU cycles per packet, for example by avoiding unnecessary read memory accesses to ring transmit descriptors,
-    or by systematically using arrays of pointers that exactly fit cache line boundaries and sizes.
+This implementation includes several key optimizations:
 
-*   Apply burst-oriented software optimization techniques to remove operations that would otherwise be unavoidable, such as ring index wrap back management.
+*   Sharing the fixed cost of invoking ``rte_eth_tx_one`` across multiple packets
 
-Burst-oriented functions are also introduced via the API for services that are intensively used by the PMD.
-This applies in particular to buffer allocators used to populate NIC rings, which provide functions to allocate/free several buffers at a time.
-For example, an mbuf_multiple_alloc function returning an array of pointers to rte_mbuf buffers which speeds up the receive poll function of the PMD when
-replenishing multiple descriptors of the receive ring.
+*   Leveraging burst-oriented hardware features (e.g., data prefetching, NIC head/tail registers, vector extensions)
+    to reduce CPU cycles per packet, including minimizing unnecessary memory accesses and aligning pointer arrays
+    with cache line boundaries and sizes
+
+*   Applying software-level burst optimizations to eliminate otherwise unavoidable overheads, such as ring index wrap-around handling
+
+The API also introduces burst-oriented functions for PMD-intensive services, such as buffer allocation.
+For instance, buffer allocators used to populate NIC rings often support functions that allocate or free multiple buffers in a single call.
+An example is ``rte_pktmbuf_alloc_bulk``, which returns an array of rte_mbuf pointers, significantly improving PMD performance
+when replenishing multiple descriptors in the receive ring.
 
 Logical Cores, Memory and NIC Queues Relationships
 --------------------------------------------------
 
-The DPDK supports NUMA allowing for better performance when a processor's logical cores and interfaces utilize its local memory.
-Therefore, mbuf allocation associated with local PCIe* interfaces should be allocated from memory pools created in the local memory.
-The buffers should, if possible, remain on the local processor to obtain the best performance results and RX and TX buffer descriptors
-should be populated with mbufs allocated from a mempool allocated from local memory.
+DPDK supports NUMA, which improves performance when a processor's logical cores and network interfaces
+use memory local to that processor. To maximize this benefit, allocate mbufs associated with local PCIe* interfaces
+from memory pools located in the same NUMA node.
+
+Ideally, keep these buffers on the local processor to achieve optimal performance. Populate Rx and Tx buffer
+descriptors with mbufs from mempools created in local memory.
 
-The run-to-completion model also performs better if packet or data manipulation is in local memory instead of a remote processors memory.
-This is also true for the pipe-line model provided all logical cores used are located on the same processor.
+The run-to-completion model also benefits from performing packet data operations in local memory,
+rather than accessing remote memory across NUMA nodes.
+The same applies to the pipeline model, provided all logical cores involved reside on the same processor.
 
-Multiple logical cores should never share receive or transmit queues for interfaces since this would require global locks and hinder performance.
+Never share receive and transmit queues between multiple logical cores, as doing so requires
+global locks and severely impacts performance.
 
-If the PMD is ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable, multiple threads can invoke ``rte_eth_tx_burst()``
-concurrently on the same tx queue without SW lock. This PMD feature found in some NICs and useful in the following use cases:
+If the PMD supports the ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` offload,
+multiple threads can call ``rte_eth_tx_burst()`` concurrently on the same Tx queue without a software lock.
+This capability, available in some NICs, proves advantageous in these scenarios:
 
-*  Remove explicit spinlock in some applications where lcores are not mapped to Tx queues with 1:1 relation.
+*   Eliminating explicit spinlocks in applications where Tx queues do not map 1:1 to logical cores
 
-*  In the eventdev use case, avoid dedicating a separate TX core for transmitting and thus
-   enables more scaling as all workers can send the packets.
+*   In eventdev-based workloads, allowing all worker threads to transmit packets, removing the need for a dedicated
+    Tx core and enabling greater scalability
 
 See `Hardware Offload`_ for ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capability probing details.
 
@@ -133,11 +141,10 @@ Device Identification, Ownership and Configuration
 Device Identification
 ~~~~~~~~~~~~~~~~~~~~~
 
-Each NIC port is uniquely designated by its (bus/bridge, device, function) PCI
-identifiers assigned by the PCI probing/enumeration function executed at DPDK initialization.
-Based on their PCI identifier, NIC ports are assigned two other identifiers:
+The PCI probing/enumeration function executed at DPDK initialization assigns each NIC port a unique PCI
+identifier (bus/bridge, device, function). Based on this PCI identifier, DPDK assigns each NIC port two additional identifiers:
 
-*   A port index used to designate the NIC port in all functions exported by the PMD API.
+*   A port index used to designate the NIC port in all functions exported by the PMD API
 
 *   A port name used to designate the port in console messages, for administration or debugging purposes.
     For ease of use, the port name includes the port index.
@@ -145,83 +152,82 @@ Based on their PCI identifier, NIC ports are assigned two other identifiers:
 Port Ownership
 ~~~~~~~~~~~~~~
 
-The Ethernet devices ports can be owned by a single DPDK entity (application, library, PMD, process, etc).
-The ownership mechanism is controlled by ethdev APIs and allows to set/remove/get a port owner by DPDK entities.
-It prevents Ethernet ports to be managed by different entities.
+A single DPDK entity (application, library, PMD, process, etc.) can own Ethernet device ports.
+The ethdev APIs control the ownership mechanism and allow DPDK entities to set, remove, or get a port owner.
+This prevents different entities from managing the same Ethernet ports.
 
 .. note::
 
-    It is the DPDK entity responsibility to set the port owner before using it and to manage the port usage synchronization between different threads or processes.
+    The DPDK entity must set port ownership before using the port and manage usage synchronization between different threads or processes.
 
-It is recommended to set port ownership early,
-like during the probing notification ``RTE_ETH_EVENT_NEW``.
+Set port ownership early, for instance during the probing notification ``RTE_ETH_EVENT_NEW``.
 
 Device Configuration
 ~~~~~~~~~~~~~~~~~~~~
 
-The configuration of each NIC port includes the following operations:
+Configuring each NIC port includes the following operations:
 
 *   Allocate PCI resources
 
-*   Reset the hardware (issue a Global Reset) to a well-known default state
+*   Reset the hardware to a well-known default state (issue a Global Reset)
 
 *   Set up the PHY and the link
 
 *   Initialize statistics counters
 
-The PMD API must also export functions to start/stop the all-multicast feature of a port and functions to set/unset the port in promiscuous mode.
+The PMD API must also export functions to start/stop the all-multicast feature of a port and functions to set/unset promiscuous mode.
 
-Some hardware offload features must be individually configured at port initialization through specific configuration parameters.
-This is the case for the Receive Side Scaling (RSS) and Data Center Bridging (DCB) features for example.
+Some hardware offload features require individual configuration at port initialization through specific parameters.
+This includes Receive Side Scaling (RSS) and Data Center Bridging (DCB) features.
 
 On-the-Fly Configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-All device features that can be started or stopped "on the fly" (that is, without stopping the device) do not require the PMD API to export dedicated functions for this purpose.
+Device features that can start or stop "on the fly" (without stopping the device) do not require the PMD API to export dedicated functions.
 
-All that is required is the mapping address of the device PCI registers to implement the configuration of these features in specific functions outside of the drivers.
+Implementing the configuration of these features in specific functions outside of the drivers requires only the mapping address of the device PCI registers.
 
 For this purpose,
-the PMD API exports a function that provides all the information associated with a device that can be used to set up a given device feature outside of the driver.
-This includes the PCI vendor identifier, the PCI device identifier, the mapping address of the PCI device registers, and the name of the driver.
+the PMD API exports a function that provides all device information needed to set up a given feature outside of the driver.
+This includes the PCI vendor identifier, the PCI device identifier, the mapping address of the PCI device registers, and the driver name.
 
-The main advantage of this approach is that it gives complete freedom on the choice of the API used to configure, to start, and to stop such features.
+The main advantage of this approach is complete freedom in choosing the API to configure, start, and stop such features.
 
 As an example, refer to the configuration of the IEEE1588 feature for the Intel® 82576 Gigabit Ethernet Controller and
-the Intel® 82599 10 Gigabit Ethernet Controller controllers in the testpmd application.
+the Intel® 82599 10 Gigabit Ethernet Controller in the testpmd application.
 
-Other features such as the L3/L4 5-Tuple packet filtering feature of a port can be configured in the same way.
-Ethernet* flow control (pause frame) can be configured on the individual port.
+Configure other features such as the L3/L4 5-Tuple packet filtering feature of a port in the same way.
+Configure Ethernet* flow control (pause frame) on the individual port.
 Refer to the testpmd source code for details.
-Also, L4 (UDP/TCP/ SCTP) checksum offload by the NIC can be enabled for an individual packet as long as the packet mbuf is set up correctly. See `Hardware Offload`_ for details.
+Also, enable L4 (UDP/TCP/SCTP) checksum offload by the NIC for an individual packet by setting up the packet mbuf correctly. See `Hardware Offload`_ for details.
 
 Configuration of Transmit Queues
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Each transmit queue is independently configured with the following information:
+Configure each transmit queue independently with the following information:
 
 *   The number of descriptors of the transmit ring
 
-*   The socket identifier used to identify the appropriate DMA memory zone from which to allocate the transmit ring in NUMA architectures
+*   The socket identifier used to identify the appropriate DMA memory zone for allocating the transmit ring in NUMA architectures
 
 *   The values of the Prefetch, Host and Write-Back threshold registers of the transmit queue
 
 *   The *minimum* transmit packets to free threshold (tx_free_thresh).
-    When the number of descriptors used to transmit packets exceeds this threshold, the network adaptor should be checked to see if it has written back descriptors.
-    A value of 0 can be passed during the TX queue configuration to indicate the default value should be used.
+    When the number of descriptors used to transmit packets exceeds this threshold, check the network adaptor to see if it has written back descriptors.
+    Pass a value of 0 during Tx queue configuration to use the default value.
     The default value for tx_free_thresh is 32.
-    This ensures that the PMD does not search for completed descriptors until at least 32 have been processed by the NIC for this queue.
+    This ensures the PMD does not search for completed descriptors until the NIC has processed at least 32 for this queue.
 
-*   The *minimum*  RS bit threshold. The minimum number of transmit descriptors to use before setting the Report Status (RS) bit in the transmit descriptor.
+*   The *minimum* RS bit threshold. The minimum number of transmit descriptors to use before setting the Report Status (RS) bit in the transmit descriptor.
     Note that this parameter may only be valid for Intel 10 GbE network adapters.
-    The RS bit is set on the last descriptor used to transmit a packet if the number of descriptors used since the last RS bit setting,
+    Set the RS bit on the last descriptor used to transmit a packet if the number of descriptors used since the last RS bit setting,
     up to the first descriptor used to transmit the packet, exceeds the transmit RS bit threshold (tx_rs_thresh).
-    In short, this parameter controls which transmit descriptors are written back to host memory by the network adapter.
-    A value of 0 can be passed during the TX queue configuration to indicate that the default value should be used.
+    In short, this parameter controls which transmit descriptors the network adapter writes back to host memory.
+    Pass a value of 0 during Tx queue configuration to use the default value.
     The default value for tx_rs_thresh is 32.
-    This ensures that at least 32 descriptors are used before the network adapter writes back the most recently used descriptor.
-    This saves upstream PCIe* bandwidth resulting from TX descriptor write-backs.
-    It is important to note that the TX Write-back threshold (TX wthresh) should be set to 0 when tx_rs_thresh is greater than 1.
+    This ensures the PMD uses at least 32 descriptors before the network adapter writes back the most recently used descriptor.
+    This saves upstream PCIe* bandwidth that would be used for Tx descriptor write-backs.
+    Set the Tx Write-back threshold (Tx wthresh) to 0 when tx_rs_thresh is greater than 1.
     Refer to the Intel® 82599 10 Gigabit Ethernet Controller Datasheet for more details.
 
 The following constraints must be satisfied for tx_free_thresh and tx_rs_thresh:
@@ -236,46 +242,45 @@ The following constraints must be satisfied for tx_free_thresh and tx_rs_thresh:
 
 *   tx_free_thresh must be less than the size of the ring minus 3.
 
-*   For optimal performance, TX wthresh should be set to 0 when tx_rs_thresh is greater than 1.
+*   For optimal performance, set Tx wthresh to 0 when tx_rs_thresh is greater than 1.
 
-One descriptor in the TX ring is used as a sentinel to avoid a hardware race condition, hence the maximum threshold constraints.
+One descriptor in the Tx ring serves as a sentinel to avoid a hardware race condition, hence the maximum threshold constraints.
 
 .. note::
 
-    When configuring for DCB operation, at port initialization, both the number of transmit queues and the number of receive queues must be set to 128.
+    When configuring for DCB operation at port initialization, set both the number of transmit queues and the number of receive queues to 128.
 
 Free Tx mbuf on Demand
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Many of the drivers do not release the mbuf back to the mempool, or local cache,
-immediately after the packet has been transmitted.
+Many drivers do not release the mbuf back to the mempool or local cache immediately after packet transmission.
 Instead, they leave the mbuf in their Tx ring and
 either perform a bulk release when the ``tx_rs_thresh`` has been crossed
 or free the mbuf when a slot in the Tx ring is needed.
 
 An application can request the driver to release used mbufs with the ``rte_eth_tx_done_cleanup()`` API.
-This API requests the driver to release mbufs that are no longer in use,
-independent of whether or not the ``tx_rs_thresh`` has been crossed.
-There are two scenarios when an application may want the mbuf released immediately:
+This API requests the driver to release mbufs no longer in use,
+independent of whether the ``tx_rs_thresh`` has been crossed.
+Two scenarios exist where an application may want the mbuf released immediately:
 
 * When a given packet needs to be sent to multiple destination interfaces
   (either for Layer 2 flooding or Layer 3 multi-cast).
-  One option is to make a copy of the packet or a copy of the header portion that needs to be manipulated.
+  One option is to copy the packet or the header portion that needs manipulation.
   A second option is to transmit the packet and then poll the ``rte_eth_tx_done_cleanup()`` API
-  until the reference count on the packet is decremented.
-  Then the same packet can be transmitted to the next destination interface.
-  The application is still responsible for managing any packet manipulations needed
-  between the different destination interfaces, but a packet copy can be avoided.
-  This API is independent of whether the packet was transmitted or dropped,
+  until the reference count on the packet decrements.
+  Then, transmit the same packet to the next destination interface.
+  The application remains responsible for managing any packet manipulations needed
+  between the different destination interfaces, but avoids a packet copy.
+  This API operates independently of whether the interface transmitted or dropped the packet,
   only that the mbuf is no longer in use by the interface.
 
-* Some applications are designed to make multiple runs, like a packet generator.
+* Some applications make multiple runs, like a packet generator.
   For performance reasons and consistency between runs,
   the application may want to reset back to an initial state
   between each run, where all mbufs are returned to the mempool.
-  In this case, it can call the ``rte_eth_tx_done_cleanup()`` API
-  for each destination interface it has been using
-  to request it to release of all its used mbufs.
+  In this case, call the ``rte_eth_tx_done_cleanup()`` API
+  for each destination interface used
+  to request it to release all used mbufs.
 
 To determine if a driver supports this API, check for the *Free Tx mbuf on demand* feature
 in the *Network Interface Controller Drivers* document.
@@ -285,49 +290,49 @@ Hardware Offload
 
 Depending on driver capabilities advertised by
 ``rte_eth_dev_info_get()``, the PMD may support hardware offloading
-feature like checksumming, TCP segmentation, VLAN insertion or
-lockfree multithreaded TX burst on the same TX queue.
+features like checksumming, TCP segmentation, VLAN insertion, or
+lockfree multithreaded Tx burst on the same Tx queue.
 
-The support of these offload features implies the addition of dedicated
-status bit(s) and value field(s) into the rte_mbuf data structure, along
-with their appropriate handling by the receive/transmit functions
-exported by each PMD. The list of flags and their precise meaning is
-described in the mbuf API documentation and in the :ref:`mbuf_meta` chapter.
+Supporting these offload features requires adding dedicated
+status bit(s) and value field(s) to the rte_mbuf data structure, along
+with appropriate handling by the receive/transmit functions
+exported by each PMD. The mbuf API documentation and the :ref:`mbuf_meta` chapter
+describe the list of flags and their precise meanings.
 
 Per-Port and Per-Queue Offloads
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-In the DPDK offload API, offloads are divided into per-port and per-queue offloads as follows:
+In the DPDK offload API, offloads divide into per-port and per-queue offloads as follows:
 
-* A per-queue offloading can be enabled on a queue and disabled on another queue at the same time.
-* A pure per-port offload is the one supported by device but not per-queue type.
-* A pure per-port offloading can't be enabled on a queue and disabled on another queue at the same time.
-* A pure per-port offloading must be enabled or disabled on all queues at the same time.
-* Any offloading is per-queue or pure per-port type, but can't be both types at same devices.
+* A per-queue offload can be enabled on one queue and disabled on another queue simultaneously.
+* A pure per-port offload is supported by a device but not as a per-queue type.
+* A pure per-port offload cannot be enabled on one queue and disabled on another queue simultaneously.
+* A pure per-port offload must be enabled or disabled on all queues simultaneously.
+* An offload is either per-queue or pure per-port type; it cannot be both types on the same device.
 * Port capabilities = per-queue capabilities + pure per-port capabilities.
-* Any supported offloading can be enabled on all queues.
+* Any supported offload can be enabled on all queues.
 
-The different offloads capabilities can be queried using ``rte_eth_dev_info_get()``.
+Query the different offload capabilities using ``rte_eth_dev_info_get()``.
 The ``dev_info->[rt]x_queue_offload_capa`` returned from ``rte_eth_dev_info_get()`` includes all per-queue offloading capabilities.
 The ``dev_info->[rt]x_offload_capa`` returned from ``rte_eth_dev_info_get()`` includes all pure per-port and per-queue offloading capabilities.
 Supported offloads can be either per-port or per-queue.
 
-Offloads are enabled using the existing ``RTE_ETH_TX_OFFLOAD_*`` or ``RTE_ETH_RX_OFFLOAD_*`` flags.
-Any requested offloading by an application must be within the device capabilities.
-Any offloading is disabled by default if it is not set in the parameter
+Enable offloads using the existing ``RTE_ETH_TX_OFFLOAD_*`` or ``RTE_ETH_RX_OFFLOAD_*`` flags.
+Any offload requested by an application must be within the device capabilities.
+Any offload is disabled by default if it is not set in the parameter
 ``dev_conf->[rt]xmode.offloads`` to ``rte_eth_dev_configure()`` and
 ``[rt]x_conf->offloads`` to ``rte_eth_[rt]x_queue_setup()``.
 
-If any offloading is enabled in ``rte_eth_dev_configure()`` by an application,
-it is enabled on all queues no matter whether it is per-queue or
-per-port type and no matter whether it is set or cleared in
+If an application enables any offload in ``rte_eth_dev_configure()``,
+it is enabled on all queues regardless of whether it is per-queue or
+per-port type and regardless of whether it is set or cleared in
 ``[rt]x_conf->offloads`` to ``rte_eth_[rt]x_queue_setup()``.
 
-If a per-queue offloading hasn't been enabled in ``rte_eth_dev_configure()``,
-it can be enabled or disabled in ``rte_eth_[rt]x_queue_setup()`` for individual queue.
-A newly added offloads in ``[rt]x_conf->offloads`` to ``rte_eth_[rt]x_queue_setup()`` input by application
-is the one which hasn't been enabled in ``rte_eth_dev_configure()`` and is requested to be enabled
-in ``rte_eth_[rt]x_queue_setup()``. It must be per-queue type, otherwise trigger an error log.
+If a per-queue offload has not been enabled in ``rte_eth_dev_configure()``,
+it can be enabled or disabled in ``rte_eth_[rt]x_queue_setup()`` for an individual queue.
+A newly added offload in ``[rt]x_conf->offloads`` to ``rte_eth_[rt]x_queue_setup()`` input by the application
+is one that has not been enabled in ``rte_eth_dev_configure()`` and is requested to be enabled
+in ``rte_eth_[rt]x_queue_setup()``. It must be per-queue type; otherwise an error log triggers.
 
 Poll Mode Driver API
 --------------------
@@ -335,44 +340,43 @@ Poll Mode Driver API
 Generalities
 ~~~~~~~~~~~~
 
-By default, all functions exported by a PMD are lock-free functions that are assumed
-not to be invoked in parallel on different logical cores to work on the same target object.
-For instance, a PMD receive function cannot be invoked in parallel on two logical cores to poll the same RX queue of the same port.
-Of course, this function can be invoked in parallel by different logical cores on different RX queues.
-It is the responsibility of the upper-level application to enforce this rule.
+By default, all functions exported by a PMD are lock-free functions assumed
+not to be invoked in parallel on different logical cores working on the same target object.
+For instance, a PMD receive function cannot be invoked in parallel on two logical cores polling the same Rx queue of the same port.
+This function can be invoked in parallel by different logical cores on different Rx queues.
+The upper-level application must enforce this rule.
 
-If needed, parallel accesses by multiple logical cores to shared queues can be explicitly protected by dedicated inline lock-aware functions
+If needed, explicitly protect parallel accesses by multiple logical cores to shared queues using dedicated inline lock-aware functions
 built on top of their corresponding lock-free functions of the PMD API.
 
 Generic Packet Representation
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-A packet is represented by an rte_mbuf structure, which is a generic metadata structure containing all necessary housekeeping information.
-This includes fields and status bits corresponding to offload hardware features, such as checksum computation of IP headers or VLAN tags.
+An rte_mbuf structure represents a packet. This generic metadata structure contains all necessary housekeeping information,
+including fields and status bits corresponding to offload hardware features, such as checksum computation of IP headers or VLAN tags.
 
 The rte_mbuf data structure includes specific fields to represent, in a generic way, the offload features provided by network controllers.
-For an input packet, most fields of the rte_mbuf structure are filled in by the PMD receive function with the information contained in the receive descriptor.
-Conversely, for output packets, most fields of rte_mbuf structures are used by the PMD transmit function to initialize transmit descriptors.
+For an input packet, the PMD receive function fills in most fields of the rte_mbuf structure with information contained in the receive descriptor.
+Conversely, for output packets, the PMD transmit function uses most fields of rte_mbuf structures to initialize transmit descriptors.
 
 See :doc:`../mbuf_lib` chapter for more details.
 
 Ethernet Device API
 ~~~~~~~~~~~~~~~~~~~
 
-The Ethernet device API exported by the Ethernet PMDs is described in the *DPDK API Reference*.
+The *DPDK API Reference* describes the Ethernet device API exported by the Ethernet PMDs.
 
 .. _ethernet_device_standard_device_arguments:
 
 Ethernet Device Standard Device Arguments
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Standard Ethernet device arguments allow for a set of commonly used arguments/
-parameters which are applicable to all Ethernet devices to be available to for
-specification of specific device and for passing common configuration
-parameters to those ports.
+Standard Ethernet device arguments provide a set of commonly used arguments/
+parameters applicable to all Ethernet devices. Use these arguments/parameters to
+specify specific devices and pass common configuration parameters to those ports.
 
-* ``representor`` for a device which supports the creation of representor ports
-  this argument allows user to specify which switch ports to enable port
+* Use ``representor`` for a device that supports creating representor ports.
+  This argument allows the user to specify which switch ports to enable port
   representors for::
 
    -a DBDF,representor=vf0
@@ -380,8 +384,8 @@ parameters to those ports.
    -a DBDF,representor=vf[0-31]
    -a DBDF,representor=vf[0,2-4,7,9-11]
 
-  These examples will attach VF representors relative to DBDF.
-  The VF IDs can be a list, a range or a mix.
+  These examples attach VF representors relative to DBDF.
+  The VF IDs can be a list, a range, or a mix.
   SF representors follow the same syntax::
 
    -a DBDF,representor=sf0
@@ -389,47 +393,47 @@ parameters to those ports.
    -a DBDF,representor=sf[0-1023]
    -a DBDF,representor=sf[0,2-4,7,9-11]
 
-  If there are multiple PFs associated with the same PCI device,
-  the PF ID must be used to distinguish between representors relative to different PFs::
+  If multiple PFs are associated with the same PCI device,
+  use the PF ID to distinguish between representors relative to different PFs::
 
    -a DBDF,representor=pf1vf0
    -a DBDF,representor=pf[0-1]vf0
 
-  The example above will attach 4 representors pf0vf0, pf1vf0, pf0 and pf1.
-  If only VF representors are required, the PF part must be enclosed with parentheses::
+  The example above attaches 4 representors pf0vf0, pf1vf0, pf0, and pf1.
+  If only VF representors are required, enclose the PF part in parentheses::
 
    -a DBDF,representor=(pf[0-1])vf0
 
-  The example above will attach 2 representors pf0vf0, pf1vf0.
+  The example above attaches 2 representors pf0vf0 and pf1vf0.
 
-  List of representors for the same PCI device is enclosed in square brackets::
+  Enclose the list of representors for the same PCI device in square brackets::
 
    -a DBDF,representor=[pf[0-1],pf2vf[0-2],pf3[3,5-8]]
 
-  Note: PMDs may have additional extensions for the representor parameter, and users
-  should consult the relevant PMD documentation to see support devargs.
+  Note: PMDs may have additional extensions for the representor parameter. Consult
+  the relevant PMD documentation for supported devargs.
 
 Extended Statistics API
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-The extended statistics API allows a PMD to expose all statistics that are
-available to it, including statistics that are unique to the device.
-Each statistic has three properties ``name``, ``id`` and ``value``:
+The extended statistics API allows a PMD to expose all available statistics,
+including statistics unique to the device.
+Each statistic has three properties: ``name``, ``id``, and ``value``:
 
-* ``name``: A human readable string formatted by the scheme detailed below.
+* ``name``: A human-readable string formatted by the scheme detailed below.
 * ``id``: An integer that represents only that statistic.
-* ``value``: A unsigned 64-bit integer that is the value of the statistic.
+* ``value``: An unsigned 64-bit integer that is the value of the statistic.
 
-Note that extended statistic identifiers are
-driver-specific, and hence might not be the same for different ports.
-The API consists of various ``rte_eth_xstats_*()`` functions, and allows an
-application to be flexible in how it retrieves statistics.
+Note that extended statistic identifiers are driver-specific,
+and therefore might not be the same for different ports.
+The API consists of various ``rte_eth_xstats_*()`` functions and provides
+applications flexibility in how they retrieve statistics.
 
 Scheme for Human Readable Names
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-A naming scheme exists for the strings exposed to clients of the API. This is
-to allow scraping of the API for statistics of interest. The naming scheme uses
+A naming scheme governs the strings exposed to clients of the API. This scheme
+allows scraping of the API for statistics of interest. The naming scheme uses
 strings split by a single underscore ``_``. The scheme is as follows:
 
 * direction
@@ -438,69 +442,67 @@ strings split by a single underscore ``_``. The scheme is as follows:
 * detail n
 * unit
 
-Examples of common statistics xstats strings, formatted to comply to the scheme
+Examples of common statistics xstats strings, formatted to comply with the scheme
 proposed above:
 
 * ``rx_bytes``
 * ``rx_crc_errors``
 * ``tx_multicast_packets``
 
-The scheme, although quite simple, allows flexibility in presenting and reading
+The scheme, although simple, provides flexibility in presenting and reading
 information from the statistic strings. The following example illustrates the
-naming scheme:``rx_packets``. In this example, the string is split into two
-components. The first component ``rx`` indicates that the statistic is
-associated with the receive side of the NIC.  The second component ``packets``
+naming scheme: ``rx_packets``. In this example, the string splits into two
+components. The first component ``rx`` indicates that the statistic
+is associated with the receive side of the NIC. The second component ``packets``
 indicates that the unit of measure is packets.
 
 A more complicated example: ``tx_size_128_to_255_packets``. In this example,
-``tx`` indicates transmission, ``size``  is the first detail, ``128`` etc are
+``tx`` indicates transmission, ``size`` is the first detail, ``128`` etc. are
 more details, and ``packets`` indicates that this is a packet counter.
 
 Some additions in the metadata scheme are as follows:
 
 * If the first part does not match ``rx`` or ``tx``, the statistic does not
-  have an affinity with either receive of transmit.
+  have an affinity with either receive or transmit.
 
 * If the first letter of the second part is ``q`` and this ``q`` is followed
   by a number, this statistic is part of a specific queue.
 
-An example where queue numbers are used is as follows: ``tx_q7_bytes`` which
-indicates this statistic applies to queue number 7, and represents the number
+An example where queue numbers are used: ``tx_q7_bytes`` indicates this statistic applies to queue number 7 and represents the number
 of transmitted bytes on that queue.
 
 API Design
 ^^^^^^^^^^
 
-The xstats API uses the ``name``, ``id``, and ``value`` to allow performant
-lookup of specific statistics. Performant lookup means two things;
+The xstats API uses ``name``, ``id``, and ``value`` to allow performant
+lookup of specific statistics. Performant lookup means two things:
 
-* No string comparisons with the ``name`` of the statistic in fast-path
-* Allow requesting of only the statistics of interest
+* No string comparisons with the ``name`` of the statistic in the fast path
+* Allow requesting only the statistics of interest
 
-The API ensures these requirements are met by mapping the ``name`` of the
-statistic to a unique ``id``, which is used as a key for lookup in the fast-path.
-The API allows applications to request an array of ``id`` values, so that the
-PMD only performs the required calculations. Expected usage is that the
-application scans the ``name`` of each statistic, and caches the ``id``
-if it has an interest in that statistic. On the fast-path, the integer can be used
+The API meets these requirements by mapping the ``name`` of the
+statistic to a unique ``id``, which serves as a key for lookup in the fast path.
+The API allows applications to request an array of ``id`` values, so the
+PMD only performs the required calculations. The expected usage is that the
+application scans the ``name`` of each statistic and caches the ``id``
+if it has an interest in that statistic. On the fast path, the integer can be used
 to retrieve the actual ``value`` of the statistic that the ``id`` represents.
 
 API Functions
 ^^^^^^^^^^^^^
 
-The API is built out of a small number of functions, which can be used to
-retrieve the number of statistics and the names, IDs and values of those
-statistics.
+The API is built from a small number of functions, which retrieve the number of statistics
+and the names, IDs, and values of those statistics.
 
-* ``rte_eth_xstats_get_names_by_id()``: returns the names of the statistics. When given a
-  ``NULL`` parameter the function returns the number of statistics that are available.
+* ``rte_eth_xstats_get_names_by_id()``: Returns the names of the statistics. When given a
+  ``NULL`` parameter, the function returns the number of available statistics.
 
 * ``rte_eth_xstats_get_id_by_name()``: Searches for the statistic ID that matches
-  ``xstat_name``. If found, the ``id`` integer is set.
+  ``xstat_name``. If found, sets the ``id`` integer.
 
 * ``rte_eth_xstats_get_by_id()``: Fills in an array of ``uint64_t`` values
-  with matching the provided ``ids`` array. If the ``ids`` array is NULL, it
-  returns all statistics that are available.
+  matching the provided ``ids`` array. If the ``ids`` array is NULL, it
+  returns all available statistics.
 
 
 Application Usage
@@ -509,11 +511,11 @@ Application Usage
 Imagine an application that wants to view the dropped packet count. If no
 packets are dropped, the application does not read any other metrics for
 performance reasons. If packets are dropped, the application has a particular
-set of statistics that it requests. This "set" of statistics allows the app to
-decide what next steps to perform. The following code-snippets show how the
-xstats API can be used to achieve this goal.
+set of statistics that it requests. This "set" of statistics allows the application to
+decide what next steps to perform. The following code snippets show how the
+xstats API achieves this goal.
 
-First step is to get all statistics names and list them:
+The first step is to get all statistics names and list them:
 
 .. code-block:: c
 
@@ -557,9 +559,9 @@ First step is to get all statistics names and list them:
         printf("%s: %"PRIu64"\n", xstats_names[i].name, values[i]);
     }
 
-The application has access to the names of all of the statistics that the PMD
-exposes. The application can decide which statistics are of interest, cache the
-ids of those statistics by looking up the name as follows:
+The application has access to the names of all statistics that the PMD
+exposes. The application can decide which statistics are of interest and cache the
+IDs of those statistics by looking up the name as follows:
 
 .. code-block:: c
 
@@ -576,10 +578,8 @@ ids of those statistics by looking up the name as follows:
         goto err;
     }
 
-The API provides flexibility to the application so that it can look up multiple
-statistics using an array containing multiple ``id`` numbers. This reduces the
-function call overhead of retrieving statistics, and makes lookup of multiple
-statistics simpler for the application.
+The API allows the application to look up multiple statistics using an array containing multiple ``id`` numbers.
+This reduces function call overhead when retrieving statistics and simplifies looking up multiple statistics.
 
 .. code-block:: c
 
@@ -597,12 +597,12 @@ statistics simpler for the application.
     }
 
 
-This array lookup API for xstats allows the application create multiple
-"groups" of statistics, and look up the values of those IDs using a single API
-call. As an end result, the application is able to achieve its goal of
-monitoring a single statistic ("rx_errors" in this case), and if that shows
+This array lookup API for xstats allows the application to create multiple
+"groups" of statistics and look up the values of those IDs using a single API
+call. As a result, the application achieves its goal of
+monitoring a single statistic (in this case, "rx_errors"). If that shows
 packets being dropped, it can easily retrieve a "set" of statistics using the
-IDs array parameter to ``rte_eth_xstats_get_by_id`` function.
+IDs array parameter to the ``rte_eth_xstats_get_by_id`` function.
 
 NIC Reset API
 ~~~~~~~~~~~~~
@@ -611,84 +611,81 @@ NIC Reset API
 
     int rte_eth_dev_reset(uint16_t port_id);
 
-Sometimes a port has to be reset passively. For example when a PF is
-reset, all its VFs should also be reset by the application to make them
-consistent with the PF. A DPDK application also can call this function
-to trigger a port reset. Normally, a DPDK application would invokes this
-function when an RTE_ETH_EVENT_INTR_RESET event is detected.
+Sometimes a port must be reset passively. For example, when a PF is
+reset, the application should also reset all its VFs to maintain consistency
+with the PF. A DPDK application can also call this function
+to trigger a port reset. Normally, a DPDK application invokes this
+function when it detects an RTE_ETH_EVENT_INTR_RESET event.
 
-It is the duty of the PMD to trigger RTE_ETH_EVENT_INTR_RESET events and
-the application should register a callback function to handle these
-events. When a PMD needs to trigger a reset, it can trigger an
+The PMD triggers RTE_ETH_EVENT_INTR_RESET events.
+The application should register a callback function to handle these
+events. When a PMD needs to trigger a reset, it triggers an
 RTE_ETH_EVENT_INTR_RESET event. On receiving an RTE_ETH_EVENT_INTR_RESET
-event, applications can handle it as follows: Stop working queues, stop
+event, applications should: stop working queues, stop
 calling Rx and Tx functions, and then call rte_eth_dev_reset(). For
-thread safety all these operations should be called from the same thread.
+thread safety, call all these operations from the same thread.
 
-For example when PF is reset, the PF sends a message to notify VFs of
-this event and also trigger an interrupt to VFs. Then in the interrupt
-service routine the VFs detects this notification message and calls
+For example, when a PF is reset, it sends a message to notify VFs of
+this event and also triggers an interrupt to VFs. Then, in the interrupt
+service routine, the VFs detect this notification message and call
 rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RESET, NULL).
 This means that a PF reset triggers an RTE_ETH_EVENT_INTR_RESET
-event within VFs. The function rte_eth_dev_callback_process() will
-call the registered callback function. The callback function can trigger
-the application to handle all operations the VF reset requires including
+event within VFs. The function rte_eth_dev_callback_process()
+calls the registered callback function. The callback function can trigger
+the application to handle all operations the VF reset requires, including
 stopping Rx/Tx queues and calling rte_eth_dev_reset().
 
-The rte_eth_dev_reset() itself is a generic function which only does
-some hardware reset operations through calling dev_unint() and
-dev_init(), and itself does not handle synchronization, which is handled
-by application.
+The rte_eth_dev_reset() function is a generic function that only performs hardware reset operations by calling dev_uninit() and
+dev_init(). It does not handle synchronization; the application handles that.
 
-The PMD itself should not call rte_eth_dev_reset(). The PMD can trigger
-the application to handle reset event. It is duty of application to
-handle all synchronization before it calls rte_eth_dev_reset().
+The PMD should not call rte_eth_dev_reset(). The PMD can trigger
+the application to handle the reset event. The application must
+handle all synchronization before calling rte_eth_dev_reset().
 
 The above error handling mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PASSIVE``.
 
 Proactive Error Handling Mode
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE``,
-different from the application invokes recovery in PASSIVE mode,
-the PMD automatically recovers from error in PROACTIVE mode,
-and only a small amount of work is required for the application.
+This mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE``, which
+differs from PASSIVE mode where the application invokes recovery.
+In PROACTIVE mode, the PMD automatically recovers from errors,
+and the application requires only minimal handling.
 
 During error detection and automatic recovery,
 the PMD sets the data path pointers to dummy functions
-(which will prevent the crash),
-and also make sure the control path operations fail with a return code ``-EBUSY``.
+(which prevent crashes)
+and ensures control path operations fail with return code ``-EBUSY``.
 
 Because the PMD recovers automatically,
-the application can only sense that the data flow is disconnected for a while
-and the control API returns an error in this period.
+the application only senses that the data flow is disconnected for a while
+and that the control API returns an error during this period.
 
-In order to sense the error happening/recovering,
-as well as to restore some additional configuration,
+To sense error occurrence and recovery,
+as well as to restore additional configuration,
 three events are available:
 
 ``RTE_ETH_EVENT_ERR_RECOVERING``
-   Notify the application that an error is detected
-   and the recovery is being started.
+   Notifies the application that an error is detected
+   and recovery is beginning.
    Upon receiving the event, the application should not invoke
-   any control path function until receiving
+   any control path function until receiving the
    ``RTE_ETH_EVENT_RECOVERY_SUCCESS`` or ``RTE_ETH_EVENT_RECOVERY_FAILED`` event.
 
 .. note::
 
    Before the PMD reports the recovery result,
-   the PMD may report the ``RTE_ETH_EVENT_ERR_RECOVERING`` event again,
-   because a larger error may occur during the recovery.
+   it may report the ``RTE_ETH_EVENT_ERR_RECOVERING`` event again
+   because a larger error may occur during recovery.
 
 ``RTE_ETH_EVENT_RECOVERY_SUCCESS``
-   Notify the application that the recovery from error is successful,
-   the PMD already re-configures the port,
+   Notifies the application that recovery from the error was successful.
+   The PMD has reconfigured the port,
    and the effect is the same as a restart operation.
 
 ``RTE_ETH_EVENT_RECOVERY_FAILED``
-   Notify the application that the recovery from error failed,
-   the port should not be usable anymore.
+   Notifies the application that recovery from the error failed.
+   The port should not be usable anymore.
    The application should close the port.
 
-The error handling mode supported by the PMD can be reported through
-``rte_eth_dev_info_get``.
+Query the error handling mode supported by the PMD using ``rte_eth_dev_info_get()``.
-- 
2.51.0

