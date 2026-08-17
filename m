Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD7CC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 02:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41A9C406B6;
	Mon, 17 Aug 2026 04:54:02 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5566740609
 for <dev@dpdk.org>; Mon, 17 Aug 2026 04:53:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADHn_O5d4JqAwjkBQ--.21980S15;
 Mon, 17 Aug 2026 10:53:50 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 13/13] doc/sxe2: add acl-stat-type parameter documentation
Date: Mon, 17 Aug 2026 10:53:39 +0800
Message-ID: <20260817025339.2792682-14-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
References: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHn_O5d4JqAwjkBQ--.21980S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15XF1fWw4ktr4rKFykKrg_yoW8tw18pa
 13X34Sg3Z7JF15J3y7Ca18Wr1rAa9aka43C3yjg34Ivan8CryFvay2k3yrKa9rXa48Za4U
 Zr1qgry7CF4qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
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

This commit adds documentation for the acl-stat-type parameter
which controls ACL statistics type used for ACL rule hit counting.

- 1: Only count the number of packets
- 2: Only count the number of bytes
- 3: Count both packets and bytes (default)

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 doc/guides/nics/sxe2.rst | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/doc/guides/nics/sxe2.rst b/doc/guides/nics/sxe2.rst
index 8278a5f108..008d944391 100644
--- a/doc/guides/nics/sxe2.rst
+++ b/doc/guides/nics/sxe2.rst
@@ -98,29 +98,16 @@ Runtime Configuration
 
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
+- ``acl-stat-type`` parameter [int]
+
+  This parameter controls the ACL statistics type
+  used for ACL rule hit counting (via ``rte_flow_query``).
+
+  - 1: Only count the number of packets.
+  - 2: Only count the number of bytes.
+  - 3: Count both packets and bytes (default).
+
+  Default value is 3 (count both packets and bytes).
 
 - ``no-sched-mode`` parameter [int]
 
-- 
2.52.0

