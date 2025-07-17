Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB12C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 22:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A481740665;
	Fri, 18 Jul 2025 00:09:46 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 86E5240665
 for <dev@dpdk.org>; Fri, 18 Jul 2025 00:09:44 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id B78C01D00120;
 Thu, 17 Jul 2025 18:09:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 17 Jul 2025 18:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752790183;
 x=1752876583; bh=Bja9F3s66k7qFsuEBgFBRjkh8ulV0TnxtQsdzyhJ2+s=; b=
 XoXulmnKNB/TmprQDeFjx81e9PQTkwIValfaPdp3kxZCyKaWhroQoQj3b15Xdkmr
 AvloOmYOQGvLOMfWImPNbDg92PeD2DP4LmmrtBCCE7kH6Va0U9MftCvR/V7Hj3tk
 WcjQJkPevZ0W/7zklNzQsumbZmeJ8mZVZSJLVTUlv0wjJHsvhu8AoFaQ41wscJ2y
 Buo/88J5qJexSifLe1/2XNAaFGR2DPz/c8YIdBHCXljx8KyyC9WB4rFNZYrhZjY/
 mZ7yEWSl89YcqtgpFozkg8bGcnqfTSjybOeOeaDG8ixTxE14wCIH5pgJA8RtZ5bQ
 VS8tZk9vEIKMw1R4FBPTlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752790183; x=
 1752876583; bh=Bja9F3s66k7qFsuEBgFBRjkh8ulV0TnxtQsdzyhJ2+s=; b=O
 hceA3GhAyQRMAHsbTCg+jegs5QC+b8DkYNvMznA0Wk0e349kEidwBcJVUeOithSC
 XB1ai1IG+pC7d4kGLYt/JCIeeX7viWxC1MKTyAm32qgIaoyhQU8APOqbWpDXdLwH
 DZ4WKRHHJPrXRlLGPZaaXll/iTgR/x5yqB0oJCY3CSIduCUmGF4Enhg+XFzv6YzZ
 J2RTox0QjOLMNsMmANKdN8THObPK486IGeryloDbKmsUIqPiXRUoKJghgtOpAZ2Q
 kBQ2mj9NQ7tXwTN/AY7esPoCQRWFQjiK/PE+aqXBQdclrikMwMALxFV9xOgU2CrW
 dfDxBUUnep1SLlRagm4Tw==
X-ME-Sender: <xms:p3R5aF6BE42iVi-oudDxs4vew0DJCNBK6ymbrZaFLSrbA_5h81krfw>
 <xme:p3R5aKT_OGwGuRJhan6R29aafCo8R_EHlFp7Hkq2rM2AzrENSndFRY6iGt-kED5RC
 dUjAmc3rz-ej_KzUw>
X-ME-Received: <xmr:p3R5aCA18Ctf1hx4KW7riL-FjVukj3lUYz7c3YjR6w0dJBku3Kci91_E8SH-ozTfR4msE9Oz9RVuxWWV7_niJ4Mrs5O8w4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedugeefvdegveekueeuudegleetjedutedvjeevhffhudegkedvgfdt
 udeiuefgheenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epuggvvhesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhi
 ughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtg
 homhdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopeho
 rhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehnvh
 hiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:p3R5aKE6xSmoED7INNuVIsOiMCtsIxHfqlC9359xy1tNEL8Ad55Wyg>
 <xmx:p3R5aMAKwjTHsYT8zc19jl-XK3LN1o9wwHWnMX15dU2IW1MSxHgK8Q>
 <xmx:p3R5aCXo-3wKIAhvYgba55_8KokcEaXOjzTomgXzsDgaUqBxHdi4pg>
 <xmx:p3R5aIp1PPSPZf5BFnNZCu1E68Ujh4vbqjR_-gyNP1ZqodPhrKy1Ng>
 <xmx:p3R5aKTFyOzkKeixNUzNkBJIgYe_SjN5KKRdzzH4A8UHrV2IrxC-lTls>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 18:09:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 3/4] doc: rework mlx5 guide per features
Date: Fri, 18 Jul 2025 00:05:43 +0200
Message-ID: <20250717220912.376503-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717220912.376503-1-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
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

The documentation for net mlx5 is reworded and re-organized.
Design, configuration, requirements and limitations
are grouped per features for easier reading.

New details are added, and more will come later.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/nics/features/mlx5.ini             |    1 +
 doc/guides/nics/mlx5.rst                      | 4573 +++++++++++------
 doc/guides/platform/mlx5.rst                  |   39 +-
 doc/guides/prog_guide/ethdev/flow_offload.rst |    7 +-
 doc/guides/sample_app_ug/flow_filtering.rst   |    2 +-
 5 files changed, 3108 insertions(+), 1514 deletions(-)

diff --git a/doc/guides/nics/features/mlx5.ini b/doc/guides/nics/features/mlx5.ini
index 264254839f..4f9c4c309b 100644
--- a/doc/guides/nics/features/mlx5.ini
+++ b/doc/guides/nics/features/mlx5.ini
@@ -53,6 +53,7 @@ Power8               = Y
 x86-32               = Y
 x86-64               = Y
 Usage doc            = Y
+Design doc           = Y
 
 [rte_flow items]
 aggr_affinity        = Y
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 1b136f083a..63c2770018 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1,6 +1,7 @@
-..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright 2015 6WIND S.A.
-    Copyright 2015 Mellanox Technologies, Ltd
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2015 6WIND S.A.
+   Copyright 2015 Mellanox Technologies, Ltd
+   Copyright (c) 2025 NVIDIA Corporation & Affiliates
 
 .. include:: <isonum.txt>
 
@@ -51,1000 +52,116 @@ A DPU can act as a NIC in NIC mode.
 Design
 ------
 
-Besides its dependency on libibverbs (that implies libmlx5 and associated
-kernel support), librte_net_mlx5 relies heavily on system calls for control
-operations such as querying/updating the MTU and flow control parameters.
+Please refer to the :ref:`mlx5 design <mlx5_common_design>`
+for considerations relevant to all mlx5 drivers.
 
+This driver is designed with a strong emphasis on performance,
+with data available in the `performance reports <https://core.dpdk.org/perf-reports/>`_
+published after each major releases.
+
+Performance optimization is addressed in many paths:
+
+- Steering performed in software using the Rx/Tx packet API.
+- Steering partially offloaded to hardware via the flow API.
+- Steering fully handled in the hardware switch using flow offload and hairpin API.
+
+Rx/Tx packet burst
+~~~~~~~~~~~~~~~~~~
+
+The Rx / Tx data path use different techniques to offer the best performance.
+
+- If the enabled features are compatible, a vectorized data path will be selected.
+  It means the implementation will use some SIMD (vectorized) instructions
+  as much as possible to accelerate the packet burst processing.
+
+- On the receiving (Rx) side, some PCI bandwidth is saved
+  by :ref:`compressing the packet descriptors (CQE) <mlx5_cqe_comp_param>`.
+  This feature is enabled by default.
+
+- Additional Rx acceleration for small packets is achieved
+  by further reducing PCI bandwidth usage
+  with :ref:`multi-packet Rx queues (MPRQ) <mlx5_mprq_params>`.
+  This feature is disabled by default.
+
+More details about Rx implementations and their configurations are provided
+in the chapter about :ref:`mlx5_rx_functions`.
+
+- On the transmitting (Tx) side,
+  a :ref:`packet descriptor (WQE) optimization <mlx5_tx_inline>`
+  is provided through :ref:`inlining configurations <mlx5_tx_inline_params>`.
+
+- Additional Tx acceleration for small packets is achieved
+  by saving PCI bandwidth with :ref:`enhanced Multi-Packet Write (eMPW) <mlx5_mpw_param>`.
+
+- Sending packet can be scheduled accurately
+  thanks to :ref:`time-based packet pacing <mlx5_tx_pp_param>`.
+
+
+Flow steering
+~~~~~~~~~~~~~
+
+A major benefit of the mlx5 devices
+is the :ref:`bifurcated driver <mlx5_bifurcated>` capability.
+It allows to route some flows from the device to the kernel
+while other flows go directly to the userspace PMD.
 This capability allows the PMD to coexist with kernel network interfaces
-which remain functional, although they stop receiving unicast packets as
-long as they share the same MAC address.
-This means legacy linux control tools (for example: ethtool, ifconfig and
-more) can operate on the same network interfaces that owned by the DPDK
-application.
+which remain functional, although they stop receiving unicast packets
+as long as they share the same MAC address.
+This means Linux control tools (ethtool, iproute and more)
+can operate on the same network interfaces as ones owned by the DPDK application.
+
+When using flow offload extensively,
+the configuration of the flow rules becomes performance-critical.
+That's why the hardware is evolving to offer faster flow steering access.
+The steering engine was accelerated by introducing Direct Verbs,
+and even more with Direct Rules.
+At this stage, a lot of flow rules manipulations were done in software.
+This technology is named software steering (SWS).
+Later the performance was a lot more improved
+with :ref:`hardware steering (HWS) <mlx5_hws>`,
+a WQE-based high scaling and safer flow insertion/destruction.
+It allows to insert millions of rules per second.
+
+While using the :doc:`synchronous flow API <../prog_guide/ethdev/flow_offload>`
+is convenient and easy to manage,
+it is not efficient enough at a large scale.
+That's why mlx5 allows to offload many features asynchronously.
+The :ref:`asynchronous flow API <flow_async_api>`
+makes use of :ref:`pre-configured templates <flow_template_api>`
+to insert new rules very fast with predictable performance.
+The best flow offload performance is achieved by using the asynchronous API
+which requires the :ref:`hardware steering engine <mlx5_hws>`
+to be :ref:`enabled <mlx5_dv_flow>`.
+
+The device operates flow offload in two different domains:
+
+- NIC part is where packets are going through the PCI bus
+  for Rx and Tx operations.
+
+- E-Switch is an embedded network switch
+  which may operate full offload of packet processing.
+
+Note that flow rules are not cached in the driver.
+When stopping a device port, all the flows created on this port
+from the application will be flushed automatically in the background.
+After stopping the device port, all flows on this port
+become invalid and not represented in the system.
+All references to these flows held by the application
+should be discarded directly but neither destroyed nor flushed.
+The application should re-create the flows as required after the port restart.
 
 See :doc:`../../platform/mlx5` guide for more design details,
 including prerequisites installation.
 
