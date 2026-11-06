Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D32606A33C
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 06:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O7louhWe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75E4D40297;
	Fri,  6 Nov 2026 07:14:49 +0100 (CET)
Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
 by mails.dpdk.org (Postfix) with ESMTPS id DD1DE4026D
 for <dev@dpdk.org>; Fri,  6 Nov 2026 07:14:47 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=wuwloX/TosWgOWnMdNRr0QxbN8NViMbQp1qizXHyvb4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945687; v=1; x=1794550487;
 b=O7louhWesUtptJn1yl4PLx0Hvcgkci8F59uByYOsygjhFwtaxUx/MLwXjKppWiw/g60wQwHd
 k7owYtakD9tWUsCmnd894+tNbvkPfCSTasX/Ek2CzfzXQNVD/vccb8HpX1b2CIuN7whWb663j9V
 NDjrhS9wQJdGUDxTDIUtEt0o=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id ea0b87a064fb23a5;
 Fri, 06 Nov 2026 06:14:47 +0000
X-Mizu-Trace-ID: ea0b87a064fb23a5
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net
Cc: dev@dpdk.org,
	fengchengwen@huawei.com
Subject: [PATCH v2 0/2] use NUMA node terminology
Date: Fri,  6 Nov 2026 14:14:36 +0800
Message-ID: <20261106061438.392492-1-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

This is a new version of the "use NUMA node terminology" series,
which converted the whole tree to the NUMA node terminology
(about 227 patches).

Following the review feedback, this version takes a staged
approach. This series only contains the groundwork, there is no
tree-wide replacement patch:

1/2 doc: deprecate socket terminology in favor of NUMA node
2/2 cocci: add script for NUMA node terminology renames

The deprecation notice announces the socket_id to numa_node field
renames of the public structures and the deprecation of the
socket-named functions, the rte_malloc_socket_stats structure and
the SOCKET_ID_ANY macro. The old names are kept as deprecated
aliases for one release, giving applications a full release
window to migrate.

Once the notice has completed a release cycle, the coccinelle
script will be used to generate a single tree-wide conversion
patch, instead of the previous large series of small patches
which overloaded the CI.

The script covers the mechanical source renames: API function
call sites, macros, the rte_malloc_socket_stats structure, and
socket_id member accesses. Coccinelle cannot express every
needed change: designated initializers, union field declarations,
documentation and string literals require manual adjustments; it
also silently skips functions whose signature carries attribute
macros it does not know (e.g. __rte_unused). The same applies to
the fields named "socket" in rte_graph and rte_bbdev_queue_conf,
where a generic rename rule would over-match.

The replacement names follow the libnuma node semantics while
keeping the existing DPDK memory allocation model: bare node
getters (rte_numa_node(), rte_numa_node_count(),
rte_numa_node_by_idx(), rte_cpu_numa_node(),
rte_lcore_to_numa_node()), an rte_malloc_onnode() allocation
family shaped after libnuma's numa_alloc_onnode(), and
rte_malloc_heap_get_numa_node().

Series-changes: 2
- only the deprecation notice and the coccinelle script, the
  tree-wide conversion patch will be submitted after the notice
  completes a release cycle
- keep old names as deprecated aliases for one release window
- cover the full rename set in the script (malloc family,
  rte_cpu_socket_id, rte_cryptodev_socket_id,
  rte_ml_dev_socket_id, rte_malloc_socket_stats)
- use a "Terminology change" tag in the deprecation notice as
  the rename spans several libraries
- name the replacements after libnuma semantics
  (rte_numa_node(), rte_malloc_onnode(), ...)

Chengwen Feng (2):
  doc: deprecate socket terminology in favor of NUMA node
  cocci: add script for NUMA node terminology renames

 devtools/cocci/socket_to_numa_node.cocci | 152 +++++++++++++++++++++++
 doc/guides/rel_notes/deprecation.rst     |  35 ++++++
 2 files changed, 187 insertions(+)
 create mode 100644 devtools/cocci/socket_to_numa_node.cocci

-- 
2.55.0

