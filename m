Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E09606A332
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BrmFQmxt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 206A2427E1;
	Fri,  6 Nov 2026 07:14:54 +0100 (CET)
Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
 by mails.dpdk.org (Postfix) with ESMTPS id 352CA4026D
 for <dev@dpdk.org>; Fri,  6 Nov 2026 07:14:53 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=BKRYvblQFKEa2usqkMjTCGDuhIWNbx58Tb1CAi72bZE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945693; v=1; x=1794550493;
 b=BrmFQmxt6J9OtNHpmvlv30bh9mKhSjvHrkYKV85/KiXC2K33LVGR4SJgvcAU+S7e3rzumK5M
 RMk3UGdv9ESrg/FH1cfnuxt+I/7A55Wggki1HdsgH+Ot/pGWO3X7etxaV/oKToIyzb0ncIs86Pu
 T9XIbvb9hL0Rbf/JuEL7AK9A=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 01754e34b91632d0;
 Fri, 06 Nov 2026 06:14:52 +0000
X-Mizu-Trace-ID: 01754e34b91632d0
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net
Cc: dev@dpdk.org,
	fengchengwen@huawei.com
Subject: [PATCH v2 1/2] doc: deprecate socket terminology in favor of NUMA node
Date: Fri,  6 Nov 2026 14:14:37 +0800
Message-ID: <20261106061438.392492-2-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Announce the rename of the socket_id fields of the public
structures to numa_node, and the deprecation of the socket-named
functions and macros across several libraries, keeping them as
deprecated aliases for one release.

This notice starts the deprecation process of the NUMA node
terminology migration discussed on the mailing list. The
mechanical conversion will be submitted as a single patch,
produced with the coccinelle script added by the next patch,
once this notice completes a release cycle.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 doc/guides/rel_notes/deprecation.rst | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 02b495f6a8..f846a4c83b 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -16,6 +16,41 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* Terminology change: The public structures use ``socket_id`` to refer to a NUMA node,
+  which conflates CPU sockets with NUMA memory nodes.
+  The field is renamed to ``numa_node``, keeping ``socket_id``
+  as a deprecated union alias.
+  Affected structures include: ``rte_acl_param``, ``rte_bbdev_data``,
+  ``rte_bbdev_info``, ``rte_bbdev_queue_conf``, ``rte_compressdev_config``,
+  ``rte_cryptodev_config``, ``rte_event_timer_adapter_conf``,
+  ``rte_event_vector_adapter_conf``, ``rte_fbk_hash_params``,
+  ``rte_graph``, ``rte_graph_cluster_stats_param``, ``rte_graph_param``,
+  ``rte_gro_param``, ``rte_hash_parameters``, ``rte_ipsec_sad_conf``,
+  ``rte_member_parameters``, ``rte_member_setsum``, ``rte_memseg``,
+  ``rte_memseg_list``, ``rte_memzone``, ``rte_ml_dev_config``,
+  ``rte_mempool``, ``rte_rawdev``, ``rte_rawdev_info`` and
+  ``rte_service_spec``.
+  The fields of ``rte_graph`` and ``rte_bbdev_queue_conf`` are named
+  ``socket`` rather than ``socket_id``; their deprecated aliases keep
+  that name.
+  Applications should switch to ``numa_node``.
+
+* Terminology change: The legacy socket-named functions
+  ``rte_socket_id()``, ``rte_socket_count()``, ``rte_socket_id_by_idx()``,
+  ``rte_cpu_socket_id()``, ``rte_lcore_to_socket_id()``,
+  the ``rte_malloc_socket()`` family,
+  ``rte_malloc_heap_get_socket()``, ``rte_malloc_get_socket_stats()``,
+  ``rte_malloc_heap_socket_is_external()``, ``rte_eth_dev_socket_id()``,
+  ``rte_cryptodev_socket_id()``, ``rte_compressdev_socket_id()``,
+  ``rte_event_dev_socket_id()``, ``rte_rawdev_socket_id()`` and
+  ``rte_ml_dev_socket_id()``
+  are deprecated aliases of their NUMA-named replacements,
+  and will be removed in a future release.
+  The ``rte_malloc_socket_stats`` structure is renamed to
+  ``rte_malloc_numa_stats``, keeping the old name as a deprecated
+  typedef alias.
+  The ``SOCKET_ID_ANY`` macro is deprecated; use ``RTE_NUMA_NODE_ANY``.
+
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
-- 
2.55.0

