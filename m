Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C533C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:45:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C809740E3E;
	Mon, 31 Aug 2026 04:45:38 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 3984F40E2F;
 Mon, 31 Aug 2026 04:45:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXnTvO6pRqLNyjBg--.52698S2;
 Mon, 31 Aug 2026 10:45:34 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 45/47] doc/sxe2: remove drv-SW-stats parameter documentation
Date: Mon, 31 Aug 2026 10:45:31 +0800
Message-ID: <20260831024531.3231705-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXnTvO6pRqLNyjBg--.52698S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW7CF4ruw4rCFW3XryUGFg_yoW5ur1rpa
 9xZ34IyFykZr1Ut3yxAw48Wr18ZFsaya45G34UWayIvan8AryrZw4DKayFga9rGFy8A345
 Zr1DuryUAa1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
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

