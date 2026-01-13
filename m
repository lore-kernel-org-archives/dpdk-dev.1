Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E6D30CEE
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 23:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 503C440616;
	Wed, 14 Jan 2026 00:01:03 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 590D84029A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 00:01:01 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-432d256c2a9so4376513f8f.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 15:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768345261;
 x=1768950061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkNHHu7i+wyRPYTJfpZdh5yHeY0UFhQiFcLECzTNpOc=;
 b=i/8O1bSiJ0ZImutxeYkZWI7cXuytHpsY76U7Ye8lgdkvwwLn1aUJlSY0eAQdcyWsUG
 opk98JqYLWa+jsRecEWBmz+pY9ef7L0498YWpGCwqtV8x8W2mxEvver2RPoaXW5+Mwx4
 OXB+ZG6TvOa6yxSKUefOT+C6qU8crnbFWec2ZUC/GZ0bEk7KCpGdCKe4xXIaZy8cjxPs
 wJS7A7txVsIe1sbZL9qMk1dLoNnuGA54mqBmmeeS/nyW2JfsC/lxaSIQcJPkHAZUW8OF
 8ZAGBY2gTV8U0IMvG9nmH/Iqlkl9HbfXgf1/3Y91jIHhycSzz41t61XhB/0iVsA4a4ap
 Y/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768345261; x=1768950061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dkNHHu7i+wyRPYTJfpZdh5yHeY0UFhQiFcLECzTNpOc=;
 b=UHBORHtB4v1xSihUg7VslXm/QxFRoQzbFWR+qKJFws9YFFyxBvNlHGfdyPkQehZ/JZ
 8/WiG/fK+jFn/vQPG6IFG0jsaMv6aJV5VZrhrcoqXQ6lEepSNgD0oGKPl2dAQ4SCJtzL
 qwcKpknn5qTVvu6KcpmDidyEiWUznVZasCoJZ7tcHXUjnHoD8i4cImZp14OjNCJSPva2
 49rFdfewhk5V+v9xQpLufx6zjOdGg6TPRhU1mrUKBOSHx865L7SBEz8zFfDWh/7F43hw
 pyvGniFAxtjWiDIu6pknQm01PK9g6Zc/Rbgrn/0zpshGIXPasLy1is8fHlsGcPA0lXJS
 4S5g==
X-Gm-Message-State: AOJu0YwOYlbKljUeyz6jyHs4QsdYigb6e+zwZgoOEPOVG7fYXA6EKwBN
 CBiLh6aJyEGRbGQhQ9qbHT/bSNTpCNVgGJzLgdKwa/sMrGZbSgbiRESY4ad/KXMCFHxpSgUTWqn
 HNwC8
X-Gm-Gg: AY/fxX4nytTS4jJrgFblnLinXDvA58h34V9d7kR2azg26BzMR8waxcR6opW1NAcbN5x
 XUKHj7NaP+1UOkbw9e1VtYF1Rq1eQnh6TjGPABex7HHcgwsf+wsWBmUVoG135cymya87tg6ipyS
 FDzyGl5sQ3HlA1h2LxQs83bElynCag+Dgeckxhs/VzAZ4YgTgY/We1hU9I66udAn/ynGFV49xC9
 KKVo0z1ig6zL7TJJWRdw74trcCXpw7LAfJXPCVMCfZOXz8Z8S2mcNzXkTXR4/I5PT/5akFTV4tH
 w+ymmkEpeUpa9cM0EqKqEWAF+BgbPDWIa7NuTbqffEq4JjR0cqeocTbk/wQmiCc5Rj2VuXowp1H
 qYCwIM45sxjCrVDNt/RtaHXQj8necmTy9eE8x1deZ14GLYMWlNsaN0dNrRZNexNawYZIw5krm5Y
 lcohx+KlcSSalhYQ2HrFgndOoRS03Qhb9tEqkcUXf/qaM1yuYUVw==
