Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC180C43211
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Jun 2026 04:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E71409FA;
	Sat, 27 Jun 2026 06:16:57 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 07CDC40272
 for <dev@dpdk.org>; Sat, 27 Jun 2026 06:16:54 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACX_uG0Tj9qwnyGFQ--.17759S2;
 Sat, 27 Jun 2026 12:16:53 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 23/23] net/sxe2: update sxe2 feature matrix docs
Date: Sat, 27 Jun 2026 12:16:52 +0800
Message-ID: <20260627041652.847113-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
References: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACX_uG0Tj9qwnyGFQ--.17759S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJw4rArWDCrW5Jr4kWF4Durg_yoWDtrykpa
 y8Z3yFyaykJr1Yy3srAw48Wrn5Zanay3sxCryDG342van8GryFvrW7Ka4rKFZrCry5A34Y
 vr1jvry7ua1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
 0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
 0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KsjUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Update the sxe2.ini feature sheet to accurately reflect the recently
implemented hardware capabilities in the sxe2 PMD.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 doc/guides/nics/features/sxe2.ini |  56 +++++++++
 doc/guides/nics/sxe2.rst          | 186 ++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)

diff --git a/doc/guides/nics/features/sxe2.ini b/doc/guides/nics/features/sxe2.ini
index 09ba2f558c..3c1e6a8a39 100644
--- a/doc/guides/nics/features/sxe2.ini
+++ b/doc/guides/nics/features/sxe2.ini
@@ -7,17 +7,73 @@
 ; is selected.
 ;
 [Features]
+Speed capabilities   = Y
+Link status          = Y
+Link status event    = Y
+Rx interrupt         = Y
 Fast mbuf free       = P
 Free Tx mbuf on demand = Y
 Burst mode info      = Y
 Queue start/stop     = Y
+Power mgmt address monitor = Y
 Buffer split on Rx   = P
 Scattered Rx         = Y
+Traffic manager      = Y
 CRC offload          = Y
+VLAN offload         = Y
+QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
+Timestamp offload    = P
+Inner L3 checksum    = P
+Inner L4 checksum    = P
 Rx descriptor status = Y
 Tx descriptor status = Y
+MTU update           = Y
+TSO                  = P
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Inline crypto        = Y
+Packet type parsing  = Y
+Timesync             = Y
+Basic stats          = Y
+Extended stats       = Y
+FW version           = Y
+Module EEPROM dump   = Y
+Multiprocess aware   = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
+
+[rte_flow items]
+eth                  = P
+geneve               = Y
+gre                  = Y
+gtpu                 = Y
+ipv4                 = Y
+ipv6                 = Y
+ipv6_frag_ext        = Y
+nvgre                = Y
+sctp                 = Y
+tcp                  = Y
+udp                  = Y
+vlan                 = P
+vxlan                = Y
+vxlan_gpe            = Y
+
+[rte_flow actions]
+count                = Y
+drop                 = Y
+mark                 = Y
+passthru             = Y
+port_representor     = Y
+queue                = Y
+represented_port     = Y
+rss                  = Y
+send_to_kernel       = Y
+port_id              = Y
diff --git a/doc/guides/nics/sxe2.rst b/doc/guides/nics/sxe2.rst
index 539072b076..270556037b 100644
--- a/doc/guides/nics/sxe2.rst
+++ b/doc/guides/nics/sxe2.rst
@@ -35,3 +35,189 @@ preventing unauthorized access to random physical memory.
 This capability allows the PMD to coexist with kernel network interfaces
 which remain functional, although they stop receiving unicast packets
 as long as they share the same MAC address.