-Features
---------
-
-- Multi arch support: x86_64, POWER8, ARMv8, i686.
-- Multiple TX and RX queues.
-- Shared Rx queue.
-- Rx queue delay drop.
-- Rx queue available descriptor threshold event.
-- Host shaper support.
-- Support steering for external Rx queue created outside the PMD.
-- Support for scattered TX frames.
-- Advanced support for scattered Rx frames with tunable buffer attributes.
-- IPv4, IPv6, TCPv4, TCPv6, UDPv4 and UDPv6 RSS on any number of queues.
-- RSS using different combinations of fields: L3 only, L4 only or both,
-  and source only, destination only or both.
-- Several RSS hash keys, one for each flow type.
-- Default RSS operation with no hash key specification.
-- Symmetric RSS function.
-- Configurable RETA table.
-- Link flow control (pause frame).
-- Support for multiple MAC addresses.
-- VLAN filtering.
-- RX VLAN stripping.
-- TX VLAN insertion.
-- RX CRC stripping configuration.
-- TX mbuf fast free offload.
-- Promiscuous mode on PF and VF.
-- Multicast promiscuous mode on PF and VF.
-- Hardware checksum offloads.
-- Flow director (RTE_FDIR_MODE_PERFECT, RTE_FDIR_MODE_PERFECT_MAC_VLAN and
-  RTE_ETH_FDIR_REJECT).
-- Flow API, including :ref:`flow_isolated_mode`.
-- Multiple process.
-- KVM and VMware ESX SR-IOV modes are supported.
-- RSS hash result is supported.
-- Hardware TSO for generic IP or UDP tunnel, including VXLAN and GRE.
-- Hardware checksum Tx offload for generic IP or UDP tunnel, including VXLAN and GRE.
-- RX interrupts.
-- Statistics query including Basic, Extended and per queue.
-- Rx HW timestamp.
-- Tunnel types: VXLAN, L3 VXLAN, VXLAN-GPE, GRE, MPLSoGRE, MPLSoUDP, IP-in-IP, Geneve, GTP.
-- Tunnel HW offloads: packet type, inner/outer RSS, IP and UDP checksum verification.
-- NIC HW offloads: encapsulation (vxlan, gre, mplsoudp, mplsogre), NAT, routing, TTL
-  increment/decrement, count, drop, mark. For details please see :ref:`mlx5_offloads_support`.
-- Flow insertion rate of more then million flows per second, when using Direct Rules.
-- Support for multiple rte_flow groups.
-- Per packet no-inline hint flag to disable packet data copying into Tx descriptors.
-- Hardware LRO.
-- Hairpin.
-- Multiple-thread flow insertion.
-- Matching on IPv4 Internet Header Length (IHL).
-- Matching on IPv6 routing extension header.
-- Matching on GTP extension header with raw encap/decap action.
-- Matching on Geneve TLV option header with raw encap/decap action.
-- Matching on ESP header SPI field.
-- Matching on InfiniBand BTH.
-- Matching on random value.
-- Modify IPv4/IPv6 ECN field.
-- Push or remove IPv6 routing extension.
-- NAT64.
-- RSS support in sample action.
-- E-Switch mirroring and jump.
-- E-Switch mirroring and modify.
-- Send to kernel.
-- 21844 flow priorities for ingress or egress flow groups greater than 0 and for any transfer
-  flow group.
-- Flow quota.
-- Flow metering, including meter policy API.
-- Flow meter hierarchy.
-- Flow meter mark.
-- Flow integrity offload API.
-- Connection tracking.
-- Sub-Function representors.
-- Sub-Function.
-- Matching on represented port.
-- Matching on aggregated affinity.
-- Matching on external Tx queue.
-- Matching on E-Switch manager.
-
-
-Limitations
------------
-
-- Windows support:
-
-  On Windows, the features are limited:
-
-  - Promiscuous mode is not supported
-  - The following rules are supported:
-
-    - IPv4/UDP with CVLAN filtering
-    - Unicast MAC filtering
-
-  - Additional rules are supported from WinOF2 version 2.70:
-
-    - IPv4/TCP with CVLAN filtering
-    - L4 steering rules for port RSS of UDP, TCP and IP
-
-- PCI Virtual Function MTU:
-
-  MTU settings on PCI Virtual Functions have no effect.
-  The maximum receivable packet size for a VF is determined by the MTU
-  configured on its associated Physical Function.
-  DPDK applications using VFs must be prepared to handle packets
-  up to the maximum size of this PF port.
-
-- For secondary process:
-
-  - Forked secondary process not supported.
-  - MPRQ is not supported. Callback to free externally attached MPRQ buffer is set
-    in a primary process, but has a different virtual address in a secondary process.
-    Calling a function at the wrong address leads to a segmentation fault.
-  - External memory unregistered in EAL memseg list cannot be used for DMA
-    unless such memory has been registered by ``mlx5_mr_update_ext_mp()`` in
-    primary process and remapped to the same virtual address in secondary
-    process. If the external memory is registered by primary process but has
-    different virtual address in secondary process, unexpected error may happen.
-
-- Shared Rx queue:
-
-  - Counters of received packets and bytes number of devices in same share group are same.
-  - Counters of received packets and bytes number of queues in same group and queue ID are same.
-
-- Available descriptor threshold event:
-
-  - Does not support shared Rx queue and hairpin Rx queue.
-
-- The symmetric RSS function is supported by swapping source and destination
-  addresses and ports.
-
-- Host shaper:
-
-  - Support BlueField series NIC from BlueField-2.
-  - When configuring host shaper with ``RTE_PMD_MLX5_HOST_SHAPER_FLAG_AVAIL_THRESH_TRIGGERED`` flag,
-    only rates 0 and 100Mbps are supported.
-
-- Unified FDB:
-
-  - Jump FDB Rx is valid only when unified FDB is enabled,
-    as it is required to have FDB Rx/Tx.
-  - In unified FDB mode, the tag and RSS actions are only allowed in FDB Rx domain.
-
-- HW steering:
-
-  - WQE based high scaling and safer flow insertion/destruction.
-  - Set ``dv_flow_en`` to 2 in order to enable HW steering.
-  - Async queue-based ``rte_flow_async`` APIs supported only.
-  - NIC ConnectX-5 and before are not supported.
-  - Reconfiguring flow API engine is not supported.
-    Any subsequent call to ``rte_flow_configure()`` with different configuration
-    than initially provided will be rejected with ``-ENOTSUP`` error code.
-  - Partial match with item template is not supported.
-  - IPv6 5-tuple matching is not supported.
-  - With E-Switch enabled, ports which share the E-Switch domain
-    should be started and stopped in a specific order:
-
-    - When starting ports, the transfer proxy port should be started first
-      and port representors should follow.
-    - When stopping ports, all of the port representors
-      should be stopped before stopping the transfer proxy port.
-
-    If ports are started/stopped in an incorrect order,
-    ``rte_eth_dev_start()``/``rte_eth_dev_stop()`` will return an appropriate error code:
-
-    - ``-EAGAIN`` for ``rte_eth_dev_start()``.
-    - ``-EBUSY`` for ``rte_eth_dev_stop()``.
-
-  - Matching on ICMP6 following IPv6 routing extension header,
-    should match ``ipv6_routing_ext_next_hdr`` instead of ICMP6.
-    IPv6 routing extension matching is not supported in flow template relaxed
-    matching mode (see ``struct rte_flow_pattern_template_attr::relaxed_matching``).
-
-  - The supported actions order is as below::
-
-          MARK (a)
-          *_DECAP (b)
-          OF_POP_VLAN
-          COUNT | AGE
-          METER_MARK | CONNTRACK
-          OF_PUSH_VLAN
-          MODIFY_FIELD
-          *_ENCAP (c)
-          JUMP | DROP | RSS (a) | QUEUE (a) | REPRESENTED_PORT (d)
-
-    a. Only supported on ingress.
-    b. Any decapsulation action, including the combination of RAW_ENCAP and RAW_DECAP actions
-       which results in L3 decapsulation.
-       Not supported on egress.
-    c. Any encapsulation action, including the combination of RAW_ENCAP and RAW_DECAP actions
-       which results in L3 encap.
-    d. Only in transfer (switchdev) mode.
-
-  - MPLS:
-
-    - RTE_FLOW_ITEM_TYPE_MPLS matching is only supported with ``FLEX_PARSER_PROFILE_ENABLE = 1``.
-    - RTE_FLOW_ITEM_TYPE_MPLS matching is not supported on group 0.
-
-  - When using synchronous flow API,
-    the following limitations and considerations apply:
-
-    - Geneve options is supported when ``FLEX_PARSER_PROFILE_ENABLE`` = 0 (default).
-
-  - Template table with flags ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG``
-    or ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG``
-    cannot be created on group 0 (group 1 in practice),
-    since group 0 is created on startup in unified FDB domain.
-
-  - ``RTE_FLOW_ACTION_TYPE_MARK`` is not supported in FDB Tx domain.
-
-- When using Verbs flow engine (``dv_flow_en`` = 0), flow pattern without any
-  specific VLAN will match for VLAN packets as well:
-
-  When VLAN spec is not specified in the pattern, the matching rule will be created with VLAN as a wild card.
-  Meaning, the flow rule::
-
-        flow create 0 ingress pattern eth / vlan vid is 3 / ipv4 / end ...
-
-  Will only match vlan packets with vid=3. and the flow rule::
-
-        flow create 0 ingress pattern eth / ipv4 / end ...
-
-  Will match any ipv4 packet (VLAN included).
-
-- When using Verbs flow engine (``dv_flow_en`` = 0), multi-tagged(QinQ) match is not supported.
-
-- When using DV flow engine (``dv_flow_en`` = 1), flow pattern with any VLAN specification will match only single-tagged packets unless the ETH item ``type`` field is 0x88A8 or the VLAN item ``has_more_vlan`` field is 1.
-  The flow rule::
-
-        flow create 0 ingress pattern eth / ipv4 / end ...
-
-  Will match any ipv4 packet.
-  The flow rules::
-
-        flow create 0 ingress pattern eth / vlan / end ...
-        flow create 0 ingress pattern eth has_vlan is 1 / end ...
-        flow create 0 ingress pattern eth type is 0x8100 / end ...
-
-  Will match single-tagged packets only, with any VLAN ID value.
-  The flow rules::
-
-        flow create 0 ingress pattern eth type is 0x88A8 / end ...
-        flow create 0 ingress pattern eth / vlan has_more_vlan is 1 / end ...
-
-  Will match multi-tagged packets only, with any VLAN ID value.
-
-- A flow pattern with 2 sequential VLAN items is not supported.
-
-- VLAN pop offload command:
-
-  - Flow rules having a VLAN pop offload command as one of their actions and
-    are lacking a match on VLAN as one of their items are not supported.
-  - The command is not supported on egress traffic in NIC mode.
-
-- VLAN push offload is not supported on ingress traffic in NIC mode.
-
-- VLAN set PCP offload is not supported on existing headers.
-
-- A multi segment packet must have not more segments than reported by dev_infos_get()
-  in tx_desc_lim.nb_seg_max field. This value depends on maximal supported Tx descriptor
-  size and ``txq_inline_min`` settings and may be from 2 (worst case forced by maximal
-  inline settings) to 58.
-
-- Match on VXLAN supports any bits in the tunnel header
-
-  - Flag 8-bits and first 24-bits reserved fields matching
-    is only supported when using DV flow engine (``dv_flow_en`` = 2).
-  - For ConnectX-5, the UDP destination port must be the standard one (4789).
-  - Default UDP destination is 4789 if not explicitly specified.
-  - Group zero's behavior may differ which depends on FW.
-  - User should set different flags when matching on VXLAN-GPE/GBP:
-
-    - for VXLAN-GPE - P flag
-    - for VXLAN-GBP - G flag
-
-- Matching on VXLAN-GPE header fields:
-
-     - ``rsvd0``/``rsvd1`` matching support depends on FW version
-       when using DV flow engine (``dv_flow_en`` = 1).
-     - ``protocol`` should be explicitly specified in HWS (``dv_flow_en`` = 2).
-
-- L3 VXLAN and VXLAN-GPE tunnels cannot be supported together with MPLSoGRE and MPLSoUDP.
-
-- MPLSoUDP with multiple MPLS headers is only supported in HW steering (``dv_flow_en`` = 2).
-
-- Match on Geneve header supports the following fields only:
-
-     - VNI
-     - OAM
-     - protocol type
-     - options length
-
-- Match on Geneve TLV option is supported on the following fields:
-
-     - Class
-     - Type
-     - Length
-     - Data
-
-  Class/Type/Length fields must be specified as well as masks.
-  Class/Type/Length specified masks must be full.
-  Matching Geneve TLV option without specifying data is not supported.
-  Matching Geneve TLV option with ``data & mask == 0`` is not supported.
-
-  In SW steering (``dv_flow_en`` = 1):
-
-     - Only one Class/Type/Length Geneve TLV option is supported per shared device.
-     - Supported only with ``FLEX_PARSER_PROFILE_ENABLE`` = 0.
-
-  In HW steering (``dv_flow_en`` = 2):
-
-     - Multiple Class/Type/Length Geneve TLV options are supported per physical device.
-     - Multiple of same Geneve TLV option isn't supported at the same pattern template.
-     - Supported only with ``FLEX_PARSER_PROFILE_ENABLE`` = 8.
-     - Supported also with ``FLEX_PARSER_PROFILE_ENABLE`` = 0 for single DW only.
-     - Supported for FW version **xx.37.0142** and above.
-
-  .. _geneve_parser_api:
-
-  - An API (``rte_pmd_mlx5_create_geneve_tlv_parser``)
-    is available for the flexible parser used in HW steering:
-
-    Each physical device has 7 DWs for GENEVE TLV options.
-    Partial option configuration is supported,
-    mask for data is provided in parser creation
-    indicating which DWs configuration is requested.
-    Only masked data DWs can be matched later as item field using flow API.
-
-    - Matching of ``type`` field is supported for each configured option.
-    - However, for matching ``class`` field,
-      the option should be configured with ``match_on_class_mode=2``.
-      One extra DW is consumed for it.
-    - Matching on ``length`` field is not supported.
-
-    - More limitations with ``FLEX_PARSER_PROFILE_ENABLE`` = 0:
-
-      - single DW
-      - ``sample_len`` must be equal to ``option_len`` and not bigger than 1.
-      - ``match_on_class_mode`` different than 1 is not supported.
-      - ``offset`` must be 0.
-
-    Although the parser is created per physical device, this API is port oriented.
-    Each port should call this API before using GENEVE OPT item,
-    but its configuration must use the same options list
-    with same internal order configured by first port.
-
-    Calling this API for different ports under same physical device doesn't consume
-    more DWs, the first one creates the parser and the rest use same configuration.
-
-- VF: flow rules created on VF devices can only match traffic targeted at the
-  configured MAC addresses (see ``rte_eth_dev_mac_addr_add()``).
-
-- Match on GTP tunnel header item supports the following fields only:
-
-     - v_pt_rsv_flags: E flag, S flag, PN flag
-     - msg_type
-     - teid
-
-- Match on GTP extension header only for GTP PDU session container (next
-  extension header type = 0x85).
-- Match on GTP extension header is not supported in group 0.
-
-- When using DV/Verbs flow engine (``dv_flow_en`` = 1/0 respectively),
-  match on SPI field in ESP header for group 0 is supported from ConnectX-7.
-
-- Matching on SPI field in ESP header is supported over the PF only.
-
-- Flex item:
-
-  - Hardware support: **NVIDIA BlueField-2** and **NVIDIA BlueField-3**.
-  - Flex item is supported on PF only.
-  - Hardware limits ``header_length_mask_width`` up to 6 bits.
-  - Firmware supports 8 global sample fields.
-    Each flex item allocates non-shared sample fields from that pool.
-  - Supported flex item can have 1 input link - ``eth`` or ``udp``
-    and up to 3 output links - ``ipv4`` or ``ipv6``.
-  - Flex item fields (``next_header``, ``next_protocol``, ``samples``)
-    do not participate in RSS hash functions.
-  - In flex item configuration, ``next_header.field_base`` value
-    must be byte aligned (multiple of 8).
-  - Modify field with flex item, the offset must be byte aligned (multiple of 8).
-
-- Match on random value:
-
-  - Supported only with HW Steering enabled (``dv_flow_en`` = 2).
-  - Supported only in table with ``nb_flows=1``.
-  - NIC ingress/egress flow in group 0 is not supported.
-  - Supports matching only 16 bits (LSB).
-
-- Match with compare result item (``RTE_FLOW_ITEM_TYPE_COMPARE``):
-
-  - Only supported in HW steering(``dv_flow_en`` = 2) mode.
-  - Only single flow is supported to the flow table.
-  - Only single item is supported per pattern template.
-  - In switch mode, when the ``repr_matching_en`` flag is enabled in the devargs
-    (which is the default setting),
-    the match with compare result item is not supported for ``ingress`` rules.
-    This is because an implicit ``REPRESENTED_PORT`` needs to be added to the matcher,
-    which conflicts with the single item limitation.
-  - Only 32-bit comparison is supported or 16-bit for random field.
-  - Only supported for ``RTE_FLOW_FIELD_META``, ``RTE_FLOW_FIELD_TAG``,
-    ``RTE_FLOW_FIELD_ESP_SEQ_NUM``,
-    ``RTE_FLOW_FIELD_RANDOM`` and ``RTE_FLOW_FIELD_VALUE``.
-  - The field type ``RTE_FLOW_FIELD_VALUE`` must be the base (``b``) field.
-  - The field type ``RTE_FLOW_FIELD_RANDOM`` can only be compared with
-    ``RTE_FLOW_FIELD_VALUE``.
-
-- No Tx metadata go to the E-Switch steering domain for the Flow group 0.
-  The flows within group 0 and set metadata action are rejected by hardware.
-
-.. note::
-
-   MAC addresses not already present in the bridge table of the associated
-   kernel network device will be added and cleaned up by the PMD when closing
-   the device. In case of ungraceful program termination, some entries may
-   remain present and should be removed manually by other means.
-
-- Buffer split offload is supported with regular Rx burst routine only,
-  no MPRQ feature or vectorized code can be engaged.
-
-- When Multi-Packet Rx queue is configured (``mprq_en``), a Rx packet can be
-  externally attached to a user-provided mbuf with having RTE_MBUF_F_EXTERNAL in
-  ol_flags. As the mempool for the external buffer is managed by PMD, all the
-  Rx mbufs must be freed before the device is closed. Otherwise, the mempool of
-  the external buffers will be freed by PMD and the application which still
-  holds the external buffers may be corrupted.
-  User-managed mempools with external pinned data buffers
-  cannot be used in conjunction with MPRQ
-  since packets may be already attached to PMD-managed external buffers.
-
-- RSS hash result limitations:
-
-  Full support is only available when hash RSS format is selected
-  as the current CQE compression format on the Rx side (``rxq_cqe_comp_en``).
-
-  Using any other format may result in some Rx packets
-  not having the ``RTE_MBUF_F_RX_RSS_HASH`` flag set.
-
-  When multi-packet Rx queue is enabled (``mprq_en``)
-  and Rx CQE compression is enabled (``rxq_cqe_comp_en``) simultaneously,
-  RSS hash result is not fully supported.
-  This is because the checksum format is selected by default in this configuration.
-
-- IPv6 Multicast messages are not supported on VM, while promiscuous mode
-  and allmulticast mode are both set to off.
-  To receive IPv6 Multicast messages on VM, explicitly set the relevant
-  MAC address using rte_eth_dev_mac_addr_add() API.
-
-- To support a mixed traffic pattern (some buffers from local host memory, some
-  buffers from other devices) with high bandwidth, a mbuf flag is used.
-
-  An application hints the PMD whether or not it should try to inline the
-  given mbuf data buffer. PMD should do the best effort to act upon this request.
-
-  The hint flag ``RTE_PMD_MLX5_FINE_GRANULARITY_INLINE`` is dynamic,
-  registered by application with rte_mbuf_dynflag_register(). This flag is
-  purely driver-specific and declared in PMD specific header ``rte_pmd_mlx5.h``,
-  which is intended to be used by the application.
-
-  To query the supported specific flags in runtime,
-  the function ``rte_pmd_mlx5_get_dyn_flag_names`` returns the array of
-  currently (over present hardware and configuration) supported specific flags.
-  The "not inline hint" feature operating flow is the following one:
-
-    - application starts
-    - probe the devices, ports are created
-    - query the port capabilities
-    - if port supporting the feature is found
-    - register dynamic flag ``RTE_PMD_MLX5_FINE_GRANULARITY_INLINE``
-    - application starts the ports
-    - on ``dev_start()`` PMD checks whether the feature flag is registered and
-      enables the feature support in datapath
-    - application might set the registered flag bit in ``ol_flags`` field
-      of mbuf being sent and PMD will handle ones appropriately.
-
-- The amount of descriptors in Tx queue may be limited by data inline settings.
-  Inline data require the more descriptor building blocks and overall block
-  amount may exceed the hardware supported limits. The application should
-  reduce the requested Tx size or adjust data inline settings with
-  ``txq_inline_max`` and ``txq_inline_mpw`` devargs keys.
-
-- To provide the packet send scheduling on mbuf timestamps the ``tx_pp``
-  parameter should be specified.
-  When PMD sees the RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME set on the packet
-  being sent it tries to synchronize the time of packet appearing on
-  the wire with the specified packet timestamp. It the specified one
-  is in the past it should be ignored, if one is in the distant future
-  it should be capped with some reasonable value (in range of seconds).
-  These specific cases ("too late" and "distant future") can be optionally
-  reported via device xstats to assist applications to detect the
-  time-related problems.
-
-  The timestamp upper "too-distant-future" limit
-  at the moment of invoking the Tx burst routine
-  can be estimated as ``tx_pp`` option (in nanoseconds) multiplied by 2^23.
-  Please note, for the testpmd txonly mode,
-  the limit is deduced from the expression::
-
-        (n_tx_descriptors / burst_size + 1) * inter_burst_gap
-
-  There is no any packet reordering according timestamps is supposed,
-  neither within packet burst, nor between packets, it is an entirely
-  application responsibility to generate packets and its timestamps
-  in desired order. The timestamps can be put only in the first packet
-  in the burst providing the entire burst scheduling.
-
-- E-Switch decapsulation Flow:
-
-  - can be applied to PF port only.
-  - must specify VF port action (packet redirection from PF to VF).
-  - optionally may specify tunnel inner source and destination MAC addresses.
-
-- E-Switch  encapsulation Flow:
-
-  - can be applied to VF ports only.
-  - must specify PF port action (packet redirection from VF to PF).
-
-- E-Switch Manager matching:
-
-  - For BlueField with old FW
-    which doesn't expose the E-Switch Manager vport ID in the capability,
-    matching E-Switch Manager should be used only in BlueField embedded CPU mode.
-
-- Raw encapsulation:
-
-  - The input buffer, used as outer header, is not validated.
-
-- Raw decapsulation:
-
-  - The decapsulation is always done up to the outermost tunnel detected by the HW.
-  - The input buffer, providing the removal size, is not validated.
-  - The buffer size must match the length of the headers to be removed.
-
-- Outer UDP checksum calculation for encapsulation flow actions:
-
-  - Currently available NVIDIA NICs and DPUs do not have a capability to calculate
-    the UDP checksum in the header added using encapsulation flow actions.
-
-    Applications are required to use 0 in UDP checksum field in such flow actions.
-    Resulting packet will have outer UDP checksum equal to 0.
-
-- ICMP(code/type/identifier/sequence number) / ICMP6(code/type/identifier/sequence number) matching,
-  IP-in-IP and MPLS flow matching are all mutually exclusive features which cannot be supported together
-  (see :ref:`mlx5_firmware_config`).
-
-- LRO:
-
-  - Requires DevX and DV flow to be enabled.
-  - KEEP_CRC offload cannot be supported with LRO.
-  - The first mbuf length, without head-room,  must be big enough to include the
-    TCP header (122B).
-  - Rx queue with LRO offload enabled, receiving a non-LRO packet, can forward
-    it with size limited to max LRO size, not to max RX packet length.
-  - The driver rounds down the port configuration value ``max_lro_pkt_size``
-    (from ``rte_eth_rxmode``) to a multiple of 256 due to hardware limitation.
-  - LRO can be used with outer header of TCP packets of the standard format:
-        eth (with or without vlan) / ipv4 or ipv6 / tcp / payload
-
-    Other TCP packets (e.g. with MPLS label) received on Rx queue with LRO enabled, will be received with bad checksum.
-  - LRO packet aggregation is performed by HW only for packet size larger than
-    ``lro_min_mss_size``. This value is reported on device start, when debug
-    mode is enabled.
-
-- CRC:
-
-  - ``RTE_ETH_RX_OFFLOAD_KEEP_CRC`` cannot be supported with decapsulation
-    for ConnectX-6 Dx, BlueField-2, and above.
-    The capability bit ``scatter_fcs_w_decap_disable`` shows NIC support.
-
-- TX mbuf fast free:
-
-  - fast free offload assumes the all mbufs being sent are originated from the
-    same memory pool and there is no any extra references to the mbufs (the
-    reference counter for each mbuf is equal 1 on tx_burst call). The latter
-    means there should be no any externally attached buffers in mbufs. It is
-    an application responsibility to provide the correct mbufs if the fast
-    free offload is engaged. The mlx5 PMD implicitly produces the mbufs with
-    externally attached buffers if MPRQ option is enabled, hence, the fast
-    free offload is neither supported nor advertised if there is MPRQ enabled.
-
-- Sample flow:
-
-  - Supports ``RTE_FLOW_ACTION_TYPE_SAMPLE`` action only within NIC Rx and
-    E-Switch steering domain.
-  - In E-Switch steering domain, for sampling with sample ratio > 1 in a transfer rule,
-    additional actions are not supported in the sample actions list.
-  - For ConnectX-5, the ``RTE_FLOW_ACTION_TYPE_SAMPLE`` is typically used as
-    first action in the E-Switch egress flow if with header modify or
-    encapsulation actions.
-  - For NIC Rx flow, supports only ``MARK``, ``COUNT``, ``QUEUE``, ``RSS`` in the
-    sample actions list.
-  - In E-Switch steering domain, for mirroring with sample ratio = 1 in a transfer rule,
-    supports only ``RAW_ENCAP``, ``PORT_ID``, ``REPRESENTED_PORT``, ``VXLAN_ENCAP``, ``NVGRE_ENCAP``
-    in the sample actions list.
-  - In E-Switch steering domain, for mirroring with sample ratio = 1 in a transfer rule,
-    the encapsulation actions (``RAW_ENCAP`` or ``VXLAN_ENCAP`` or ``NVGRE_ENCAP``)
-    support uplink port only.
-  - In E-Switch steering domain, for mirroring with sample ratio = 1 in a transfer rule,
-    the port actions (``PORT_ID`` or ``REPRESENTED_PORT``) with uplink port and ``JUMP`` action
-    are not supported without the encapsulation actions
-    (``RAW_ENCAP`` or ``VXLAN_ENCAP`` or ``NVGRE_ENCAP``) in the sample actions list.
-  - For ConnectX-5 trusted device, the application metadata with SET_TAG index 0
-    is not supported before ``RTE_FLOW_ACTION_TYPE_SAMPLE`` action.
-
-- Modify Field flow:
-
-  - Supports the 'set' and 'add' operations for ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD`` action.
-  - Modification of an arbitrary place in a packet via the special ``RTE_FLOW_FIELD_START`` Field ID is not supported.
-  - Modify field action using ``RTE_FLOW_FIELD_RANDOM`` is not supported.
-  - Modification of the 802.1Q tag is not supported.
-  - Modification of VXLAN network or GENEVE network ID is supported only for HW steering.
-  - Modification of the VXLAN header is supported with below limitations:
-
-    - Only for HW steering (``dv_flow_en=2``).
-    - Support VNI and the last reserved byte modifications for traffic
-      with default UDP destination port: 4789 for VXLAN and VXLAN-GBP, 4790 for VXLAN-GPE.
-
-  - Modification of GENEVE network ID is not supported when configured
-    ``FLEX_PARSER_PROFILE_ENABLE`` supports Geneve TLV options.
-    See :ref:`mlx5_firmware_config` for more flex parser information.
-  - Modification of GENEVE TLV option fields is supported only for HW steering.
-    Only DWs configured in :ref:`parser creation <geneve_parser_api>` can be modified,
-    'type' and 'class' fields can be modified when ``match_on_class_mode=2``.
-  - Modification of GENEVE TLV option data supports one DW per action.
-  - Offsets cannot skip past the boundary of a field.
-  - If the field type is ``RTE_FLOW_FIELD_MAC_TYPE``
-    and packet contains one or more VLAN headers,
-    the meaningful type field following the last VLAN header
-    is used as modify field operation argument.
-    The modify field action is not intended to modify VLAN headers type field,
-    dedicated VLAN push and pop actions should be used instead.
-  - For packet fields (e.g. MAC addresses, IPv4 addresses or L4 ports)
-    offset specifies the number of bits to skip from field's start,
-    starting from MSB in the first byte, in the network order.
-  - For flow metadata fields (e.g. META or TAG)
-    offset specifies the number of bits to skip from field's start,
-    starting from LSB in the least significant byte, in the host order.
-  - Modification of the MPLS header is supported with some limitations:
-
-    - Only in HW steering.
-    - Only in ``src`` field.
-    - Only for outermost tunnel header (``level=2``).
-      For ``RTE_FLOW_FIELD_MPLS``,
-      the default encapsulation level ``0`` describes the outermost tunnel header.
-
-      .. note::
-
-         The default encapsulation level ``0`` describes
-         the "outermost that match is supported",
-         currently it is the first tunnel,
-         but it can be changed to outer when it is supported.
-
-  - Default encapsulation level ``0`` describes outermost.
-  - Encapsulation level ``2`` is supported with some limitations:
-
-    - Only in HW steering.
-    - Only in ``src`` field.
-    - ``RTE_FLOW_FIELD_VLAN_ID`` is not supported.
-    - ``RTE_FLOW_FIELD_IPV4_PROTO`` is not supported.
-    - ``RTE_FLOW_FIELD_IPV6_PROTO/DSCP/ECN`` are not supported.
-    - ``RTE_FLOW_FIELD_ESP_PROTO/SPI/SEQ_NUM`` are not supported.
-    - ``RTE_FLOW_FIELD_TCP_SEQ/ACK_NUM`` are not supported.
-    - Second tunnel fields are not supported.
-
-  - Encapsulation levels greater than ``2`` are not supported.
-
-- Age action:
-
-  - with HW steering (``dv_flow_en=2``)
-
-    - Using the same indirect count action combined with multiple age actions
-      in different flows may cause a wrong age state for the age actions.
-    - Creating/destroying flow rules with indirect age action when it is active
-      (timeout != 0) may cause a wrong age state for the indirect age action.
-
-    - The driver reuses counters for aging action, so for optimization
-      the values in ``rte_flow_port_attr`` structure should describe:
-
-      - ``nb_counters`` is the number of flow rules using counter (with/without age)
-        in addition to flow rules using only age (without count action).
-      - ``nb_aging_objects`` is the number of flow rules containing age action.
-
-- IPv6 header item 'proto' field, indicating the next header protocol, should
-  not be set as extension header.
-  In case the next header is an extension header, it should not be specified in
-  IPv6 header item 'proto' field.
-  The last extension header item 'next header' field can specify the following
-  header protocol type.
-
-- Match on IPv6 routing extension header supports the following fields only:
-
-  - ``type``
-  - ``next_hdr``
-  - ``segments_left``
-
-  Only supports HW steering (``dv_flow_en=2``).
-
-- IPv6 routing extension push/remove:
-
-  - Supported only with HW Steering enabled (``dv_flow_en=2``).
-  - Supported in non-zero group
-    (no limits on transfer domain if ``fdb_def_rule_en=1`` which is default).
-  - Only supports TCP or UDP as next layer.
-  - IPv6 routing header must be the only present extension.
-  - Not supported on guest port.
-
-- NAT64 action:
-
-  - Supported only with HW Steering enabled (``dv_flow_en`` = 2).
-  - FW version: at least ``XX.39.1002``.
-  - Supported only on non-root table.
-  - Actions order limitation should follow the modify fields action.
-  - The last 2 TAG registers will be used implicitly in address backup mode.
-  - Even if the action can be shared, new steering entries will be created per flow rule.
-    It is recommended a single rule with NAT64 should be shared
-    to reduce the duplication of entries.
-    The default address and other fields conversion will be handled with NAT64 action.
-    To support other address, new rule(s) with modify fields on the IP addresses should be created.
-  - TOS / Traffic Class is not supported now.
-
-- Hairpin:
-
-  - Hairpin between two ports could only manual binding and explicit Tx flow mode. For single port hairpin, all the combinations of auto/manual binding and explicit/implicit Tx flow mode could be supported.
-  - Hairpin in switchdev SR-IOV mode is not supported till now.
-  - ``out_of_buffer`` statistics are not available on:
-    - NICs older than ConnectX-7.
-    - DPUs older than BlueField-3.
-
-- Quota:
-
-  - Quota implemented for HWS / template API.
-  - Maximal value for quota SET and ADD operations in INT32_MAX (2GB).
-  - Application cannot use 2 consecutive ADD updates.
-    Next tokens update after ADD must always be SET.
-  - Quota flow action cannot be used with Meter or CT flow actions in the same rule.
-  - Quota flow action and item supported in non-root HWS tables.
-  - Maximal number of HW quota and HW meter objects <= 16e6.
-
-- Meter:
-
-  - All the meter colors with drop action will be counted only by the global drop statistics.
-  - Yellow detection is only supported with ASO metering.
-  - Red color must be with drop action.
-  - Meter statistics are supported only for drop case.
-  - A meter action created with pre-defined policy must be the last action in the flow except single case where the policy actions are:
-     - green: NULL or END.
-     - yellow: NULL or END.
-     - RED: DROP / END.
-  - The only supported meter policy actions:
-     - green: QUEUE, RSS, PORT_ID, REPRESENTED_PORT, JUMP, DROP, MODIFY_FIELD, MARK, METER and SET_TAG.
-     - yellow: QUEUE, RSS, PORT_ID, REPRESENTED_PORT, JUMP, DROP, MODIFY_FIELD, MARK, METER and SET_TAG.
-     - RED: must be DROP.
-  - Policy actions of RSS for green and yellow should have the same configuration except queues.
-  - Policy with RSS/queue action is not supported when ``dv_xmeta_en`` enabled.
-  - If green action is METER, yellow action must be the same METER action or NULL.
-  - meter profile packet mode is supported.
-  - meter profiles of RFC2697, RFC2698 and RFC4115 are supported.
-  - RFC4115 implementation is following MEF, meaning yellow traffic may reclaim unused green bandwidth when green token bucket is full.
-  - When using DV flow engine (``dv_flow_en`` = 1),
-    if meter has drop count
-    or meter hierarchy contains any meter that uses drop count,
-    it cannot be used by flow rule matching all ports.
-  - When using DV flow engine (``dv_flow_en`` = 1),
-    if meter hierarchy contains any meter that has MODIFY_FIELD/SET_TAG,
-    it cannot be used by flow matching all ports.
-  - When using HWS flow engine (``dv_flow_en`` = 2),
-    only meter mark action is supported.
-
-- Ptype:
-
-  - Only supports HW steering (``dv_flow_en=2``).
-  - The supported values are:
-    L2: ``RTE_PTYPE_L2_ETHER``, ``RTE_PTYPE_L2_ETHER_VLAN``, ``RTE_PTYPE_L2_ETHER_QINQ``
-    L3: ``RTE_PTYPE_L3_IPV4``, ``RTE_PTYPE_L3_IPV6``
-    L4: ``RTE_PTYPE_L4_TCP``, ``RTE_PTYPE_L4_UDP``, ``RTE_PTYPE_L4_ICMP``
-    and their ``RTE_PTYPE_INNER_XXX`` counterparts as well as ``RTE_PTYPE_TUNNEL_ESP``.
-    Any other values are not supported. Using them as a value will cause unexpected behavior.
-  - Matching on both outer and inner IP fragmented is supported
-    using ``RTE_PTYPE_L4_FRAG`` and ``RTE_PTYPE_INNER_L4_FRAG`` values.
-    They are not part of L4 types, so they should be provided explicitly
-    as a mask value during pattern template creation.
-    Providing ``RTE_PTYPE_L4_MASK`` during pattern template creation
-    and ``RTE_PTYPE_L4_FRAG`` during flow rule creation
-    will cause unexpected behavior.
-
-- Integrity:
-
-  - Verification bits provided by the hardware are ``l3_ok``, ``ipv4_csum_ok``, ``l4_ok``, ``l4_csum_ok``.
-  - ``level`` value 0 references outer headers.
-  - Negative integrity item verification is not supported.
-
-  - With SW steering (``dv_flow_en=1``)
-
-    - Integrity offload is enabled starting from **ConnectX-6 Dx**.
-    - Multiple integrity items not supported in a single flow rule.
-    - Flow rule items supplied by application must explicitly specify
-      network headers referred by integrity item.
-
-      For example, if integrity item mask sets ``l4_ok`` or ``l4_csum_ok`` bits,
-      reference to L4 network header, TCP or UDP, must be in the rule pattern as well::
-
-         flow create 0 ingress pattern integrity level is 0 value mask l3_ok value spec l3_ok / eth / ipv6 / end ...
-         flow create 0 ingress pattern integrity level is 0 value mask l4_ok value spec l4_ok / eth / ipv4 proto is udp / end ...
-
-  - With HW steering (``dv_flow_en=2``)
-    - The ``l3_ok`` field represents all L3 checks, but nothing about IPv4 checksum.
-    - The ``l4_ok`` field represents all L4 checks including L4 checksum.
-
-- Connection tracking:
-
-  - Cannot co-exist with ASO meter, ASO age action in a single flow rule.
-  - Flow rules insertion rate and memory consumption need more optimization.
-  - 16 ports maximum (with ``dv_flow_en=1``).
-  - 32M connections maximum.
-
-- Multi-thread flow insertion:
-
-  - In order to achieve best insertion rate, application should manage the flows per lcore.
-  - Better to disable memory reclaim by setting ``reclaim_mem_mode`` to 0 to accelerate the flow object allocation and release with cache.
-
-- HW hashed bonding
-
-  - TXQ affinity subjects to HW hash once enabled.
-
-- Bonding under socket direct mode
-
-  - Needs MLNX_OFED 5.4+.
-
-- Match on aggregated affinity:
-
-  - Supports NIC ingress flow in group 0.
-  - Supports E-Switch flow in group 0 and depends on
-    device-managed flow steering (DMFS) mode.
-
-- Timestamps:
-
-  - CQE timestamp field width is limited by hardware to 63 bits, MSB is zero.
-  - In the free-running mode the timestamp counter is reset on power on
-    and 63-bit value provides over 1800 years of uptime till overflow.
-  - In the real-time mode
-    (configurable with ``REAL_TIME_CLOCK_ENABLE`` firmware settings),
-    the timestamp presents the nanoseconds elapsed since 01-Jan-1970,
-    hardware timestamp overflow will happen on 19-Jan-2038
-    (0x80000000 seconds since 01-Jan-1970).
-  - The send scheduling is based on timestamps
-    from the reference "Clock Queue" completions,
-    the scheduled send timestamps should not be specified with non-zero MSB.
-
-- Match on GRE header supports the following fields:
-
-  - c_rsvd0_v: C bit, K bit, S bit
-  - protocol type
-  - checksum
-  - key
-  - sequence
-
-  Matching on checksum and sequence needs MLNX_OFED 5.6+.
-
-- Matching on NVGRE header:
-
-  - c_rc_k_s_rsvd0_ver
-  - protocol
-  - tni
-  - flow_id
-
-  In SW steering (``dv_flow_en`` = 1), only tni is supported.
-  In HW steering (``dv_flow_en`` = 2), all fields are supported.
-
-- The NIC egress flow rules on representor port are not supported.
-
-- In switch mode, flow rule matching ``RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT`` item
-  with port ID ``UINT16_MAX`` means matching packets sent by E-Switch manager from software.
-  Need MLNX_OFED 24.04+.
-
-- A driver limitation for ``RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR`` action
-  restricts the ``port_id`` configuration to only accept the value ``0xffff``,
-  indicating the E-Switch manager.
-  If the ``repr_matching_en`` flag is enabled, the traffic will be directed
-  to the representor of the source virtual port (SF/VF), while if it is disabled,
-  the traffic will be routed based on the steering rules in the ingress domain.
-
-- Send to kernel action (``RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL``):
-
-  - Supported on non-root table.
-  - Supported in isolated mode.
-  - In HW steering (``dv_flow_en`` = 2):
-    - not supported on guest port.
-
-- During live migration to a new process set its flow engine as standby mode,
-  the user should only program flow rules in group 0 (``fdb_def_rule_en=0``).
-  Live migration is only supported under SWS (``dv_flow_en=1``).
-  The flow group 0 is shared between DPDK processes
-  while the other flow groups are limited to the current process.
-  The flow engine of a process cannot move from active to standby mode
-  if preceding active application rules are still present and vice versa.
-
-
-Statistics
-----------
-
-MLX5 supports various methods to report statistics:
-
-Port statistics can be queried using ``rte_eth_stats_get()``. The received and sent statistics are through SW only and counts the number of packets received or sent successfully by the PMD. The imissed counter is the amount of packets that could not be delivered to SW because a queue was full. Packets not received due to congestion in the bus or on the NIC can be queried via the rx_discards_phy xstats counter.
-
-Extended statistics can be queried using ``rte_eth_xstats_get()``. The extended statistics expose a wider set of counters counted by the device. The extended port statistics counts the number of packets received or sent successfully by the port. As NVIDIA NICs are using the :ref:`Bifurcated Linux Driver <linux_gsg_linux_drivers>` those counters counts also packet received or sent by the Linux kernel. The counters with ``_phy`` suffix counts the total events on the physical port, therefore not valid for VF.
-
-Finally per-flow statistics can by queried using ``rte_flow_query`` when attaching a count action for specific flow. The flow counter counts the number of packets received successfully by the port and match the specific flow.
-
-
-Extended Statistics Counters
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Send Scheduling Counters
-^^^^^^^^^^^^^^^^^^^^^^^^
-
-The mlx5 PMD provides a comprehensive set of counters designed for
-debugging and diagnostics related to packet scheduling during transmission.
-These counters are applicable only if the port was configured with the ``tx_pp`` devarg
-and reflect the status of the PMD scheduling infrastructure
-based on Clock and Rearm Queues, used as a workaround on ConnectX-6 DX NICs.
-
-``tx_pp_missed_interrupt_errors``
-  Indicates that the Rearm Queue interrupt was not serviced on time.
-  The EAL manages interrupts in a dedicated thread,
-  and it is possible that other time-consuming actions were being processed concurrently.
-
-``tx_pp_rearm_queue_errors``
-  Signifies hardware errors that occurred on the Rearm Queue,
-  typically caused by delays in servicing interrupts.
-
-``tx_pp_clock_queue_errors``
-  Reflects hardware errors on the Clock Queue,
-  which usually indicate configuration issues
-  or problems with the internal NIC hardware or firmware.
-
-``tx_pp_timestamp_past_errors``
-  Tracks the application attempted to send packets with timestamps set in the past.
-  It is useful for debugging application code
-  and does not indicate a malfunction of the PMD.
-
-``tx_pp_timestamp_future_errors``
-  Records attempts by the application to send packets
-  with timestamps set too far into the future,
-  exceeding the hardware’s scheduling capabilities.
-  Like the previous counter, it aids in application debugging
-  without suggesting a PMD malfunction.
-
-``tx_pp_jitter``
-  Measures the internal NIC real-time clock jitter estimation
-  between two consecutive Clock Queue completions, expressed in nanoseconds.
-  Significant jitter may signal potential clock synchronization issues,
-  possibly due to inappropriate adjustments
-  made by a system PTP (Precision Time Protocol) agent.
-
-``tx_pp_wander``
-  Indicates the long-term stability of the internal NIC real-time clock
-  over 2^24 completions, measured in nanoseconds.
-  Significant wander may also suggest clock synchronization problems.
-
-``tx_pp_sync_lost``
-  A general operational indicator;
-  a non-zero value indicates that the driver has lost synchronization with the Clock Queue,
-  resulting in improper scheduling operations.
-  To restore correct scheduling functionality, it is necessary to restart the port.
-
-The following counters are particularly valuable for verifying and debugging application code.
-They do not indicate driver or hardware malfunctions
-and are applicable to newer hardware with direct on-time scheduling capabilities
-(such as ConnectX-7 and above):
-
-``tx_pp_timestamp_order_errors``
-  Indicates attempts by the application to send packets
-  with timestamps that are not in strictly ascending order.
-  Since the PMD does not reorder packets within hardware queues,
-  violations of timestamp order can lead to packets being sent at incorrect times.
+:ref:`All the features are detailed in a chapter below. <mlx5_net_features>`
 
 
 Compilation
 -----------
 
