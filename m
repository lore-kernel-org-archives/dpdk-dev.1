Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA553C87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 05:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D59AC4025D;
	Mon,  4 Aug 2025 07:36:35 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 37725400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 07:36:34 +0200 (CEST)
Received: from debian (unknown [78.109.79.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id B9532E0155;
 Mon,  4 Aug 2025 09:36:32 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am B9532E0155
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1754285793;
 bh=vpaLNKQZ41CqPzr9VQ1Xj0GP5RzNgvDOf4nvz3vZaAY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Abi+aTYvkUTI+99W1N8D4QMccwElXy3H7c/khIkUhg63JN8ukk7759Zsgv8dkVn8p
 zbCnZ6I8cuZ9wX+D2XNzlBzDVe3YLUYRuzf+xaIwd9WRg3TTk2X7fJuRccWnn28rkV
 PBGJaGbNx+Z92HsP7vikMuxNemieYxJfFRCFQTw+p35QFZEFWjC/DYghsQdUTlJfBm
 hIZAdkGD1WNG0O8qZQfya4NtgfEfIYxBOPtXSONkpf1zqKDMjW+t2oR4L41AEzKuP+
 hOkF7jeRXpudeBZaw+IEUcvDVrIL2N/OjdUUnACKqpOUmX0lcbI8O2ymyBA0ZBU6Jf
 0s6DkpsOX8Qng==
Date: Mon, 4 Aug 2025 09:36:25 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Nandini Persad <nandinipersad361@gmail.com>
cc: dev@dpdk.org
Subject: Re: [PATCH] doc: reword ethdev guide
In-Reply-To: <20250804023524.26272-1-nandinipersad361@gmail.com>
Message-ID: <29abbd83-b7d4-71bf-1422-33bc3dc43188@arknetworks.am>
References: <20250804023524.26272-1-nandinipersad361@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-244893901-1754285792=:7515"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-244893901-1754285792=:7515
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Nandini,

On Sun, 3 Aug 2025, Nandini Persad wrote:

> With the help of Ajit Khaparde, I spent some time adding minor
> information and rewriting this section for grammar and
> clarity.
>
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---
> doc/guides/prog_guide/ethdev/ethdev.rst | 381 +++++++++++++-----------
> 1 file changed, 207 insertions(+), 174 deletions(-)
>
> diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
> index 89eb31a48d..aca277c701 100644
> --- a/doc/guides/prog_guide/ethdev/ethdev.rst
> +++ b/doc/guides/prog_guide/ethdev/ethdev.rst
> @@ -4,295 +4,328 @@
> Poll Mode Driver
> ================
>
> -The DPDK includes 1 Gigabit, 10 Gigabit and 40 Gigabit and para virtualized virtio Poll Mode Drivers.
> +The Data Plane Development Kit (DPDK) supports a wife range of Ethernet speeds,

Typo: wife -> wide

> +from 10 Megabits to 400 Gigabits.

..to 400 Gigabits, depending on the hardware capabilities.

> +
> +DPDK’s Poll Mode Drivers (PMDs) are high-performance, optimized drivers for various
> +network interface cards that bypass the traditional kernel  network stack to reduce

(redundant space in 'kernel  network')

> +latency and improve throughput. They access RX and TX descriptors directly in a polling
> +mode without relying on interrupts (except for Link Status Change notifications), enabling

This may be omitting the existence of 'rte_eth_dev_rx_intr_enable' - never mind.

> +efficient packet reception and transmission in user-space applications.
> +
> +This section outlines the requirements of Ethernet PMDs, their design principles,
> +and presents a high-level architecture along with a generic external API.
>
> -A Poll Mode Driver (PMD) consists of APIs, provided through the BSD driver running in user space,
> -to configure the devices and their respective queues.
> -In addition, a PMD accesses the RX and TX descriptors directly without any interrupts
> -(with the exception of Link Status Change interrupts) to quickly receive,
> -process and deliver packets in the user's application.
> -This section describes the requirements of the PMDs,
> -their global design principles and proposes a high-level architecture and a generic external API for the Ethernet PMDs.
>
> Requirements and Assumptions
> ----------------------------
>
> -The DPDK environment for packet processing applications allows for two models, run-to-completion and pipe-line:
> +The DPDK environment for packet processing applications allows for two models: run-to-completion and pipe-line:

Perhaps spell pipeline without a hyphen.

>
> -*   In the *run-to-completion*  model, a specific port's RX descriptor ring is polled for packets through an API.
> -    Packets are then processed on the same core and placed on a port's TX descriptor ring through an API for transmission.
> +*   In the *run-to-completion*  model, a specific port’s RX descriptor ring is polled for packets through an API.
> +    Packets are then processed on the same core and transmitted via the port’s TX descriptor ring using another API.
>
> -*   In the *pipe-line*  model, one core polls one or more port's RX descriptor ring through an API.
> -    Packets are received and passed to another core via a ring.
> -    The other core continues to process the packet which then may be placed on a port's TX descriptor ring through an API for transmission.
> +*   In the *pipe-line*  model, one core polls the RX descriptor ring(s) of one or more ports via an API.

Perhaps spell pipeline without a hyphen.

> +    Received packets are then passed to another core through a ring for further processing,
> +     which may include transmission through the TX descriptor ring using an API.
>
> -In a synchronous run-to-completion model,
> -each logical core assigned to the DPDK executes a packet processing loop that includes the following steps:
> +In a synchronous run-to-completion model, each logical core (lcore)
> +assigned to DPDK executes a packet processing loop consisting of:

May be '..loop, a procedure which is as follows:', to avoid below tense changes.

>
> -*   Retrieve input packets through the PMD receive API
> +*   Retrieving input packets using the PMD receive API
>
> -*   Process each received packet one at a time, up to its forwarding
> +*   Processing each received packet individually, up to its forwarding
>
> -*   Send pending output packets through the PMD transmit API
> +*   Transmitting output packets using the PMD transmit API
>
> -Conversely, in an asynchronous pipe-line model, some logical cores may be dedicated to the retrieval of received packets and
> -other logical cores to the processing of previously received packets.
> -Received packets are exchanged between logical cores through rings.
> -The loop for packet retrieval includes the following steps:
> +In contrast, the asynchronous pipeline model assigns some logical cores to retrieve received packets
> +and others to process them. Packets are exchanged between cores via rings.
> +
> +The packet retrieval loop includes:
>
> *   Retrieve input packets through the PMD receive API
>
> *   Provide received packets to processing lcores through packet queues
>
> -The loop for packet processing includes the following steps:
> +The packet processing loop includes:
>
> -*   Retrieve the received packet from the packet queue
> +*   Dequeuing received packets from the packet queue
>
> -*   Process the received packet, up to its retransmission if forwarded
> +*   Processing packets, including retransmission if forwarded
>
> -To avoid any unnecessary interrupt processing overhead, the execution environment must not use any asynchronous notification mechanisms.
> -Whenever needed and appropriate, asynchronous communication should be introduced as much as possible through the use of rings.
> +To minimize interrupt-related overhead, the execution environment should avoid asynchronous
> +notification mechanisms. When asynchronous communication is required, it should be implemented
> +using rings where possible. Minimizing lock contention is critical in multi-core environments.
> +To support this, PMDs are designed to use per-core private resources whenever possible.
> +For example, if a PMD is not RTE_ETH_TX_OFFLOAD_MT_LOCKFREE capable, it maintains a separate
> +transmit queue per core and per port. Similarly, each receive queue is assigned to and polled by a single lcore.
>
> -Avoiding lock contention is a key issue in a multi-core environment.
> -To address this issue, PMDs are designed to work with per-core private resources as much as possible.
> -For example, a PMD maintains a separate transmit queue per-core, per-port, if the PMD is not ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable.
> -In the same way, every receive queue of a port is assigned to and polled by a single logical core (lcore).
> +To support Non-Uniform Memory Access (NUMA), memory management is designed to assign each logical
> +core a private buffer pool in local memory to reduce remote memory access. Configuration of packet
> +buffer pools should consider the underlying physical memory layout, such as DIMMs, channels, and ranks.
> +The application must ensure that proper parameters are set during memory pool creation.
>
> -To comply with Non-Uniform Memory Access (NUMA), memory management is designed to assign to each logical core
> -a private buffer pool in local memory to minimize remote memory access.
> -The configuration of packet buffer pools should take into account the underlying physical memory architecture in terms of DIMMS,
> -channels and ranks.
> -The application must ensure that appropriate parameters are given at memory pool creation time.
> See :doc:`../mempool_lib`.
>
> Design Principles
> -----------------
>
> -The API and architecture of the Ethernet* PMDs are designed with the following guidelines in mind.
> +The API and architecture of the Ethernet* Poll Mode Drivers (PMDs) are designed according to the following principles:
> +PMDs should support the enforcement of global, policy-driven decisions at the upper application level.
> +At the same time, NIC PMD functions must not hinder the performance gains expected by these higher-level policies,
> +or worse, prevent them from being implemented.
> +For example, both the receive and transmit functions of a PMD define a maximum number of packets or descriptors to poll.

If this points at the "burst" size argument, then it's packets, not descriptors.
The application has no way of knowing whether a Tx packet translates to one or
more SW/HW descriptors in any given PMD.

> +
> +This enables a run-to-completion processing stack to either statically configure or dynamically adjust its
> +behavior according to different global loop strategies, such as:
>
> -PMDs must help global policy-oriented decisions to be enforced at the upper application level.
> -Conversely, NIC PMD functions should not impede the benefits expected by upper-level global policies,
> -or worse prevent such policies from being applied.
> +*   Receiving, processing, and transmitting packets one at a time in a piecemeal fashion
>
> -For instance, both the receive and transmit functions of a PMD have a maximum number of packets/descriptors to poll.
> -This allows a run-to-completion processing stack to statically fix or
> -to dynamically adapt its overall behavior through different global loop policies, such as:
> +*   Receiving as many packets as possible, then processing and transmitting them all immediately
>
> -*   Receive, process immediately and transmit packets one at a time in a piecemeal fashion.
> +*   Receiving a set number of packets, processing them, and batching them for transmission at once
>
> -*   Receive as many packets as possible, then process all received packets, transmitting them immediately.
> +To maximize performance, overall software architecture and optimization techniques must be considered
> +alongside available low-level hardware optimizations (e.g., CPU cache behavior, bus speed, and NIC PCI bandwidth).
>
> -*   Receive a given maximum number of packets, process the received packets, accumulate them and finally send all accumulated packets to transmit.
> +One common example of this software/hardware tradeoff is packet transmission in burst-oriented network engines.
> +Originally, a PMD could expose only the rte_eth_tx_one function to transmit a single packet at a time on a given queue.

I take it, this 'rte_eth_tx_one' is mentioned in some figurative sense, like "if
it did exist, its meaning would be", because it does not seem to exist in DPDK.

>
> -To achieve optimal performance, overall software design choices and pure software optimization techniques must be considered and
> -balanced against available low-level hardware-based optimization features (CPU cache properties, bus speed, NIC PCI bandwidth, and so on).
> -The case of packet transmission is an example of this software/hardware tradeoff issue when optimizing burst-oriented network packet processing engines.
> -In the initial case, the PMD could export only an rte_eth_tx_one function to transmit one packet at a time on a given queue.
> -On top of that, one can easily build an rte_eth_tx_burst function that loops invoking the rte_eth_tx_one function to transmit several packets at a time.
> -However, an rte_eth_tx_burst function is effectively implemented by the PMD to minimize the driver-level transmit cost per packet through the following optimizations:
> +While it’s possible to build an rte_eth_tx_burst function by repeatedly calling rte_eth_tx_one,
> +most PMDs implement rte_eth_tx_burst directly to reduce per-packet transmission overhead.
>
> -*   Share among multiple packets the un-amortized cost of invoking the rte_eth_tx_one function.
> +This implementation includes several key optimizations:
>
> -*   Enable the rte_eth_tx_burst function to take advantage of burst-oriented hardware features (prefetch data in cache, use of NIC head/tail registers)
> -    to minimize the number of CPU cycles per packet, for example by avoiding unnecessary read memory accesses to ring transmit descriptors,
> -    or by systematically using arrays of pointers that exactly fit cache line boundaries and sizes.
>
> -*   Apply burst-oriented software optimization techniques to remove operations that would otherwise be unavoidable, such as ring index wrap back management.
> +*   Sharing the fixed cost of invoking rte_eth_tx_one across multiple packets
> +
> +*   Taking advantage of burst-oriented hardware features (e.g., data prefetching, NIC head/tail registers) to reduce CPU cycles per packet.

One more prominent example: vector extensions.

> +    This includes minimizing unnecessary memory accesses or leveraging pointer arrays that align with cache line boundaries and sizes.
> +
> +*   Applying software-level burst optimizations to eliminate otherwise unavoidable overheads, such as ring index wrap-around handling.
> +
> +The API also introduces burst-oriented functions for PMD-intensive services, such as buffer allocation.
> +For instance, buffer allocators used to populate NIC rings often support functions that allocate or free multiple buffers in a single call.
> +An example is mbuf_multiple_alloc, which returns an array of rte_mbuf pointers—significantly improving PMD performance

The 'mbuf_multiple_alloc' does not seem figurative and it doesn't exist in DPDK.
Perhaps, 'rte_pktmbuf_alloc_bulk'?

> +when replenishing multiple descriptors in the receive ring.
>
> -Burst-oriented functions are also introduced via the API for services that are intensively used by the PMD.
> -This applies in particular to buffer allocators used to populate NIC rings, which provide functions to allocate/free several buffers at a time.
> -For example, an mbuf_multiple_alloc function returning an array of pointers to rte_mbuf buffers which speeds up the receive poll function of the PMD when
> -replenishing multiple descriptors of the receive ring.
>
> Logical Cores, Memory and NIC Queues Relationships
> --------------------------------------------------
>
> -The DPDK supports NUMA allowing for better performance when a processor's logical cores and interfaces utilize its local memory.
> -Therefore, mbuf allocation associated with local PCIe* interfaces should be allocated from memory pools created in the local memory.
> -The buffers should, if possible, remain on the local processor to obtain the best performance results and RX and TX buffer descriptors
> -should be populated with mbufs allocated from a mempool allocated from local memory.
> +DPDK supports NUMA (Non-Uniform Memory Access), which enables improved performance when a processor’s logical
> +cores and network interfaces use memory that is local to that processor. To maximize this benefit, mbufs
> +associated with local PCIe* interfaces should be allocated from memory pools located in the same NUMA node.
>
> -The run-to-completion model also performs better if packet or data manipulation is in local memory instead of a remote processors memory.
> -This is also true for the pipe-line model provided all logical cores used are located on the same processor.
> +Ideally, these buffers should remain on the local processor to achieve optimal performance. RX and TX buffer
> +descriptors should be populated with mbufs from mempools created in local memory.
> +The run-to-completion model also benefits from having packet data and associated operations performed
> +in local memory, rather than accessing remote memory across NUMA nodes.
>
> -Multiple logical cores should never share receive or transmit queues for interfaces since this would require global locks and hinder performance.
> +The same applies to the pipeline model, provided that all logical cores involved are on the same processor.
> +Receive and transmit queues should never be shared between multiple logical cores, as doing so would require
> +global locks and severely impact performance. If the PMD supports the RTE_ETH_TX_OFFLOAD_MT_LOCKFREE offload,
> +multiple threads can call rte_eth_tx_burst() concurrently on the same TX queue without needing a software lock.
>
> -If the PMD is ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capable, multiple threads can invoke ``rte_eth_tx_burst()``
> -concurrently on the same tx queue without SW lock. This PMD feature found in some NICs and useful in the following use cases:
> +This capability, available in some NICs, can be advantageous in the following scenarios:
>
> -*  Remove explicit spinlock in some applications where lcores are not mapped to Tx queues with 1:1 relation.
> +*  Eliminates the need for explicit spinlocks in applications where TX queues are not mapped 1:1 to logical cores.

Eliminat'ing', to match above 'scenarios'?

>
> -*  In the eventdev use case, avoid dedicating a separate TX core for transmitting and thus
> -   enables more scaling as all workers can send the packets.
> +*  In eventdev-based workloads, allows all worker threads to transmit packets, removing the need for a dedicated

May be 'allow'?

> +   TX core and enabling greater scalability.

Interesting! But perhaps sending packets from multiple Tx threads is just OK?
They anyway go out the same physical port, the only question is packet order,
but I don't see how 'MT_LOCKFREE' solves this. May be I'm wrong in fact.

>
> See `Hardware Offload`_ for ``RTE_ETH_TX_OFFLOAD_MT_LOCKFREE`` capability probing details.
>
> +
> Device Identification, Ownership and Configuration
> --------------------------------------------------
>
> Device Identification
> ~~~~~~~~~~~~~~~~~~~~~
>
> -Each NIC port is uniquely designated by its (bus/bridge, device, function) PCI
> -identifiers assigned by the PCI probing/enumeration function executed at DPDK initialization.
> -Based on their PCI identifier, NIC ports are assigned two other identifiers:
> +Each NIC port is uniquely identified by its PCI (bus/bridge, device, function) identifiers,

Can be expressed shortly as "by its PCI BDF". Also, doesn't DPDK now include
certain vdev NICs, such as 'af_xdp', 'pcap', that aren't bound to PCI thing?

> +which are assigned during the PCI probing and enumeration phase at DPDK initialization.

Not necessarily at DPDK initialization (in the "global" sense), as there are
also hotplug add/remove APIs nowadays.

> +Based on these PCI identifiers, each NIC port is also assigned two additional identifiers:
>
> -*   A port index used to designate the NIC port in all functions exported by the PMD API.
> +*   A port index, used to refer to the NIC port in all PMD API function calls.
>
> -*   A port name used to designate the port in console messages, for administration or debugging purposes.
> -    For ease of use, the port name includes the port index.
> +*   A port name, used in console messages for administration and debugging.
> +    For convenience, the port name includes the port index.

I can imagine the 'hotplug add' API being called during the runtime, when, say,
three ports are already present, with the name requested, say, 'net_pcap0', but
the port ID for that will be '3'. Or am I missing something?

>
> Port Ownership
> ~~~~~~~~~~~~~~
>
> -The Ethernet devices ports can be owned by a single DPDK entity (application, library, PMD, process, etc).
> -The ownership mechanism is controlled by ethdev APIs and allows to set/remove/get a port owner by DPDK entities.
> -It prevents Ethernet ports to be managed by different entities.
> +Ethernet device ports can be owned by a single DPDK entity such as an application, library, PMD, or process.
> +The ownership mechanism is managed through ethdev APIs, which allow entities to set, remove, or retrieve port
> +ownership. This ensures that Ethernet ports are not concurrently controlled by multiple entities.
>
> .. note::
>
> -    It is the DPDK entity responsibility to set the port owner before using it and to manage the port usage synchronization between different threads or processes.
> +    It is the DPDK entity’s responsibility to set the port owner before using it and to manage the port usage synchronization between different threads or processes.
> +
>
> It is recommended to set port ownership early,
> -like during the probing notification ``RTE_ETH_EVENT_NEW``.
> +ideally, during the probing notification ``RTE_ETH_EVENT_NEW``.
>
> Device Configuration
> ~~~~~~~~~~~~~~~~~~~~
>
> -The configuration of each NIC port includes the following operations:
> +The configuration of each NIC port involves the following operations:
>
> -*   Allocate PCI resources
> +* Configuring hardware for:
>
> -*   Reset the hardware (issue a Global Reset) to a well-known default state
> +   * Packet inspection, classification, and associated actions
>
> -*   Set up the PHY and the link
> +   * Traffic metering and policing, if required
>
> -*   Initialize statistics counters
> +   * RX and TX queues, including hairpin queues if supported
>
> -The PMD API must also export functions to start/stop the all-multicast feature of a port and functions to set/unset the port in promiscuous mode.
> +* Allocating PCI resources
> +
> +* Reset the hardware (issue a Global Reset) to a well-known default state
> +
> +* Set up the PHY and the link
> +
> +* Initialize statistics counters
> +
> +The PMD API must also provide functions to enable or disable the all-multicast feature,
> +as well as functions to set or clear promiscuous mode for each port.
> +
> +Some hardware offload capabilities must be explicitly configured during port initialization

I'd say it's offloads that can be configured. Capabilities can be queried.

> +using specific parameters. Examples include Receive Side Scaling (RSS) and Data Center Bridging (DCB).
>
> -Some hardware offload features must be individually configured at port initialization through specific configuration parameters.
> -This is the case for the Receive Side Scaling (RSS) and Data Center Bridging (DCB) features for example.
>
> On-the-Fly Configuration
> ~~~~~~~~~~~~~~~~~~~~~~~~
>
> -All device features that can be started or stopped "on the fly" (that is, without stopping the device) do not require the PMD API to export dedicated functions for this purpose.
> +Device features that can be enabled or disabled on the fly (without stopping the device)
> +do not require the PMD API to expose dedicated functions for their control.
> +Instead, configuring these features externally only requires access to the mapped address
> +of the device’s PCI registers. This allows configuration to be handled by functions outside the driver itself.
> +
> +To support this, the PMD API provides a function that returns all relevant device information
> +needed to configure such features externally. This includes:
> +
> +*  PCI vendor ID
> +
> +*  PCI device ID
> +
> +*  Mapped address of the PCI device registers
>
> -All that is required is the mapping address of the device PCI registers to implement the configuration of these features in specific functions outside of the drivers.
> +*  Name of the driver
>
> -For this purpose,
> -the PMD API exports a function that provides all the information associated with a device that can be used to set up a given device feature outside of the driver.
> -This includes the PCI vendor identifier, the PCI device identifier, the mapping address of the PCI device registers, and the name of the driver.
> +The key advantage of this approach is that it provides flexibility, allowing any API
> +or external mechanism to be used for feature configuration, activation, or deactivation.
>
> -The main advantage of this approach is that it gives complete freedom on the choice of the API used to configure, to start, and to stop such features.
> +For example, the IEEE1588 feature on the Intel® 82576 Gigabit Ethernet Controller
> +and Intel® 82599 10 Gigabit Ethernet Controller can be configured this way using the testpmd application.
> +Other features, such as L3/L4 5-Tuple packet filtering, can also be configured similarly. Ethernet

Filtering? Does this point at customised parsing via the 'ddp' thing in fact?

> +flow control (pause frame) is configurable per port—see the testpmd source code for implementation details.

Port-see? Perhaps 'per port, - see'.

>
> -As an example, refer to the configuration of the IEEE1588 feature for the Intel® 82576 Gigabit Ethernet Controller and
> -the Intel® 82599 10 Gigabit Ethernet Controller controllers in the testpmd application.
> +In addition, L4 checksum offload (UDP/TCP/SCTP) can be enabled on a per-packet basis, provided
> +the packet’s mbuf is correctly set up. See `Hardware Offload`_ for details
>
> -Other features such as the L3/L4 5-Tuple packet filtering feature of a port can be configured in the same way.
> -Ethernet* flow control (pause frame) can be configured on the individual port.
> -Refer to the testpmd source code for details.
> -Also, L4 (UDP/TCP/ SCTP) checksum offload by the NIC can be enabled for an individual packet as long as the packet mbuf is set up correctly. See `Hardware Offload`_ for details.
>
> Configuration of Transmit Queues
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -Each transmit queue is independently configured with the following information:
> +Each transmit (TX) queue is configured independently with the following parameters:
>
> -*   The number of descriptors of the transmit ring
> +* Number of descriptors in the transmit ring.
>
> -*   The socket identifier used to identify the appropriate DMA memory zone from which to allocate the transmit ring in NUMA architectures
> +* Socket identifier to select the appropriate DMA memory zone for TX ring allocation in NUMA systems.
>
> -*   The values of the Prefetch, Host and Write-Back threshold registers of the transmit queue
> +* Threshold values for the prefetch, host, and write-back registers of the TX queue.

I'd add ", if supported by the PMD", as hardly all vendors support this.

>
> -*   The *minimum* transmit packets to free threshold (tx_free_thresh).
> -    When the number of descriptors used to transmit packets exceeds this threshold, the network adaptor should be checked to see if it has written back descriptors.
> -    A value of 0 can be passed during the TX queue configuration to indicate the default value should be used.
> -    The default value for tx_free_thresh is 32.
> -    This ensures that the PMD does not search for completed descriptors until at least 32 have been processed by the NIC for this queue.
> +* Transmit free threshold (tx_free_thresh) — the minimum number of transmitted packets that must accumulate before checking whether the network adapter has written back descriptors.
>
> -*   The *minimum*  RS bit threshold. The minimum number of transmit descriptors to use before setting the Report Status (RS) bit in the transmit descriptor.
> -    Note that this parameter may only be valid for Intel 10 GbE network adapters.
> -    The RS bit is set on the last descriptor used to transmit a packet if the number of descriptors used since the last RS bit setting,
> -    up to the first descriptor used to transmit the packet, exceeds the transmit RS bit threshold (tx_rs_thresh).
> -    In short, this parameter controls which transmit descriptors are written back to host memory by the network adapter.
> -    A value of 0 can be passed during the TX queue configuration to indicate that the default value should be used.
> -    The default value for tx_rs_thresh is 32.
> -    This ensures that at least 32 descriptors are used before the network adapter writes back the most recently used descriptor.
> -    This saves upstream PCIe* bandwidth resulting from TX descriptor write-backs.
> -    It is important to note that the TX Write-back threshold (TX wthresh) should be set to 0 when tx_rs_thresh is greater than 1.
> -    Refer to the Intel® 82599 10 Gigabit Ethernet Controller Datasheet for more details.
> +   * If set to 0, the default value is used.
>
> -The following constraints must be satisfied for tx_free_thresh and tx_rs_thresh:
> +   * The default is 32, ensuring that the PMD does not poll for completed descriptors until at least 32 have been processed by the NIC.

Until "..have been queued by the driver for transmittion" may be?

>
> -*   tx_rs_thresh must be greater than 0.
> +* Transmit RS (Report Status) threshold (tx_rs_thresh): the minimum number of TX descriptors used before setting the RS bit in a descriptor.
>
> -*   tx_rs_thresh must be less than the size of the ring minus 2.
> +   * This parameter is typically relevant for Intel 10 GbE network adapters.
>
> -*   tx_rs_thresh must be less than or equal to tx_free_thresh.
> +   * The RS bit is set on the last descriptor used to transmit a packet if the number of descriptors used since the last RS bit exceeds this threshold.
>
> -*   tx_free_thresh must be greater than 0.
> +   * If set to 0, the default value is used.
>
> -*   tx_free_thresh must be less than the size of the ring minus 3.
> +   * The default value is 32, which helps conserve PCIe* bandwidth by reducing write-backs to host memory.
>
> -*   For optimal performance, TX wthresh should be set to 0 when tx_rs_thresh is greater than 1.
> +   * When tx_rs_thresh > 1, TX write-back threshold (TX wthresh) should be set to 0.
>
> -One descriptor in the TX ring is used as a sentinel to avoid a hardware race condition, hence the maximum threshold constraints.
> +For more details, refer to the Intel® 82599 10 Gigabit Ethernet Controller Datasheet.
>
> .. note::
>
>     When configuring for DCB operation, at port initialization, both the number of transmit queues and the number of receive queues must be set to 128.
>
> +
> Free Tx mbuf on Demand
> ~~~~~~~~~~~~~~~~~~~~~~
>
> -Many of the drivers do not release the mbuf back to the mempool, or local cache,
> -immediately after the packet has been transmitted.
> -Instead, they leave the mbuf in their Tx ring and
> -either perform a bulk release when the ``tx_rs_thresh`` has been crossed
> -or free the mbuf when a slot in the Tx ring is needed.
> -
> -An application can request the driver to release used mbufs with the ``rte_eth_tx_done_cleanup()`` API.
> -This API requests the driver to release mbufs that are no longer in use,
> -independent of whether or not the ``tx_rs_thresh`` has been crossed.
> -There are two scenarios when an application may want the mbuf released immediately:
> -
> -* When a given packet needs to be sent to multiple destination interfaces
> -  (either for Layer 2 flooding or Layer 3 multi-cast).
> -  One option is to make a copy of the packet or a copy of the header portion that needs to be manipulated.
> -  A second option is to transmit the packet and then poll the ``rte_eth_tx_done_cleanup()`` API
> -  until the reference count on the packet is decremented.
> -  Then the same packet can be transmitted to the next destination interface.
> -  The application is still responsible for managing any packet manipulations needed
> -  between the different destination interfaces, but a packet copy can be avoided.
> -  This API is independent of whether the packet was transmitted or dropped,
> -  only that the mbuf is no longer in use by the interface.
> -
> -* Some applications are designed to make multiple runs, like a packet generator.
> -  For performance reasons and consistency between runs,
> -  the application may want to reset back to an initial state
> -  between each run, where all mbufs are returned to the mempool.
> -  In this case, it can call the ``rte_eth_tx_done_cleanup()`` API
> -  for each destination interface it has been using
> -  to request it to release of all its used mbufs.
> -
> -To determine if a driver supports this API, check for the *Free Tx mbuf on demand* feature
> -in the *Network Interface Controller Drivers* document.
> +Many drivers do not immediately return mbufs to the mempool or local cache after a packet has been transmitted.
> +Instead, they retain the mbuf in the TX ring and either:
> +
> +* Perform a bulk release once the tx_rs_thresh threshold has been crossed, or

Did you mean 'tx_free_thresh'?

> +
> +* Free the mbuf only when a slot in the TX ring is needed.
> +
> +To manually trigger the release of used mbufs, applications can use the rte_eth_tx_done_cleanup() API.
> +This function requests the driver to free all mbufs no longer in use—regardless of whether tx_rs_thresh has been crossed.

The 'use-regardless' looks odd. And may be 'tx_free_thresh' in fact?

> +
> +There are two main use cases where immediate mbuf release may be desired:
> +
> +1. Multi-destination Packet Transmission
> +
> +When a single packet must be sent to multiple destination interfaces (e.g., Layer 2 flooding or Layer 3 multicast), two approaches exist:
> +
> +Copy the packet, or at least the header portion to modify as needed for each destination.
> +
> +Use rte_eth_tx_done_cleanup() to release the mbuf after the first transmission.
> +Once the reference count is decremented, the same packet can be sent to another destination.
> +
> +Note: The application remains responsible for making any necessary packet modifications between transmissions.
> +This method works whether the packet was transmitted or dropped—what matters is that the mbuf is no longer in use by the interface.

The 'dropped-what' bit is odd.

> +
> +2. Applications with Multiple Execution Runs
> +
> +Some applications, such as packet generators, may operate in repeated runs.
> +For consistency and performance, they may wish to return to a clean state between runs,
> +ensuring all mbufs are returned to the mempool.
> +
> +In this case, the application can call rte_eth_tx_done_cleanup() for each interface used,
> +requesting the driver to release all in-use mbufs.
> +
> +To check if a driver supports this feature, refer to the Free Tx mbuf on demand capability
> +listed in the Network Interface Controller Drivers documentation.
>
> Hardware Offload
> ~~~~~~~~~~~~~~~~
>
> -Depending on driver capabilities advertised by
> -``rte_eth_dev_info_get()``, the PMD may support hardware offloading
> -feature like checksumming, TCP segmentation, VLAN insertion or
> -lockfree multithreaded TX burst on the same TX queue.
> +Based on the capabilities reported by rte_eth_dev_info_get(),
> +a PMD may support various hardware offload features, including:
> +
> +* Checksumming (IP, UDP, TCP)
> +* UDP and TCP segmentation
> +* VLAN insertion and stripping
> +* MACsec (Media Access Control Security)
> +* Large Receive Offload (LRO)
> +* Lock-free multithreaded TX bursts on the same TX queue
> +* Buffer split offload

Also: timestamping.

> +
> +When buffer split offload is supported, the driver must configure an appropriate memory pool
> +and set the required parameters to enable the feature.
> +
> +Support for these offloads introduces additional status bits and value fields in the rte_mbuf structure.
> +These fields must be correctly handled by the PMD’s transmit and receive functions.
> +The complete list of flags, their usage, and detailed explanations are provided in the mbuf API
> +documentation and the :ref:mbuf_meta chapter.
> +
> +Additionally, drivers must be capable of handling scattered packets, where the data is spread

Is it an absolute "must"?

Thank you.

> +across multiple mbuf segments stitched together.
>
> -The support of these offload features implies the addition of dedicated
> -status bit(s) and value field(s) into the rte_mbuf data structure, along
> -with their appropriate handling by the receive/transmit functions
> -exported by each PMD. The list of flags and their precise meaning is
> -described in the mbuf API documentation and in the :ref:`mbuf_meta` chapter.
>
> Per-Port and Per-Queue Offloads
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -- 
> 2.34.1
>
>
--8323328-244893901-1754285792=:7515--