+
+Configuration
+-------------
+
+Runtime Configuration
+~~~~~~~~~~~~~~~~~~~~~
+
+- ``Traffic Management Scheduling Levels``
+
+  The DPDK Traffic Management (rte_tm) APIs can be used to configure the Tx scheduler on the NIC.
+  The ``sched-layer-mode`` parameter can be used to set the number of scheduling levels
+  in the transmit scheduling hierarchy.
+  The provided value must be between 0 and 3.
+  If the value provided is greater than the number of levels supported by the HW,
+  the driver will use the hardware maximum value.
+
+- ``flow-duplicate-pattern`` parameter [int]
+
+  This parameter controls whether duplicate flow rules (rules with the same pattern items)
+  are allowed on the switch engine flow type.
+  Value ``0`` rejects duplicates; values ``1`` and ``2`` allow duplicates
+  but differ in which rule takes effect when multiple identical rules exist.
+
+  There are three options to choose:
+
+  - 0. Prevent insertion of rules with the same pattern items.
+    In this case, only the first rule is inserted and the following
+    rules are rejected and error code EEXIST is returned.
+
+  - 1. Allow insertion of rules with the same pattern items.
+    In this case, all rules are inserted but only the first rule
+    takes effect, the next rule takes effect only if the previous
+    rules are deleted.
+
+  - 2. Allow insertion of rules with the same pattern items.
+    In this case, all rules are inserted but only the last rule
+    takes effect, the previous rule takes effect only if the last
+    rule is deleted.
+
+  This option only applies to the switch engine flow type.
+  For the Fnav flow engine type, duplicate rules are always rejected.
+
+  When multiple PFs and VFs are bound to the driver, the same-priority
+  pattern can be applied to different ports (PF or VF).
+  This parameter controls whether duplicate rules across ports are
+  allowed and which rule takes effect when multiple identical rules
+  exist.
+
+  When only a single PF or VF is present (one port), sending an
+  identical pattern on the same port always returns error code EEXIST,
+  regardless of the parameter value.
+
+  By default, the PMD will set this value to 1 (allow duplicates,
+  first-added takes effect).
+
+- ``fnav-stat-type`` parameter [int]
+
+  This parameter controls the Fnav flow engine statistics type used
+  for flow rule hit counting (via ``rte_flow_query``).
+
+  - 1: Only count the number of packets.
+  - 2: Only count the number of bytes.
+  - 3: Count both packets and bytes (default).
+
+  Default value is 3 (count both packets and bytes).
+
+- ``drv-sw-stats`` parameter [int]
+
+  This parameter controls whether per-packet software statistics
+  (SW stats) are collected in the Rx data path.
+
+  Hardware packet statistic counters may be inaccurate for certain
+  packet types due to hardware design limitations.
+  When accuracy of Rx packet classification statistics is critical,
+  enabling this parameter allows the driver to accumulate statistics
+  in software as packets are received, providing an alternative
+  statistical path that bypasses hardware counter inaccuracies.
+
+  - 0: Disable software statistics collection (default).
+    The basic port statistics (``ipackets``, ``ibytes``) are reported
+    from the hardware counters.
+  - 1: Enable software statistics collection.
+    Per-packet software statistics are accumulated for unicast,
+    multicast, broadcast, and dropped packets in the Rx data path.
+
+  When enabled, the following extended statistics (xstats) are available:
+  ``rx_sw_unicast_packets``, ``rx_sw_multicast_packets``,
+  ``rx_sw_broadcast_packets``, ``rx_sw_drop_packets``,
+  and ``rx_sw_drop_bytes``.
+
+- ``no-sched-mode`` parameter [int]
+
+  This parameter enables non-scheduling mode (no-sched mode).
+  When enabled, the transmit path bypasses the hardware scheduling module
+  and packets are sent directly out through the port.
+  This results in lower transmit latency and higher throughput,
+  but Traffic Management (rte_tm) APIs are not supported in this mode.
+
+  - 0: Disable non-scheduling mode (default).
+    The transmit path goes through the hardware scheduling hierarchy.
+    Traffic Management (rte_tm) APIs can be used to configure the Tx scheduler.
+  - 1: Enable non-scheduling mode.
+    The transmit path bypasses the hardware scheduling module.
+    Packets are sent directly from the port at full speed without scheduling.
+    Traffic Management (rte_tm) APIs are not available in this mode.
+
+- ``rx-low-latency`` parameter [int]
+
+  This parameter controls the interrupt throttling (ITR) interval
+  for Rx queue interrupts.
+
+  When enabled, the driver sets a shorter interrupt coalescing timeout
+  (``SXE2_ITR_INTERVAL_LOW``, approximately 1 μs),
+  reducing the time between packet arrival and interrupt delivery to the CPU.
+  This lowers receive latency at the cost of increased CPU interrupt rate.
+
+  When disabled (default), the driver uses the normal interrupt throttling
+  interval (``SXE2_ITR_INTERVAL_NORMAL``, approximately 20 μs),
+  which reduces the CPU interrupt rate at the expense of higher receive latency.
+
+  - 0: Disable Rx low latency (default).
+    Normal interrupt throttling interval (~20 μs) is used.
+  - 1: Enable Rx low latency.
+    Low interrupt throttling interval (~1 μs) is used
+    for reduced receive latency.
+
+- ``function-flow-direct`` parameter [int]
+
+  This parameter controls whether flow rules from different functional units
+  (DPDK vs kernel driver) are isolated or combined when both drivers
+  control the same physical port.
+
+  When the DPDK PMD and the kernel network driver coexist on the same port,
+  flow rules may originate from either driver.
+  This parameter determines how the source VSI (Virtual Switch Interface)
+  of each flow rule is handled during hardware programming.
+
+  - 0 (default): Isolate flow rules between DPDK and kernel.
+    When ``flow_isolated`` is enabled (``rte_flow_isolate()`` called),
+    kernel-side flow rules take priority and DPDK-side flow rules are suppressed.
+    When ``flow_isolated`` is disabled, DPDK-side flow rules take priority
+    and kernel-side flow rules are suppressed.
+    Only one functional unit's flows are active at a time.
+
+  - 1: Allow direct flow rules from both DPDK and kernel simultaneously.
+    Both DPDK and kernel source VSIs are preserved in the hardware flow table.
+    Flow rules from both sides are programmed without isolation.
+
+  This option only applies to FNAV and ACL flow engine types
+  and does not apply to PF bond devices.
+
+Extended Statistics (xstats)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The PMD provides the following extended statistics (xstats) for detailed
+monitoring of receive-side packet classification and software-level accounting.
+The software statistics path is provided as a workaround for hardware
+counter inaccuracies on certain packet types --- it accumulates per-packet
+statistics directly in the Rx data path, ensuring that unicast, multicast,
+broadcast, and drop counts reflect the actual packets processed by the driver.
+
+Receive Software Statistics
+  These counters are collected in the Rx data path when ``drv-sw-stats=1``
+  is configured (see the ``drv-sw-stats`` devarg above).
+  When ``drv-sw-stats`` is disabled (default), these xstats report zero.
+
+  - ``rx_sw_unicast_packets``: Number of unicast packets received.
+  - ``rx_sw_multicast_packets``: Number of multicast packets received.
+  - ``rx_sw_broadcast_packets``: Number of broadcast packets received.
+  - ``rx_sw_drop_packets``: Number of packets dropped in the Rx data path.
+  - ``rx_sw_drop_bytes``: Number of bytes dropped in the Rx data path.
+
+  When ``drv-sw-stats`` is enabled, the basic counters ``ipackets`` and
+  ``ibytes`` (from ``rte_eth_stats``) also reflect the software-accumulated
+  packet and byte counts. Otherwise, they are reported from hardware counters.
+
+Fnav Flow Engine Statistics
+  The Fnav flow engine statistics type is controlled by the ``fnav-stat-type``
+  devarg (see above). Depending on the configuration:
+
+  - ``fnav-stat-type=1``: Only packet count is available.
+  - ``fnav-stat-type=2``: Only byte count is available.
+  - ``fnav-stat-type=3`` (default): Both packet and byte counts are available.
+
+  Flow query results (via ``rte_flow_query``) expose these per-flow counters
+  through the query API, not via xstats.
-- 
2.52.0