-See :ref:`mlx5 common compilation <mlx5_common_compilation>`.
+The dependencies and steps are described in
+the :ref:`common compilation chapter <mlx5_common_compilation>`
+for all mlx5 drivers.
 
 
 Configuration
@@ -1053,12 +170,19 @@ Configuration
 Environment Configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-See :ref:`mlx5 common configuration <mlx5_common_env>`.
+The variables and tools are described in
+the :ref:`common environment configuration chapter <mlx5_common_env>`
+for all mlx5 drivers.
 
 Firmware configuration
 ~~~~~~~~~~~~~~~~~~~~~~
 
-See :ref:`mlx5_firmware_config` guide.
+The firmware variables required for specific networking features
+are described as part of each feature in this guide.
+
+All the variables and tools are described in
+the :ref:`common firmware configuration chapter <mlx5_firmware_config>`
+for all mlx5 drivers.
 
 Runtime Configuration
 ~~~~~~~~~~~~~~~~~~~~~
@@ -1075,10 +199,12 @@ for an additional list of options shared with other mlx5 drivers.
 
   .. note::
 
-    There is a race condition in probing port if ``probe_opt_en`` is enabled.
-    Port probing may fail with a wrong ifindex in cache
-    while the interrupt thread is updating the cache.
-    Please try again if port probing failed.
+     There is a race condition in probing port if ``probe_opt_en`` is enabled.
+     Port probing may fail with a wrong ifindex in cache
+     while the interrupt thread is updating the cache.
+     Please try again if port probing failed.
+
+.. _mlx5_cqe_comp_param:
 
 - ``rxq_cqe_comp_en`` parameter [int]
 
@@ -1106,9 +232,9 @@ for an additional list of options shared with other mlx5 drivers.
   Supported on:
 
   - x86_64 with ConnectX-4, ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
   - POWER9 and ARMv8 with ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
 
 - ``rxq_pkt_pad_en`` parameter [int]
 
@@ -1121,9 +247,11 @@ for an additional list of options shared with other mlx5 drivers.
   Supported on:
 
   - x86_64 with ConnectX-4, ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
   - POWER8 and ARMv8 with ConnectX-4 Lx, ConnectX-5, ConnectX-6, ConnectX-6 Dx,
-    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField, BlueField-2, and BlueField-3.
+    ConnectX-6 Lx, ConnectX-7, ConnectX-8, BlueField-2, and BlueField-3.
+
+.. _mlx5_delay_drop_param:
 
 - ``delay_drop`` parameter [int]
 
@@ -1142,15 +270,17 @@ for an additional list of options shared with other mlx5 drivers.
   MLNX_OFED 5.5.
 
   To enable / disable the delay drop rearming, the private flag ``dropless_rq``
-  can be set and queried via ethtool:
+  can be set and queried via ethtool::
 
-  - ethtool --set-priv-flags <netdev> dropless_rq on (/ off)
-  - ethtool --show-priv-flags <netdev>
+     ethtool --set-priv-flags <netdev> dropless_rq on (/ off)
+     ethtool --show-priv-flags <netdev>
 
   The configuration flag is global per PF and can only be set on the PF, once
   it is on, all the VFs', SFs' and representors' Rx queues will share the timer
   and rearming.
 
+.. _mlx5_mprq_params:
+
 - ``mprq_en`` parameter [int]
 
   A nonzero value enables configuring Multi-Packet Rx queues. Rx queue is
@@ -1159,7 +289,7 @@ for an additional list of options shared with other mlx5 drivers.
 
   Multi-Packet Rx Queue (MPRQ a.k.a Striding RQ) can further save PCIe bandwidth
   by posting a single large buffer for multiple packets. Instead of posting a
-  buffers per a packet, one large buffer is posted in order to receive multiple
+  buffer per packet, one large buffer is posted in order to receive multiple
   packets on the buffer. A MPRQ buffer consists of multiple fixed-size strides
   and each stride receives one packet. MPRQ can improve throughput for
   small-packet traffic.
@@ -1211,22 +341,24 @@ for an additional list of options shared with other mlx5 drivers.
   greater or equal to this value. The default value is 12, valid only if
   ``mprq_en`` is set.
 
+.. _mlx5_tx_inline_params:
+
 - ``txq_inline`` parameter [int]
 
-  Amount of data to be inlined during TX operations. This parameter is
+  Amount of data to be inlined during Tx operations. This parameter is
   deprecated and converted to the new parameter ``txq_inline_max`` providing
   partial compatibility.
 
 - ``txqs_min_inline`` parameter [int]
 
-  Enable inline data send only when the number of TX queues is greater or equal
+  Enable inline data send only when the number of Tx queues is greater or equal
   to this value.
 
   This option should be used in combination with ``txq_inline_max`` and
-  ``txq_inline_mpw`` below and does not affect ``txq_inline_min`` settings above.
+  ``txq_inline_mpw`` and does not affect ``txq_inline_min`` settings.
 
   If this option is not specified the default value 16 is used for BlueField
-  and 8 for other platforms
+  and 8 for other platforms.
 
   The data inlining consumes the CPU cycles, so this option is intended to
   auto enable inline data if we have enough Tx queues, which means we have
@@ -1339,13 +471,13 @@ for an additional list of options shared with other mlx5 drivers.
 
 - ``txqs_max_vec`` parameter [int]
 
-  Enable vectorized Tx only when the number of TX queues is less than or
+  Enable vectorized Tx only when the number of Tx queues is less than or
   equal to this value. This parameter is deprecated and ignored, kept
   for compatibility issue to not prevent driver from probing.
 
 - ``txq_mpw_hdr_dseg_en`` parameter [int]
 
-  A nonzero value enables including two pointers in the first block of TX
+  A nonzero value enables including two pointers in the first block of TrxX
   descriptor. The parameter is deprecated and ignored, kept for compatibility
   issue.
 
@@ -1358,6 +490,8 @@ for an additional list of options shared with other mlx5 drivers.
   is deprecated and converted directly to ``txq_inline_mpw`` providing full
   compatibility. Valid only if eMPW feature is engaged.
 
+.. _mlx5_mpw_param:
+
 - ``txq_mpw_en`` parameter [int]
 
   A nonzero value enables Enhanced Multi-Packet Write (eMPW) for NICs starting
@@ -1406,6 +540,8 @@ for an additional list of options shared with other mlx5 drivers.
   The new name for this parameter is ``sq_db_nc``.
   See :ref:`common driver options <mlx5_common_driver_options>`.
 
+.. _mlx5_tx_pp_param:
+
 - ``tx_pp`` parameter [int]
 
   If a nonzero value is specified the driver creates all necessary internal
@@ -1436,6 +572,8 @@ for an additional list of options shared with other mlx5 drivers.
   if the number of global Tx queues on the port is less than ``txqs_max_vec``.
   The parameter is deprecated and ignored.
 
+.. _mlx5_rx_vec_param:
+
 - ``rx_vec_en`` parameter [int]
 
   A nonzero value enables Rx vector if the port is not configured in
@@ -1452,6 +590,8 @@ for an additional list of options shared with other mlx5 drivers.
 
   Enabled by default, valid only on VF devices ignored otherwise.
 
+.. _mlx5_vxlan_param:
+
 - ``l3_vxlan_en`` parameter [int]
 
   A nonzero value allows L3 VXLAN and VXLAN-GPE flow creation. To enable
@@ -1460,6 +600,8 @@ for an additional list of options shared with other mlx5 drivers.
 
   Disabled by default.
 
+.. _mlx5_meta_mark_param:
+
 - ``dv_xmeta_en`` parameter [int]
 
   A nonzero value enables extensive flow metadata support if device is
@@ -1474,7 +616,7 @@ for an additional list of options shared with other mlx5 drivers.
     NIC Rx steering domains, no ``MARK`` and ``META`` information crosses
     the domain boundaries. The ``MARK`` item is 24 bits wide, the ``META``
     item is 32 bits wide and match supported on egress only
-    when ``dv_flow_en`` = 1.
+    when ``dv_flow_en=1``.
 
   - 1, this engages extensive metadata mode, the ``MARK`` and ``META``
     related actions and items operate within all supported steering domains,
@@ -1498,7 +640,7 @@ for an additional list of options shared with other mlx5 drivers.
   - 3, this engages tunnel offload mode. In E-Switch configuration, that
     mode implicitly activates ``dv_xmeta_en=1``.
 
-  - 4, this mode is only supported in HWS (``dv_flow_en=2``).
+  - 4, this mode is only supported in :ref:`HW steering <mlx5_hws>`.
     The Rx/Tx metadata with 32b width copy between FDB and NIC is supported.
     The mark is only supported in NIC and there is no copy supported.
 
@@ -1517,7 +659,7 @@ for an additional list of options shared with other mlx5 drivers.
 
   Disabled by default (set to 0).
 
-  The Direct Verbs/Rules (engaged with ``dv_flow_en`` = 1) supports all
+  The Direct Verbs/Rules (engaged with ``dv_flow_en=1``) supports all
   of the extensive metadata features. The legacy Verbs supports FLAG and
   MARK metadata actions over NIC Rx steering domain only.
 
@@ -1532,6 +674,8 @@ for an additional list of options shared with other mlx5 drivers.
   for the 24-bit mode, the flows with the MARK action value outside
   the specified range will be rejected.
 
+.. _mlx5_dv_flow:
+
 - ``dv_flow_en`` parameter [int]
 
   Value 0 means legacy Verbs flow offloading.
@@ -1571,6 +715,8 @@ for an additional list of options shared with other mlx5 drivers.
 
   Disabled by default (set to 0).
 
+.. _mlx5_representor_params:
+
 - ``representor`` parameter [list]
 
   This parameter can be used to instantiate DPDK Ethernet devices from
@@ -1612,6 +758,8 @@ for an additional list of options shared with other mlx5 drivers.
 
   set to 128 by default.
 
+.. _mlx5_lro_timeout:
+
 - ``lro_timeout_usec`` parameter [int]
 
   The maximum allowed duration of an LRO session, in micro-seconds.
@@ -1620,6 +768,9 @@ for an additional list of options shared with other mlx5 drivers.
   If this parameter is not specified, by default PMD will set
   the smallest value supported by HW.
 
+
+.. _mlx5_hairpin_size:
+
 - ``hp_buf_log_sz`` parameter [int]
 
   The total data buffer size of a hairpin queue (logarithmic form), in bytes.
@@ -1668,7 +819,7 @@ for an additional list of options shared with other mlx5 drivers.
 
   There are two options to choose:
 
-  - 0. Prevent insertion of rules with the same pattern items on non-root table.
+  - 0. Prevent insertion of rules with the same pattern items on non-root HW table.
     In this case, only the first rule is inserted and the following rules are
     rejected and error code EEXIST is returned.
 
@@ -1679,8 +830,523 @@ for an additional list of options shared with other mlx5 drivers.
   By default, the PMD will set this value to 1.
 
 
