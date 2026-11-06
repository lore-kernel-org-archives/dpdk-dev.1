Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D932606A338
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WIXUl25e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0DB142D26;
	Fri,  6 Nov 2026 07:14:56 +0100 (CET)
Received: from mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
 by mails.dpdk.org (Postfix) with ESMTPS id 76E9042D0C
 for <dev@dpdk.org>; Fri,  6 Nov 2026 07:14:56 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=myufjnTC+rCHJvI7+OPZjwcA0mK0gU6R+mN3OUZweXg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945696; v=1; x=1794550496;
 b=WIXUl25eVu2bRFbYlEGvbTFq2jSR0TL3Qk53+wztbnoWJIMb1ZzWGTWZwRaHmf0Lfltihqm7
 iFhBLJAp4FDbI6sla8sx65/HWhvvm1EkE/YZT3JcSwCa2/ShUUkXXfufwQ51HP7xuEOwC6kIuAd
 OLqDmd/luSX4pttBvFOVdyNA=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 17d32103f400ed31;
 Fri, 06 Nov 2026 06:14:55 +0000
X-Mizu-Trace-ID: 17d32103f400ed31
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net
Cc: dev@dpdk.org,
	fengchengwen@huawei.com
Subject: [PATCH v2 2/2] cocci: add script for NUMA node terminology renames
Date: Fri,  6 Nov 2026 14:14:38 +0800
Message-ID: <20261106061438.392492-3-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106061438.392492-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261106061438.392492-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Add a coccinelle script that codifies the socket to NUMA node
rename rules of the migration announced in the deprecation
notice.

The script is not applied now. Once the deprecation notice has
completed a release cycle, it will be used to generate a single
tree-wide conversion patch.

Coccinelle cannot express every needed change: designated
initializers, union field declarations, documentation and string
literals require manual adjustments. It also silently skips
functions whose signature carries unknown attribute macros
(e.g. __rte_unused).

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 devtools/cocci/socket_to_numa_node.cocci | 152 +++++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 devtools/cocci/socket_to_numa_node.cocci

diff --git a/devtools/cocci/socket_to_numa_node.cocci b/devtools/cocci/socket_to_numa_node.cocci
new file mode 100644
index 0000000000..76d91df053
--- /dev/null
+++ b/devtools/cocci/socket_to_numa_node.cocci
@@ -0,0 +1,152 @@
+// Convert the socket terminology to NUMA node terminology.
+//
+// This script codifies the rename rules of the socket to NUMA node
+// terminology migration announced in
+// doc/guides/rel_notes/deprecation.rst. The tree is not converted
+// yet: once the deprecation notice has completed a release cycle,
+// this script is used to generate a single tree-wide conversion
+// patch.
+//
+// Coccinelle cannot express every needed change: designated
+// initializers, union field declarations, documentation and string
+// literals require manual adjustments.
+//
+// Coccinelle also silently skips functions whose signature carries
+// unknown attribute macros (e.g. __rte_unused); call sites inside
+// such functions need manual conversion as well.
+//
+// The socket_id names are kept as deprecated aliases, applications
+// get one release to switch (see deprecation.rst).
+
+// Union member of the public structures.
+@@
+expression E;
+@@
+-E.socket_id
++E.numa_node
+
+@@
+expression E;
+@@
+-E->socket_id
++E->numa_node
+
+// EAL APIs.
+@@
+@@
+-SOCKET_ID_ANY
++RTE_NUMA_NODE_ANY
+
+@@
+@@
+-rte_socket_id()
++rte_numa_node()
+
+@@
+@@
+-rte_socket_count()
++rte_numa_node_count()
+
+@@
+expression E;
+@@
+-rte_socket_id_by_idx(E)
++rte_numa_node_by_idx(E)
+
+@@
+expression E;
+@@
+-rte_cpu_socket_id(E)
++rte_cpu_numa_node(E)
+
+@@
+expression E;
+@@
+-rte_lcore_to_socket_id(E)
++rte_lcore_to_numa_node(E)
+
+// Legacy malloc APIs.
+@@
+expression E1, E2, E3, E4;
+@@
+-rte_malloc_socket(E1, E2, E3, E4)
++rte_malloc_onnode(E1, E2, E3, E4)
+
+@@
+expression E1, E2, E3, E4;
+@@
+-rte_zmalloc_socket(E1, E2, E3, E4)
++rte_zmalloc_onnode(E1, E2, E3, E4)
+
+@@
+expression E1, E2, E3, E4, E5;
+@@
+-rte_calloc_socket(E1, E2, E3, E4, E5)
++rte_calloc_onnode(E1, E2, E3, E4, E5)
+
+@@
+expression E1, E2, E3, E4;
+@@
+-rte_realloc_socket(E1, E2, E3, E4)
++rte_realloc_onnode(E1, E2, E3, E4)
+
+@@
+expression E;
+@@
+-rte_malloc_heap_get_socket(E)
++rte_malloc_heap_get_numa_node(E)
+
+@@
+expression E1, E2;
+@@
+-rte_malloc_get_socket_stats(E1, E2)
++rte_malloc_get_numa_stats(E1, E2)
+
+@@
+expression E;
+@@
+-rte_malloc_heap_socket_is_external(E)
++rte_malloc_heap_numa_is_external(E)
+
+@@
+@@
+-struct rte_malloc_socket_stats
++struct rte_malloc_numa_stats
+
+// Device APIs (the same pattern applies to every library that
+// exposed a device socket API).
+@@
+expression E;
+@@
+-rte_eth_dev_socket_id(E)
++rte_eth_dev_numa_node(E)
+
+@@
+expression E;
+@@
+-rte_cryptodev_socket_id(E)
++rte_cryptodev_numa_node(E)
+
+@@
+expression E;
+@@
+-rte_event_dev_socket_id(E)
++rte_event_dev_numa_node(E)
+
+@@
+expression E;
+@@
+-rte_compressdev_socket_id(E)
++rte_compressdev_numa_node(E)
+
+@@
+expression E;
+@@
+-rte_rawdev_socket_id(E)
++rte_rawdev_numa_node(E)
+
+@@
+expression E;
+@@
+-rte_ml_dev_socket_id(E)
++rte_ml_dev_numa_node(E)
-- 
2.55.0