X-Received: by 2002:a05:6000:2483:b0:42b:55a1:214f with SMTP id
 ffacd0b85a97d-4342c4f7255mr464141f8f.21.1768345260476; 
 Tue, 13 Jan 2026 15:01:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44977200f8f.26.2026.01.13.15.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 15:01:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nandini Persad <nandinipersad361@gmail.com>
Subject: [PATCH v3 01/11] doc: correct grammar and punctuation errors in
 ethdev guide
Date: Tue, 13 Jan 2026 14:51:03 -0800
Message-ID: <20260113230052.54435-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113230052.54435-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260113230052.54435-1-stephen@networkplumber.org>
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
 doc/guides/prog_guide/ethdev/ethdev.rst | 168 ++++++++++++------------
 1 file changed, 82 insertions(+), 86 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index daaf43ea3b..68b0985033 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -4,25 +4,25 @@
 Poll Mode Driver
 ================
 
-The DPDK includes 1 Gigabit, 10 Gigabit and 40 Gigabit and para virtualized virtio Poll Mode Drivers.
+The DPDK includes support multiple physical speeds as well as
+pure virtualized Poll Mode Drivers.
 
-A Poll Mode Driver (PMD) consists of APIs, provided through the BSD driver running in user space,
-to configure the devices and their respective queues.
+A Poll Mode Driver (PMD) consists of APIs (provided through the BSD driver running in user space) to configure the devices and their respective queues.
 In addition, a PMD accesses the RX and TX descriptors directly without any interrupts
 (with the exception of Link Status Change interrupts) to quickly receive,
 process and deliver packets in the user's application.
-This section describes the requirements of the PMDs,
-their global design principles and proposes a high-level architecture and a generic external API for the Ethernet PMDs.
+This section describes the requirements of the PMDs and
+their global design principles. It also proposes a high-level architecture and a generic external API for the Ethernet PMDs.
 
 Requirements and Assumptions
 ----------------------------
 
 The DPDK environment for packet processing applications allows for two models, run-to-completion and pipe-line:
 
-*   In the *run-to-completion*  model, a specific port's RX descriptor ring is polled for packets through an API.
-    Packets are then processed on the same core and placed on a port's TX descriptor ring through an API for transmission.
+*   In the *run-to-completion* model, a specific port's Rx descriptor ring is polled for packets through an API.
+    Packets are then processed on the same core and placed on a port's Tx descriptor ring through an API for transmission.
 
-*   In the *pipe-line*  model, one core polls one or more port's RX descriptor ring through an API.
+*   In the *pipe-line* model, one core polls one or more ports' Rx descriptor rings through an API.
     Packets are received and passed to another core via a ring.
     The other core continues to process the packet which then may be placed on a port's TX descriptor ring through an API for transmission.
 
@@ -48,14 +48,14 @@ The loop for packet processing includes the following steps:
 
 *   Retrieve the received packet from the packet queue
 
-*   Process the received packet, up to its retransmission if forwarded
+*   Process the received packet up to its retransmission if forwarded
 
 To avoid any unnecessary interrupt processing overhead, the execution environment must not use any asynchronous notification mechanisms.
 Whenever needed and appropriate, asynchronous communication should be introduced as much as possible through the use of rings.
 
 Avoiding lock contention is a key issue in a multi-core environment.
-To address this issue, PMDs are designed to work with per-core private resources as much as possible.
-For example, a PMD maintains a separate transmit queue per-core, per-port, if the PMD is not ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable.
+To address this issue, PMDs are designed to work with per core private resources as much as possible.
+For example, a PMD maintains a separate transmit queue per core, per port, if the PMD is not ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable.
 In the same way, every receive queue of a port is assigned to and polled by a single logical core (lcore).
 
 To comply with Non-Uniform Memory Access (NUMA), memory management is designed to assign to each logical core
@@ -68,7 +68,7 @@ See :doc:`../mempool_lib`.
 Design Principles
 -----------------
 