+.. _mlx5_rx_functions:
+
+Rx burst functions
+------------------
+
+There are multiple Rx burst functions with different advantages and limitations.
+
+The Rx function is selected based on multiple parameters:
+
+- :ref:`multi-segments Rx scatter <nic_features_scattered_rx>`
+- :ref:`multi-packet Rx queues (MPRQ) <mlx5_mprq_params>`
+- :ref:`vectorized Rx datapath <mlx5_rx_vec_param>`
+
+This parameter may also have an impact on the behavior:
+
+- :ref:`packet descriptor (CQE) compression <mlx5_cqe_comp_param>`
+
+.. table:: Rx burst functions
+
+   +-------------------+------------------------+---------+-----------------+------+-------+
+   || Function Name    || Parameters to Enable  || Scatter|| Error Recovery || CQE || Large|
+   |                   |                        |         |                 || comp|| MTU  |
+   +===================+========================+=========+=================+======+=======+
+   | rx_burst          | rx_vec_en=0            |   Yes   | Yes             |  Yes |  Yes  |
+   +-------------------+------------------------+---------+-----------------+------+-------+
+   | rx_burst_vec      | rx_vec_en=1 (default)  |   No    | if CQE comp off |  Yes |  No   |
+   +-------------------+------------------------+---------+-----------------+------+-------+
+   | rx_burst_mprq     || mprq_en=1             |   No    | Yes             |  Yes |  Yes  |
+   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
+   +-------------------+------------------------+---------+-----------------+------+-------+
+   | rx_burst_mprq_vec || rx_vec_en=1 (default) |   No    | if CQE comp off |  Yes |  Yes  |
+   |                   || mprq_en=1             |         |                 |      |       |
+   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
+   +-------------------+------------------------+---------+-----------------+------+-------+
+
+
+.. _mlx5_net_stats:
+
+Statistics
+----------
+
+MLX5 supports various methods to report statistics:
+
+Basic port statistics can be queried using ``rte_eth_stats_get()``.
+The received and sent statistics are through SW only
+and counts the number of packets received or sent successfully by the PMD.
+The ``imissed`` counter is the amount of packets that could not be delivered
+to SW because a queue was full.
+Packets not received due to congestion in the bus or on the NIC
+can be queried via the ``rx_discards_phy`` xstats counter.
+
+Extended statistics can be queried using ``rte_eth_xstats_get()``.
+The extended statistics expose a wider set of counters counted by the device.
+The extended port statistics counts the number of packets
+received or sent successfully by the port.
+As NVIDIA NICs are using a :ref:`bifurcated Linux driver <bifurcated_driver>`,
+those counters counts also packet received or sent by the Linux kernel.
+
+Finally per-flow statistics can by queried using ``rte_flow_query()``
+when attaching a count action for specific flow.
+The flow counter counts the number of packets received successfully
+by the port and match the specific flow rule.
+
+
+Extended Statistics Counters
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The counters with ``_phy`` suffix counts the total events on the physical port,
+therefore not valid for VF.
+
+Send Scheduling Counters
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+The mlx5 PMD provides a comprehensive set of counters designed for
+debugging and diagnostics related to packet scheduling during transmission.
+These counters are applicable only if the port was configured with the ``tx_pp`` devarg
+and reflect the status of the PMD scheduling infrastructure
+based on Clock and Rearm Queues, used as a workaround on ConnectX-6 DX NICs.
+
+``tx_pp_missed_interrupt_errors``
+  Indicates that the Rearm Queue interrupt was not serviced on time.
+  The EAL manages interrupts in a dedicated thread,
+  and it is possible that other time-consuming actions were being processed concurrently.
+
+``tx_pp_rearm_queue_errors``
+  Signifies hardware errors that occurred on the Rearm Queue,
+  typically caused by delays in servicing interrupts.
+
+``tx_pp_clock_queue_errors``
+  Reflects hardware errors on the Clock Queue,
+  which usually indicate configuration issues
+  or problems with the internal NIC hardware or firmware.
+
+``tx_pp_timestamp_past_errors``
+  Tracks the application attempted to send packets with timestamps set in the past.
+  It is useful for debugging application code
+  and does not indicate a malfunction of the PMD.
+
+``tx_pp_timestamp_future_errors``
+  Records attempts by the application to send packets
+  with timestamps set too far into the future,
+  exceeding the hardware’s scheduling capabilities.
+  Like the previous counter, it aids in application debugging
+  without suggesting a PMD malfunction.
+
+``tx_pp_jitter``
+  Measures the internal NIC real-time clock jitter estimation
+  between two consecutive Clock Queue completions, expressed in nanoseconds.
+  Significant jitter may signal potential clock synchronization issues,
+  possibly due to inappropriate adjustments
+  made by a system PTP (Precision Time Protocol) agent.
+
+``tx_pp_wander``
+  Indicates the long-term stability of the internal NIC real-time clock
+  over 2^24 completions, measured in nanoseconds.
+  Significant wander may also suggest clock synchronization problems.
+
+``tx_pp_sync_lost``
+  A general operational indicator;
+  a non-zero value indicates that the driver has lost synchronization with the Clock Queue,
+  resulting in improper scheduling operations.
+  To restore correct scheduling functionality, it is necessary to restart the port.
+
+The following counters are particularly valuable for verifying and debugging application code.
+They do not indicate driver or hardware malfunctions
+and are applicable to newer hardware with direct on-time scheduling capabilities
+(such as ConnectX-7 and above):
+
+``tx_pp_timestamp_order_errors``
+  Indicates attempts by the application to send packets
+  with timestamps that are not in strictly ascending order.
+  Since the PMD does not reorder packets within hardware queues,
+  violations of timestamp order can lead to packets being sent at incorrect times.
+
+
+Rx/Tx tuning
+------------
+
+#. Configure aggressive CQE Zipping for maximum performance::
+
+        mlxconfig -d <mst device> s CQE_COMPRESSION=1
+
+   To set it back to the default CQE Zipping mode use::
+
+        mlxconfig -d <mst device> s CQE_COMPRESSION=0
+
+#. In case of virtualization:
+
+   - Make sure that hypervisor kernel is 3.16 or newer.
+   - Configure boot with ``iommu=pt``.
+   - Use 1G huge pages.
+   - Make sure to allocate a VM on huge pages.
+   - Make sure to set CPU pinning.
+
+#. Use the CPU near local NUMA node to which the PCIe adapter is connected,
+   for better performance. For VMs, verify that the right CPU
+   and NUMA node are pinned according to the above. Run::
+
+        lstopo-no-graphics --merge
+
+   to identify the NUMA node to which the PCIe adapter is connected.
+
+#. If more than one adapter is used, and root complex capabilities allow
+   to put both adapters on the same NUMA node without PCI bandwidth degradation,
+   it is recommended to locate both adapters on the same NUMA node.
+   This in order to forward packets from one to the other without
+   NUMA performance penalty.
+
+#. Disable pause frames::
+
+        ethtool -A <netdev> rx off tx off
+
+#. Verify IO non-posted prefetch is disabled by default. This can be checked
+   via the BIOS configuration. Please contact you server provider for more
+   information about the settings.
+
+   .. note::
+
+        On some machines, depends on the machine integrator, it is beneficial
+        to set the PCI max read request parameter to 1K. This can be
+        done in the following way:
+
+        To query the read request size use::
+
+                setpci -s <NIC PCI address> 68.w
+
+        If the output is different than 3XXX, set it by::
+
+                setpci -s <NIC PCI address> 68.w=3XXX
+
+        The XXX can be different on different systems. Make sure to configure
+        according to the setpci output.
+
+#. To minimize overhead of searching Memory Regions:
+
+   - '--numa-mem' is recommended to pin memory by predictable amount.
+   - Configure per-lcore cache when creating Mempools for packet buffer.
+   - Refrain from dynamically allocating/freeing memory in run-time.
+
+
+.. _mlx5_net_features:
+
+Features & Support
+------------------
+
+.. rst-class:: punchcard
+.. rst-class:: numbered-table
+
+=======================================  =======  =======
+Port/Queue Feature                        Linux   Windows
+=======================================  =======  =======
+:ref:`multi-process <mlx5_multiproc>`       X
+:ref:`Virtual Function <mlx5_net_vf>`       X        X
+:ref:`Sub-Function <mlx5_net_sf>`           X
+:ref:`port representor <mlx5_repr>`         X        X
+:ref:`hairpin <mlx5_hairpin>`               X        X
+:ref:`statistics <mlx5_net_stats>`          X        P
+link flow control (pause frame)             X
+Rx interrupt                                X
+:ref:`shared Rx queue <mlx5_shared_rx>`     X
+:ref:`Rx drop delay <mlx5_drop>`            X        X
+:ref:`Rx timestamp <mlx5_rx_timstp>`        X        X
+:ref:`Tx scheduling <mlx5_tx_sched>`        X
+:ref:`Tx inline <mlx5_tx_inline>`           X        X
+:ref:`Tx fast free <mlx5_tx_fast_free>`     X        X
+:ref:`Tx affinity <mlx5_aggregated>`        X
+:ref:`buffer split <mlx5_buf_split>`        X        X
+:ref:`multi-segment <mlx5_multiseg>`        X        X
+promiscuous                                 X        X
+multicast promiscuous                       X        X
+multiple MAC addresses                      X
+:ref:`LRO <mlx5_lro>`                       X        X
+:ref:`TSO <mlx5_tso>`                       X        X
+:ref:`L2 CRC <mlx5_crc>`                    X        X
+:ref:`L3/L4 checksums <mlx5_cksums>`        X        X
+:ref:`RSS with L3/L4 <mlx5_rss>`            X        X
+:ref:`symmetric RSS <mlx5_rss>`             X        X
+:ref:`configurable RETA <mlx5_rss>`         X        X
+:ref:`RSS hash result <mlx5_rss>`           X        X
+:ref:`VLAN <mlx5_vlan>`                     X        X
+:ref:`host shaper <mlx5_host_shaper>`       X
+=======================================  =======  =======
+
+
+.. note::
+
+   The mlx5 PMD is supported on Linux and :ref:`limited on Windows <mlx5_windows_limitations>`.
+
+
+There are 2 different flow API:
+
+- sync API (``rte_flow_create``)
+- template async API (``rte_flow_template_table_create`` / ``rte_flow_async_create``)
+
+The sync API is supported in both software (SWS) and hardware (HWS) steering engines,
+while the template async API requires using the hardware steering engine (HWS).
+
+Below tables apply to Linux implementation only.
+
+.. rst-class:: punchcard
+.. rst-class:: numbered-table
+
+========================================  ========  ========  ==================
+Flow Matching                             sync SWS  sync HWS  template async HWS
+========================================  ========  ========  ==================
+:ref:`aggr affinity <mlx5_aggregated>`       X         X              X
+:ref:`compare <mlx5_compare>`                                         X
+:ref:`conntrack <mlx5_conntrack>`            X         X              X
+:ref:`eCPRI <mlx5_ecpri>`                    X         X              X
+:ref:`Eth <mlx5_eth>`                        X         X              X
+:ref:`flex <mlx5_flex_item>`                 X         X              X
+:ref:`GENEVE <mlx5_geneve>`                  X         X              X
+:ref:`GRE <mlx5_gre>`                        X         X              X
+:ref:`GTP <mlx5_gtp>`                        X         X              X
+:ref:`ICMP <mlx5_icmp>`                      X         X              X
+:ref:`integrity <mlx5_integrity>`            X         X              X
+:ref:`IP-in-IP <mlx5_ip>`                    X         X              X
+:ref:`IPsec ESP <mlx5_ipsec>`                X         X              X
+:ref:`IPv4 <mlx5_ip>`                        X         X              X
+:ref:`IPv6 <mlx5_ip>`                        X         X              X
+:ref:`mark <mlx5_mark>`                      X         X              X
+:ref:`meta <mlx5_meta>`                      X         X              X
+:ref:`meter color <mlx5_meter>`              X         X              X
+:ref:`MPLSoGRE <mlx5_mpls>`                  X
+:ref:`MPLSoUDP <mlx5_mpls>`                  X         X              X
+:ref:`NSH <mlx5_nsh>`                        X         X              X
+:ref:`NVGRE <mlx5_nvgre>`                    X         X              X
+:ref:`port representor <mlx5_flow_port>`     X         X              X
+:ref:`ptype <mlx5_ptype>`                                             X
+:ref:`quota <mlx5_quota>`                                             X
+:ref:`random <mlx5_random>`                            X              X
+:ref:`represented port <mlx5_flow_port>`     X         X              X
+:ref:`RoCE IB BTH <mlx5_roce>`               X
+:ref:`SRv6 <mlx5_ip>`                                  X              X
+:ref:`tag <mlx5_tag>`                        X         X              X
+:ref:`TCP <mlx5_tcp>`                        X         X              X
+:ref:`Tx queue <mlx5_flow_queue>`            X         X              X
+:ref:`UDP <mlx5_udp>`                        X         X              X
+:ref:`VLAN <mlx5_vlan>`                      X         X              X
+:ref:`VXLAN <mlx5_vxlan>`                    X         X              X
+========================================  ========  ========  ==================
+
+
+.. rst-class:: punchcard
+.. rst-class:: numbered-table
+
+========================================  ========  ========  ==================
+Flow Action                               sync SWS  sync HWS  template async HWS
+========================================  ========  ========  ==================
+:ref:`age <mlx5_age>`                        X         X              X
+:ref:`conntrack <mlx5_conntrack>`            X         X              X
+:ref:`count <mlx5_flow_count>`               X         X              X
+:ref:`drop <mlx5_flow_drop>`                 X         X              X
+:ref:`flag <mlx5_flag>`                      X         X              X
+:ref:`indirect <mlx5_indirect>`              X         X              X
+:ref:`indirect list <mlx5_indirect>`         X         X              X
+:ref:`IPv6 ext push <mlx5_ip>`                         X              X
+:ref:`IPv6 ext remove <mlx5_ip>`                       X              X
+:ref:`jump <mlx5_jump>`                      X         X              X
+:ref:`mark <mlx5_mark>`                      X         X              X
+:ref:`meter <mlx5_meter>`                    X
+:ref:`meter mark <mlx5_meter>`               X         X              X
+:ref:`modify field <mlx5_modify>`            X         X              X
+:ref:`NAT64 <mlx5_nat64>`                              X              X
+:ref:`nvgre decap <mlx5_nvgre>`              X         X              X
+:ref:`nvgre encap <mlx5_nvgre>`              X         X              X
+:ref:`port representor <mlx5_flow_port>`     X         X              X
+:ref:`quota <mlx5_quota>`                                             X
+:ref:`queue <mlx5_flow_queue>`               X         X              X
+:ref:`raw decap <mlx5_raw_header>`           X         X              X
+:ref:`raw encap <mlx5_raw_header>`           X         X              X
+:ref:`represented port <mlx5_flow_port>`     X         X              X
+:ref:`rss <mlx5_rss>`                        X         X              X
+:ref:`sample <mlx5_sample>`                  X         X              X
+:ref:`send to kernel <mlx5_bifurcated>`      X         X              X
+:ref:`set meta <mlx5_meta>`                  X         X              X
+:ref:`set tag <mlx5_tag>`                    X         X              X
+:ref:`VLAN push <mlx5_vlan>`                 X         X              X
+:ref:`VLAN pop <mlx5_vlan>`                  X         X              X
+:ref:`VLAN set <mlx5_vlan>`                  X         X              X
+:ref:`VXLAN decap <mlx5_vxlan>`              X         X              X
+:ref:`VXLAN decap <mlx5_vxlan>`              X         X              X
+========================================  ========  ========  ==================
+
+
+Supported Architectures
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The mlx5 PMD is tested on several 64-bit architectures:
+
+- Intel/AMD (x86_64)
+- Arm (aarch64)
+- IBM Power
+
+
+Supported Operating Systems
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The mlx5 PMD is designed to run on Linux and Windows.
+It requires a kernel driver and some libraries.
+
+The :ref:`Linux prerequisites <mlx5_linux_prerequisites>`
+are Linux kernel driver and rdma-core libraries.
+These dependencies are also packaged in MLNX_OFED or MLNX_EN,
+shortened below as "OFED".
+
+The :ref:`Windows prerequisites <mlx5_windows_prerequisites>`
+are Windows kernel driver and DevX library.
+These dependencies are packaged in WinOF2.
+
+.. _mlx5_windows_limitations:
+
+On Windows, the features are limited:
+
+- The flow template asynchronous API is not supported.
+
+- The following flow rules are supported:
+
+  - IPv4/UDP with CVLAN filtering
+  - Unicast MAC filtering
+
+- Additional rules are supported from WinOF2 version 2.70:
+
+  - IPv4/TCP with CVLAN filtering
+  - L4 steering rules for port RSS of IP, UDP, TCP
+
+
+.. _mlx5_multiproc:
+
+Multi-Process
+~~~~~~~~~~~~~
+
+When starting a DPDK application, the process mode can be primary (only one)
+or seconday (all others).
+
+The flow group 0 is shared between DPDK processes
+while the other flow groups are limited to the current process.
+
+Live Migration
+^^^^^^^^^^^^^^
+
+During live migration to a new process,
+the flow engine must be set as standby mode.
+The user should only program flow rules in group 0 (``fdb_def_rule_en=0``).
+
+The flow engine of a process cannot move from active to standby mode
+if preceding active application rules are still present and vice versa.
+
+Live migration is only supported with SWS (``dv_flow_en=1``).
+
+Limitations
+^^^^^^^^^^^
+
+#. Forked secondary processes are not supported with mlx5.
+
+#. MPRQ is not supported in multi-process.
+   The callback to free externally attached MPRQ buffer
+   is set in a primary process,
+   but has a different virtual address in a secondary process.
+   Calling the function at the wrong address would crash.
+
+#. External memory unregistered in EAL memseg list cannot be used for DMA
+   unless such memory has been
+   registered by ``mlx5_mr_update_ext_mp()`` in the primary process
+   and remapped to the same virtual address in the secondary process.
+   If the external memory is registered by the primary process
+   but has a different virtual address in the secondary process,
+   unexpected error may happen.
+
+
+.. _mlx5_flow_create:
+
+Flow Rule Creation
+~~~~~~~~~~~~~~~~~~
+
+In mlx5 devices, the flow rules are inserted in HW tables.
+
+As explained in the :doc:`flow API documentation <../prog_guide/ethdev/flow_offload>`,
+a rule can be created synchronously (``rte_flow_create``)
+or asynchronously (``rte_flow_async_create``)
+with the help of a template table (``rte_flow_template_table_create``).
+A template table is added as a matcher entity inside a HW table.
+
+Depending on the attribute of a rule,
+it belongs to different domains:
+
+- ingress: NIC Rx domain
+- egress: NIC Tx domain
+- transfer: E-Switch domain
+
+The Embedded Switch (E-Switch) contains a Forwarding DataBase (FDB)
+which controls the forwarding of packets between E-Switch ports
+if :ref:`switchdev mode <mlx5_switchdev>` is enabled in the kernel.
+The FDB is updated by creating flow rules and template tables in E-Switch domain.
+
+The flow rules of the same group and same domain are in the same HW table.
+Inside a group, the flow rules may have different priorities:
+up to 21844 priorities in non-root tables.
+
+There is a default HW root table in each domain.
+These root tables are shared with the mlx5 kernel driver,
+and this is where rules lookup starts,
+then other groups are reached with :ref:`jump redirections <mlx5_jump>`.
+
+In NIC Rx and NIC Tx domains, the first group (index 0) is the HW root table.
+In E-Switch domain, by default (``fdb_def_rule_en=1``),
+the FDB root table is hidden and only used internally for default rules.
+In this case, the first group (index 0) for transfer rules is an FDB table
+which is linked to the FDB root table.
+
+A template table specialized
+with the flags ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG``
+or ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_VPORT_ORIG``
+can be created only in non-root HW table.
+
+Tuning
+^^^^^^
+
+In order to achieve the best flow rule insertion rate,
+the flow rule creation should be managed in parallel lcores.
+
+The flow object allocation and release with cache may be accelerated
+by disabling memory reclaim with ``reclaim_mem_mode=0``.
+
+
+.. _mlx5_bifurcated:
+
+Bifurcated Driver
+~~~~~~~~~~~~~~~~~
+
+The same device is managed by both :ref:`kernel <bifurcated_driver>` and DPDK drivers.
+
+After enabling the :ref:`isolated mode <flow_isolated_mode>`,
+non-matched packets are routed directly from the hardware to the kernel.
+
+.. note::
+
+   The isolated mode must be enabled with ``rte_flow_isolate()``
+   before calling ``rte_eth_dev_configure()``.
+   It will avoid automatic rules created for basic configurations
+   like promiscuous, multicast, MAC, VLAN, RSS.
+
+In isolated mode, if a specific flow needs to be received by the kernel,
+it is possible to use the flow action ``RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL``.
+
+Limitations
+^^^^^^^^^^^
+
+The flow action ``RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL``
+is not supported on HW root table.
+
+In :ref:`HW steering <mlx5_hws>`, the action ``RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL``
+is not supported on guest port.
+
+
 Multiport E-Switch
-------------------
+~~~~~~~~~~~~~~~~~~
 
 In standard deployments of NVIDIA ConnectX and BlueField HCAs, where embedded switch is enabled,
 each physical port is associated with a single switching domain.
@@ -1747,7 +1413,7 @@ With this configuration, mlx5 PMD supports:
 - forwarding traffic to physical port, PF, VF or SF using REPRESENTED_PORT actions;
 
 Requirements
-~~~~~~~~~~~~
+^^^^^^^^^^^^
 
 Supported HCAs:
 
@@ -1761,7 +1427,7 @@ Supported mlx5 kernel modules versions:
 - Modules packaged in MLNX_OFED - from version v23.04-0.5.3.3.
 
 Configuration
-~~~~~~~~~~~~~
+^^^^^^^^^^^^^
 
 #. Apply required FW configuration::
 
@@ -1802,10 +1468,10 @@ Configuration
       9    E6:35:83:1F:B0:A9 08:00.0_representor_c0pf1vf3 mlx5_pci       up       200 Gbps
 
 Limitations
-~~~~~~~~~~~
+^^^^^^^^^^^
 
 - Multiport E-Switch is not supported on Windows.
-- Multiport E-Switch is supported only with HW Steering flow engine (``dv_flow_en=2``).
+- Multiport E-Switch is supported only with :ref:`HW steering <mlx5_hws>`.
 - Matching traffic coming from a physical port and forwarding it to a physical port
   (either the same or other one) is not supported.
 
@@ -1813,350 +1479,1053 @@ Limitations
   between physical port representors and forward the traffic using hairpin queues.
 
 
+.. _mlx5_net_vf:
+
+Virtual Function
+~~~~~~~~~~~~~~~~
+
+SR-IOV Virtual Function (VF) is a type of supported port.
+
+Limitations
+^^^^^^^^^^^
+
+#. MTU settings on PCI Virtual Functions have no effect.
+   The maximum receivable packet size for a VF is determined by the MTU
+   configured on its associated Physical Function (PF).
+   DPDK applications using VFs must be prepared to handle packets
+   up to the maximum size of this PF port.
+
+
+.. _mlx5_net_sf:
+
 Sub-Function
-------------
+~~~~~~~~~~~~
 
 See :ref:`mlx5_sub_function`.
 
-Sub-Function representor support
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
 A SF netdev supports E-Switch representation offload
 similar to PF and VF representors.
-Use <sfnum> to probe SF representor::
+Use ``sfnum`` to probe SF representor::
 
    testpmd> port attach <PCI_BDF>,representor=sf<sfnum>,dv_flow_en=1
 
 
-Performance tuning
-------------------
+.. _mlx5_repr:
 
-#. Configure aggressive CQE Zipping for maximum performance::
+Port Representor
+~~~~~~~~~~~~~~~~
 
-        mlxconfig -d <mst device> s CQE_COMPRESSION=1
+The entities allowing to manage the ports of the hardware switch
+are the port representors.
 
-   To set it back to the default CQE Zipping mode use::
+The flow item and action for port representor
+are described in a section dedicated to handling
+:ref:`port in a flow rule <mlx5_flow_port>`.
 
-        mlxconfig -d <mst device> s CQE_COMPRESSION=0
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
 
-#. In case of virtualization:
+Port representors require to configure
+the device in :ref:`switchdev mode <mlx5_switchdev>`.
 
-   - Make sure that hypervisor kernel is 3.16 or newer.
-   - Configure boot with ``iommu=pt``.
-   - Use 1G huge pages.
-   - Make sure to allocate a VM on huge pages.
-   - Make sure to set CPU pinning.
+The port representors and their matching behaviour are configured
+with some :ref:`parameters <mlx5_representor_params>`.
 
-#. Use the CPU near local NUMA node to which the PCIe adapter is connected,
-   for better performance. For VMs, verify that the right CPU
-   and NUMA node are pinned according to the above. Run::
 
-        lstopo-no-graphics --merge
+.. _mlx5_hairpin:
 
-   to identify the NUMA node to which the PCIe adapter is connected.
+Hairpin Ports
+~~~~~~~~~~~~~
 
-#. If more than one adapter is used, and root complex capabilities allow
-   to put both adapters on the same NUMA node without PCI bandwidth degradation,
-   it is recommended to locate both adapters on the same NUMA node.
-   This in order to forward packets from one to the other without
-   NUMA performance penalty.
+Requirements
+^^^^^^^^^^^^
 
-#. Disable pause frames::
+These are the requirements for using 1 hairpin port:
 
-        ethtool -A <netdev> rx off tx off
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-5
+OFED       4.7-3
+rdma-core  26
+DPDK       19.11
+=========  ==========
 
