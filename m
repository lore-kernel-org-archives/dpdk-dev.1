Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D7CD98F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1B6140DDD;
	Thu, 18 Jun 2026 10:27:50 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id DD5EF4027F
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:27:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAnlunwqzNqY8cLFA--.46372S22;
 Thu, 18 Jun 2026 16:27:35 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 20/20] net/sxe2: update sxe2 feature matrix docs
Date: Thu, 18 Jun 2026 16:27:23 +0800
Message-ID: <20260618082723.571054-21-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618082723.571054-1-liujie5@linkdatatechnology.com>
References: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
 <20260618082723.571054-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnlunwqzNqY8cLFA--.46372S22
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyUCFy3WrWxWFWrKrW8Crg_yoW3CFyxpa
 yUZ34rtF97Jr1avwsrA3W8Xr1rZrsay343CrWDGa42qan8GryFvw47Kay0gayDuFyYya4Y
 vr1qgFy7CF4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42
 IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
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
 doc/guides/nics/features/sxe2.ini |  56 +++++++++++++
 doc/guides/nics/sxe2.rst          | 132 ++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)

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
index 539072b076..1c754ffea6 100644
--- a/doc/guides/nics/sxe2.rst
+++ b/doc/guides/nics/sxe2.rst
@@ -35,3 +35,135 @@ preventing unauthorized access to random physical memory.
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
+  There are two options to choose:
+
+  - 0. Prevent insertion of flow rules with the same pattern items.
+    In this case, duplicate rules are rejected and error code EEXIST is returned.
+
+  - 1. Allow insertion of flow rules with the same pattern items.
+    In this case, the per-rule metadata flag ``switch_pattern_dup_allow`` is set
+    to instruct the hardware switch engine that rules with identical pattern
+    items are permitted.
+
+  This option only applies to the switch engine flow type.
+  For the Fnav flow engine type, duplicate rules are always rejected.
+
+  By default, the PMD will set this value to 1.
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
+- ``high-performance-mode`` parameter [int]
+
+  This parameter enables high performance mode.
+  When enabled, the transmit path bypasses the hardware scheduling module
+  and packets are sent directly out through the port.
+  In this mode, Traffic Management (rte_tm) APIs are not supported.
+
+  - 0: Disable high performance mode (default).
+    The transmit path goes through the hardware scheduling hierarchy.
+    Traffic Management (rte_tm) APIs can be used to configure the Tx scheduler.
+  - 1: Enable high performance mode.
+    The transmit path bypasses the hardware scheduling module.
+    Packets are sent directly from the port without scheduling.
+    Traffic Management (rte_tm) APIs are not available in this mode.
+
+- ``rx-low-latency`` parameter [int]
+
+  This parameter controls whether Rx low latency mode is enabled.
+
+  - 0: Disable Rx low latency (default).
+  - 1: Enable Rx low latency.
+
+- ``function-flow-direct`` parameter [int]
+
+  This parameter controls the function flow rule direct feature.
+
+  - 0: Disable direct function flow rules (default).
+  - 1: Enable direct function flow rules.
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
2.31.1