-The API and architecture of the Ethernet* PMDs are designed with the following guidelines in mind.
+The API and architecture of the Ethernet PMDs are designed with the following guidelines in mind.
 
 PMDs must help global policy-oriented decisions to be enforced at the upper application level.
 Conversely, NIC PMD functions should not impede the benefits expected by upper-level global policies,
@@ -87,11 +87,11 @@ to dynamically adapt its overall behavior through different global loop policies
 To achieve optimal performance, overall software design choices and pure software optimization techniques must be considered and
 balanced against available low-level hardware-based optimization features (CPU cache properties, bus speed, NIC PCI bandwidth, and so on).
 The case of packet transmission is an example of this software/hardware tradeoff issue when optimizing burst-oriented network packet processing engines.
-In the initial case, the PMD could export only an rte_eth_tx_one function to transmit one packet at a time on a given queue.
-On top of that, one can easily build an rte_eth_tx_burst function that loops invoking the rte_eth_tx_one function to transmit several packets at a time.
+In the initial case, the PMD could export only an ``rte_eth_tx_one`` function to transmit one packet at a time on a given queue.
+On top of that, one can easily build an ``rte_eth_tx_burst`` function that loops invoking the ``rte_eth_tx_one`` function to transmit several packets at a time.
 However, an rte_eth_tx_burst function is effectively implemented by the PMD to minimize the driver-level transmit cost per packet through the following optimizations:
 
-*   Share among multiple packets the un-amortized cost of invoking the rte_eth_tx_one function.
+*   Share among multiple packets the un-amortized cost of invoking the ``rte_eth_tx_one`` function.
 
 *   Enable the rte_eth_tx_burst function to take advantage of burst-oriented hardware features (prefetch data in cache, use of NIC head/tail registers)
     to minimize the number of CPU cycles per packet, for example by avoiding unnecessary read memory accesses to ring transmit descriptors,
@@ -99,9 +99,9 @@ However, an rte_eth_tx_burst function is effectively implemented by the PMD to m
 
 *   Apply burst-oriented software optimization techniques to remove operations that would otherwise be unavoidable, such as ring index wrap back management.
 
-Burst-oriented functions are also introduced via the API for services that are intensively used by the PMD.
+Burst-oriented functions are also introduced via the API for services that are extensively used by the PMD.
 This applies in particular to buffer allocators used to populate NIC rings, which provide functions to allocate/free several buffers at a time.
-For example, an mbuf_multiple_alloc function returning an array of pointers to rte_mbuf buffers which speeds up the receive poll function of the PMD when
+An example of this would be an ``mbuf_multiple_alloc`` function returning an array of pointers to rte_mbuf buffers which speeds up the receive poll function of the PMD when
 replenishing multiple descriptors of the receive ring.
 
 Logical Cores, Memory and NIC Queues Relationships
@@ -109,21 +109,20 @@ Logical Cores, Memory and NIC Queues Relationships
 
 The DPDK supports NUMA allowing for better performance when a processor's logical cores and interfaces utilize its local memory.
 Therefore, mbuf allocation associated with local PCIe* interfaces should be allocated from memory pools created in the local memory.
-The buffers should, if possible, remain on the local processor to obtain the best performance results and RX and TX buffer descriptors
+The buffers should, if possible, remain on the local processor to obtain the best performance results and Rx and Tx buffer descriptors
 should be populated with mbufs allocated from a mempool allocated from local memory.
 
-The run-to-completion model also performs better if packet or data manipulation is in local memory instead of a remote processors memory.
+The run-to-completion model also performs better if packet or data manipulation is in local memory instead of a remote processor's memory.
 This is also true for the pipe-line model provided all logical cores used are located on the same processor.
 
 Multiple logical cores should never share receive or transmit queues for interfaces since this would require global locks and hinder performance.
 
 If the PMD is ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable, multiple threads can invoke ``rte_eth_tx_burst()``
-concurrently on the same tx queue without SW lock. This PMD feature found in some NICs and useful in the following use cases:
+concurrently on the same Tx queue without an SW lock. This PMD feature found in some NICs is useful for:
 