-#. Verify IO non-posted prefetch is disabled by default. This can be checked
-   via the BIOS configuration. Please contact you server provider for more
-   information about the settings.
-
-   .. note::
-
-        On some machines, depends on the machine integrator, it is beneficial
-        to set the PCI max read request parameter to 1K. This can be
-        done in the following way:
-
-        To query the read request size use::
-
-                setpci -s <NIC PCI address> 68.w
-
-        If the output is different than 3XXX, set it by::
-
-                setpci -s <NIC PCI address> 68.w=3XXX
-
-        The XXX can be different on different systems. Make sure to configure
-        according to the setpci output.
-
-#. To minimize overhead of searching Memory Regions:
-
-   - '--numa-mem' is recommended to pin memory by predictable amount.
-   - Configure per-lcore cache when creating Mempools for packet buffer.
-   - Refrain from dynamically allocating/freeing memory in run-time.
-
-Rx burst functions
-------------------
-
-There are multiple Rx burst functions with different advantages and limitations.
-
-.. table:: Rx burst functions
-
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   || Function Name    || Enabler               || Scatter|| Error Recovery || CQE || Large|
-   |                   |                        |         |                 || comp|| MTU  |
-   +===================+========================+=========+=================+======+=======+
-   | rx_burst          | rx_vec_en=0            |   Yes   | Yes             |  Yes |  Yes  |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   | rx_burst_vec      | rx_vec_en=1 (default)  |   No    | if CQE comp off |  Yes |  No   |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   | rx_burst_mprq     || mprq_en=1             |   No    | Yes             |  Yes |  Yes  |
-   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-   | rx_burst_mprq_vec || rx_vec_en=1 (default) |   No    | if CQE comp off |  Yes |  Yes  |
-   |                   || mprq_en=1             |         |                 |      |       |
-   |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
-   +-------------------+------------------------+---------+-----------------+------+-------+
-
-.. _mlx5_offloads_support:
-
-Supported hardware offloads
----------------------------
-
-Below tables show offload support depending on hardware, firmware,
-and Linux software support.
-
-The :ref:`Linux prerequisites <mlx5_linux_prerequisites>`
-are Linux kernel and rdma-core libraries.
-These dependencies are also packaged in MLNX_OFED or MLNX_EN,
-shortened below as "OFED".
-
-.. table:: Minimal SW/HW versions for queue offloads
-
-   ============== ===== ===== ========= ===== ========== =============
-   Offload        DPDK  Linux rdma-core OFED   firmware   hardware
-   ============== ===== ===== ========= ===== ========== =============
-   common base    17.11  4.14    16     4.2-1 12.21.1000 ConnectX-4
-   checksums      17.11  4.14    16     4.2-1 12.21.1000 ConnectX-4
-   Rx timestamp   17.11  4.14    16     4.2-1 12.21.1000 ConnectX-4
-   TSO            17.11  4.14    16     4.2-1 12.21.1000 ConnectX-4
-   LRO            19.08  N/A     N/A    4.6-4 16.25.6406 ConnectX-5
-   Tx scheduling  20.08  N/A     N/A    5.1-2 22.28.2006 ConnectX-6 Dx
-   Buffer Split   20.11  N/A     N/A    5.1-2 16.28.2006 ConnectX-5
-   ============== ===== ===== ========= ===== ========== =============
-
-.. table:: Minimal SW/HW versions for rte_flow offloads
-
-   +-----------------------+-----------------+-----------------+
-   | Offload               | with E-Switch   | with NIC        |
-   +=======================+=================+=================+
-   | Count                 | | DPDK 19.05    | | DPDK 19.02    |
-   |                       | | OFED 4.6      | | OFED 4.6      |
-   |                       | | rdma-core 24  | | rdma-core 23  |
-   |                       | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Drop                  | | DPDK 19.05    | | DPDK 18.11    |
-   |                       | | OFED 4.6      | | OFED 4.5      |
-   |                       | | rdma-core 24  | | rdma-core 23  |
-   |                       | | ConnectX-5    | | ConnectX-4    |
-   +-----------------------+-----------------+-----------------+
-   | Queue / RSS           | |               | | DPDK 18.11    |
-   |                       | |     N/A       | | OFED 4.5      |
-   |                       | |               | | rdma-core 23  |
-   |                       | |               | | ConnectX-4    |
-   +-----------------------+-----------------+-----------------+
-   | Shared action         | |               | |               |
-   |                       | | :numref:`sact`| | :numref:`sact`|
-   |                       | |               | |               |
-   |                       | |               | |               |
-   +-----------------------+-----------------+-----------------+
-   | | VLAN                | | DPDK 19.11    | | DPDK 19.11    |
-   | | (of_pop_vlan /      | | OFED 4.7-1    | | OFED 4.7-1    |
-   | | of_push_vlan /      | | ConnectX-5    | | ConnectX-5    |
-   | | of_set_vlan_pcp /   | |               | |               |
-   | | of_set_vlan_vid)    | |               | |               |
-   +-----------------------+-----------------+-----------------+
-   | | VLAN                | | DPDK 21.05    | |               |
-   | | ingress and /       | | OFED 5.3      | |    N/A        |
-   | | of_push_vlan /      | | ConnectX-6 Dx | |               |
-   +-----------------------+-----------------+-----------------+
-   | | VLAN                | | DPDK 21.05    | |               |
-   | | egress and /        | | OFED 5.3      | |    N/A        |
-   | | of_pop_vlan /       | | ConnectX-6 Dx | |               |
-   +-----------------------+-----------------+-----------------+
-   | Encapsulation         | | DPDK 19.05    | | DPDK 19.02    |
-   | (VXLAN / NVGRE / RAW) | | OFED 4.7-1    | | OFED 4.6      |
-   |                       | | rdma-core 24  | | rdma-core 23  |
-   |                       | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Encapsulation         | | DPDK 19.11    | | DPDK 19.11    |
-   | GENEVE                | | OFED 4.7-3    | | OFED 4.7-3    |
-   |                       | | rdma-core 27  | | rdma-core 27  |
-   |                       | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Tunnel Offload        | |  DPDK 20.11   | | DPDK 20.11    |
-   |                       | |  OFED 5.1-2   | | OFED 5.1-2    |
-   |                       | |  rdma-core 32 | | N/A           |
-   |                       | |  ConnectX-5   | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | | Header rewrite      | | DPDK 19.05    | | DPDK 19.02    |
-   | | (set_ipv4_src /     | | OFED 4.7-1    | | OFED 4.7-1    |
-   | | set_ipv4_dst /      | | rdma-core 24  | | rdma-core 24  |
-   | | set_ipv6_src /      | | ConnectX-5    | | ConnectX-5    |
-   | | set_ipv6_dst /      | |               | |               |
-   | | set_tp_src /        | |               | |               |
-   | | set_tp_dst /        | |               | |               |
-   | | dec_ttl /           | |               | |               |
-   | | set_ttl /           | |               | |               |
-   | | set_mac_src /       | |               | |               |
-   | | set_mac_dst)        | |               | |               |
-   +-----------------------+-----------------+-----------------+
-   | | Header rewrite      | | DPDK 20.02    | | DPDK 20.02    |
-   | | (set_dscp)          | | OFED 5.0      | | OFED 5.0      |
-   | |                     | | rdma-core 24  | | rdma-core 24  |
-   | |                     | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | | Header rewrite      | | DPDK 22.07    | | DPDK 22.07    |
-   | | (ipv4_ecn /         | | OFED 5.6-2    | | OFED 5.6-2    |
-   | | ipv6_ecn)           | | rdma-core 41  | | rdma-core 41  |
-   | |                     | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Jump                  | | DPDK 19.05    | | DPDK 19.02    |
-   |                       | | OFED 4.7-1    | | OFED 4.7-1    |
-   |                       | | rdma-core 24  | | N/A           |
-   |                       | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Mark / Flag           | | DPDK 19.05    | | DPDK 18.11    |
-   |                       | | OFED 4.6      | | OFED 4.5      |
-   |                       | | rdma-core 24  | | rdma-core 23  |
-   |                       | | ConnectX-5    | | ConnectX-4    |
-   +-----------------------+-----------------+-----------------+
-   | Meta data             | |  DPDK 19.11   | | DPDK 19.11    |
-   |                       | |  OFED 4.7-3   | | OFED 4.7-3    |
-   |                       | |  rdma-core 26 | | rdma-core 26  |
-   |                       | |  ConnectX-5   | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Port ID               | | DPDK 19.05    |     | N/A       |
-   |                       | | OFED 4.7-1    |     | N/A       |
-   |                       | | rdma-core 24  |     | N/A       |
-   |                       | | ConnectX-5    |     | N/A       |
-   +-----------------------+-----------------+-----------------+
-   | Hairpin               | |               | | DPDK 19.11    |
-   |                       | |     N/A       | | OFED 4.7-3    |
-   |                       | |               | | rdma-core 26  |
-   |                       | |               | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | 2-port Hairpin        | |               | | DPDK 20.11    |
-   |                       | |     N/A       | | OFED 5.1-2    |
-   |                       | |               | | N/A           |
-   |                       | |               | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Metering              | |  DPDK 19.11   | | DPDK 19.11    |
-   |                       | |  OFED 4.7-3   | | OFED 4.7-3    |
-   |                       | |  rdma-core 26 | | rdma-core 26  |
-   |                       | |  ConnectX-5   | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | ASO Metering          | |  DPDK 21.05   | | DPDK 21.05    |
-   |                       | |  OFED 5.3     | | OFED 5.3      |
-   |                       | |  rdma-core 33 | | rdma-core 33  |
-   |                       | |  ConnectX-6 Dx| | ConnectX-6 Dx |
-   +-----------------------+-----------------+-----------------+
-   | Metering Hierarchy    | |  DPDK 21.08   | | DPDK 21.08    |
-   |                       | |  OFED 5.3     | | OFED 5.3      |
-   |                       | |  N/A          | | N/A           |
-   |                       | |  ConnectX-6 Dx| | ConnectX-6 Dx |
-   +-----------------------+-----------------+-----------------+
-   | Sampling              | |  DPDK 20.11   | | DPDK 20.11    |
-   |                       | |  OFED 5.1-2   | | OFED 5.1-2    |
-   |                       | |  rdma-core 32 | | N/A           |
-   |                       | |  ConnectX-5   | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Encapsulation         | |  DPDK 21.02   | | DPDK 21.02    |
-   | GTP PSC               | |  OFED 5.2     | | OFED 5.2      |
-   |                       | |  rdma-core 35 | | rdma-core 35  |
-   |                       | |  ConnectX-6 Dx| | ConnectX-6 Dx |
-   +-----------------------+-----------------+-----------------+
-   | Encapsulation         | | DPDK 21.02    | | DPDK 21.02    |
-   | GENEVE TLV option     | | OFED 5.2      | | OFED 5.2      |
-   |                       | | rdma-core 34  | | rdma-core 34  |
-   |                       | | ConnectX-6 Dx | | ConnectX-6 Dx |
-   +-----------------------+-----------------+-----------------+
-   | Modify Field          | | DPDK 21.02    | | DPDK 21.02    |
-   |                       | | OFED 5.2      | | OFED 5.2      |
-   |                       | | rdma-core 35  | | rdma-core 35  |
-   |                       | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Connection tracking   | |               | | DPDK 21.05    |
-   |                       | |     N/A       | | OFED 5.3      |
-   |                       | |               | | rdma-core 35  |
-   |                       | |               | | ConnectX-6 Dx |
-   +-----------------------+-----------------+-----------------+
-
-.. table:: Minimal SW/HW versions for shared action offload
-   :name: sact
-
-   +-----------------------+-----------------+-----------------+
-   | Shared Action         | with E-Switch   | with NIC        |
-   +=======================+=================+=================+
-   | RSS                   | |               | | DPDK 20.11    |
-   |                       | |     N/A       | | OFED 5.2      |
-   |                       | |               | | rdma-core 33  |
-   |                       | |               | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-   | Age                   | | DPDK 20.11    | | DPDK 20.11    |
-   |                       | | OFED 5.2      | | OFED 5.2      |
-   |                       | | rdma-core 32  | | rdma-core 32  |
-   |                       | | ConnectX-6 Dx | | ConnectX-6 Dx |
-   +-----------------------+-----------------+-----------------+
-   | Count                 | | DPDK 21.05    | | DPDK 21.05    |
-   |                       | | OFED 4.6      | | OFED 4.6      |
-   |                       | | rdma-core 24  | | rdma-core 23  |
-   |                       | | ConnectX-5    | | ConnectX-5    |
-   +-----------------------+-----------------+-----------------+
-
-.. table:: Minimal SW/HW versions for flow template API
-
-   +-----------------+--------------------+--------------------+
-   | DPDK            | NIC                | Firmware           |
-   +=================+====================+====================+
-   | 22.11           | ConnectX-6 Dx      | xx.35.1012         |
-   +-----------------+--------------------+--------------------+
-
-Notes for metadata
-------------------
-
-MARK and META items are interrelated with datapath - they might move from/to
-the applications in mbuf fields. Hence, zero value for these items has the
-special meaning - it means "no metadata are provided", not zero values are
-treated by applications and PMD as valid ones.
-
-Moreover in the flow engine domain the value zero is acceptable to match and
-set, and we should allow to specify zero values as rte_flow parameters for the
-META and MARK items and actions. In the same time zero mask has no meaning and
-should be rejected on validation stage.
-
-Notes for rte_flow
-------------------
-
-Flows are not cached in the driver.
-When stopping a device port, all the flows created on this port from the
-application will be flushed automatically in the background.
-After stopping the device port, all flows on this port become invalid and
-not represented in the system.
-All references to these flows held by the application should be discarded
-directly but neither destroyed nor flushed.
-
-The application should re-create the flows as required after the port restart.
-
-
-Notes for flow counters
------------------------
-
-mlx5 PMD supports the ``COUNT`` flow action,
-which provides an ability to count packets (and bytes)
-matched against a given flow rule.
-This section describes the high level overview of
-how this support is implemented and limitations.
-
-HW steering flow engine
-~~~~~~~~~~~~~~~~~~~~~~~
+These are the requirements for using 2 hairpin ports:
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-5
+OFED       5.1-2
+DPDK       20.11
+=========  ==========
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Hairpin Rx queue data may be stored in locked internal device memory
+if enabled by setting these values (see :ref:`mlx5_firmware_config`)::
+
+   HAIRPIN_DATA_BUFFER_LOCK=1
+   MEMIC_SIZE_LIMIT=0
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The size of the buffers may be specified
+with the parameter :ref:`hp_buf_log_sz <mlx5_hairpin_size>`.
+
+By default, data buffers and packet descriptors for hairpin queues
+are placed in device memory which is shared with other resources (e.g. flow rules).
+
+Since DPDK 22.11 and NVIDIA MLNX_OFED 5.8, it is possible
+to specify memory placement for hairpin Rx and Tx queues:
+
+- Place data buffers and Rx packet descriptors in dedicated device memory.
+  Application can request that configuration
+  through ``use_locked_device_memory`` configuration option.
+
+  Placing data buffers and Rx packet descriptors in dedicated device memory
+  can decrease latency on hairpinned traffic,
+  since traffic processing for the hairpin queue will not be memory starved.
+
+  However, reserving device memory for hairpin Rx queues
+  may decrease throughput under heavy load,
+  since less resources will be available on device.
+
+  This option is supported only for Rx hairpin queues.
+
+- Place Tx packet descriptors in host memory.
+  Application can request that configuration
+  through ``use_rte_memory`` configuration option.
+
+  Placing Tx packet descritors in host memory can increase traffic throughput.
+  This results in more resources available on the device for other purposes,
+  which reduces memory contention on device.
+  Side effect of this option is visible increase in latency,
+  since each packet incurs additional PCI transactions.
+
+  This option is supported only for Tx hairpin queues.
+
+Limitations
+^^^^^^^^^^^
+
+#. Hairpin between two ports could only do manual binding and explicit Tx flow mode.
+   For single port hairpin, all the combinations of auto/manual binding
+   and explicit/implicit Tx flow mode are supported.
+
+#. Hairpin in switchdev SR-IOV mode is not supported till now.
+
+#. ``out_of_buffer`` statistics are not available on:
+
+   - NICs older than ConnectX-7.
+   - DPUs older than BlueField-3.
+
+
+.. _mlx5_aggregated:
+
+Aggregated Ports
+~~~~~~~~~~~~~~~~
+
+When multiple ports are merged together like in bonding,
+the aggregated physical ports are hidden behind the virtual bonding port.
+However we may need to distinguish the physical ports
+to transmit packets on the same port as where the flow is received.
+
+The number of aggregated ports can be revealed
+with the function ``rte_eth_dev_count_aggr_ports()``.
+
+On Rx side, an aggregated port is matched in a flow rule
+with the item ``RTE_FLOW_ITEM_TYPE_AGGR_AFFINITY``
+so it can be directed to a specific queue.
+
+On Tx side, queues may be mapped to an aggregated port
+with ``rte_eth_dev_map_aggr_tx_affinity()``,
+otherwise the queue affinity depends on HW hash.
+
+Requirements
+^^^^^^^^^^^^
+
+Linux bonding under socket direct mode requires at least MLNX_OFED 5.4.
+
+Matching on aggregated affinity in E-Switch
+depends on device-managed flow steering (DMFS) mode.
+
+Limitations
+^^^^^^^^^^^
+
+#. Matching on aggregated affinity is supported only in group 0.
+
+
+.. _mlx5_shared_rx:
+
+Shared Rx Queue
+~~~~~~~~~~~~~~~
+
+Limitations
+^^^^^^^^^^^
+
+#. Counters of received packets and bytes of devices in the same share group are same.
+
+#. Counters of received packets and bytes of queues in the same group and queue ID are same.
+
+
+.. _mlx5_hws:
+
+Hardware Steering
+~~~~~~~~~~~~~~~~~
+
+Faster than software steering (SWS),
+hardware steering (HWS) is the only mode supporting the flow template async API.
+
+Flow rules are managed by the hardware,
+with a WQE-based high scaling and safer flow insertion/destruction.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+firmware   xx.35.1012
+DPDK       22.11
+=========  =============
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+HW steering is :ref:`enabled <mlx5_dv_flow>` with ``dv_flow_en=2``.
+
+Reconfiguring HW steering engine is not supported.
+Any subsequent call to ``rte_flow_configure()`` with different configuration
+than initially provided will be rejected.
+
+Limitations
+^^^^^^^^^^^
+
+#. With E-Switch enabled, ports which share the E-Switch domain
+   should be started and stopped in a specific order:
+
+   - When starting ports, the transfer proxy port should be started first
+     and port representors should follow.
+   - When stopping ports, all port representors should be stopped
+     before stopping the transfer proxy port.
+
+   If ports are started/stopped in an incorrect order,
+   ``rte_eth_dev_start()``/``rte_eth_dev_stop()`` will return an appropriate error code:
+
+   - ``-EAGAIN`` for ``rte_eth_dev_start()``.
+   - ``-EBUSY`` for ``rte_eth_dev_stop()``.
+
+#. Partial match with item template is not supported.
+
+#. The supported actions order is as below::
+
+      MARK (a)
+      *_DECAP (b)
+      OF_POP_VLAN
+      COUNT | AGE
+      METER_MARK | CONNTRACK
+      OF_PUSH_VLAN
+      MODIFY_FIELD
+      *_ENCAP (c)
+      JUMP | DROP | RSS (a) | QUEUE (a) | REPRESENTED_PORT (d)
+
+   a. Only supported on ingress.
+   b. Any decapsulation action, including the combination of RAW_ENCAP and RAW_DECAP actions
+      which results in L3 decapsulation.
+      Not supported on egress.
+   c. Any encapsulation action, including the combination of RAW_ENCAP and RAW_DECAP actions
+      which results in L3 encap.
+   d. Only in transfer (switchdev) mode.
+
+
+.. _mlx5_drop:
+
+Rx Drop
+~~~~~~~
+
+When all packet descriptors of an Rx queue are exhausted,
+the received packets are dropped.
+
+It is possible to :ref:`delay <mlx5_delay_drop_param>` such packet drop,
+waiting a short time for descriptors to become available.
+By default, there is a delay before dropping packets of hairpin Rx queues.
+
+Requirements
+^^^^^^^^^^^^
+
+There are requirements for having drop delay supported:
+
+=========  ==========
+Minimum    Version
+=========  ==========
+OFED       5.5
+=========  ==========
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+To enable / disable the drop timer rearming,
+the private flag ``dropless_rq`` can be set and queried via ethtool::
+
+   ethtool --set-priv-flags <netdev> dropless_rq on (/ off)
+   ethtool --show-priv-flags <netdev>
+
+Limitations
+^^^^^^^^^^^
+
+#. The configuration of the drop delay is global for the port, and must be set on the PF.
+
+#. The drop delay timer is per port, shared with the Rx queues of VF, SF and representors.
+
+
+.. _mlx5_rx_timstp:
+
+Rx Timestamp
+~~~~~~~~~~~~
+
+A :ref:`timestamp <nic_features_hw_timestamp>` may be written in packet metadata.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-4
+firmware   12.21.1000
+OFED       4.2-1
+Linux      4.14
+rdma-core  16
+DPDK       17.11
+=========  ==========
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Real-time timestamp format is enabled
+by setting this value (see :ref:`mlx5_firmware_config`)::
+
+   REAL_TIME_CLOCK_ENABLE=1
+
+Limitations
+^^^^^^^^^^^
+
+#. CQE timestamp field width is limited by hardware to 63 bits, MSB is zero.
+
+#. In the free-running mode the timestamp counter is reset on power on
+   and 63-bit value provides over 1800 years of uptime till overflow.
+
+#. In the real-time mode
+   (configurable with ``REAL_TIME_CLOCK_ENABLE`` firmware settings),
+   the timestamp presents the nanoseconds elapsed since 01-Jan-1970,
+   hardware timestamp overflow will happen on 19-Jan-2038
+   (0x80000000 seconds since 01-Jan-1970).
+
+#. The send scheduling is based on timestamps
+   from the reference "Clock Queue" completions,
+   the scheduled send timestamps should not be specified with non-zero MSB.
+
+
+.. _mlx5_tx_sched:
+
+Tx Scheduling
+~~~~~~~~~~~~~
+
+When PMD sees the ``RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME`` set on the packet
+being sent it tries to synchronize the time of packet appearing on
+the wire with the specified packet timestamp. If the specified one
+is in the past it should be ignored, if one is in the distant future
+it should be capped with some reasonable value (in range of seconds).
+These specific cases ("too late" and "distant future") can be optionally
+reported via device xstats to assist applications to detect the
+time-related problems.
+
+The timestamp upper "too-distant-future" limit
+at the moment of invoking the Tx burst routine
+can be estimated as ``tx_pp`` option (in nanoseconds) multiplied by 2^23.
+Please note, for the testpmd txonly mode,
+the limit is deduced from the expression::
+
+   (n_tx_descriptors / burst_size + 1) * inter_burst_gap
+
+There is no any packet reordering according timestamps is supposed,
+neither within packet burst, nor between packets, it is an entirely
+application responsibility to generate packets and its timestamps
+in desired order.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+firmware   22.28.2006
+OFED       5.1-2
+Linux
+rdma-core
+DPDK       20.08
+=========  =============
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+To provide the packet send scheduling on mbuf timestamps the ``tx_pp``
+parameter should be specified.
+
+Limitations
+^^^^^^^^^^^
+
+#. The timestamps can be put only in the first packet
+   in the burst providing the entire burst scheduling.
+
+
+.. _mlx5_tx_inline:
+
+Tx Inline
+~~~~~~~~~
+
+The packet data can be inlined into the packet descriptor (WQE)
+to save some PCI bandwidth.
+It has a CPU cost but it reduces the latency and can improve the throughput.
+
+There is flag to disable inlining per packet.
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+Inlining is enabled per port
+through multiple :ref:`configuration parameters <mlx5_tx_inline_params>`.
+
+The configuration per packet is described below.
+
+To support a mixed traffic pattern (some buffers from local host memory,
+some buffers from other devices) with high bandwidth, an mbuf flag is used.
+
+An application hints the PMD whether or not it should try to inline
+the given mbuf data buffer.
+The PMD should do the best effort to act upon this request.
+
+The hint flag ``RTE_PMD_MLX5_FINE_GRANULARITY_INLINE`` is dynamic,
+registered by the application with ``rte_mbuf_dynflag_register()``.
+This flag is purely driver-specific
+and declared in the PMD specific header ``rte_pmd_mlx5.h``.
+
+To query the supported specific flags in runtime,
+the function ``rte_pmd_mlx5_get_dyn_flag_names()`` returns the array
+of currently (over present hardware and configuration) supported specific flags.
+
+The "not inline hint" feature operating flow is the following one:
+
+#. application starts
+#. probe the devices, ports are created
+#. query the port capabilities
+#. if port supporting the feature is found
+#. register dynamic flag ``RTE_PMD_MLX5_FINE_GRANULARITY_INLINE``
+#. application starts the ports
+#. on ``dev_start()`` PMD checks whether the feature flag is registered
+   and enables the feature support in datapath
+#. application might set the registered flag bit in ``ol_flags`` field
+   of mbuf being sent and PMD will handle ones appropriately.
+
+
+.. _mlx5_tx_fast_free:
+
+Fast Tx mbuf Free
+~~~~~~~~~~~~~~~~~
+
+With the flag ``RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE``,
+it is assumed that all mbufs being sent are originated from the same memory pool
+and there is no any extra references to the mbufs
+(the reference counter for each mbuf is equal to 1 on Tx burst).
+The latter means there should be no any externally attached buffers in mbufs.
+
+It is an application responsibility to provide the correct mbufs
+if the :ref:`fast free offload <nic_features_fast_mbuf_free>` is engaged.
+
+Requirements
+^^^^^^^^^^^^
+
+:ref:`MPRQ <mlx5_mprq_params>` must be disabled.
+
+The mlx5 PMD implicitly produces the mbufs with externally attached buffers
+if MPRQ option is enabled, hence, the fast free offload is
+neither supported nor advertised if MPRQ is enabled.
+
+
+.. _mlx5_buf_split:
+
+Buffer Split
+~~~~~~~~~~~~
+
+On Rx, the packets can be :ref:`split at a specific offset <nic_features_buffer_split>`,
+allowing header or payload processing from a specific memory or device.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-5
+firmware   16.28.2006
+OFED       5.1-2
+DPDK       20.11
+=========  ==========
+
+Limitations
+^^^^^^^^^^^
+
+#. Buffer split offload is supported with regular Rx burst routine only,
+   no MPRQ feature or vectorized code can be engaged.
+
+
+.. _mlx5_multiseg:
+
+Multi-Segment Scatter/Gather
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+:ref:`nic_features_scattered_rx`
+
+Limitations
+^^^^^^^^^^^
+
+#. A multi-segment packet must not have more segments
+   than reported in ``rte_eth_dev_info.tx_desc_lim.nb_seg_max``.
+   This value depends on maximal supported Tx descriptor size
+   and ``txq_inline_min`` settings,
+   and may be from 2 (worst case forced by maximal inline settings) to 58.
+
+
+.. _mlx5_lro:
+
+LRO
+~~~
+
+:ref:`Large Receive Offload (LRO) <nic_features_lro>`
+aggregates multiple packets in a big buffer.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-5
+firmware   16.25.6406
+OFED       4.6-4
+DPDK       19.08
+=========  ==========
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+LRO requires DevX (``UCTX_EN=1``).
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+LRO requires DV flow to be enabled (``dv_flow_en=1`` or ``dv_flow_en=2``).
+
+The session timeout may be changed
+with the parameter :ref:`lro_timeout_usec <mlx5_lro_timeout>`.
+
+Limitations
+^^^^^^^^^^^
+
+#. The driver rounds down the port configuration value ``max_lro_pkt_size``
+   (from ``rte_eth_rxmode``) to a multiple of 256 due to hardware limitation.
+
+#. LRO is performed only for packet size larger than ``lro_min_mss_size``.
+   This value is reported on device start, when debug mode is enabled.
+
+#. Rx queue with LRO offload enabled, receiving a non-LRO packet,
+   can forward it with size limited to max LRO size, not to max Rx packet length.
+
+#. ``RTE_ETH_RX_OFFLOAD_KEEP_CRC`` offload cannot be supported with LRO.
+
+#. The first mbuf length, without headroom,
+   must be big enough to include the TCP header (122B).
+
+#. LRO can be used with outer header of TCP packets of the standard format::
+
+     eth (with or without vlan) / ipv4 or ipv6 / tcp / payload
+
+   Other TCP packets (e.g. with MPLS label) received on Rx queue with LRO enabled,
+   will be received with bad checksum.
+
+
+.. _mlx5_tso:
+
+TSO
+~~~
+
+:ref:`TCP Segmentation Offload (TSO) <nic_features_tso>`
+is supported for generic IP or UDP tunnel, including VXLAN and GRE.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-4
+firmware   12.21.1000
+OFED       4.2-1
+Linux      4.14
+rdma-core  16
+DPDK       17.11
+=========  ==========
+
+
+.. _mlx5_crc:
+
+CRC
+~~~
+
+:ref:`nic_features_crc_offload`
+
+Requirements
+^^^^^^^^^^^^
+
+``RTE_ETH_RX_OFFLOAD_KEEP_CRC`` is not supported with decapsulation for some devices
+(such as ConnectX-6 Dx, ConnectX-6 Lx, ConnectX-7, BlueField-2 and BlueField-3).
+The capability bit ``scatter_fcs_w_decap_disable`` shows HW support.
+
+Limitations
+^^^^^^^^^^^
+
+#. ``RTE_ETH_RX_OFFLOAD_KEEP_CRC`` is not supported if :ref:`mlx5_lro` is enabled.
+
+
+.. _mlx5_cksums:
+
+L3/L4 Checksums Offloading
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Checksum API includes
+:ref:`L3 <nic_features_l3_checksum_offload>`,
+:ref:`L4 <nic_features_l4_checksum_offload>`,
+:ref:`inner L3 <nic_features_inner_l3_checksum>`
+and :ref:`inner L4 <nic_features_inner_l4_checksum>`.
+
+IP and UDP checksums are verified on Rx, including in tunnels.
+
+Hardware checksum Tx offload is supported
+for generic IP or UDP tunnel, including VXLAN and GRE.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-4
+firmware   12.21.1000
+OFED       4.2-1
+Linux      4.14
+rdma-core  16
+DPDK       17.11
+=========  ==========
+
+
+.. _mlx5_rss:
+
+RSS
+~~~
+
+Receive Side Scaling (RSS) allows to dispatch received packets to multiple queues.
+
+RSS can be configured at port level:
+
+- :ref:`nic_features_rss_hash`
+- :ref:`nic_features_rss_key_update`
+- :ref:`nic_features_rss_reta_update`
+
+or at flow level with ``RTE_FLOW_ACTION_TYPE_RSS``,
+including :ref:`inner RSS <nic_features_inner_rss>`.
+
+Different combinations of fields are supported:
+L3 only, L4 only or both, and source only, destination only or both.
+
+Multiple RSS hash keys are supported, one for each flow type.
+
+The symmetric RSS function is supported by swapping source and destination
+addresses and ports.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========  =================
+Minimum    Version     for Shared Action
+=========  ==========  =================
+hardware   ConnectX-4  ConnectX-5
+OFED       4.5         5.2
+rdma-core  23          33
+DPDK       18.11       20.11
+=========  ==========  =================
+
+Limitations
+^^^^^^^^^^^
+
+#. RSS hash result:
+
+   Full support is only available when hash RSS format is selected
+   as the current :ref:`CQE compression format <mlx5_cqe_comp_param>` on the Rx side.
+
+   Using any other format may result in some Rx packets
+   not having the ``RTE_MBUF_F_RX_RSS_HASH`` flag set.
+
+#. If :ref:`multi-packet Rx queue <mlx5_mprq_params>` is configured
+   and :ref:`Rx CQE compression <mlx5_cqe_comp_param>` is enabled at the same time,
+   RSS hash result is not fully supported.
+   This is because the checksum format is selected by default in this configuration.
+
+#. Flex item fields (``next_header``, ``next_protocol``, ``samples``)
+   do not participate in RSS hash functions.
+
+#. ``RTE_FLOW_ACTION_TYPE_RSS`` can be used in transfer flow rules,
+   since firmware version xx.43.1014,
+   but only on template tables
+   with ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG`` specialization.
+
+
+.. _mlx5_flow_queue:
+
+Flow Queue
+~~~~~~~~~~
+
+A flow may be sent to a specific queue with ``RTE_FLOW_ACTION_TYPE_QUEUE``.
+
+The egress traffic sent via a specific Tx queue
+is matched with ``RTE_FLOW_ITEM_TYPE_TX_QUEUE``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-4
+OFED       4.5
+rdma-core  23
+DPDK       18.11
+=========  ==========
+
+Limitations
+^^^^^^^^^^^
+
+#. ``RTE_FLOW_ACTION_TYPE_QUEUE`` can be used in transfer flow rules,
+   since firmware version xx.43.1014,
+   but only on template tables
+   with ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG`` specialization.
+
+
+.. _mlx5_flow_port:
+
+Flow Port ID
+~~~~~~~~~~~~
+
+The flow item ``RTE_FLOW_ITEM_TYPE_PORT_ID`` is deprecated.
+For matching flows coming from a specific port,
+the items ``RTE_FLOW_ITEM_TYPE_PORT_REPRESENTOR``
+and ``RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT`` can be used.
+
+The flow action ``RTE_FLOW_ACTION_TYPE_PORT_ID`` is deprecated.
+For sending flows to a specific port,
+the actions ``RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR``
+and ``RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT`` can be used.
+
+In E-Switch mode, a flow rule matching
+``RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT`` with port ID ``UINT16_MAX``
+means matching packets sent by the E-Switch manager from software.
+This feature requires at least OFED 24.04 or an upstream equivalent.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============
+Minimum    for E-Switch
+=========  ============
+hardware   ConnectX-5
+OFED       4.7-1
+rdma-core  24
+DPDK       19.05
+=========  ============
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The behaviour of port representors is configured
+with some :ref:`parameters <mlx5_representor_params>`.
+The option ``repr_matching_en`` has an impact on flow steering.
+
+Limitations
+^^^^^^^^^^^
+
+#. The NIC egress flow rules on port representor are not supported.
+
+#. A driver limitation for ``RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR`` action
+   restricts the ``port_id`` configuration to only accept the value ``0xffff``,
+   indicating the E-Switch manager.
+   If the ``repr_matching_en`` parameter is enabled, the traffic will be directed
+   to the representor of the source virtual port (SF/VF), while if it is disabled,
+   the traffic will be routed based on the steering rules in the ingress domain.
+
+
+.. _mlx5_flow_drop:
+
+Flow Drop
+~~~~~~~~~
+
+A flow may be dropped with ``RTE_FLOW_ACTION_TYPE_DROP``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-4
+OFED       4.6           4.5
+rdma-core  24            23
+DPDK       19.05         18.11
+=========  ============  ============
+
+
+.. _mlx5_jump:
+
+Flow Jump
+~~~~~~~~~
+
+A flow rule may redirect to another group of rules
+with ``RTE_FLOW_ACTION_TYPE_JUMP``.
+
+In template API, it is possible to redirect to a specific index
+in a flow template table with ``RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       4.7-1         4.7-1
+rdma-core  24
+DPDK       19.05         19.02
+=========  ============  ============
+
+Jump to a template table index is supported with these requirements:
+
+=========  ============
+Minimum    Version
+=========  ============
+DPDK       24.11
+=========  ============
+
+Limitations
+^^^^^^^^^^^
+
+#. With the async template API, jumping to a template table
+   with ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG`` specialization
+   from a template table with a different specialization
+   is supported since firmware version xx.43.1014.
+
+
+.. _mlx5_indirect:
+
+Flow Indirect
+~~~~~~~~~~~~~
+
+An action can be created separately of a flow rule.
+Then the indirect action can be referenced in one or more flow rules
+with ``RTE_FLOW_ACTION_TYPE_INDIRECT``.
+
+Similarly a list of indirect actions can be referenced
+with ``RTE_FLOW_ACTION_TYPE_INDIRECT_LIST``.
+
+Limitations
+^^^^^^^^^^^
+
+#. For actions list, the handle in the template action part must be non-zero.
+
+#. If an indirect actions list handle is non-masked,
+   the handle will be used as a reference to the action type in template creation.
+
+#. If an indirect actions list handle is masked,
+   the mask will be used in template creation and flow rule.
+
+
+.. _mlx5_meta:
+
+Flow Metadata
+~~~~~~~~~~~~~
+
+A metadata can be attached to a flow with ``RTE_FLOW_ACTION_TYPE_SET_META``
+and matched with ``RTE_FLOW_ITEM_TYPE_META``.
+
+The flow items ``RTE_FLOW_ITEM_TYPE_META`` and ``RTE_FLOW_ITEM_TYPE_MARK``
+are interrelated with the datapath -
+they might move from/to the applications in mbuf fields.
+Hence, zero value for these items has the special meaning "no metadata are provided".
+Non-zero values are treated by the application and the driver as valid ones.
+
+Moreover in the flow engine domain, the value zero is acceptable to match and set,
+and it should be allowed to specify zero values as parameters
+for the META and MARK flow items and actions.
+In the same time, zero mask has no meaning and should be rejected on validation stage.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       4.7-3         4.7-3
+rdma-core  26            26
+DPDK       19.11         19.11
+=========  ============  ============
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The parameter :ref:`dv_xmeta_en <mlx5_meta_mark_param>`
+allows to configure the driver handling of META and MARK.
+
+Limitations
+^^^^^^^^^^^
+
+#. No Tx metadata go to the E-Switch steering domain for the flow group 0.
+   The rules using ``RTE_FLOW_ACTION_TYPE_SET_META`` within group 0 are rejected.
+
+
+.. _mlx5_mark:
+
+Flow Mark
+~~~~~~~~~
+
+A mark can be attached to a flow with ``RTE_FLOW_ACTION_TYPE_MARK``
+and matched with ``RTE_FLOW_ITEM_TYPE_MARK``.
+
+See notes about :ref:`mlx5_meta`.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-4
+OFED       4.6           4.5
+rdma-core  24            23
+DPDK       19.05         18.11
+=========  ============  ============
+
+Limitations
+^^^^^^^^^^^
+
+#. ``RTE_FLOW_ACTION_TYPE_MARK`` can be used in transfer flow rules,
+   since firmware version xx.43.1014,
+   but only on template tables
+   with ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG`` specialization.
+
+
+.. _mlx5_flag:
+
+Flow Flag
+~~~~~~~~~
+
+A flow can be flagged with ``RTE_FLOW_ACTION_TYPE_FLAG``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-4
+OFED       4.6           4.5
+rdma-core  24            23
+DPDK       19.05         18.11
+=========  ============  ============
+
+
+.. _mlx5_tag:
+
+Flow Tag
+~~~~~~~~
+
+A tag is matched with the flow item ``RTE_FLOW_ITEM_TYPE_TAG``.
+
+
+
+.. _mlx5_integrity:
+
+Flow Integrity
+~~~~~~~~~~~~~~
+
+Packets may be matched on their integrity status (like checksums)
+with ``RTE_FLOW_ITEM_TYPE_INTEGRITY``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+DPDK       21.05
+=========  =============
+
+Limitations
+^^^^^^^^^^^
+
+#. Verification bits provided by the hardware are:
+
+   - ``l3_ok``
+   - ``ipv4_csum_ok``
+   - ``l4_ok``
+   - ``l4_csum_ok``
+
+#. ``level`` value 0 references outer headers.
+
+#. Negative integrity item verification is not supported.
+
+#. With SW steering (``dv_flow_en=1``)
+
+   - Multiple integrity items are not supported in a single flow rule.
+   - The network headers referred by the integrity item must be explicitly matched.
+     For example, if the integrity mask sets ``l4_ok`` or ``l4_csum_ok`` bits,
+     the L4 network headers, TCP or UDP, must be in the rule pattern.
+     Examples::
+
+        flow create 0 ingress pattern integrity level is 0 value mask l3_ok value spec l3_ok / eth / ipv6 / end ...
+        flow create 0 ingress pattern integrity level is 0 value mask l4_ok value spec l4_ok / eth / ipv4 proto is udp / end ...
+
+#. With :ref:`HW steering <mlx5_hws>`
+
+   - The ``l3_ok`` field represents all L3 checks, but nothing about IPv4 checksum.
+   - The ``l4_ok`` field represents all L4 checks including L4 checksum.
+
+
+.. _mlx5_flow_count:
+
+Flow Count
+~~~~~~~~~~
+
+Matched ackets (and bytes) counters may be enabled
+in flow rules with ``RTE_FLOW_ACTION_TYPE_COUNT``.
+
+Below is described how it works in the HW steering flow engine.
 
 Flow counters are allocated from HW in bulks.
 A set of bulks forms a flow counter pool managed by PMD.
