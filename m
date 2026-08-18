Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB12C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 02:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF29940698;
	Tue, 18 Aug 2026 04:15:39 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E2C034064C
 for <dev@dpdk.org>; Tue, 18 Aug 2026 04:15:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADHNUA8wINq+acKBg--.60494S15;
 Tue, 18 Aug 2026 10:15:28 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 13/13] doc/sxe2: add acl-stat-type parameter documentation
Date: Tue, 18 Aug 2026 10:15:18 +0800
Message-ID: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHNUA8wINq+acKBg--.60494S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15XF1fWw4ktr4rKFykKrg_yoW8tw18pa
 13X34Sg3Z7JF15J3y7Ca18Wr1rAa9aka43C3yjg34Ivan8CryFvay2k3yrKa9rXa48Za4U
 Zr1qgry7CF4qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

