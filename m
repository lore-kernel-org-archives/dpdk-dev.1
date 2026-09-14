Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A6FC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 793B040DD7;
	Mon, 14 Sep 2026 16:44:22 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E2E3540E3E
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:44:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BD1E42074F;
 Mon, 14 Sep 2026 16:44:19 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 14 Sep 2026 16:44:19 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v6 2/2] mempool: introduce pile driver
Date: Mon, 14 Sep 2026 14:44:17 +0000
Message-ID: <20260914144417.942470-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914144417.942470-1-mb@smartsharesystems.com>
References: <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260914144417.942470-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Sep 2026 14:44:19.0232 (UTC)
 FILETIME=[86054A00:01DD4457]
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

Added a new "pile" mempool driver, based on the high-performance lock-free
"pile" stack variant.
With this driver added, the max number of mempool drivers
(RTE_MEMPOOL_MAX_OPS_IDX) would be exceeded, so it was increased from 16
to 32.

Changed the other stack drivers to call their specific push/pop functions,
instead of calling the generic stack push/pop API.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v6:
* No changes.
v5:
* Added release note. (AI advanced model)
* Moved increase of max number of mempool drivers from stack patch to
  mempool driver patch, where it belongs.
* Mentioned increase of max number of mempool drivers in patch
  description.
* Removed the rte_mempool_register_ops() and rte_mempool_set_ops_byname()
  changes.
  They are included in the "mempool: various cleanups" patch in the
  "mempool: cleanup, fixes, improvements and optimizations" series.
v4:
* No changes.
v3:
* Call other stack types' specific push/pop functions.
v2:
* There is no v2.
---
 doc/guides/rel_notes/release_26_11.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 572e579ed5..17a1219222 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -61,6 +61,7 @@ New Features
   pushed and popped in LIFO manner, but objects within each bulk are not ordered
   as expected by a stack.
   Furthermore, it is not strictly bounded by its size, but might hold more objects.
+* mempool: Added "pile" driver, using the lock-free "pile" stack-like implementation.
 
 Removed Items
 -------------
-- 
2.43.0

