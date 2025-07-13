Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A295C83F17
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Jul 2025 14:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3821C4026B;
	Sun, 13 Jul 2025 16:21:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3ACD74013F
 for <dev@dpdk.org>; Sun, 13 Jul 2025 16:21:35 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D636F20421;
 Sun, 13 Jul 2025 16:21:34 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sun, 13 Jul 2025 16:21:34 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] doc: announce mbuf fast free configuration requirements
Date: Sun, 13 Jul 2025 14:21:27 +0000
Message-ID: <20250713142127.349940-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Jul 2025 14:21:34.0759 (UTC)
 FILETIME=[6FEE3B70:01DBF401]
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

For TX mbuf fast release offload, the mbuf mempool pointer will be added
to the ethdev tx queue configuration structure, so the ethdev TX burst
operation doesn't need to fetch it from the first mbuf of each burst being
fast free'd to the mempool.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/deprecation.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..a7b4505a24 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -152,3 +152,9 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* ethdev: Configuring a transmit queue for fast mbuf release will
+  require specifying which mempool to free the mbufs to.
+  For this, a new field ``struct rte_mempool *mp_fast_free`` will be
+  added to ``struct rte_eth_txconf``, and must be set when the
+  ``RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE`` offload flag is set.
-- 
2.43.0