@@ -2202,6 +2571,23 @@ The counter service thread works as follows:
 #. Sleep for ``(query time) - svc_cycle_time`` milliseconds
 #. Repeat.
 
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  =============  ======================   =================
+Minimum    for E-Switch  NIC domain     E-Switch Shared Action   NIC Shared Action
+=========  ============  =============  ======================   =================
+hardware   ConnectX-5    ConnectX-5     ConnectX-5               ConnectX-5
+firmware
+OFED       4.6           4.6            4.6                      4.6
+Linux
+rdma-core  24            23             24                       23
+DPDK       19.05         19.02          21.05                    21.05
+=========  ============  =============  ======================   =================
+
+Limitations
+^^^^^^^^^^^
+
 Because freeing a counter (by destroying a flow rule or destroying indirect action)
 does not immediately make it available for the application,
 the PMD might return:
@@ -2217,67 +2603,1348 @@ The application has to be aware that flow rule create or indirect action create
 might need be retried.
 
 
-Notes for hairpin
------------------
+.. _mlx5_age:
 
-NVIDIA ConnectX and BlueField devices support
-specifying memory placement for hairpin Rx and Tx queues.
-This feature requires NVIDIA MLNX_OFED 5.8.
+Flow Age
+~~~~~~~~
 
-By default, data buffers and packet descriptors for hairpin queues
-are placed in device memory
-which is shared with other resources (e.g. flow rules).
+A flow rule timeout can be set with ``RTE_FLOW_ACTION_TYPE_AGE``.
 
-Starting with DPDK 22.11 and NVIDIA MLNX_OFED 5.8,
-applications are allowed to:
+Requirements
+^^^^^^^^^^^^
 
-#. Place data buffers and Rx packet descriptors in dedicated device memory.
-   Application can request that configuration
-   through ``use_locked_device_memory`` configuration option.
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+OFED       5.2
+rdma-core  32
+DPDK       20.11
+=========  =============
 
-   Placing data buffers and Rx packet descriptors in dedicated device memory
-   can decrease latency on hairpinned traffic,
-   since traffic processing for the hairpin queue will not be memory starved.
+Limitations
+^^^^^^^^^^^
 
-   However, reserving device memory for hairpin Rx queues
-   may decrease throughput under heavy load,
-   since less resources will be available on device.
+With :ref:`HW steering <mlx5_hws>`,
 
-   This option is supported only for Rx hairpin queues.
+#. Using the same indirect count action combined with multiple age actions
+   in different flows may cause a wrong age state for the age actions.
 
-#. Place Tx packet descriptors in host memory.
-   Application can request that configuration
-   through ``use_rte_memory`` configuration option.
+#. Creating/destroying flow rules with indirect age action when it is active
+   (timeout != 0) may cause a wrong age state for the indirect age action.
 
-   Placing Tx packet descritors in host memory can increase traffic throughput.
-   This results in more resources available on the device for other purposes,
-   which reduces memory contention on device.
-   Side effect of this option is visible increase in latency,
-   since each packet incurs additional PCI transactions.
+#. The driver reuses counters for aging action, so for optimization
+   the values in ``rte_flow_port_attr`` structure should describe:
 
-   This option is supported only for Tx hairpin queues.
+   - ``nb_counters`` is the number of flow rules using counter (with/without age)
+     in addition to flow rules using only age (without count action).
+   - ``nb_aging_objects`` is the number of flow rules containing age action.
 
 
-Notes for testpmd
------------------
+.. _mlx5_quota:
 
-Compared to librte_net_mlx4 that implements a single RSS configuration per
-port, librte_net_mlx5 supports per-protocol RSS configuration.
+Quota
+~~~~~
 