-*  Remove explicit spinlock in some applications where lcores are not mapped to Tx queues with 1:1 relation.
+*  Removing explicit spinlock in some applications where lcores are not mapped to Tx queues with 1:1 relation.
 
-*  In the eventdev use case, avoid dedicating a separate TX core for transmitting and thus
-   enables more scaling as all workers can send the packets.
+*  Enabling greater scalability by removing the requirement to have a dedicated Tx core.
 
 See `Hardware Offload`_ for ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capability probing details.
 
@@ -133,8 +132,8 @@ Device Identification, Ownership and Configuration
 Device Identification
 ~~~~~~~~~~~~~~~~~~~~~
 
-Each NIC port is uniquely designated by its (bus/bridge, device, function) PCI
-identifiers assigned by the PCI probing/enumeration function executed at DPDK initialization.
+Each NIC port is uniquely designated by its PCI
+identifiers (bus/bridge, device, function) assigned by the PCI probing/enumeration function executed at DPDK initialization.
 Based on their PCI identifier, NIC ports are assigned two other identifiers:
 
 *   A port index used to designate the NIC port in all functions exported by the PMD API.
@@ -146,15 +145,14 @@ Port Ownership
 ~~~~~~~~~~~~~~
 
 The Ethernet devices ports can be owned by a single DPDK entity (application, library, PMD, process, etc).
-The ownership mechanism is controlled by ethdev APIs and allows to set/remove/get a port owner by DPDK entities.
-It prevents Ethernet ports to be managed by different entities.
+The ownership mechanism is controlled by ethdev APIs and allows setting/removing/getting a port owner by DPDK entities.
+This prevents Ethernet ports from being managed by different entities.
 
 .. note::
 
-    It is the DPDK entity responsibility to set the port owner before using it and to manage the port usage synchronization between different threads or processes.
+    It is the DPDK entity responsibility to set the port owner before using the port and to manage the port usage synchronization between different threads or processes.
 
-It is recommended to set port ownership early,
-like during the probing notification ``RTE_ETH_EVENT_NEW``.
+It is recommended to set port ownership early. For instance, during the probing notification ``RTE_ETH_EVENT_NEW``.
 
 Device Configuration
 ~~~~~~~~~~~~~~~~~~~~
@@ -163,7 +161,7 @@ The configuration of each NIC port includes the following operations:
 
 *   Allocate PCI resources
 
-*   Reset the hardware (issue a Global Reset) to a well-known default state
+*   Reset the hardware to a well-known default state (issue a Global Reset)
 
 *   Set up the PHY and the link
 
@@ -172,7 +170,7 @@ The configuration of each NIC port includes the following operations:
 The PMD API must also export functions to start/stop the all-multicast feature of a port and functions to set/unset the port in promiscuous mode.
 
 Some hardware offload features must be individually configured at port initialization through specific configuration parameters.
-This is the case for the Receive Side Scaling (RSS) and Data Center Bridging (DCB) features for example.
+This is the case for the Receive Side Scaling (RSS) and Data Center Bridging (DCB) features.
 
 On-the-Fly Configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -193,7 +191,7 @@ the Intel® 82599 10 Gigabit Ethernet Controller controllers in the testpmd appl
 Other features such as the L3/L4 5-Tuple packet filtering feature of a port can be configured in the same way.
 Ethernet* flow control (pause frame) can be configured on the individual port.
 Refer to the testpmd source code for details.
-Also, L4 (UDP/TCP/ SCTP) checksum offload by the NIC can be enabled for an individual packet as long as the packet mbuf is set up correctly. See `Hardware Offload`_ for details.
+Also, L4 (UDP/TCP/SCTP) checksum offload by the NIC can be enabled for an individual packet as long as the packet mbuf is set up correctly. See `Hardware Offload`_ for details.
 
 Configuration of Transmit Queues
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -208,7 +206,7 @@ Each transmit queue is independently configured with the following information:
 
 *   The *minimum* transmit packets to free threshold (tx_free_thresh).
     When the number of descriptors used to transmit packets exceeds this threshold, the network adaptor should be checked to see if it has written back descriptors.
