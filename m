Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A3F9EDF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 15:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26A59402B5;
	Wed, 22 Apr 2026 17:19:15 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 70A66402A3
 for <dev@dpdk.org>; Wed, 22 Apr 2026 17:19:13 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso47661515e9.0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776871153; x=1777475953; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VWP8bPQmUD2Ctkaxlj09qcVlKQ2318VAOLedPMlCd1Y=;
 b=LNdMuvsibOAk1m/HYua4qBk2kbjZMN5mK9YnJ7kEeQGAP3fQPZt0enKv7cWI/cwxYg
 lhHb0TGDicePbVwAvQbW+54fafgb4E0AWEon6SeaKW8WFr/Fj1US1QO6tVRGI05cVpKz
 Op72IEFLzvAakaOkVHg6nideH7KGB7P87uUsLrHVDjFpr77wpTW/X3kUPgR5qmKWpYmT
 urwdX8x6gLh6SKRlWNvga5/PUTrZDdy1YFIYzRdT87w7vQZTlbS8rJCaMFE7BRTyCFay
 57Rs4QY3bee07CmfkbbptabGDngEtnp8qeKTVqcp8dN3sMjeS7789ZIP9eBWk21xHIZl
 cSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776871153; x=1777475953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWP8bPQmUD2Ctkaxlj09qcVlKQ2318VAOLedPMlCd1Y=;
 b=VlD/MPkvNcS4RRz5FZnS9E6ipD+XZMt6t3NUjR7CHMnfEj56dG8Yj1Uljv0QiWRN9e
 bU0hkt+2Fkfak2y/BjvDVOdY0x5UTjxqkhwRr/GqlmYy5cL5DSSqqO66duzbl6n4cHFT
 MtppbkKMXpZvGilLKIfMx4R2HcRke5PI/uxe+M9CUQ1BsRrTwL16wyMUZIdaqgeiQ/ao
 1LpIvOVsmyFuzZRvXz7LxPMgzMkztLBOkACtBLZgPfMBVww35szmFjGbshUmQiQ7oxqk
 6GHzTaIzVrH52v4s4YxNLzvCYlzOImXtl+qMHJOg1VItKJ/tvswXq41y2/EZv4W0mp9i
 2SRA==
X-Gm-Message-State: AOJu0Yy0J3G/yBg2QLqTD+dpcN6PtcWfRHIoDW1Co2/YPWWorxe+Ql97
 +d492ZrlVIfi1VBot4M6S40N3nExaKO0/TdAeuvLPR8UqoZ0GLe05FPugYmzsAhc
X-Gm-Gg: AeBDietjW/skAf/FY7biZHYnGHXhLLDuNRlXLSeP7YoUjSpDfn0ZpGkW6p3KmNnfSEd
 zRqVSmFhyb8GBDUB8mYiWqz3cvrfCn5ssd1ducKAkdS4To0CEEw92tEIfqMe6kxfyrSYDDs+FLG
 K1E2LmoLUzgBPKo0R/2r7Mo9JB8TstNRop51gCjEZyZfAdRp9WgOtnYQURjhUxelvbnK872pEyC
 dsodTT7zm5K5V2/vQTT7zG7mykEvzzHvsc1csT+V7XdDnwKOaEmRlkMBI2uNgbQ2hxXZibeNZJ7
 XpjKUn8A+4vDodPOWc6M17y08JVsV7p/QvWT4J3W1tR0SYtU8bjS5h6ThG/KsX8m1+7NdUaa+9R
 GVVxYediJWwl/HO/acEb0gpf98XU0g1Lrhw09jR6cr9UYxm8LfsxHbieh/uQ3yak7T4mE2J2P1O
 L5yEiFuWtxuW/LAWq29UH9Z63K65ni+7BISODpC4w=
X-Received: by 2002:a05:600c:a107:b0:489:d1c:d468 with SMTP id
 5b1f17b1804b1-4890d1cdaedmr169100555e9.31.1776871151624; 
 Wed, 22 Apr 2026 08:19:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e765:dd8f:f85b:d79d])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-489fec8f7cbsm187246005e9.11.2026.04.22.08.19.10
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:19:10 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dev@dpdk.org
Subject: [PATCH] tree-wide: fix 'allow[s] to' grammar
Date: Wed, 22 Apr 2026 16:18:53 +0100
Message-ID: <20260422151901.3523790-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Luca Boccassi <luca.boccassi@gmail.com>

Lintian flags 'allow[s] to' as grammatically incorrect, as it
requires an object before the next verb.

Fix docs, comments and son on by either switching to gerundinve or
adding 'one' as the object.