-Since ``testpmd`` defaults to IP RSS mode and there is currently no
-command-line parameter to enable additional protocols (UDP and TCP as well
-as IP), the following commands must be entered from its CLI to get the same
-behavior as librte_net_mlx4::
+A quota limit (packets or bytes) may be applied to a flow
+with ``RTE_FLOW_ACTION_TYPE_QUOTA``.
+Then the quota state is handled by matching with ``RTE_FLOW_ITEM_TYPE_QUOTA``.
+
+Requirements
+^^^^^^^^^^^^
+
+Such flow rule requires :ref:`HW steering <mlx5_hws>`.
+
+Limitations
+^^^^^^^^^^^
+
+#. Quota is supported only in non-root HW tables (group > 0).
+
+#. Quota must be an indirect rule.
+
+#. The maximal value is ``INT32_MAX`` (2G).
+
+#. After increasing the value with ``RTE_FLOW_UPDATE_QUOTA_ADD``,
+   the next update must be with ``RTE_FLOW_UPDATE_QUOTA_SET``.
+
+#. The maximal number of HW quota and HW meter objects is ``16e6``.
+
+#. ``RTE_FLOW_ACTION_TYPE_QUOTA`` cannot be used in the same rule
+   with a meter action or ``RTE_FLOW_ACTION_TYPE_CONNTRACK``.
+
+
+.. _mlx5_meter:
+
+Metering
+~~~~~~~~
+
+Meter profile packet mode is supported.
+
+Meter profiles of RFC2697, RFC2698 and RFC4115 are supported.
+
+RFC4115 implementation is following MEF,
+meaning yellow traffic may reclaim unused green bandwidth
+when green token bucket is full.
+
+A meter M can be created on port X and to be shared with a port Y
+on the same switch domain:
+
+.. code-block:: console
+
+   flow create X ingress transfer pattern eth / port_id id is Y / end actions meter mtr_id M / end
+
+A termination meter M can be the policy green action of another termination meter N.
+The two meters are chained together as a chain. Using meter N in a flow will apply
+both the meters in hierarchy on that flow:
+
+.. code-block:: console
+
+   add port meter policy 0 1 g_actions queue index 0 / end y_actions end r_actions drop / end
+   create port meter 0 M 1 1 yes 0xffff 1 0
+   add port meter policy 0 2 g_actions meter mtr_id M / end y_actions end r_actions drop / end
+   create port meter 0 N 2 2 yes 0xffff 1 0
+   flow create 0 ingress group 1 pattern eth / end actions meter mtr_id N / end
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========  =============  =============
+Minimum    Basic       ASO            Hierarchy
+=========  ==========  =============  =============
+hardware   ConnectX-5  ConnectX-6 Dx  ConnectX-6 Dx
+firmware
+OFED       4.7-3       5.3            5.3
+Linux
+rdma-core  26          33
+DPDK       19.11       21.05          21.08
+=========  ==========  =============  =============
+
+Limitations
+^^^^^^^^^^^
+
+#. All the meter colors with drop action will be counted only by the global drop statistics.
+
+#. Yellow detection is only supported with ASO metering.
+
+#. Red color must be with drop action.
+
+#. Meter statistics are supported only for drop case.
+
+#. A meter action created with pre-defined policy must be the last action in the flow except single case where the policy actions are:
+
+   - green: NULL or END.
+   - yellow: NULL or END.
+   - RED: DROP / END.
+
+#. The only supported meter policy actions:
+
+   - green: QUEUE, RSS, PORT_ID, REPRESENTED_PORT, JUMP, DROP, MODIFY_FIELD, MARK, METER and SET_TAG.
+   - yellow: QUEUE, RSS, PORT_ID, REPRESENTED_PORT, JUMP, DROP, MODIFY_FIELD, MARK, METER and SET_TAG.
+   - RED: must be DROP.
+
+#. Policy actions of RSS for green and yellow should have the same configuration except queues.
+
+#. Policy with RSS/queue action is not supported when ``dv_xmeta_en`` enabled.
+
+#. If green action is METER, yellow action must be the same METER action or NULL.
+
+#. When using DV flow engine (``dv_flow_en=1``),
+   if meter has drop count
+   or meter hierarchy contains any meter that uses drop count,
+   it cannot be used by flow rule matching all ports.
+
+#. When using DV flow engine (``dv_flow_en=1``),
+   if meter hierarchy contains any meter that has MODIFY_FIELD/SET_TAG,
+   it cannot be used by flow matching all ports.
+
+#. When using :ref:`HW steering <mlx5_hws>`,
+   only meter mark action is supported.
+
+#. The maximal number of HW quota and HW meter objects is ``16e6``.
+
+
+.. _mlx5_sample:
+
+Sampling
+~~~~~~~~
+
+A ratio of a flow can be duplicated before getting a fate action applied.
+Such sampling rule is configured with ``RTE_FLOW_ACTION_TYPE_SAMPLE``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       5.1-2         5.1-2
+rdma-core  32
+DPDK       20.11         20.11
+=========  ============  ============
+
+Limitations
+^^^^^^^^^^^
+
+#. Supports ``RTE_FLOW_ACTION_TYPE_SAMPLE`` action only within NIC Rx and
+   E-Switch steering domain.
+
+#. In E-Switch steering domain, for sampling with sample ratio > 1 in a transfer rule,
+   additional actions are not supported in the sample actions list.
+
+#. For ConnectX-5, the ``RTE_FLOW_ACTION_TYPE_SAMPLE`` is typically used as
+   first action in the E-Switch egress flow if with header modify or
+   encapsulation actions.
+
+#. For NIC Rx flow, supports only ``MARK``, ``COUNT``, ``QUEUE``, ``RSS`` in the
+   sample actions list.
+
+#. In E-Switch steering domain, for mirroring with sample ratio = 1 in a transfer rule,
+   supports only ``RAW_ENCAP``, ``PORT_ID``, ``REPRESENTED_PORT``, ``VXLAN_ENCAP``, ``NVGRE_ENCAP``
+   in the sample actions list.
+
+#. In E-Switch steering domain, for mirroring with sample ratio = 1 in a transfer rule,
+   the encapsulation actions (``RAW_ENCAP`` or ``VXLAN_ENCAP`` or ``NVGRE_ENCAP``)
+   support uplink port only.
+
+#. In E-Switch steering domain, for mirroring with sample ratio = 1 in a transfer rule,
+   the port actions (``PORT_ID`` or ``REPRESENTED_PORT``) with uplink port and ``JUMP`` action
+   are not supported without the encapsulation actions
+   (``RAW_ENCAP`` or ``VXLAN_ENCAP`` or ``NVGRE_ENCAP``) in the sample actions list.
+
+#. For ConnectX-5 trusted device, the application metadata with SET_TAG index 0
+   is not supported before ``RTE_FLOW_ACTION_TYPE_SAMPLE`` action.
+
+
+.. _mlx5_random:
+
+Random
+~~~~~~
+
+A flow rule can match randomly by using ``RTE_FLOW_ITEM_TYPE_RANDOM``.
+
+Requirements
+^^^^^^^^^^^^
+
+Such flow rule requires :ref:`HW steering <mlx5_hws>`.
+
+Limitations
+^^^^^^^^^^^
+
+#. Supports matching only 16 bits (LSB).
+
+#. NIC ingress/egress flow in group 0 is not supported.
+
+#. Supported only in template table with ``nb_flows=1``.
+
+
+.. _mlx5_flex_item:
+
+Flex Item
+~~~~~~~~~
+
+A flow can be matched on a set of fields at specific offsets
+with ``RTE_FLOW_ITEM_TYPE_FLEX``.
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching a flex item requires to enable the dynamic flex parser
+by setting these values::
+
+   FLEX_PARSER_PROFILE_ENABLE=4
+   PROG_PARSE_GRAPH=1
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+Limitations
+^^^^^^^^^^^
+
+#. Flex item is supported on PF only.
+
+#. The header length mask width can go up to 6 bits.
+
+#. The Firmware supports 8 global sample fields.
+   Each flex item allocates non-shared sample fields from that pool.
+
+#. The flex item can have 1 input link - ``eth`` or ``udp``
+    and up to 3 output links - ``ipv4`` or ``ipv6``.
+
+#. In flex item configuration, ``next_header.field_base`` value
+   must be byte aligned (multiple of 8).
+
+#. With ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD``, the flex item offset
+   must be byte aligned (multiple of 8).
+
+#. The flex item fields (``next_header``, ``next_protocol``, ``samples``)
+   do not participate in RSS hash functions.
+
+
+.. _mlx5_raw_header:
+
+Raw Header
+~~~~~~~~~~
+
+A flow can be encapsulated with an additional header
+provided through ``RTE_FLOW_ACTION_TYPE_RAW_ENCAP``.
+
+Similarly a header can be removed by decapsulating a flow
+with ``RTE_FLOW_ACTION_TYPE_RAW_DECAP``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       4.7-1         4.6
+rdma-core  24            23
+DPDK       19.05         19.02
+=========  ============  ============
+
+Limitations
+^^^^^^^^^^^
+
+#. The input buffer, used as outer header for raw encapsulation, is not validated.
+
+#. The input buffer, providing the removal size of decapsulation, is not validated.
+
+#. The buffer size must match the length of the headers to be removed.
+
+#. The decapsulation is always done up to the outermost tunnel detected by the HW.
+
+
+.. _mlx5_modify:
+
+Header Field Modification
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Packet headers of a flow can be modified with ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ==========
+Minimum    Version
+=========  ==========
+hardware   ConnectX-5
+OFED       5.2
+rdma-core  35
+DPDK       21.02
+=========  ==========
+
+Limitations
+^^^^^^^^^^^
+
+#. Supports the 'set' and 'add' operations for ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD`` action.
+
+#. Not supported in group 0.
+
+#. Modification of an arbitrary place in a packet via
+   the special ``RTE_FLOW_FIELD_START`` field ID is not supported.
+
+#. Offsets must be 4-byte aligned: 32, 64 and 96 for IPv6.
+
+#. Offsets cannot skip past the boundary of a field.
+
+#. For packet fields (e.g. MAC addresses, IPv4 addresses or L4 ports)
+   offset specifies the number of bits to skip from field's start,
+   starting from MSB in the first byte, in the network order.
+
+#. For flow metadata fields (e.g. META or TAG)
+   offset specifies the number of bits to skip from field's start,
+   starting from LSB in the least significant byte, in the host order.
+
+#. Cannot use ``RTE_FLOW_FIELD_RANDOM``.
+
+#. Cannot use ``RTE_FLOW_FIELD_MARK``.
+
+#. Modification of the 802.1Q tag is not supported.
+
+#. If the field type is ``RTE_FLOW_FIELD_MAC_TYPE``
+   and packet contains one or more VLAN headers,
+   the meaningful type field following the last VLAN header
+   is used as modify field operation argument.
+   The modify field action is not intended to modify VLAN headers type field,
+   dedicated VLAN push and pop actions should be used instead.
+
+#. Modification of VXLAN network or GENEVE network ID is supported only for HW steering.
+
+#. Modification of the VXLAN header is supported with below limitations:
+
+   - Only for :ref:`HW steering <mlx5_hws>`.
+   - Support VNI and the last reserved byte modifications for traffic
+     with default UDP destination port: 4789 for VXLAN and VXLAN-GBP, 4790 for VXLAN-GPE.
+
+#. Modification of GENEVE network ID is not supported when configured
+   ``FLEX_PARSER_PROFILE_ENABLE`` supports GENEVE TLV options.
+   See :ref:`mlx5_firmware_config` for more flex parser information.
+
+#. Modification of GENEVE TLV option fields is supported only for HW steering.
+   Only DWs configured in :ref:`parser creation <mlx5_geneve_parser>` can be modified,
+   'type' and 'class' fields can be modified when ``match_on_class_mode=2``.
+
+#. Modification of GENEVE TLV option data supports one DW per action.
+
+#. Modification of the MPLS header is supported with some limitations:
+
+   - Only in HW steering.
+   - Only in ``src`` field.
+   - Only for outermost tunnel header (``level=2``).
+     For ``RTE_FLOW_FIELD_MPLS``,
+     the default encapsulation level ``0`` describes the outermost tunnel header.
+
+   .. note::
+
+      The default encapsulation level ``0`` describes
+      the "outermost that match is supported",
+      currently it is the first tunnel,
+      but it can be changed to outer when it is supported.
+
+#. Default encapsulation level ``0`` describes outermost.
+
+#. Encapsulation level ``2`` is supported with some limitations:
+
+   - Only in HW steering.
+   - Only in ``src`` field.
+   - ``RTE_FLOW_FIELD_VLAN_ID`` is not supported.
+   - ``RTE_FLOW_FIELD_IPV4_PROTO`` is not supported.
+   - ``RTE_FLOW_FIELD_IPV6_PROTO/DSCP/ECN`` are not supported.
+   - ``RTE_FLOW_FIELD_ESP_PROTO/SPI/SEQ_NUM`` are not supported.
+   - ``RTE_FLOW_FIELD_TCP_SEQ/ACK_NUM`` are not supported.
+   - Second tunnel fields are not supported.
+
+#. Encapsulation levels greater than ``2`` are not supported.
+
+
+.. _mlx5_compare:
+
+Field Comparison
+~~~~~~~~~~~~~~~~
+
+The traffic may be matched in a flow by comparing some header or metadata fields
+to be lesser, greater or equal a value or another field,
+thanks to ``RTE_FLOW_ITEM_TYPE_COMPARE``.
+
+Requirements
+^^^^^^^^^^^^
+
+Such flow rule requires :ref:`HW steering <mlx5_hws>`.
+
+Limitations
+^^^^^^^^^^^
+
+#. Only single flow is supported to the flow table.
+
+#. Only single item is supported per pattern template.
+
+#. In switch mode, when ``repr_matching_en`` is enabled (default setting),
+   matching ``RTE_FLOW_ITEM_TYPE_COMPARE`` is not supported for ``ingress`` rules.
+   This is because an implicit ``RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT``
+   needs to be added to the matcher,
+   which conflicts with the single item limitation.
+
+#. Only 32-bit comparison is supported or 16-bit for random field.
+
+#. Only supported for ``RTE_FLOW_FIELD_META``, ``RTE_FLOW_FIELD_TAG``,
+   ``RTE_FLOW_FIELD_ESP_SEQ_NUM``,
+   ``RTE_FLOW_FIELD_RANDOM`` and ``RTE_FLOW_FIELD_VALUE``.
+
+#. The field type ``RTE_FLOW_FIELD_VALUE`` must be the base (``b``) field.
+
+#. The field type ``RTE_FLOW_FIELD_RANDOM`` can only be compared with
+   ``RTE_FLOW_FIELD_VALUE``.
+
+
+.. _mlx5_ptype:
+
+Packet Type
+~~~~~~~~~~~
+
+When receiving a packet, its type is parsed
+and :ref:`stored <nic_features_packet_type_parsing>`
+in the field ``packet_type`` of ``rte_mbuf``.
+
+The same packet type format may be used to match a flow
+with ``RTE_FLOW_ITEM_TYPE_PTYPE``.
+
+Requirements
+^^^^^^^^^^^^
+
+Such flow rule requires :ref:`HW steering <mlx5_hws>`.
+
+Limitations
+^^^^^^^^^^^
+
+#. The supported values are:
+
+   - L2: ``RTE_PTYPE_L2_ETHER``, ``RTE_PTYPE_L2_ETHER_VLAN``, ``RTE_PTYPE_L2_ETHER_QINQ``
+   - L3: ``RTE_PTYPE_L3_IPV4``, ``RTE_PTYPE_L3_IPV6``
+   - L4: ``RTE_PTYPE_L4_TCP``, ``RTE_PTYPE_L4_UDP``, ``RTE_PTYPE_L4_ICMP``
+     and their ``RTE_PTYPE_INNER_XXX`` counterparts as well as ``RTE_PTYPE_TUNNEL_ESP``.
+
+   Any other values are not supported.
+   Using them as a value will cause unexpected behavior.
+
+#. Matching on both outer and inner fragmented IP is supported
+   using ``RTE_PTYPE_L4_FRAG`` and ``RTE_PTYPE_INNER_L4_FRAG`` values.
+   They are not part of L4 types, so they should be provided explicitly
+   as a mask value during pattern template creation.
+   Providing ``RTE_PTYPE_L4_MASK`` during pattern template creation
+   and ``RTE_PTYPE_L4_FRAG`` during flow rule creation
+   will cause unexpected behavior.
+
+
+.. _mlx5_eth:
+
+Ethernet
+~~~~~~~~
+
+Ethernet header is matched with the flow item ``RTE_FLOW_ITEM_TYPE_ETH``.
+
+
+.. _mlx5_roce:
+
+RoCE
+~~~~
+
+Remote Direct Memory Access (RDMA) over Converged Ethernet (RoCE)
+can be matched through the InfiniBand Base Transport Header (BTH)
+with the flow item ``RTE_FLOW_ITEM_TYPE_IB_BTH``.
+
+Limitations
+^^^^^^^^^^^
+
+#. ``RTE_FLOW_ITEM_TYPE_IB_BTH`` is not supported in group 0.
+
+#. ``RTE_FLOW_ITEM_TYPE_IB_BTH`` is not supported
+   with :ref:`HW steering <mlx5_hws>`.
+
+
+.. _mlx5_icmp:
+
+ICMP
+~~~~
+
+Internet Control Message Protocol (ICMP) for IPv4 and IPv6
+are matched respectively with
+``RTE_FLOW_ITEM_TYPE_ICMP`` and ``RTE_FLOW_ITEM_TYPE_ICMP6``.
+There are more flow items for ICMPv6.
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching ICMP flow is enabled by setting this value::
+
+   FLEX_PARSER_PROFILE_ENABLE=2
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+
+.. _mlx5_ip:
+
+IP
+~~
+
+Internet Protocol (IP) v4 and v6
+are matched respectively with the flow items
+``RTE_FLOW_ITEM_TYPE_IPV4`` and ``RTE_FLOW_ITEM_TYPE_IPV6``.
+
+There are more flow items for IPv6 extensions (like SRv6)
+which can be pushed or removed thanks to the flow offload actions
+``RTE_FLOW_ACTION_TYPE_IPV6_EXT_PUSH`` and ``RTE_FLOW_ACTION_TYPE_IPV6_EXT_REMOVE``.
+
+Translation between IPv4 and IPv6 can be offloaded with :ref:`mlx5_nat64`.
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching IP-in-IP tunnel flow is enabled by setting this value::
+
+   FLEX_PARSER_PROFILE_ENABLE=0
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+Limitations
+^^^^^^^^^^^
+
+#. IPv6 5-tuple matching is not supported with :ref:`HW steering <mlx5_hws>`.
+
+#. IPv6 multicast messages are not supported on VM,
+   while promiscuous mode and allmulticast mode are both set to off.
+   To receive IPv6 Multicast messages on VM,
+   explicitly set the relevant MAC address
+   using the function ``rte_eth_dev_mac_addr_add()``.
+
+#. IPv6 header item ``proto`` field, indicating the next header protocol,
+   should not be set as extension header.
+   In case the next header is an extension header,
+   it should not be specified in IPv6 header item ``proto`` field.
+   The last extension header item 'next header' field
+   can specify the following header protocol type.
+
+#. Match on IPv6 routing extension header requires :ref:`HW steering <mlx5_hws>`,
+   and supports the following fields:
+
+   - ``type``
+   - ``next_hdr``
+   - ``segments_left``
+
+#. IPv6 routing extension matching is not supported in flow template relaxed mode
+   (see ``struct rte_flow_pattern_template_attr::relaxed_matching``).
+
+#. Matching ICMP6 following IPv6 routing extension header
+   should match ``ipv6_routing_ext_next_hdr`` instead of ICMP6.
+
+#. IPv6 routing extension push/remove:
+
+   - Requires :ref:`HW steering <mlx5_hws>`.
+   - Supported in non-zero group
+     (no limits on transfer domain if ``fdb_def_rule_en=1`` which is default).
+   - Supports TCP or UDP as next layer.
+   - IPv6 routing header must be the only present extension.
+   - Not supported on guest port.
+
+#. IP-in-IP is not supported with :ref:`HW steering <mlx5_hws>`.
+
+
+.. _mlx5_nat64:
+
+NAT64
+~~~~~
+
+Network Address Translation between IPv6 and IPv4 (NAT64)
+can be offloaded with the flow action ``RTE_FLOW_ACTION_TYPE_NAT64``.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  =============
+Minimum    Version
+=========  =============
+firmware   xx.39.1002
+=========  =============
+
+NAT64 requires :ref:`HW steering <mlx5_hws>`.
+
+Limitations
+^^^^^^^^^^^
+
+#. Supported only on non-root HW table.
+
+#. TOS / Traffic Class is not supported.
+
+#. Actions order limitation should follow the :ref:`modify action <mlx5_modify>`.
+
+#. The last 2 tag registers will be used implicitly in address backup mode.
+
+#. Even if the action can be shared, new steering entries will be created per flow rule.
+   It is recommended a single rule with NAT64 should be shared
+   to reduce the duplication of entries.
+   The default address and other fields conversion will be handled with NAT64 action.
+   To support other address, new rule(s) with modify fields on the IP addresses
+   should be created.
+
+
+.. _mlx5_udp:
+
+UDP
+~~~
+
+User Datagram Protocol (UDP)
+is matched with the flow item ``RTE_FLOW_ITEM_TYPE_UDP``.
+
+Limitations
+^^^^^^^^^^^
+
+#. Outer UDP checksum calculation for encapsulation flow actions:
+
+  Currently available NVIDIA NICs and DPUs do not have a capability to calculate
+  the UDP checksum in the header added using encapsulation flow actions.
+
+  The application is required to use 0 in UDP checksum field in such flow actions.
+  Resulting packet will have outer UDP checksum equal to 0.
+
+
+.. _mlx5_tcp:
+
+TCP
+~~~
+
+Transmission Control Protocol (TCP)
+is matched with the flow item ``RTE_FLOW_ITEM_TYPE_TCP``.
+
+
+.. _mlx5_conntrack:
+
+TCP Connection Tracking
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Connection tracking is the process of tracking a TCP connection
+between two endpoints (e.g. between server and client).
+This involves maintaining the state of the connection,
+identifying state changing packets, malformed packets,
+packets that do not conform to the protocol or the current connection state, and more.
+This process requires state awareness.
+
+:ref:`TCP connection tracking <flow_conntrack_action>` is offloaded to the hardware
+thanks to the item ``RTE_FLOW_ITEM_TYPE_CONNTRACK``
+and the action ``RTE_FLOW_ACTION_TYPE_CONNTRACK``.
+
+This offload can track a single connection only,
+meaning every connection should be offloaded separately.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+OFED       5.3
+rdma-core  35
+DPDK       21.05
+=========  =============
+
+Limitations
+^^^^^^^^^^^
+
+#. 16 ports maximum (with ``dv_flow_en=1``).
+
+#. 32M connections maximum.
+
+#. The CT action must be wrapped by an action_handle
+
+#. ``RTE_FLOW_ACTION_TYPE_CONNTRACK`` action cannot be inserted in group 0.
+
+#. Flow rules insertion rate and memory consumption need more optimization.
+
+#. Cannot track a connection before seeing the first 2 handshake packets (SYN and SYN-ACK).
+
+#. No direction validation is done for closing sequence (FIN).
+
+#. Retransmission limit checking cannot work.
+
+#. Cannot co-exist with ASO meter, ASO age action in a single flow rule.
+
+
+.. _mlx5_vlan:
+
+VLAN
+~~~~
+
+Virtual Local Area Network (VLAN) tags
+can be configured at port level:
+
+- :ref:`nic_features_vlan_filter`
+- :ref:`nic_features_vlan_offload`
+- :ref:`nic_features_qinq_offload`
+
+or at flow level with the item ``RTE_FLOW_ITEM_TYPE_VLAN``
+and the actions :
+
+- ``RTE_FLOW_ACTION_TYPE_OF_POP_VLAN``
+- ``RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN``
+- ``RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_VID``
+- ``RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_PCP``
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ====================  ===============
+Minimum    Version for E-Switch  Version for NIC
+=========  ====================  ===============
+hardware   ConnectX-5            ConnectX-5
+OFED       4.7-1                 4.7-1
+DPDK       19.11                 19.11
+=========  ====================  ===============
+
+The flow transfer actions ``RTE_FLOW_ACTION_TYPE_OF_POP_VLAN`` on egress,
+and ``RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN`` on ingress,
+are supported with these requirements:
+
+=========  ====================
+Minimum    Version for E-Switch
+=========  ====================
+hardware   ConnectX-6 Dx
+OFED       5.3
+DPDK       21.05
+=========  ====================
+
+Limitations
+^^^^^^^^^^^
+
+#. When using Verbs flow engine (``dv_flow_en=0``),
+   a flow pattern without any specific VLAN
+   will match for VLAN packets as well.
+
+   When VLAN spec is not specified in the pattern,
+   the matching rule will be created with VLAN as a wild card.
+   Meaning, the flow rule::
+
+      flow create 0 ingress pattern eth / ipv4 / end ...
+
+   will match any IPv4 packet (VLAN included).
+
+   While the flow rule::
+
+      flow create 0 ingress pattern eth / vlan vid is 3 / ipv4 / end ...
+
+   will only match VLAN packets with ``vid=3``.
+
+#. When using Verbs flow engine (``dv_flow_en=0``),
+   multi-tagged (QinQ) match is not supported.
+
+#. When using DV flow engine (``dv_flow_en=1``),
+   flow pattern with any VLAN specification will match only single-tagged packets
+   unless the ethdev item ``type`` field is 0x88A8
+   or the VLAN item ``has_more_vlan`` field is 1.
+
+   The flow rule::
+
+      flow create 0 ingress pattern eth / ipv4 / end ...
+
+   will match any IPv4 packet.
+
+   The flow rules::
+
+      flow create 0 ingress pattern eth / vlan / end ...
+      flow create 0 ingress pattern eth has_vlan is 1 / end ...
+      flow create 0 ingress pattern eth type is 0x8100 / end ...
+
+   will match single-tagged packets only, with any VLAN ID value.
+
+   The flow rules::
+
+      flow create 0 ingress pattern eth type is 0x88A8 / end ...
+      flow create 0 ingress pattern eth / vlan has_more_vlan is 1 / end ...
+
+   will match multi-tagged packets only, with any VLAN ID value.
+
+#. A flow pattern with 2 sequential VLAN items is not supported.
+
+#. VLAN pop rule is not supported on egress traffic in NIC domain.
+
+#. VLAN pop rule without a match on VLAN item is not supported.
+
+#. VLAN push rule is not supported on ingress traffic in NIC domain.
+
+#. VLAN set PCP rule is not supported on existing headers.
+
+
+.. _mlx5_vxlan:
+
+VXLAN
+~~~~~
+
+Virtual Extensible Local Area Network (VXLAN) tunnel
+can be matched with the flow item ``RTE_FLOW_ITEM_TYPE_VXLAN``.
+
+There are 2 flow actions for encapsulation and decapsulation:
+
+- ``RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP``
+- ``RTE_FLOW_ACTION_TYPE_VXLAN_DECAP``
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       4.7-1         4.6
+rdma-core  24            23
+DPDK       19.05         19.02
+=========  ============  ============
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching VXLAN-GPE flow is enabled by setting one of these values::
+
+   FLEX_PARSER_PROFILE_ENABLE=0
+   or
+   FLEX_PARSER_PROFILE_ENABLE=2
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+The UDP destination port may be changed::
+
+   IP_OVER_VXLAN_EN=1
+   IP_OVER_VXLAN_PORT=<udp dport>
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The parameter :ref:`l3_vxlan_en <mlx5_vxlan_param>` must be set.
+
+Limitations
+^^^^^^^^^^^
+
+#. Matching on 8-bit flag and first 24-bit reserved fields
+   is only supported when using DV flow engine (``dv_flow_en=2``).
+
+#. For ConnectX-5, the UDP destination port must be the standard one (4789).
+
+#. Default UDP destination is 4789 if not explicitly specified.
+
+#. Group zero's behavior may differ which depends on FW.
+
+#. Different flags should be set when matching on VXLAN-GPE/GBP:
+
+   - for VXLAN-GPE - P flag
+   - for VXLAN-GBP - G flag
+
+#. Matching on VXLAN-GPE fields ``rsvd0``/``rsvd1`` depends on FW version
+   when using DV flow engine (``dv_flow_en=1``).
+
+#. Matching on VXLAN-GPE field ``protocol`` should be explicitly specified
+   in HWS (``dv_flow_en=2``).
+
+#. L3 VXLAN and VXLAN-GPE tunnels cannot be supported together with MPLSoGRE and MPLSoUDP.
+
+
+.. _mlx5_gre:
+
+GRE
+~~~
+
+Generic Routing Encapsulation (GRE) tunnel
+can be matched with the flow item ``RTE_FLOW_ITEM_TYPE_GRE``.
+
+More precise matching is possible with
+``RTE_FLOW_ITEM_TYPE_GRE_OPTION`` and ``RTE_FLOW_ITEM_TYPE_GRE_KEY``.
+
+The following fields of the GRE header can be matched:
+
+  - bits C, K and S
+  - protocol type
+  - checksum
+  - key
+  - sequence
+
+Requirements
+^^^^^^^^^^^^
+
+Matching on checksum and sequence needs MLNX_OFED 5.6+.
+
+
+.. _mlx5_nvgre:
+
+NVGRE
+~~~~~
+
+Network Virtualization using Generic Routing Encapsulation (NVGRE) tunnel
+can be matched with the flow item ``RTE_FLOW_ITEM_TYPE_NVGRE``.
+
+There are 2 flow actions for encapsulation and decapsulation:
+
+- ``RTE_FLOW_ACTION_TYPE_NVGRE_ENCAP``
+- ``RTE_FLOW_ACTION_TYPE_NVGRE_DECAP``
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       4.7-1         4.6
+rdma-core  24            23
+DPDK       19.05         19.02
+=========  ============  ============
+
+Limitations
+^^^^^^^^^^^
+
+#. In SW steering (``dv_flow_en=1``), this field can be matched:
+
+   - tni
+
+#. In :ref:`HW steering <mlx5_hws>`, these fields can be matched:
+
+   - c_rc_k_s_rsvd0_ver
+   - protocol
+   - tni
+   - flow_id
+
+
+.. _mlx5_geneve:
+
+GENEVE
+~~~~~~
+
+GEneric NEtwork Virtualization Encapsulation (GENEVE) tunnel
+can be matched with the flow item ``RTE_FLOW_ITEM_TYPE_GENEVE``
+for the following fields:
+
+- VNI
+- OAM
+- protocol type
+- options length
+
+The variable length option can be matched with ``RTE_FLOW_ITEM_TYPE_GENEVE_OPT``
+for the following fields:
+
+- Class
+- Type
+- Length
+- Data
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ============  ============
+Minimum    for E-Switch  NIC domain
+=========  ============  ============
+hardware   ConnectX-5    ConnectX-5
+OFED       4.7-3         4.7-3
+rdma-core  27            27
+DPDK       19.11         19.11
+=========  ============  ============
+
+For matching TLV option, these are the requirements:
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+OFED       5.2
+rdma-core  34
+DPDK       21.02
+=========  =============
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching GENEVE flow is enabled by setting one of these values::
+
+   FLEX_PARSER_PROFILE_ENABLE=0
+   or
+   FLEX_PARSER_PROFILE_ENABLE=1
+
+Matching GENEVE flow with TLV option is enabled by setting one of these values::
+
+   FLEX_PARSER_PROFILE_ENABLE=0
+   or
+   FLEX_PARSER_PROFILE_ENABLE=8
+
+Matching GENEVE flow with TLV option in HW steering with the sync API requires this value::
+
+   FLEX_PARSER_PROFILE_ENABLE=0
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+Limitations
+^^^^^^^^^^^
+
+#. GENEVE TLV option matching has restrictions.
+
+   Class/Type/Length fields must be specified as well as masks.
+   Class/Type/Length specified masks must be full.
+   Matching GENEVE TLV option without specifying data is not supported.
+   Matching GENEVE TLV option with ``data & mask == 0`` is not supported.
+
+   In SW steering (``dv_flow_en=1``):
+
+   - Only one Class/Type/Length GENEVE TLV option is supported per shared device.
+   - Supported only with ``FLEX_PARSER_PROFILE_ENABLE=0``.
+
+   In :ref:`HW steering <mlx5_hws>`:
+
+   - Multiple Class/Type/Length GENEVE TLV options are supported per physical device.
+   - Multiple of same GENEVE TLV option isn't supported at the same pattern template.
+   - Supported only with ``FLEX_PARSER_PROFILE_ENABLE=8``.
+   - Supported also with ``FLEX_PARSER_PROFILE_ENABLE=0`` for single DW only.
+   - Supported for FW version xx.37.0142 and above.
+
+.. _mlx5_geneve_parser:
+
+#. An API (``rte_pmd_mlx5_create_geneve_tlv_parser``)
+   is available for the flexible parser used in HW steering:
+
+   Each physical device has 7 DWs for GENEVE TLV options.
+   Partial option configuration is supported,
+   mask for data is provided in parser creation
+   indicating which DWs configuration is requested.
+   Only masked data DWs can be matched later as item field using flow API.
+
+   - Matching of ``type`` field is supported for each configured option.
+   - However, for matching ``class`` field,
+     the option should be configured with ``match_on_class_mode=2``.
+     One extra DW is consumed for it.
+   - Matching on ``length`` field is not supported.
+
+   - More limitations with ``FLEX_PARSER_PROFILE_ENABLE=0``:
+
+     - single DW
+     - ``sample_len`` must be equal to ``option_len`` and not bigger than 1.
+     - ``match_on_class_mode`` different than 1 is not supported.
+     - ``offset`` must be 0.
+
+   Although the parser is created per physical device, this API is port oriented.
+   Each port should call this API before using GENEVE OPT item,
+   but its configuration must use the same options list
+   with same internal order configured by first port.
+
+   Calling this API for different ports under same physical device doesn't consume
+   more DWs, the first one creates the parser and the rest use same configuration.
+
+
+.. _mlx5_gtp:
+
+GTP
+~~~
+
+GPRS Tunneling Protocol (GTP)
+can be matched with the flow item ``RTE_FLOW_ITEM_TYPE_GTP``
+for the following fields:
+
+- bits E, S and PN
+- message type
+- TEID
+
+GTP extension header for PDU session container (extension header type ``0x85``)
+can be matched with the flow item ``RTE_FLOW_ITEM_TYPE_GTP_PSC``.
+
+Requirements
+^^^^^^^^^^^^
+
+For matching GTP PSC, these are the requirements:
+
+=========  =============
+Minimum    Version
+=========  =============
+hardware   ConnectX-6 Dx
+OFED       5.2
+rdma-core  35
+DPDK       21.02
+=========  =============
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching GTP flow is enabled by setting this value::
+
+   FLEX_PARSER_PROFILE_ENABLE=3
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+Limitations
+^^^^^^^^^^^
+
+#. Matching on GTP extension header is not supported in group 0.
+
+
+.. _mlx5_mpls:
+
+MPLS
+~~~~
+
+Multi Protocol Label Switching (MPLS) flows (MPLS-over-GRE and MPLS-over-UDP)
+can be matched with ``RTE_FLOW_ITEM_TYPE_MPLS``.
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching MPLS flow is enabled by setting this value::
+
+   FLEX_PARSER_PROFILE_ENABLE=1
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+Limitations
+^^^^^^^^^^^
+
+#. MPLSoUDP with multiple MPLS headers is only supported in :ref:`HW steering <mlx5_hws>`.
+
+#. MPLS matching with :ref:`HW steering <mlx5_hws>` is not supported on group 0.
+
+#. The maximum supported MPLS headers is 5.
+
+
+.. _mlx5_nsh:
+
+NSH
+~~~
+
+Network Service Header (NSH) flows
+can be matched with ``RTE_FLOW_ITEM_TYPE_NSH``.
+
+Runtime configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+The DV flow engine must be enabled (``dv_flow_en=1``).
+
+The parameter :ref:`l3_vxlan_en <mlx5_vxlan_param>` must be set.
+
+Limitations
+^^^^^^^^^^^
+
+#. NSH matching is supported only when NSH follows VXLAN-GPE.
+
+#. NSH fields matching is not supported.
+
+
+.. _mlx5_ipsec:
+
+IPsec
+~~~~~
+
+Encapsulating Security Payload (ESP) is matched with ``RTE_FLOW_ITEM_TYPE_ESP``.
+
+Limitations
+^^^^^^^^^^^
+
+#. Matching on SPI field in ESP header is supported over the PF only.
+
+#. When using DV/Verbs flow engine (``dv_flow_en`` = 1/0 respectively),
+   match on SPI field in ESP header for group 0 is supported from ConnectX-7.
+
+
+.. _mlx5_ecpri:
+
+eCPRI
+~~~~~
+
+Enhanced Common Public Radio Interface (eCPRI) flows
+can be matched with ``RTE_FLOW_ITEM_TYPE_ECPRI``.
+
+Firmware configuration
+^^^^^^^^^^^^^^^^^^^^^^
+
+Matching eCPRI flow is enabled by setting these values::
+
+   FLEX_PARSER_PROFILE_ENABLE=4
+   PROG_PARSE_GRAPH=1
+
+Other protocols may require a different firmware configuration.
+See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+
+
+.. _mlx5_host_shaper:
+
+Host Shaper
+~~~~~~~~~~~
+
+Host shaper register is per host port register
+which sets a shaper on the host port.
+All VF/host PF representors belonging to one host port share one host shaper.
+For example, if representor 0 and representor 1 belong to the same host port,
+and a host shaper rate of 1Gbps is configured,
+the shaper throttles both representors traffic from the host.
+
+Host shaper has two modes for setting the shaper,
+immediate and deferred to available descriptor threshold event trigger.
+
+In immediate mode, the rate limit is configured immediately to host shaper.
+
+When deferring to the available descriptor threshold trigger,
+the shaper is not set until an available descriptor threshold event
+is received by any Rx queue in a VF representor belonging to the host port.
+The only rate supported for deferred mode is 100Mbps
+(there is no limit on the supported rates for immediate mode).
+In deferred mode, the shaper is set on the host port by the firmware
+upon receiving the available descriptor threshold event,
+which allows throttling host traffic on available descriptor threshold events
+at minimum latency, preventing excess drops in the Rx queue.
+
+Requirements
+^^^^^^^^^^^^
+
+=========  ===========
+Minimum    Version
+=========  ===========
+hardware   BlueField-2
+=========  ===========
+
+Dependency on mstflint package
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In order to configure host shaper register,
+``librte_net_mlx5`` depends on ``libmtcr_ul``
+which can be installed from MLNX_OFED mstflint package.
+Meson detects ``libmtcr_ul`` existence at configure stage.
+If the library is detected, the application must link with ``-lmtcr_ul``,
+as done by the pkg-config file libdpdk.pc.
+
+Available descriptor threshold and host shaper
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There is a command to configure the available descriptor threshold in testpmd.
+Testpmd also contains sample logic to handle available descriptor threshold events.
+The typical workflow is:
+testpmd configures available descriptor threshold for Rx queues,
+enables ``avail_thresh_triggered`` in host shaper and registers a callback.
+When traffic from the host is too high
+and Rx queue emptiness is below the available descriptor threshold,
+the PMD receives an event
+and the firmware configures a 100Mbps shaper on the host port automatically.
+Then the PMD call the callback registered previously,
+which will delay a while to let Rx queue empty,
+then disable host shaper.
+
+Let's assume we have a simple BlueField-2 setup:
+port 0 is uplink, port 1 is VF representor.
+Each port has 2 Rx queues.
+To control traffic from the host to the Arm device,
+we can enable the available descriptor threshold in testpmd by:
+
+.. code-block:: console
+
+   testpmd> mlx5 set port 1 host_shaper avail_thresh_triggered 1 rate 0
+   testpmd> set port 1 rxq 0 avail_thresh 70
+   testpmd> set port 1 rxq 1 avail_thresh 70
+
+The first command disables the current host shaper
+and enables the available descriptor threshold triggered mode.
+The other commands configure the available descriptor threshold
+to 70% of Rx queue size for both Rx queues.
+
+When traffic from the host is too high,
+testpmd console prints log about available descriptor threshold event,
+then host shaper is disabled.
+The traffic rate from the host is controlled and less drop happens in Rx queues.
+
+The threshold event and shaper can be disabled like this:
+
+.. code-block:: console
+
+   testpmd> mlx5 set port 1 host_shaper avail_thresh_triggered 0 rate 0
+   testpmd> set port 1 rxq 0 avail_thresh 0
+   testpmd> set port 1 rxq 1 avail_thresh 0
+
+It is recommended an application disables the available descriptor threshold
+and ``avail_thresh_triggered`` before exit,
+if it enables them before.
+
+The shaper can also be configured with a value, the rate unit is 100Mbps.
+Below, the command sets the current shaper to 5Gbps
+and disables ``avail_thresh_triggered``.
+
+.. code-block:: console
+
+   testpmd> mlx5 set port 1 host_shaper avail_thresh_triggered 0 rate 50
+
+Limitations
+^^^^^^^^^^^
+
+#. When configuring host shaper with ``RTE_PMD_MLX5_HOST_SHAPER_FLAG_AVAIL_THRESH_TRIGGERED`` flag,
+   only rates 0 and 100Mbps are supported.
 