-    A value of 0 can be passed during the TX queue configuration to indicate the default value should be used.
+    A value of 0 can be passed during the Tx queue configuration to indicate the default value should be used.
     The default value for tx_free_thresh is 32.
     This ensures that the PMD does not search for completed descriptors until at least 32 have been processed by the NIC for this queue.
 
@@ -220,7 +218,7 @@ Each transmit queue is independently configured with the following information:
     A value of 0 can be passed during the TX queue configuration to indicate that the default value should be used.
     The default value for tx_rs_thresh is 32.
     This ensures that at least 32 descriptors are used before the network adapter writes back the most recently used descriptor.
-    This saves upstream PCIe* bandwidth resulting from TX descriptor write-backs.
+    This saves upstream PCIe* bandwidth resulting from Tx descriptor write-backs.
     It is important to note that the TX Write-back threshold (TX wthresh) should be set to 0 when tx_rs_thresh is greater than 1.
     Refer to the Intel® 82599 10 Gigabit Ethernet Controller Datasheet for more details.
 
@@ -242,7 +240,7 @@ One descriptor in the TX ring is used as a sentinel to avoid a hardware race con
 
 .. note::
 
-    When configuring for DCB operation, at port initialization, both the number of transmit queues and the number of receive queues must be set to 128.
+    When configuring for DCB operation at port initialization, both the number of transmit queues and the number of receive queues must be set to 128.
 
 Free Tx mbuf on Demand
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -263,7 +261,7 @@ There are two scenarios when an application may want the mbuf released immediate
   One option is to make a copy of the packet or a copy of the header portion that needs to be manipulated.
   A second option is to transmit the packet and then poll the ``rte_eth_tx_done_cleanup()`` API
   until the reference count on the packet is decremented.
-  Then the same packet can be transmitted to the next destination interface.
+  Then, the same packet can be transmitted to the next destination interface.
   The application is still responsible for managing any packet manipulations needed
   between the different destination interfaces, but a packet copy can be avoided.
   This API is independent of whether the packet was transmitted or dropped,
@@ -275,7 +273,7 @@ There are two scenarios when an application may want the mbuf released immediate
   between each run, where all mbufs are returned to the mempool.
   In this case, it can call the ``rte_eth_tx_done_cleanup()`` API
   for each destination interface it has been using
-  to request it to release of all its used mbufs.
+  to request it to release all its used mbufs.
 
 To determine if a driver supports this API, check for the *Free Tx mbuf on demand* feature
 in the *Network Interface Controller Drivers* document.
@@ -286,7 +284,7 @@ Hardware Offload
 Depending on driver capabilities advertised by
 ``rte_eth_dev_info_get()``, the PMD may support hardware offloading
 feature like checksumming, TCP segmentation, VLAN insertion or
-lockfree multithreaded TX burst on the same TX queue.
+lockfree multithreaded Tx burst on the same Tx queue.
 
 The support of these offload features implies the addition of dedicated
 status bit(s) and value field(s) into the rte_mbuf data structure, along
@@ -300,14 +298,14 @@ Per-Port and Per-Queue Offloads
 In the DPDK offload API, offloads are divided into per-port and per-queue offloads as follows:
 
 * A per-queue offloading can be enabled on a queue and disabled on another queue at the same time.
-* A pure per-port offload is the one supported by device but not per-queue type.
-* A pure per-port offloading can't be enabled on a queue and disabled on another queue at the same time.
+* A pure per-port offload is supported by a device but not per-queue type.
+* A pure per-port offloading cannot be enabled on a queue and disabled on another queue at the same time.
 * A pure per-port offloading must be enabled or disabled on all queues at the same time.
-* Any offloading is per-queue or pure per-port type, but can't be both types at same devices.
+* Offloading is per-queue or pure per-port type, but cannot be both types on the same devices.
 * Port capabilities = per-queue capabilities + pure per-port capabilities.
 * Any supported offloading can be enabled on all queues.
 