I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_graph_model_mcore_dispatch.h.3.gz:32]
I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_mbuf_dyn.h.3.gz:167]
I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_mbuf_history.h.3.gz:71]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_bpf_ethdev.h.3.gz:41]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:3423]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:5197]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:5224]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_crypto_adapter_runtime_params.3.gz:32]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_dma_adapter_runtime_params.3.gz:32]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_eth_rx_adapter_runtime_params.3.gz:32]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_eth_tx_adapter_runtime_params.3.gz:35]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_flow.h.3.gz:2669]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_graph.h.3.gz:222]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_mempool_objhdr.3.gz:33]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_mldev.h.3.gz:807]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_eth_api.h.3.gz:44]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_ip4_api.h.3.gz:73]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_ip6_api.h.3.gz:50]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_pkt_cls_api.h.3.gz:18]
I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_udp4_input_api.h.3.gz:42]

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
 doc/guides/linux_gsg/linux_drivers.rst            |  2 +-
 doc/guides/linux_gsg/linux_eal_parameters.rst     |  2 +-
 doc/guides/nics/mlx5.rst                          | 12 ++++++------
 doc/guides/prog_guide/bbdev.rst                   |  6 +++---
 doc/guides/prog_guide/env_abstraction_layer.rst   |  2 +-
 doc/guides/prog_guide/ethdev/flow_offload.rst     |  2 +-
 doc/guides/prog_guide/graph_lib.rst               |  2 +-
 doc/guides/prog_guide/mbuf_lib.rst                |  2 +-
 doc/guides/prog_guide/ring_lib.rst                |  2 +-
 doc/guides/rawdevs/ntb.rst                        |  2 +-
 doc/guides/sample_app_ug/l3_forward.rst           |  2 +-
 doc/guides/sample_app_ug/l3_forward_power_man.rst |  2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst       |  2 +-
 doc/guides/tools/cryptoperf.rst                   |  2 +-
 doc/guides/tools/flow-perf.rst                    |  2 +-
 doc/guides/tools/proc_info.rst                    |  4 ++--
 drivers/common/sfc_efx/base/efx_mcdi.c            |  2 +-
 drivers/common/sfc_efx/base/efx_regs_mcdi.h       |  2 +-
 drivers/net/intel/ice/base/ice_switch.h           |  2 +-
 drivers/net/qede/base/ecore_iov_api.h             |  2 +-
 drivers/net/qede/base/ecore_mcp.h                 |  2 +-
 drivers/net/sfc/sfc_ef10_essb_rx.c                |  2 +-
 drivers/net/sfc/sfc_intr.c                        |  2 +-
 drivers/net/sfc/sfc_repr.c                        |  2 +-
 drivers/net/sfc/sfc_rx.c                          |  2 +-
 drivers/net/sfc/sfc_tbls.h                        |  4 ++--
 lib/bpf/rte_bpf_ethdev.h                          |  2 +-
 lib/eal/include/rte_common.h                      |  4 ++--
 lib/ethdev/ethdev_linux_ethtool.c                 |  2 +-
 lib/ethdev/rte_ethdev.h                           |  6 +++---
 lib/ethdev/rte_flow.h                             |  2 +-
 lib/eventdev/rte_event_crypto_adapter.h           |  2 +-
 lib/eventdev/rte_event_dma_adapter.h              |  2 +-
 lib/eventdev/rte_event_eth_rx_adapter.h           |  2 +-
 lib/eventdev/rte_event_eth_tx_adapter.h           |  2 +-
 lib/graph/graph.c                                 |  2 +-
 lib/graph/node.c                                  |  2 +-
 lib/graph/rte_graph.h                             |  2 +-
 lib/graph/rte_graph_model_mcore_dispatch.h        |  2 +-
 lib/mbuf/rte_mbuf_dyn.h                           |  2 +-
 lib/mbuf/rte_mbuf_history.h                       |  2 +-
 lib/mempool/rte_mempool.h                         |  2 +-
 lib/mldev/rte_mldev.h                             |  2 +-
 lib/node/rte_node_eth_api.h                       |  2 +-
 lib/node/rte_node_ip4_api.h                       |  2 +-
 lib/node/rte_node_ip6_api.h                       |  2 +-
 lib/node/rte_node_pkt_cls_api.h                   |  2 +-
 lib/node/rte_node_udp4_input_api.h                |  2 +-
 48 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index a7d64d486c..8b117f92c2 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -379,7 +379,7 @@ Such model has the following benefits:
  - It enables the DPDK application to filter only part of the traffic,
    while the rest will be directed and handled by the kernel driver.
    The flow bifurcation is performed by the NIC hardware.
-   As an example, using :ref:`flow_isolated_mode` allows to choose
+   As an example, using :ref:`flow_isolated_mode` allows choosing
    strictly what is received in DPDK.
 
 More about the bifurcated driver can be found in
diff --git a/doc/guides/linux_gsg/linux_eal_parameters.rst b/doc/guides/linux_gsg/linux_eal_parameters.rst
index 7c5b26ce26..dfabbdc725 100644
--- a/doc/guides/linux_gsg/linux_eal_parameters.rst
+++ b/doc/guides/linux_gsg/linux_eal_parameters.rst
@@ -103,7 +103,7 @@ Memory-related options
     which may be a security concern.
     Hugepage files created in this mode are also not removed
     when all the hugepages mapped from them are freed,
-    which allows to reuse these files after a restart.
+    which allows reusing these files after a restart.
 
 *   ``--match-allocations``
 
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index a144f43336..48543f2c76 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -103,7 +103,7 @@ Flow Steering
 
 A major benefit of the mlx5 devices
 is the :ref:`bifurcated driver <mlx5_bifurcated>` capability.
-It allows to route some flows from the device to the kernel
+It allows routing some flows from the device to the kernel
 while other flows go directly to the userspace PMD.
 This capability allows the PMD to coexist with kernel network interfaces
 which remain functional, although they stop receiving unicast packets
@@ -121,12 +121,12 @@ This technology is named software steering (SWS).
 Later the performance was a lot more improved
 with :ref:`hardware steering (HWS) <mlx5_hws>`,
 a WQE-based high scaling and safer flow insertion/destruction.
