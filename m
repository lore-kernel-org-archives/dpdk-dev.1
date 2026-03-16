Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E345F506CC
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:05:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49D7C4025E;
	Mon, 16 Mar 2026 14:05:54 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id C213F400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 14:05:52 +0100 (CET)
Received: by shelob.oktetlabs.ru (Postfix, from userid 115)
 id 2699638; Mon, 16 Mar 2026 16:05:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 93E8138
Authentication-Results: shelob.oktetlabs.ru/93E8138; dkim=none;
 dkim-atps=neutral
Received: from aros.oktetlabs.ru (aros.oktetlabs.ru [192.168.38.17])
 by shelob.oktetlabs.ru (Postfix) with ESMTP id 93E8138;
 Mon, 16 Mar 2026 16:05:51 +0300 (MSK)
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] fib: fix name of main TRIE instance memory region
Date: Mon, 16 Mar 2026 16:05:18 +0300
Message-ID: <20260316130531.1671904-1-andrew.rybchenko@oktetlabs.ru>
X-Mailer: git-send-email 2.47.3
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

mem_name was built, but not used when memory is allocated.

Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Signed-off-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 lib/fib/trie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index fa5d9ec6b0..cd61446dd3 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -678,7 +678,7 @@ trie_create(const char *name, int socket_id,
 	num_tbl8 = conf->trie.num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
-	dp = rte_zmalloc_socket(name, sizeof(struct rte_trie_tbl) +
+	dp = rte_zmalloc_socket(mem_name, sizeof(struct rte_trie_tbl) +
 		TRIE_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
 		RTE_CACHE_LINE_SIZE, socket_id);
 	if (dp == NULL) {
-- 
2.47.3

