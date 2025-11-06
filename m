Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F5CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F9B940693;
	Thu,  6 Nov 2025 15:10:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4590E40431;
 Thu,  6 Nov 2025 15:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438209; x=1793974209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=InCKXH3n9inqMS8jHd9/CLGgsUJkRu1+RJItYn+ylwY=;
 b=oFNRDe9coCuLOydeNf/NrUGfVRmIS75eyUHfZqkBi6Rqxw2zm1GWPpLZ
 uFYYlivYfRIFmF4huJ6gGN0ugdH3FGg4CnemhoUcS3i9cJms3qYBm/5rD
 b41DuM3+n/c2GzDn2LsRNCbpvbgldnzM8lKXvXeQ3PxRWNt8S2mLdbVZe
 bVHeOUTOlXBb7FC3GQa0Lm1Gxy0NSxAabuDHw09Q0t9aFrTVEyBKc5u0w
 TugxnU7aB00oj8ehG82sFfEy4DOVvXTh1xLT/1NW5cUKzIHuHp8cC9ff6
 bBgR7nxIxwaSWvk4fgBAEWV+OYSf7eRdZVSooJzeg2Jtkqs0N2gWWfpaR w==;
X-CSE-ConnectionGUID: uTEJNrHMTGGrnjblVhZaRQ==
X-CSE-MsgGUID: +4cokmFXTmy6TEpXXGE04w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185299"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185299"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:08 -0800
X-CSE-ConnectionGUID: TeUXBZSVRSic5Jiiy8wFiw==
X-CSE-MsgGUID: 6FaCs4h1SAO+hP63paCuHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054719"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 05/19] graph: fix variable shadowing errors
Date: Thu,  6 Nov 2025 14:09:34 +0000
Message-ID: <20251106140948.2894678-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

The nested use of MIN/MAX macros causes shadowing due to the use of the
hard-coded temporary variable names in the macros. We can fix this in
graph library by using MIN_T/MAX_T macros instead, which actually makes
more sense in some circumstances:

* when defining SZ, use of RTE_MIN_T makes sense as the comments says it
  is defined to be usable for compile-time evaluation.
* for the size calculations, RTE_MAX_T is also useful as it explicitly
  encodes the type, making it clear that we are evaluating the size
  variables as "int" type, larger than the uin16_t size is defined as.

Fixes: b6ef3794b866 ("graph: move node clone name func into private as common")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/graph/graph.c         | 4 ++--
 lib/graph/graph_private.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 61159edc72..fa03556f14 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -729,7 +729,7 @@ __rte_node_stream_alloc(struct rte_graph *graph, struct rte_node *node)
 
 	RTE_VERIFY(size != UINT16_MAX);
 	/* Allocate double amount of size to avoid immediate realloc */
-	size = RTE_MIN(UINT16_MAX, RTE_MAX(RTE_GRAPH_BURST_SIZE, size * 2));
+	size = RTE_MIN(UINT16_MAX, RTE_MAX_T(RTE_GRAPH_BURST_SIZE, size * 2, int));
 	node->objs = rte_realloc_socket(node->objs, size * sizeof(void *),
 					RTE_CACHE_LINE_SIZE, graph->socket);
 	RTE_VERIFY(node->objs);
@@ -746,7 +746,7 @@ __rte_node_stream_alloc_size(struct rte_graph *graph, struct rte_node *node,
 
 	RTE_VERIFY(size != UINT16_MAX);
 	/* Allocate double amount of size to avoid immediate realloc */
-	size = RTE_MIN(UINT16_MAX, RTE_MAX(RTE_GRAPH_BURST_SIZE, req_size * 2));
+	size = RTE_MIN(UINT16_MAX, RTE_MAX_T(RTE_GRAPH_BURST_SIZE, req_size * 2, int));
 	node->objs = rte_realloc_socket(node->objs, size * sizeof(void *),
 					RTE_CACHE_LINE_SIZE, graph->socket);
 	RTE_VERIFY(node->objs);
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 21912c0ae6..0e064b2d64 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -149,7 +149,7 @@ static inline int clone_name(char *new_name, char *base_name, const char *append
 {
 	ssize_t sz, rc;
 
-#define SZ RTE_MIN(RTE_NODE_NAMESIZE, RTE_GRAPH_NAMESIZE)
+#define SZ RTE_MIN_T(RTE_NODE_NAMESIZE, RTE_GRAPH_NAMESIZE, uint16_t)
 	rc = rte_strscpy(new_name, base_name, SZ);
 	if (rc < 0)
 		goto fail;
-- 
2.48.1

