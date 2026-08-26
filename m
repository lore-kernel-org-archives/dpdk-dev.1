Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE0C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57B0740DF8;
	Wed, 26 Aug 2026 10:58:17 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 2943F40E19
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAD3+zmfqo5qyehMBg--.49802S2;
 Wed, 26 Aug 2026 16:58:07 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 46/51] doc/sxe2: remove drv-sw-stats parameter documentation
Date: Wed, 26 Aug 2026 16:58:07 +0800
Message-ID: <20260826085807.992979-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3+zmfqo5qyehMBg--.49802S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xJFW5CrWxtFWUJw1fZwb_yoWrJFW5pa
 y3Z34IvFykAr1Ut397Aw18Gry8ZFsaya43CrWUWayIvan8AryFvw47KayFga9rGFy0y34Y
 qr1DWFyUCayDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
 xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r
 4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUneHq7UUUUU==
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

The drv-sw-stats devarg and the software receive statistics xstats
that depend on it are no longer supported. Remove the parameter
description from the Runtime Configuration section and the
corresponding "Receive Software Statistics" subsection under
Extended Statistics to keep the documentation consistent.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 doc/guides/nics/sxe2.rst | 49 ----------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/doc/guides/nics/sxe2.rst b/doc/guides/nics/sxe2.rst
index c5b400a8ba..d9be5ab693 100644
--- a/doc/guides/nics/sxe2.rst
+++ b/doc/guides/nics/sxe2.rst
@@ -109,30 +109,6 @@ Runtime Configuration
 
   Default value is 3 (count both packets and bytes).
 
-- ``drv-sw-stats`` parameter [int]
-
-  This parameter controls whether per-packet software statistics (SW stats)
-  are collected in the Rx data path.
-
-  Hardware packet statistic counters may be inaccurate for certain packet types
-  due to hardware design limitations.
-  When accuracy of Rx packet classification statistics is critical,
-  enabling this parameter allows the driver to accumulate statistics in software
-  as packets are received, providing an alternative statistical path
-  that bypasses hardware counter inaccuracies.
-
-  - 0: Disable software statistics collection (default).
-    The basic port statistics (``ipackets``, ``ibytes``) are reported
-    from the hardware counters.
-  - 1: Enable software statistics collection.
-    Per-packet software statistics are accumulated for unicast,
-    multicast, broadcast, and dropped packets in the Rx data path.
-
-  When enabled, the following extended statistics (xstats) are available:
-  ``rx_sw_unicast_packets``, ``rx_sw_multicast_packets``,
-  ``rx_sw_broadcast_packets``, ``rx_sw_drop_packets``,
-  and ``rx_sw_drop_bytes``.
-
 - ``no-sched-mode`` parameter [int]
 
   This parameter enables non-scheduling mode (no-sched mode).
@@ -197,31 +173,6 @@ Runtime Configuration
 Extended Statistics (xstats)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The PMD provides the following extended statistics (xstats)
-for detailed monitoring of receive-side packet classification
-and software-level accounting.
-The software statistics path is provided as a workaround
-for hardware counter inaccuracies on certain packet types ---
-it accumulates per-packet statistics directly in the Rx data path,
-ensuring that unicast, multicast, broadcast, and drop counts
-reflect the actual packets processed by the driver.
-
-Receive Software Statistics
-  These counters are collected in the Rx data path
-  when ``drv-sw-stats=1`` is configured (see the ``drv-sw-stats`` devarg above).
-  When ``drv-sw-stats`` is disabled (default), these xstats report zero.
-
-  - ``rx_sw_unicast_packets``: Number of unicast packets received.
-  - ``rx_sw_multicast_packets``: Number of multicast packets received.
-  - ``rx_sw_broadcast_packets``: Number of broadcast packets received.
-  - ``rx_sw_drop_packets``: Number of packets dropped in the Rx data path.
-  - ``rx_sw_drop_bytes``: Number of bytes dropped in the Rx data path.
-
-  When ``drv-sw-stats`` is enabled, the basic counters
-  ``ipackets`` and ``ibytes`` (from ``rte_eth_stats``)
-  also reflect the software-accumulated packet and byte counts.
-  Otherwise, they are reported from hardware counters.
-
 Fnav Flow Engine Statistics
   The Fnav flow engine statistics type is controlled by
   the ``fnav-stat-type`` devarg (see above).
-- 
2.52.0

