Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C9C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:41:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 714B340E16;
	Fri, 28 Aug 2026 09:40:53 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 118A140DDE
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:40:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXnTuCO5FqbthzBg--.16839S2;
 Fri, 28 Aug 2026 15:40:50 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 44/45] doc/sxe2: remove drv-sw-stats parameter documentation
Date: Fri, 28 Aug 2026 15:40:50 +0800
Message-ID: <20260828074050.2250174-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXnTuCO5FqbthzBg--.16839S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW7CF4ruw4rCFW3XryUGFg_yoW5ur1rpa
 9xZ34IyFykZr1Ut3yxAw48Wr18ZFsaya45G34UWayIvan8AryrZw4DKayFga9rGFy8A345
 Zr1DuryUAa1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIJPEDUUUU
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

The drv-sw-stats devarg is no longer supported. Remove its
parameter description from the Runtime Configuration section.
The "Receive Software Statistics" xstats section is kept because
the rx_sw_* counters are still accumulated in the Rx data path
and reported through rte_eth_xstats_get().

Fixes: 9e95b2b3859c ("doc: update sxe2 guide and features")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 doc/guides/nics/sxe2.rst | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/doc/guides/nics/sxe2.rst b/doc/guides/nics/sxe2.rst
index c5b400a8ba..fe4f9f916b 100644
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
@@ -208,8 +184,7 @@ reflect the actual packets processed by the driver.
 
 Receive Software Statistics
   These counters are collected in the Rx data path
-  when ``drv-sw-stats=1`` is configured (see the ``drv-sw-stats`` devarg above).
-  When ``drv-sw-stats`` is disabled (default), these xstats report zero.
+  on every received packet.
 
   - ``rx_sw_unicast_packets``: Number of unicast packets received.
   - ``rx_sw_multicast_packets``: Number of multicast packets received.
@@ -217,10 +192,8 @@ Receive Software Statistics
   - ``rx_sw_drop_packets``: Number of packets dropped in the Rx data path.
   - ``rx_sw_drop_bytes``: Number of bytes dropped in the Rx data path.
 
-  When ``drv-sw-stats`` is enabled, the basic counters
-  ``ipackets`` and ``ibytes`` (from ``rte_eth_stats``)
+  The basic counters ``ipackets`` and ``ibytes`` (from ``rte_eth_stats``)
   also reflect the software-accumulated packet and byte counts.
-  Otherwise, they are reported from hardware counters.
 
 Fnav Flow Engine Statistics
   The Fnav flow engine statistics type is controlled by
-- 
2.52.0