-The different offloads capabilities can be queried using ``rte_eth_dev_info_get()``.
+The different offload capabilities can be queried using ``rte_eth_dev_info_get()``.
 The ``dev_info->[rt]x_queue_offload_capa`` returned from ``rte_eth_dev_info_get()`` includes all per-queue offloading capabilities.
 The ``dev_info->[rt]x_offload_capa`` returned from ``rte_eth_dev_info_get()`` includes all pure per-port and per-queue offloading capabilities.
 Supported offloads can be either per-port or per-queue.
@@ -326,8 +324,8 @@ per-port type and no matter whether it is set or cleared in
 If a per-queue offloading hasn't been enabled in ``rte_eth_dev_configure()``,
 it can be enabled or disabled in ``rte_eth_[rt]x_queue_setup()`` for individual queue.
 A newly added offloads in ``[rt]x_conf->offloads`` to ``rte_eth_[rt]x_queue_setup()`` input by application
-is the one which hasn't been enabled in ``rte_eth_dev_configure()`` and is requested to be enabled
-in ``rte_eth_[rt]x_queue_setup()``. It must be per-queue type, otherwise trigger an error log.
+is the one that hasn't been enabled in ``rte_eth_dev_configure()`` and is requested to be enabled
+in ``rte_eth_[rt]x_queue_setup()``. It must be per-queue type, otherwise an error log will be triggered.
 
 Poll Mode Driver API
 --------------------
@@ -337,8 +335,8 @@ Generalities
 
 By default, all functions exported by a PMD are lock-free functions that are assumed
 not to be invoked in parallel on different logical cores to work on the same target object.
-For instance, a PMD receive function cannot be invoked in parallel on two logical cores to poll the same RX queue of the same port.
-Of course, this function can be invoked in parallel by different logical cores on different RX queues.
+For instance, a PMD receive function cannot be invoked in parallel on two logical cores to poll the same Rx queue of the same port.
+This function can be invoked in parallel by different logical cores on different Rx queues.
 It is the responsibility of the upper-level application to enforce this rule.
 
 If needed, parallel accesses by multiple logical cores to shared queues can be explicitly protected by dedicated inline lock-aware functions
@@ -367,12 +365,12 @@ Ethernet Device Standard Device Arguments
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Standard Ethernet device arguments allow for a set of commonly used arguments/
-parameters which are applicable to all Ethernet devices to be available to for
-specification of specific device and for passing common configuration
+parameters applicable to all Ethernet devices. These arguments/parameters are available for
+specification of specific devices and passing common configuration
 parameters to those ports.
 
-* ``representor`` for a device which supports the creation of representor ports
-  this argument allows user to specify which switch ports to enable port
+* Use ``representor`` for a device which supports the creation of representor ports.
+  This argument allows user to specify which switch ports to enable port
   representors for::
 
    -a DBDF,representor=vf0
@@ -416,9 +414,9 @@ The extended statistics API allows a PMD to expose all statistics that are
 available to it, including statistics that are unique to the device.
 Each statistic has three properties ``name``, ``id`` and ``value``:
 
-* ``name``: A human readable string formatted by the scheme detailed below.
+* ``name``: A human-readable string formatted by the scheme detailed below.
 * ``id``: An integer that represents only that statistic.
-* ``value``: A unsigned 64-bit integer that is the value of the statistic.
+* ``value``: An unsigned 64-bit integer that is the value of the statistic.
 
 Note that extended statistic identifiers are
 driver-specific, and hence might not be the same for different ports.
@@ -447,19 +445,19 @@ proposed above:
 
 The scheme, although quite simple, allows flexibility in presenting and reading
 information from the statistic strings. The following example illustrates the
-naming scheme:``rx_packets``. In this example, the string is split into two
+naming scheme: ``rx_packets``. In this example, the string is split into two
 components. The first component ``rx`` indicates that the statistic is
 associated with the receive side of the NIC.  The second component ``packets``
 indicates that the unit of measure is packets.
 
 A more complicated example: ``tx_size_128_to_255_packets``. In this example,
