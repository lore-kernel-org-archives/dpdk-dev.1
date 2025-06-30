Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FA3C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 10:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7640402DF;
	Mon, 30 Jun 2025 12:50:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 541184025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 12:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751280634; x=1782816634;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V8ek97z5nL1eYrT1OyXD95MrqtdTPYmI5O4U75Loz/A=;
 b=HfQs5dKqHuvptEYEsisi7Ik25YrwB1i8t+b+7HzdFnU00Wf2JPE/3vhZ
 Az+vqhkgq5p8ofU6Z/1suvmSas9El5YDGDZpU0pl8A+9OVONzlFnNEf6I
 5hcnAl51zrTPRh4zEtlFpcjBDdqv9z3MzLE8UegcXxHy3gOi5afC4qLee
 41f+V7MtdgWDsQWrsomluoT/PXAytA3uCmygq7GavAqp8eZeWMs9K/YLS
 ubAyhbHWlnEaZVTH235ldyZkKLRC8eWB/yHeUTyLmTbSKQW+2VZSmpzcX
 kIKLPLcibRYsNsef79uwwRACbTxSZkEHWYqTITiJeVCzcQlJRfVoXHpBr A==;
X-CSE-ConnectionGUID: OwXvEiBvRSOPyJfbKC5rXg==
X-CSE-MsgGUID: Ui2HSGSQRf2m9zLobr7AZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52731969"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="52731969"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2025 03:50:33 -0700
X-CSE-ConnectionGUID: Xf478nOsQFykXncDDk3qPA==
X-CSE-MsgGUID: 8ev9HVqmQeCxuOA0+egDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; d="scan'208";a="157970235"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa004.jf.intel.com with ESMTP; 30 Jun 2025 03:50:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] node: fix C++ compatibility errors (option 2)
Date: Mon, 30 Jun 2025 11:50:14 +0100
Message-ID: <20250630105025.2265901-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

C++ does not allow zero-sized unions - they end up being of size 1-byte,
which leads to C/C++ compatibility issues, flagged by the compiler.

  lib/node/rte_node_mbuf_dynfield.h:78:2: error: union has size 0 in C,
size 1 in C++ [-Werror,-Wextern-c-compat]
   78 |         union {
	         |         ^
		 1 error generated.

Fix the error by omitting the persistent_data field when it is
zero-sized, since it's unusable. Any app using the field must already
specify a size for the persistent data.

Fixes: 746e8736da70 ("node: add global mbuf dynfield")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/node/rte_node_mbuf_dynfield.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_dynfield.h
index b77fdbb94f..09254c585a 100644
--- a/lib/node/rte_node_mbuf_dynfield.h
+++ b/lib/node/rte_node_mbuf_dynfield.h
@@ -69,6 +69,7 @@ typedef struct rte_node_mbuf_overload_fields {
  * 2. Overloadable fields: Fields which can be repurposed by two adjacent nodes.
  */
 typedef struct rte_node_mbuf_dynfield {
+#if RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE > 0
 	/**
 	 * Persistent mbuf region across nodes in graph walk
 	 *
@@ -78,6 +79,7 @@ typedef struct rte_node_mbuf_dynfield {
 	union {
 		uint8_t persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE];
 	};
+#endif
 	/**
 	 * Overloadable mbuf fields across graph walk. Fields which can change.
 	 *
-- 
2.48.1

