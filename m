Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF89FD8FF5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1C6A4027F;
	Thu, 26 Feb 2026 20:16:36 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 98A3E400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 20:16:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 21B4A20B6F02; Thu, 26 Feb 2026 11:16:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21B4A20B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: aman.deep.singh@intel.com, stephen@networkplumber.org, longli@microsoft.com
Subject: [PATCH] app/testpmd: reduce txonly multi-flow src_port range
Date: Thu, 26 Feb 2026 11:16:25 -0800
Message-ID: <20260226191625.1049670-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
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

Reduce the UDP source port OR-mask from 0xC0 to 0xF0, lowering
unique high-byte values from 64 to 16 (16 unique ports per lcore).

Modern SmartNICs rarely need more than 16 queues to saturate RX,
and excessive unique ports can exhaust hardware flow caching,
degrading performance.

Unique source ports by lcore count:
   1:  16,  2:  32,  4:  64,  8: 128,  16: 256

Signed-off-by: Long Li <longli@microsoft.com>
---
 app/test-pmd/txonly.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index bdcf6ea660..bb97a81402 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -229,12 +229,11 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 		 * packet generator for developer's quick performance
 		 * regression test.
 		 *
-		 * Only ports in the range 49152 (0xC000) and 65535 (0xFFFF)
-		 * will be used, with the least significant byte representing
-		 * the lcore ID. As such, the most significant byte will cycle
-		 * through 0xC0 and 0xFF.
+		 * Generate ports in the IANA ephemeral range (49152+).
+		 * The OR-mask (0xF0) produces 16 unique port values
+		 * per lcore for good RSS distribution.
 		 */
-		src_port = ((src_var++ | 0xC0) << 8) + rte_lcore_id();
+		src_port = ((src_var++ | 0xF0) << 8) + rte_lcore_id();
 		udp_hdr->src_port = rte_cpu_to_be_16(src_port);
 		RTE_PER_LCORE(_src_port_var) = src_var;
 	}
-- 
2.43.0