-``tx`` indicates transmission, ``size``  is the first detail, ``128`` etc are
+``tx`` indicates transmission, ``size`` is the first detail, ``128`` etc., are
 more details, and ``packets`` indicates that this is a packet counter.
 
 Some additions in the metadata scheme are as follows:
 
 * If the first part does not match ``rx`` or ``tx``, the statistic does not
-  have an affinity with either receive of transmit.
+  have an affinity with either receive or transmit.
 
 * If the first letter of the second part is ``q`` and this ``q`` is followed
   by a number, this statistic is part of a specific queue.
@@ -480,8 +478,8 @@ lookup of specific statistics. Performant lookup means two things;
 The API ensures these requirements are met by mapping the ``name`` of the
 statistic to a unique ``id``, which is used as a key for lookup in the fast-path.
 The API allows applications to request an array of ``id`` values, so that the
-PMD only performs the required calculations. Expected usage is that the
-application scans the ``name`` of each statistic, and caches the ``id``
+PMD only performs the required calculations. The expected usage is that the
+application scans the ``name`` of each statistic and caches the ``id``
 if it has an interest in that statistic. On the fast-path, the integer can be used
 to retrieve the actual ``value`` of the statistic that the ``id`` represents.
 
@@ -500,7 +498,7 @@ statistics.
 
 * ``rte_eth_xstats_get_by_id()``: Fills in an array of ``uint64_t`` values
   with matching the provided ``ids`` array. If the ``ids`` array is NULL, it
-  returns all statistics that are available.
+  returns all available statistics.
 
 
 Application Usage
@@ -510,10 +508,10 @@ Imagine an application that wants to view the dropped packet count. If no
 packets are dropped, the application does not read any other metrics for
 performance reasons. If packets are dropped, the application has a particular
 set of statistics that it requests. This "set" of statistics allows the app to
-decide what next steps to perform. The following code-snippets show how the
+decide what next steps to perform. The following code snippets show how the
 xstats API can be used to achieve this goal.
 
-First step is to get all statistics names and list them:
+The first step is to get all statistics names and list them:
 
 .. code-block:: c
 
@@ -559,7 +557,7 @@ First step is to get all statistics names and list them:
 
 The application has access to the names of all of the statistics that the PMD
 exposes. The application can decide which statistics are of interest, cache the
-ids of those statistics by looking up the name as follows:
+IDs of those statistics by looking up the name as follows:
 
 .. code-block:: c
 
@@ -578,8 +576,7 @@ ids of those statistics by looking up the name as follows:
 
 The API provides flexibility to the application so that it can look up multiple
 statistics using an array containing multiple ``id`` numbers. This reduces the
-function call overhead of retrieving statistics, and makes lookup of multiple
-statistics simpler for the application.
+function call overhead of retrieving statistics and simplifies the application's lookup of multiple statistics.
 
 .. code-block:: c
 
@@ -597,10 +594,10 @@ statistics simpler for the application.
     }
 
 
-This array lookup API for xstats allows the application create multiple
+This array lookup API for xstats allows the application to create multiple
 "groups" of statistics, and look up the values of those IDs using a single API
-call. As an end result, the application is able to achieve its goal of
-monitoring a single statistic ("rx_errors" in this case), and if that shows
+call. As an end result, the application can achieve its goal of
+monitoring a single statistic (in this case,"rx_errors"). If that shows
 packets being dropped, it can easily retrieve a "set" of statistics using the
 IDs array parameter to ``rte_eth_xstats_get_by_id`` function.
 
@@ -611,23 +608,23 @@ NIC Reset API
 
     int rte_eth_dev_reset(uint16_t port_id);
 
-Sometimes a port has to be reset passively. For example when a PF is
+There are times when a port has to be reset passively. For example, when a PF is
 reset, all its VFs should also be reset by the application to make them