-It allows to insert millions of rules per second.
+It allows inserting millions of rules per second.
 
 While using the :doc:`synchronous flow API <../prog_guide/ethdev/flow_offload>`
 is convenient and easy to manage,
 it is not efficient enough at a large scale.
-That's why mlx5 allows to offload many features asynchronously.
+That's why mlx5 allows offloading many features asynchronously.
 The :ref:`asynchronous flow API <flow_async_api>`
 makes use of :ref:`pre-configured templates <flow_template_api>`
 to insert new rules very fast with predictable performance.
@@ -210,7 +210,7 @@ for an additional list of options shared with other mlx5 drivers.
 - ``rxq_cqe_comp_en`` parameter [int]
 
   A nonzero value enables the compression of CQE on RX side. This feature
-  allows to save PCI bandwidth and improve performance. Enabled by default.
+  allows saving PCI bandwidth and improve performance. Enabled by default.
   Different compression formats are supported in order to achieve the best
   performance for different traffic patterns. Default format depends on
   Multi-Packet Rx queue configuration: Hash RSS format is used in case
@@ -2275,7 +2275,7 @@ DPDK       17.11
 RSS
 ~~~
 
-Receive Side Scaling (RSS) allows to dispatch received packets to multiple queues.
+Receive Side Scaling (RSS) allows dispatching received packets to multiple queues.
 
 RSS can be configured at port level:
 
@@ -2580,7 +2580,7 @@ Runtime configuration
 ^^^^^^^^^^^^^^^^^^^^^
 
 The parameter :ref:`dv_xmeta_en <mlx5_meta_mark_param>`
-allows to configure the driver handling of META and MARK.
+allows configuring the driver handling of META and MARK.
 
 Limitations
 ^^^^^^^^^^^
diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index 8abb0e9c88..bdd2d87471 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -310,7 +310,7 @@ used for each window index when scaling back the size to a reference of 1024 FFT
 The actual shape size is effectively scaled up or down
 based on the dynamic size of the FFT operation being used.
 
-This allows to distinguish different version of the flexible pointwise windowing
+This allows distinguishing different version of the flexible pointwise windowing
 applied to the FFT and exposes this platform configuration to the application.
 
 Other optional capabilities exposed during device discovery
@@ -1119,7 +1119,7 @@ is also valid for LDPC decode.
 BBDEV FFT Operation
 ~~~~~~~~~~~~~~~~~~~
 
-This operation allows to run a combination of DFT and/or IDFT and/or time-domain windowing.
+This operation allows running a combination of DFT and/or IDFT and/or time-domain windowing.
 These can be used in a modular fashion (using bypass modes) or as a processing pipeline
 which can be used for FFT-based baseband signal processing.
 
@@ -1255,7 +1255,7 @@ first by cyclic shift then by antenna.
 BBDEV MLD-TS Operation
 ~~~~~~~~~~~~~~~~~~~~~~
 
-This operation allows to run the Tree Search (TS) portion of a Maximum Likelihood processing (MLD).
+This operation allows running the Tree Search (TS) portion of a Maximum Likelihood processing (MLD).
 
 This alternate equalization option accelerates the exploration of the best combination of
 transmitted symbols across layers minimizing the Euclidean distance between the received and
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index d716895c1d..52960b393f 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -242,7 +242,7 @@ so available amount depends on the system load.
 It uses ``virt2phys`` kernel module to obtain physical addresses,
 unless running in IOVA-as-VA mode (e.g. forced with ``--iova-mode=va``).
 
-Linux allows to select any combination of the following:
+Linux allows selecting any combination of the following:
 
 * use files in hugetlbfs (the default)
   or anonymous mappings (``--in-memory``);
diff --git a/doc/guides/prog_guide/ethdev/flow_offload.rst b/doc/guides/prog_guide/ethdev/flow_offload.rst
index d5cca86c82..08cbb05bb7 100644
--- a/doc/guides/prog_guide/ethdev/flow_offload.rst
+++ b/doc/guides/prog_guide/ethdev/flow_offload.rst
@@ -3011,7 +3011,7 @@ Action: ``INDIRECT_LIST``
 Indirect API creates a shared flow action with unique action handle.
 Flow rules can access the shared flow action and resources related to
 that action through the indirect action handle.
-In addition, the API allows to update existing shared flow action configuration.
+In addition, the API allows updating existing shared flow action configuration.
 After the update completes, the new action configuration
 is available to all flows that reference that shared action.
 
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 8409e7666e..8dd49c19d2 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -10,7 +10,7 @@ data processing functions.
 
 The graph library provides API to enable graph framework operations such as
 create, lookup, dump and destroy on graph and node operations such as clone,
-edge update, and edge shrink, etc. The API also allows to create the stats
+edge update, and edge shrink, etc. The API also allows creating the stats
 cluster to monitor per graph and per node stats.
 
 Features
diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 382bfbdca4..ca941eda9e 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -123,7 +123,7 @@ timestamp mechanism, the VLAN tagging and the IP checksum computation.
 
 On TX side, it is also possible for an application to delegate some
 processing to the hardware if it supports it. For instance, the
-RTE_MBUF_F_TX_IP_CKSUM flag allows to offload the computation of the IPv4
+RTE_MBUF_F_TX_IP_CKSUM flag allows offloading the computation of the IPv4
 checksum.
 
 The following examples explain how to configure different TX offloads on