-   > port stop all
-   > port config all rss all
-   > port start all
 
 Usage example
 -------------
 
-This section demonstrates how to launch **testpmd** with NVIDIA
-ConnectX-4/ConnectX-5/ConnectX-6/BlueField devices managed by librte_net_mlx5.
+This section demonstrates how to launch **testpmd** with NVIDIA devices managed by mlx5.
 
 #. Load the kernel modules::
 
@@ -2290,7 +3957,7 @@ ConnectX-4/ConnectX-5/ConnectX-6/BlueField devices managed by librte_net_mlx5.
 
    .. note::
 
-      User space I/O kernel modules (uio and igb_uio) are not used and do
+      User space I/O kernel modules (UIO, VFIO) are not used and do
       not have to be loaded.
 
 #. Make sure Ethernet interfaces are in working order and linked to kernel
@@ -2307,12 +3974,9 @@ ConnectX-4/ConnectX-5/ConnectX-6/BlueField devices managed by librte_net_mlx5.
 
 #. Optionally, retrieve their PCI bus addresses for to be used with the allow list::
 
-      {
-          for intf in eth2 eth3 eth4 eth5;
-          do
-              (cd "/sys/class/net/${intf}/device/" && pwd -P);
-          done;
-      } |
+      for intf in eth2 eth3 eth4 eth5; do
+          cd "/sys/class/net/${intf}/device/" && pwd -P;
+      done |
       sed -n 's,.*/\(.*\),-a \1,p'
 
    Example output::
@@ -2378,6 +4042,7 @@ ConnectX-4/ConnectX-5/ConnectX-6/BlueField devices managed by librte_net_mlx5.
       Done
       testpmd>
 
+
 How to dump flows
 -----------------
 
@@ -2409,31 +4074,6 @@ all flows with assistance of external tools.
 
        mlx_steering_dump.py -f <output_file> -flowptr <flow_ptr>
 
-How to share a meter between ports in the same switch domain
-------------------------------------------------------------
-
-This section demonstrates how to use the shared meter. A meter M can be created
-on port X and to be shared with a port Y on the same switch domain by the next way:
-
-.. code-block:: console
-
-   flow create X ingress transfer pattern eth / port_id id is Y / end actions meter mtr_id M / end
-
-How to use meter hierarchy
---------------------------
-
-This section demonstrates how to create and use a meter hierarchy.
-A termination meter M can be the policy green action of another termination meter N.
-The two meters are chained together as a chain. Using meter N in a flow will apply
-both the meters in hierarchy on that flow.
-
-.. code-block:: console
-
-   add port meter policy 0 1 g_actions queue index 0 / end y_actions end r_actions drop / end
-   create port meter 0 M 1 1 yes 0xffff 1 0
-   add port meter policy 0 2 g_actions meter mtr_id M / end y_actions end r_actions drop / end
-   create port meter 0 N 2 2 yes 0xffff 1 0
-   flow create 0 ingress group 1 pattern eth / end actions meter mtr_id N / end
 
 How to configure a VF as trusted
 --------------------------------
@@ -2492,6 +4132,7 @@ The procedure below is an example of using a ConnectX-5 adapter card (pf0) with
 
    $ echo "0000:82:00.2" >> /sys/bus/pci/drivers/mlx5_core/bind
 
+
 How to trace Tx datapath
 ------------------------
 
@@ -2573,103 +4214,25 @@ Steps to enable Tx datapath tracing:
    Each list element contains the list of built WQEs with specific opcodes.
    Each WQE contains the list of the encompassed packets to send.
 
-Host shaper
------------
 
-Host shaper register is per host port register
-which sets a shaper on the host port.
-All VF/host PF representors belonging to one host port share one host shaper.
-For example, if representor 0 and representor 1 belong to the same host port,
-and a host shaper rate of 1Gbps is configured,
-the shaper throttles both representors traffic from the host.
-
-Host shaper has two modes for setting the shaper,
-immediate and deferred to available descriptor threshold event trigger.
-
-In immediate mode, the rate limit is configured immediately to host shaper.
-
-When deferring to the available descriptor threshold trigger,
-the shaper is not set until an available descriptor threshold event
-is received by any Rx queue in a VF representor belonging to the host port.
-The only rate supported for deferred mode is 100Mbps
-(there is no limit on the supported rates for immediate mode).
-In deferred mode, the shaper is set on the host port by the firmware
-upon receiving the available descriptor threshold event,
-which allows throttling host traffic on available descriptor threshold events
-at minimum latency, preventing excess drops in the Rx queue.
-
-Dependency on mstflint package
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-In order to configure host shaper register,
-``librte_net_mlx5`` depends on ``libmtcr_ul``
-which can be installed from MLNX_OFED mstflint package.
-Meson detects ``libmtcr_ul`` existence at configure stage.
-If the library is detected, the application must link with ``-lmtcr_ul``,
-as done by the pkg-config file libdpdk.pc.
-
-Available descriptor threshold and host shaper
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-There is a command to configure the available descriptor threshold in testpmd.
-Testpmd also contains sample logic to handle available descriptor threshold events.
-The typical workflow is:
-testpmd configures available descriptor threshold for Rx queues,
-enables ``avail_thresh_triggered`` in host shaper and registers a callback.
-When traffic from the host is too high
-and Rx queue emptiness is below the available descriptor threshold,
-the PMD receives an event
-and the firmware configures a 100Mbps shaper on the host port automatically.
-Then the PMD call the callback registered previously,
-which will delay a while to let Rx queue empty,
-then disable host shaper.
-
-Let's assume we have a simple BlueField-2 setup:
-port 0 is uplink, port 1 is VF representor.
-Each port has 2 Rx queues.
-To control traffic from the host to the Arm device,
-we can enable the available descriptor threshold in testpmd by:
-
-.. code-block:: console
-
-   testpmd> mlx5 set port 1 host_shaper avail_thresh_triggered 1 rate 0
-   testpmd> set port 1 rxq 0 avail_thresh 70
-   testpmd> set port 1 rxq 1 avail_thresh 70
-
-The first command disables the current host shaper
-and enables the available descriptor threshold triggered mode.
-The other commands configure the available descriptor threshold
-to 70% of Rx queue size for both Rx queues.
-
-When traffic from the host is too high,
-testpmd console prints log about available descriptor threshold event,
-then host shaper is disabled.
-The traffic rate from the host is controlled and less drop happens in Rx queues.
-
-The threshold event and shaper can be disabled like this:
-
-.. code-block:: console
-
-   testpmd> mlx5 set port 1 host_shaper avail_thresh_triggered 0 rate 0
-   testpmd> set port 1 rxq 0 avail_thresh 0
-   testpmd> set port 1 rxq 1 avail_thresh 0
-
-It is recommended an application disables the available descriptor threshold
-and ``avail_thresh_triggered`` before exit,
-if it enables them before.
-
-The shaper can also be configured with a value, the rate unit is 100Mbps.
-Below, the command sets the current shaper to 5Gbps
-and disables ``avail_thresh_triggered``.
-
-.. code-block:: console
-
-   testpmd> mlx5 set port 1 host_shaper avail_thresh_triggered 0 rate 50
-
-
-Testpmd driver specific commands
+Testpmd driver-specific commands
 --------------------------------
 
+RSS
+~~~
+
+Compared to librte_net_mlx4 that implements a single RSS configuration per
+port, librte_net_mlx5 supports per-protocol RSS configuration.
+
+Since ``testpmd`` defaults to IP RSS mode and there is currently no
+command-line parameter to enable additional protocols (UDP and TCP as well
+as IP), the following commands must be entered from its CLI to get the same
+behavior as librte_net_mlx4::
+
+   > port stop all
+   > port config all rss all
+   > port start all
+
 port attach with socket path
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -2764,7 +4327,7 @@ The mode will propagate to all the probed ports.
 GENEVE TLV options parser
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-See the :ref:`GENEVE parser API <geneve_parser_api>` for more information.
+See the :ref:`GENEVE parser API <mlx5_geneve_parser>` for more information.
 
 Set
 ^^^
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index fe5cff7032..afbe606e0c 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -20,6 +20,8 @@ In addition, there is a `web section dedicated to DPDK
 <https://developer.nvidia.com/networking/dpdk>`_.
 
 
+.. _mlx5_common_design:
+
 Design
 ------
 
@@ -138,7 +140,6 @@ The following dependencies are not part of DPDK and must be installed separately
   - ConnectX-6 Lx: **26.27.0090** and above.
   - ConnectX-7: **28.33.2028** and above.
   - ConnectX-8: **40.44.1036** and above.
-  - BlueField: **18.25.1010** and above.
   - BlueField-2: **24.28.1002** and above.
   - BlueField-3: **32.36.3126** and above.
 
@@ -393,6 +394,8 @@ An SF shares PCI-level resources with other SFs and/or with its parent PCI funct
       auxiliary:mlx5_core.sf.<num>,class=eth:regex
 
 
+.. _mlx5_switchdev:
+
 Enable Switchdev Mode
 ^^^^^^^^^^^^^^^^^^^^^
 
@@ -507,6 +510,15 @@ Below are some firmware configurations listed.
 
     CQE_COMPRESSION=1
 
+- enable real-time timestamp format::
+
+   REAL_TIME_CLOCK_ENABLE=1
+
+- allow locking hairpin RQ data buffer in device memory::
+
+   HAIRPIN_DATA_BUFFER_LOCK=1
+   MEMIC_SIZE_LIMIT=0
+
 - L3 VXLAN and VXLAN-GPE destination UDP port::
 
     IP_OVER_VXLAN_EN=1
@@ -556,14 +568,27 @@ Below are some firmware configurations listed.
    FLEX_PARSER_PROFILE_ENABLE=4
    PROG_PARSE_GRAPH=1
 
-- enable realtime timestamp format::
+Below is a table showing the protocols that requires the flex parser,
+matching with their possible flex parser profiles.
 
-   REAL_TIME_CLOCK_ENABLE=1
+.. TODO: confirm with Alex Vesker
+   is there a difference between SWS and HWS
 
-- allow locking hairpin RQ data buffer in device memory::
+.. rst-class:: punchcard
 
-   HAIRPIN_DATA_BUFFER_LOCK=1
-   MEMIC_SIZE_LIMIT=0
+========== = = = = = =
+profile    0 1 2 3 4 8
+========== = = = = = =
+IP-in-IP   0
+VXLAN-GPE  0   2
+GENEVE     0 1
+GENEVE TLV 0         8
+MPLS         1
+ICMP           2
+GTP              3
+eCPRI              4
+dyn flex           4
+========== = = = = = =
 
 
 .. _mlx5_common_driver_options:
@@ -627,7 +652,7 @@ and below are the arguments supported by the common mlx5 layer.
 
 - ``sq_db_nc`` parameter [int]
 
-  The rdma core library can map doorbell register in two ways,
+  The rdma-core library can map doorbell register in two ways,
   depending on the environment variable "MLX5_SHUT_UP_BF":
 
   - As regular cached memory (usually with write combining attribute),
diff --git a/doc/guides/prog_guide/ethdev/flow_offload.rst b/doc/guides/prog_guide/ethdev/flow_offload.rst
index a28095667d..1cd904e1ee 100644
--- a/doc/guides/prog_guide/ethdev/flow_offload.rst
+++ b/doc/guides/prog_guide/ethdev/flow_offload.rst
@@ -3258,6 +3258,8 @@ destination offset as ``48``, and provide immediate value ``0xXXXX85XX``.
    |                 | field type                                               |
    +-----------------+----------------------------------------------------------+
 
+.. _flow_conntrack_action:
+
 Action: ``CONNTRACK``
 ^^^^^^^^^^^^^^^^^^^^^
 
@@ -3858,7 +3860,7 @@ For example, to configure a RTE_FLOW_TYPE_JUMP action as a miss action for ingre
       struct rte_flow_error err;
       rte_flow_group_set_miss_actions(port, 1, &attr, act, &err);
 
-.. _flow_templates:
+.. _flow_template_api:
 
 Flow templates
 ~~~~~~~~~~~~~~
@@ -4097,6 +4099,9 @@ Testpmd commands (wrapped for clarity)::
     # 6. Complete the table resize.
     testpmd> flow template_table 0 resize_complete table 101
 
+
+.. _flow_async_api:
+
 Asynchronous operations
 -----------------------
 
diff --git a/doc/guides/sample_app_ug/flow_filtering.rst b/doc/guides/sample_app_ug/flow_filtering.rst
index 4c8a15d9f5..179e978942 100644
--- a/doc/guides/sample_app_ug/flow_filtering.rst
+++ b/doc/guides/sample_app_ug/flow_filtering.rst
@@ -36,7 +36,7 @@ where,
 ``--[non-]template``
   Specify whether to use the template API (default is template API).
 
-For more details on template API please refer to :ref:`flow_templates`.
+For more details on template API please refer to :ref:`flow_template_api`.
 
 Refer to *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
-- 
2.47.1