-consistent with the PF. A DPDK application also can call this function
-to trigger a port reset. Normally, a DPDK application would invokes this
+consistent with the PF. A DPDK application can also call this function
+to trigger a port reset. Normally, a DPDK application would invoke this
 function when an RTE_ETH_EVENT_INTR_RESET event is detected.
 
-It is the duty of the PMD to trigger RTE_ETH_EVENT_INTR_RESET events and
-the application should register a callback function to handle these
+The PMD's duty is to trigger RTE_ETH_EVENT_INTR_RESET events.
+The application should register a callback function to handle these
 events. When a PMD needs to trigger a reset, it can trigger an
 RTE_ETH_EVENT_INTR_RESET event. On receiving an RTE_ETH_EVENT_INTR_RESET
-event, applications can handle it as follows: Stop working queues, stop
+event, applications can do as follows: Stop working queues, stop
 calling Rx and Tx functions, and then call rte_eth_dev_reset(). For
 thread safety all these operations should be called from the same thread.
 
 For example when PF is reset, the PF sends a message to notify VFs of
-this event and also trigger an interrupt to VFs. Then in the interrupt
-service routine the VFs detects this notification message and calls
+this event and also trigger an interrupt to VFs. Then, in the interrupt
+service routine, the VFs detect this notification message and calls
 rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RESET, NULL).
 This means that a PF reset triggers an RTE_ETH_EVENT_INTR_RESET
 event within VFs. The function rte_eth_dev_callback_process() will
@@ -635,13 +632,12 @@ call the registered callback function. The callback function can trigger
 the application to handle all operations the VF reset requires including
 stopping Rx/Tx queues and calling rte_eth_dev_reset().
 
-The rte_eth_dev_reset() itself is a generic function which only does
-some hardware reset operations through calling dev_unint() and
-dev_init(), and itself does not handle synchronization, which is handled
+The rte_eth_dev_reset() is a generic function that only does hardware reset operations through calling dev_uninit() and
+dev_init(). It does not handle synchronization, which is handled
 by application.
 
 The PMD itself should not call rte_eth_dev_reset(). The PMD can trigger
-the application to handle reset event. It is duty of application to
+the application to handle reset event. It is the duty of the application to
 handle all synchronization before it calls rte_eth_dev_reset().
 
 The above error handling mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PASSIVE``.
@@ -649,15 +645,15 @@ The above error handling mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PASSIVE``.
 Proactive Error Handling Mode
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE``,
-different from the application invokes recovery in PASSIVE mode,
-the PMD automatically recovers from error in PROACTIVE mode,
+This mode is known as ``RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE``, which
+differs from PASSIVE mode where the application invokes recovery.
+The PMD automatically recovers from error in PROACTIVE mode,
 and only a small amount of work is required for the application.
 
 During error detection and automatic recovery,
 the PMD sets the data path pointers to dummy functions
 (which will prevent the crash),
-and also make sure the control path operations fail with a return code ``-EBUSY``.
+and ensures the control path operations fail with a return code ``-EBUSY``.
 
 Because the PMD recovers automatically,
 the application can only sense that the data flow is disconnected for a while
@@ -669,9 +665,9 @@ three events are available:
 
 ``RTE_ETH_EVENT_ERR_RECOVERING``
    Notify the application that an error is detected
-   and the recovery is being started.
+   and the recovery is beginning.
    Upon receiving the event, the application should not invoke
-   any control path function until receiving
+   any control path function until receiving the
    ``RTE_ETH_EVENT_RECOVERY_SUCCESS`` or ``RTE_ETH_EVENT_RECOVERY_FAILED`` event.
 
 .. note::
@@ -681,7 +677,7 @@ three events are available:
    because a larger error may occur during the recovery.
 
 ``RTE_ETH_EVENT_RECOVERY_SUCCESS``
-   Notify the application that the recovery from error is successful,
+   Notify the application that the recovery from the error was successful,
    the PMD already re-configures the port,
    and the effect is the same as a restart operation.
 
-- 
2.51.0