diff --git a/doc/guides/prog_guide/ring_lib.rst b/doc/guides/prog_guide/ring_lib.rst
index 98ef003aac..e13588553d 100644
--- a/doc/guides/prog_guide/ring_lib.rst
+++ b/doc/guides/prog_guide/ring_lib.rst
@@ -505,7 +505,7 @@ In particular, main SORING properties:
 
 * circular ring buffer with fixed size objects and related metadata.
 * producer, consumer plus multiple processing stages in between.
-* allows to split objects processing into multiple stages.
+* allows splitting objects processing into multiple stages.
 * objects remain in the same ring while moving from one stage to the other,
   initial order is preserved, no extra copying needed.
 * preserves the ingress order of objects within the queue across multiple stages.
diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index f8befc6594..3721b4880e 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -13,7 +13,7 @@ acceleration.
 
 This PMD allows two hosts to handshake for device start and stop, memory
 allocation for the peer to access and read/write allocated memory from peer.
-Also, the PMD allows to use doorbell registers to notify the peer and share
+Also, the PMD allows using doorbell registers to notify the peer and share
 some information by using scratchpad registers.
 
 BIOS setting on Intel Xeon
diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index c50a421fd0..e797222eb4 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -385,7 +385,7 @@ Note, that for each supported rule type,
 the application needs to calculate the expected offset of the fields
 from the start of the packet.
 That's why only packets with fixed IPv4/ IPv6 header are supported.
-That allows to perform ACL classify straight over incoming packet buffer -
+That allows performing ACL classify straight over incoming packet buffer -
 no extra protocol field retrieval need to be performed.
 
 Subsequently, the application checks whether NUMA is enabled.
diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
index 3271bc2154..5888e393d1 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -110,7 +110,7 @@ where,
 
 *   --config (port,queue,lcore)[,(port,queue,lcore)]: determines which queues from which ports are mapped to which cores.
 
-*   --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection, 0 : just allow to enter C0-state.
+*   --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection, 0 : just allow entering C0-state.
 
 *   --max-pkt-len: optional, maximum packet length in decimal (64-9600)
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index d6c344bfb3..a5a75da066 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1706,7 +1706,7 @@ Map a Tx queue with an aggregated port of the DPDK port (specified with port_id)
 
 * ``affinity``: the number of the aggregated port.
                 When multiple ports are aggregated into a single one,
-                it allows to choose which port to use for Tx via a queue.
+                it allows choosing which port to use for Tx via a queue.
 
 This command should be run when the port is stopped, otherwise it fails.
 
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index d7ee468e17..846487c5e6 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -35,7 +35,7 @@ Linearization setting
 ---------------------
 
 It is possible linearized input segmented packets just before crypto operation
-for devices which doesn't support scatter-gather, and allows to measure
+for devices which doesn't support scatter-gather, and allows measuring
 performance also for this use case.
 
 To set on the linearization options add below definition to the
diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
index a289ba482b..657f06fec7 100644
--- a/doc/guides/tools/flow-perf.rst
+++ b/doc/guides/tools/flow-perf.rst
@@ -9,7 +9,7 @@ The application provides the ability to test insertion rate of specific
 rte_flow rule, by stressing it to the NIC, and calculates the insertion
 and deletion rates.
 
-The application allows to configure which rule to apply through several
+The application allows configuring which rule to apply through several
 options of the command line.
 
 After that the application will start producing rules with same pattern
diff --git a/doc/guides/tools/proc_info.rst b/doc/guides/tools/proc_info.rst
index 0e1668edfd..0a54f20f8c 100644
--- a/doc/guides/tools/proc_info.rst
+++ b/doc/guides/tools/proc_info.rst
@@ -63,12 +63,12 @@ settings and stats per node.
 
 **--show-ring[=name]**
 The show-ring parameter display current allocation of all ring with
-debug information. Specifying the name allows to display details for specific
+debug information. Specifying the name allows displaying details for specific
 ring. For invalid or no ring name, whole list is dump.
 
 **--show-mempool[=name]**
 The show-mempool parameter display current allocation of all mempool
-debug information. Specifying the name allows to display details for specific
+debug information. Specifying the name allows displaying details for specific
 mempool. For invalid or no mempool name, whole list is dump.
 
 **--iter-mempool=name**
diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 20051c7da9..670b0d5cda 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.c
+++ b/drivers/common/sfc_efx/base/efx_mcdi.c
@@ -2689,7 +2689,7 @@ efx_mcdi_phy_module_get_info(
 
 	/*
 	 * Map device address to MC_CMD_GET_PHY_MEDIA_INFO pages.
-	 * Offset plus length interface allows to access page 0 only.
+	 * Offset plus length interface allows accessing page 0 only.
 	 * I.e. non-zero upper pages are not accessible.
 	 * See SFF-8472 section 4 Memory Organization and SFF-8436 section 7.6
 	 * QSFP+ Memory Map for details on how information is structured
diff --git a/drivers/common/sfc_efx/base/efx_regs_mcdi.h b/drivers/common/sfc_efx/base/efx_regs_mcdi.h
index a981d0be5e..259af6a0df 100644
--- a/drivers/common/sfc_efx/base/efx_regs_mcdi.h
+++ b/drivers/common/sfc_efx/base/efx_regs_mcdi.h
@@ -28619,7 +28619,7 @@
 #define	MC_CMD_PRIVILEGE_MASK_IN_GRP_BROADCAST 0x100 /* enum */
 #define	MC_CMD_PRIVILEGE_MASK_IN_GRP_ALL_MULTICAST 0x200 /* enum */
 #define	MC_CMD_PRIVILEGE_MASK_IN_GRP_PROMISCUOUS 0x400 /* enum */
-/* enum: Allows to set the TX packets' source MAC address to any arbitrary MAC
+/* enum: Allows setting the TX packets' source MAC address to any arbitrary MAC
  * adress.
  */
 #define	MC_CMD_PRIVILEGE_MASK_IN_GRP_MAC_SPOOFING_TX 0x800
diff --git a/drivers/net/intel/ice/base/ice_switch.h b/drivers/net/intel/ice/base/ice_switch.h
index 73452cc4c7..85d69cbcc7 100644
--- a/drivers/net/intel/ice/base/ice_switch.h
+++ b/drivers/net/intel/ice/base/ice_switch.h
@@ -295,7 +295,7 @@ struct ice_rule_query_data {
 };
 
 /*
- * This structure allows to pass info about lb_en and lan_en
+ * This structure allows passing info about lb_en and lan_en
  * flags to ice_add_adv_rule. Values in act would be used
  * only if act_valid was set to true, otherwise dflt
  * values would be used.
diff --git a/drivers/net/qede/base/ecore_iov_api.h b/drivers/net/qede/base/ecore_iov_api.h
index bd7c5703f6..cf52c6268a 100644
--- a/drivers/net/qede/base/ecore_iov_api.h
+++ b/drivers/net/qede/base/ecore_iov_api.h
@@ -74,7 +74,7 @@ struct ecore_vf_acquire_sw_info {
 
 	/* We have several close releases that all use ~same FW with different
 	 * versions [making it incompatible as the versioning scheme is still
-	 * tied directly to FW version], allow to override the checking. Only
+	 * tied directly to FW version], allow overriding the checking. Only
 	 * those versions would actually support this feature [so it would not
 	 * break forward compatibility with newer HV drivers that are no longer
 	 * suited].
diff --git a/drivers/net/qede/base/ecore_mcp.h b/drivers/net/qede/base/ecore_mcp.h
index 185cc23394..951dab6044 100644
--- a/drivers/net/qede/base/ecore_mcp.h
+++ b/drivers/net/qede/base/ecore_mcp.h
@@ -469,7 +469,7 @@ struct ecore_resc_unlock_params {
 	/* Resource number [valid values are 0..31] */
 	u8 resource;
 
-	/* Allow to release a resource even if belongs to another PF */
+	/* Allow releasing a resource even if belongs to another PF */
 	bool b_force;
 
 	/* Will be set as true if the resource is released */
diff --git a/drivers/net/sfc/sfc_ef10_essb_rx.c b/drivers/net/sfc/sfc_ef10_essb_rx.c
index 78bd430363..6b31cb55d0 100644
--- a/drivers/net/sfc/sfc_ef10_essb_rx.c
+++ b/drivers/net/sfc/sfc_ef10_essb_rx.c
@@ -42,7 +42,7 @@
 #define SFC_EF10_ESSB_RX_FAKE_BUF_SIZE	32
 
 /**
- * Minimum number of Rx buffers the datapath allows to use.
+ * Minimum number of Rx buffers the datapath allows using.
  *
  * Each HW Rx descriptor has many Rx buffers. The number of buffers
  * in one HW Rx descriptor is equal to size of contiguous block
diff --git a/drivers/net/sfc/sfc_intr.c b/drivers/net/sfc/sfc_intr.c
index ddddefad7b..33a76c7934 100644
--- a/drivers/net/sfc/sfc_intr.c
+++ b/drivers/net/sfc/sfc_intr.c
@@ -10,7 +10,7 @@
 /*
  * At the moment of writing DPDK v16.07 has notion of two types of
  * interrupts: LSC (link status change) and RXQ (receive indication).
- * It allows to register interrupt callback for entire device which is
+ * It allows registering an interrupt callback for entire device which is
  * not intended to be used for receive indication (i.e. link status
  * change indication only). The handler has no information which HW
  * interrupt has triggered it, so we don't know which event queue should
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 4ccdf8358b..2be17d3c8f 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -177,7 +177,7 @@ sfc_repr_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/*
 	 * mbuf is likely cache-hot. Set flag and egress m-port here instead of
 	 * doing that in representors proxy. Also, it should help to avoid
-	 * cache bounce. Moreover, potentially, it allows to use one
+	 * cache bounce. Moreover, potentially, it allows using one
 	 * multi-producer single-consumer ring for all representors.
 	 *
 	 * The only potential problem is doing so many times if enqueue
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index a193229265..c8251f6da9 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1216,7 +1216,7 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	/*
 	 * If Rx refill threshold is specified (its value is non zero) in
 	 * Rx configuration, use specified value. Otherwise use 1/8 of
-	 * the Rx descriptors number as the default. It allows to keep
+	 * the Rx descriptors number as the default. It allows keeping
 	 * Rx ring full-enough and does not refill too aggressive if
 	 * packet rate is high.
 	 *
diff --git a/drivers/net/sfc/sfc_tbls.h b/drivers/net/sfc/sfc_tbls.h
index ff619e5141..8e40ae2b9b 100644
--- a/drivers/net/sfc/sfc_tbls.h
+++ b/drivers/net/sfc/sfc_tbls.h
@@ -69,11 +69,11 @@ enum sfc_tbls_status {
  *   and information about the table
  *
  * All table layout data should be saved in a cache.
- * The cache allows to avoid getting the table descriptor each time when you want
+ * The cache allows one to avoid getting the table descriptor each time when you want
  * to manipulate table entries. It just contains the table
  * descriptors and all associated data. The cache is based on the RTE hash map and
  * it uses a table ID as a key.
- * The sfc_tbl_meta library serves as a wrapper over the cache and allows to user
+ * The sfc_tbl_meta library serves as a wrapper over the cache and allows the user
  * to get all information about the tables without worrying about the cache.
  *
  * +------------------------+
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
index cab8e9e388..8c6dc0825f 100644
--- a/lib/bpf/rte_bpf_ethdev.h
+++ b/lib/bpf/rte_bpf_ethdev.h
@@ -12,7 +12,7 @@
  * Note that right now:
  * - it is not MT safe, i.e. it is not allowed to do load/unload for the
  *   same port/queue from different threads in parallel.
- * - though it allows to do load/unload at runtime
+ * - though it allows load/unload at runtime
  *   (while RX/TX is ongoing on given port/queue).
  * - allows only one BPF program per port/queue,
  * i.e. new load will replace previously loaded for that port/queue BPF program.
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 0a356abae2..71415346cf 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -356,7 +356,7 @@ typedef uint16_t unaligned_uint16_t;
  *   Priority number must be above 100.
  *   Lowest number is the first to run.
  */
-#ifndef RTE_INIT_PRIO /* Allow to override from EAL */
+#ifndef RTE_INIT_PRIO /* Allow overriding from EAL */
 #ifndef RTE_TOOLCHAIN_MSVC
 #define RTE_INIT_PRIO(func, prio) \
 static void __attribute__((constructor(RTE_PRIO(prio)), used)) func(void)
@@ -402,7 +402,7 @@ typedef int(__cdecl *_PIFV)(void);
  *   Priority number must be above 100.
  *   Lowest number is the last to run.
  */
-#ifndef RTE_FINI_PRIO /* Allow to override from EAL */
+#ifndef RTE_FINI_PRIO /* Allow overriding from EAL */
 #ifndef RTE_TOOLCHAIN_MSVC
 #define RTE_FINI_PRIO(func, prio) \
 static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
diff --git a/lib/ethdev/ethdev_linux_ethtool.c b/lib/ethdev/ethdev_linux_ethtool.c
index e989ddfbf2..a27558d73f 100644
--- a/lib/ethdev/ethdev_linux_ethtool.c
+++ b/lib/ethdev/ethdev_linux_ethtool.c
@@ -13,7 +13,7 @@
  *
  * The ethtool bits definition should not change as it is a kernel API.
  * Using raw numbers directly avoids checking API availability
- * and allows to compile with new bits included even on an old kernel.
+ * and allows compiling with new bits included even on an old kernel.
  *
  * The array below is built from bit definitions with this shell command:
  *   sed -rn \
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 0d8e2d0236..c6aaeec202 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -2737,7 +2737,7 @@ int rte_eth_dev_count_aggr_ports(uint16_t port_id);
  *
  *  Map a Tx queue with an aggregated port of the DPDK port (specified with port_id).
  *  When multiple ports are aggregated into a single one,
- *  it allows to choose which port to use for Tx via a queue.
+ *  it allows choosing which port to use for Tx via a queue.
  *
  *  The application should use rte_eth_dev_map_aggr_tx_affinity()
  *  after rte_eth_dev_configure(), rte_eth_tx_queue_setup(), and
@@ -4390,7 +4390,7 @@ int rte_eth_dev_rx_intr_disable(uint16_t port_id, uint16_t queue_id);
  *   The port identifier of the Ethernet device.
  * @param epfd
  *   Epoll instance fd which the intr vector associated to.
- *   Using RTE_EPOLL_PER_THREAD allows to use per thread epoll instance.
+ *   Using RTE_EPOLL_PER_THREAD allows using a per-thread epoll instance.
  * @param op
  *   The operation be performed for the vector.
  *   Operation type of {RTE_INTR_EVENT_ADD, RTE_INTR_EVENT_DEL}.
@@ -4413,7 +4413,7 @@ int rte_eth_dev_rx_intr_ctl(uint16_t port_id, int epfd, int op, void *data);
  *   to rte_eth_dev_configure().
  * @param epfd
  *   Epoll instance fd which the intr vector associated to.
- *   Using RTE_EPOLL_PER_THREAD allows to use per thread epoll instance.
+ *   Using RTE_EPOLL_PER_THREAD allows using a per-thread epoll instance.
  * @param op
  *   The operation be performed for the vector.
  *   Operation type of {RTE_INTR_EVENT_ADD, RTE_INTR_EVENT_DEL}.
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index ba3bcc89a3..eacfd7c5f7 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -3208,7 +3208,7 @@ enum rte_flow_action_type {
 	 *
 	 * Using rte_eth_cman_config_set(), the application
 	 * can configure ethdev Rx queue's congestion mechanism.
-	 * This flow action allows to skip the congestion configuration
+	 * This flow action allows skipping the congestion configuration
 	 * applied to the given ethdev Rx queue.
 	 */
 	RTE_FLOW_ACTION_TYPE_SKIP_CMAN,
diff --git a/lib/eventdev/rte_event_crypto_adapter.h b/lib/eventdev/rte_event_crypto_adapter.h
index c9b277c664..9a663c6227 100644
--- a/lib/eventdev/rte_event_crypto_adapter.h
+++ b/lib/eventdev/rte_event_crypto_adapter.h
@@ -270,7 +270,7 @@ struct rte_event_crypto_adapter_runtime_params {
 	 * rte_event_crypto_adapter_create_ext() configures the adapter with
 	 * user provided value of max_nb through
 	 * rte_event_crypto_adapter_conf::max_nb parameter.
-	 * rte_event_cryptoadapter_runtime_params_set() allows to re-configure
+	 * rte_event_cryptoadapter_runtime_params_set() allows re-configuring
 	 * max_nb during runtime (after adding at least one queue pair)
 	 *
 	 * This is valid for the devices without
diff --git a/lib/eventdev/rte_event_dma_adapter.h b/lib/eventdev/rte_event_dma_adapter.h
index 9e1d0bf40c..6a32f84753 100644
--- a/lib/eventdev/rte_event_dma_adapter.h
+++ b/lib/eventdev/rte_event_dma_adapter.h
@@ -202,7 +202,7 @@ struct rte_event_dma_adapter_runtime_params {
 	 *
 	 * Callback function passed to rte_event_dma_adapter_create_ext() configures the adapter
 	 * with default value of max_nb.
-	 * rte_event_dma_adapter_runtime_params_set() allows to re-configure max_nb during runtime
+	 * rte_event_dma_adapter_runtime_params_set() allows re-configuring max_nb during runtime
 	 * (after adding at least one queue pair)
 	 *
 	 * This is valid for the devices without RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD or
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h b/lib/eventdev/rte_event_eth_rx_adapter.h
index 758e1c5f56..41e436ec3d 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.h
+++ b/lib/eventdev/rte_event_eth_rx_adapter.h
@@ -320,7 +320,7 @@ struct rte_event_eth_rx_adapter_runtime_params {
 	 * rte_event_eth_rx_adapter_create_ext() configures the adapter with
 	 * user provided value of max_nb_rx through
 	 * rte_event_eth_rx_adapter_conf::max_nb_rx parameter.
-	 * rte_event_eth_rx_adapter_runtime_params_set() allows to re-configure
+	 * rte_event_eth_rx_adapter_runtime_params_set() allows re-configuring
 	 * max_nb_rx during runtime (after adding at least one queue)
 	 *
 	 * This is valid for the devices without
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.h b/lib/eventdev/rte_event_eth_tx_adapter.h
index ef01345ac2..58d77650ae 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.h
+++ b/lib/eventdev/rte_event_eth_tx_adapter.h
@@ -120,7 +120,7 @@ struct rte_event_eth_tx_adapter_runtime_params {
 	 * rte_event_eth_tx_adapter_create_ext() configures the adapter with
 	 * user provided value of max_nb_tx through
 	 * rte_event_eth_tx_adapter_conf::max_nb_tx parameter.
-	 * rte_event_eth_tx_adapter_runtime_params_set() allows to re-configure
+	 * rte_event_eth_tx_adapter_runtime_params_set() allows re-configuring
 	 * max_nb_tx during runtime (after adding at least one queue)
 	 *
 	 * This is valid for the devices without
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 6911ea8abe..5f8ada2185 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -569,7 +569,7 @@ graph_clone(struct graph *parent_graph, const char *name, struct rte_graph_param
 
 	graph_spinlock_lock();
 
-	/* Don't allow to clone a node from a cloned graph */
+	/* Don't allow cloning a node from a cloned graph */
 	if (parent_graph->parent_id != RTE_GRAPH_ID_INVALID)
 		SET_ERR_JMP(EEXIST, fail, "A cloned graph is not allowed to be cloned");
 
diff --git a/lib/graph/node.c b/lib/graph/node.c
index e3359fe490..1fce3e6632 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -188,7 +188,7 @@ node_clone(struct node *node, const char *name)
 	struct rte_node_register *reg;
 	rte_edge_t i;
 
-	/* Don't allow to clone a node from a cloned node */
+	/* Don't allow cloning a node from a cloned node */
 	if (node->parent_id != RTE_NODE_ID_INVALID) {
 		rte_errno = EEXIST;
 		goto fail;
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index 7e433f4661..a90d6bb377 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -14,7 +14,7 @@
  *
  * This API enables graph framework operations such as create, lookup,
  * dump and destroy on graph and node operations such as clone,
- * edge update, and edge shrink, etc. The API also allows to create the stats
+ * edge update, and edge shrink, etc. The API also allows creating the stats
  * cluster to monitor per graph and per node stats.
  */
 
diff --git a/lib/graph/rte_graph_model_mcore_dispatch.h b/lib/graph/rte_graph_model_mcore_dispatch.h
index f9ff3daa88..e39d0e9abd 100644
--- a/lib/graph/rte_graph_model_mcore_dispatch.h
+++ b/lib/graph/rte_graph_model_mcore_dispatch.h
@@ -8,7 +8,7 @@
 /**
  * @file rte_graph_model_mcore_dispatch.h
  *
- * These APIs allow to set core affinity with the node and only used for mcore
+ * These APIs allow setting core affinity with the node and only used for mcore
  * dispatch model.
  */
 
diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index dc1d4f146a..20ce505bb4 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -272,7 +272,7 @@ typedef RTE_ATOMIC(uint64_t) rte_mbuf_history_t;
  * The timestamp dynamic field provides some timing information, the
  * units and time references (initial phase) are not explicitly defined
  * but are maintained always the same for a given port. Some devices allow
- * to query rte_eth_read_clock() that will return the current device
+ * querying rte_eth_read_clock() that will return the current device
  * timestamp. The dynamic Tx timestamp flag tells whether the field contains
  * actual timestamp value for the packets being sent, this value can be
  * used by PMD to schedule packet sending.
diff --git a/lib/mbuf/rte_mbuf_history.h b/lib/mbuf/rte_mbuf_history.h
index daf3cda34c..ae7161af79 100644
--- a/lib/mbuf/rte_mbuf_history.h
+++ b/lib/mbuf/rte_mbuf_history.h
@@ -11,7 +11,7 @@
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
  *
- * These functions allow to track history of mbuf objects using a dynamic field.
+ * These functions allow tracking history of mbuf objects using a dynamic field.
  *
  * It tracks the lifecycle of mbuf objects through the system
  * with a fixed set of predefined events to maintain performance.
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 2e54fc4466..8c384d3453 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -145,7 +145,7 @@ struct rte_mempool_objsz {
  * Mempool object header structure
  *
  * Each object stored in mempools are prefixed by this header structure,
- * it allows to retrieve the mempool pointer from the object and to
+ * it allows retrieving the mempool pointer from the object and
  * iterate on all objects attached to a mempool. When debug is enabled,
  * a cookie is also added in this structure preventing corruptions and
  * double-frees.
diff --git a/lib/mldev/rte_mldev.h b/lib/mldev/rte_mldev.h
index e045a997b9..3f51083cb7 100644
--- a/lib/mldev/rte_mldev.h
+++ b/lib/mldev/rte_mldev.h
@@ -569,7 +569,7 @@ struct rte_ml_op_error {
  * Get PMD specific error information for an ML op.
  *
  * When an ML operation completed with RTE_ML_OP_STATUS_ERROR as status,
- * This API allows to get PMD specific error details.
+ * This API allows getting PMD specific error details.
  *
  * @param[in] dev_id
  *   Device identifier
diff --git a/lib/node/rte_node_eth_api.h b/lib/node/rte_node_eth_api.h
index 2b7019f6bb..e9221d113b 100644
--- a/lib/node/rte_node_eth_api.h
+++ b/lib/node/rte_node_eth_api.h
@@ -12,7 +12,7 @@
  * @b EXPERIMENTAL:
  * All functions in this file may be changed or removed without prior notice.
  *
- * This API allows to setup ethdev_rx and ethdev_tx nodes
+ * This API allows setting up ethdev_rx and ethdev_tx nodes
  * and its queue associations.
  */
 
diff --git a/lib/node/rte_node_ip4_api.h b/lib/node/rte_node_ip4_api.h
index 155a9c4b21..b7bb9216b1 100644
--- a/lib/node/rte_node_ip4_api.h
+++ b/lib/node/rte_node_ip4_api.h
@@ -12,7 +12,7 @@
  * @b EXPERIMENTAL:
  * All functions in this file may be changed or removed without prior notice.
  *
- * This API allows to do control path functions of ip4_* nodes
+ * This API allows performing control path functions of ip4_* nodes
  * like ip4_lookup, ip4_rewrite.
  */
 #include <rte_common.h>
diff --git a/lib/node/rte_node_ip6_api.h b/lib/node/rte_node_ip6_api.h
index 31089b35fc..c0cdc3926a 100644
--- a/lib/node/rte_node_ip6_api.h
+++ b/lib/node/rte_node_ip6_api.h
@@ -12,7 +12,7 @@
  * @b EXPERIMENTAL:
  * All functions in this file may be changed or removed without prior notice.
  *
- * This API allows to do control path functions of ip6_* nodes
+ * This API allows performing control path functions of ip6_* nodes
  * like ip6_lookup, ip6_rewrite.
  */
 #include <rte_common.h>
diff --git a/lib/node/rte_node_pkt_cls_api.h b/lib/node/rte_node_pkt_cls_api.h
index cf617d6985..6f824b4f1f 100644
--- a/lib/node/rte_node_pkt_cls_api.h
+++ b/lib/node/rte_node_pkt_cls_api.h
@@ -12,7 +12,7 @@
  * @b EXPERIMENTAL:
  * All functions in this file may be changed or removed without prior notice.
  *
- * This API allows to do control path functions of pkt_cls node.
+ * This API allows performing control path functions of pkt_cls node.
  */
 
 #ifdef __cplusplus
diff --git a/lib/node/rte_node_udp4_input_api.h b/lib/node/rte_node_udp4_input_api.h
index c52dded337..50f37b8bd9 100644
--- a/lib/node/rte_node_udp4_input_api.h
+++ b/lib/node/rte_node_udp4_input_api.h
@@ -12,7 +12,7 @@
  * @b EXPERIMENTAL:
  * All functions in this file may be changed or removed without prior notice.
  *
- * This API allows to control path functions of udp4_* nodes
+ * This API allows performing control path functions of udp4_* nodes
  * like udp4_input.
  */
 #include <rte_common.h>
-- 
2.47.3

