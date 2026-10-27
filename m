Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D368606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E9Y16M0Z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CD954066C;
	Tue, 27 Oct 2026 10:50:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 02FD240608
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793094639; x=1824630639;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=eKcnK+S6Z2sJkp5umxQuy2hu4QflZMDnm4vKE0Ftw/w=;
 b=E9Y16M0ZVtjg7oysFh8YnmYIQEIHRUxv0iDpsuzC33OBB256Vh0QOKXg
 AkNnhSZ2QziBB7vU2dB3gQf7mCQEJISiHAq8M8mNARnOJMkdtVX/Y9u1f
 K2eW5w/5qAigMTuLVzTdpgonDIau1pkGFZ6r5Gd+rxVbNVbenIKjPnvr2
 FX9LkhKfvSUqbxVEBIdYq/1VrRx6wjb7zksUfJsh1fIZLGHhkSCHfHAcy
 peOAYHpRClYf97kX0/dWfMtTCgT3tYhGFIGViG0RzVU9mXLVRbVejxn2w
 gCE53JlCxvEbciJzkTpDX1SgnES6sTpRG0NCSx+xRiWA663UcEvnRLhnp g==;
X-CSE-ConnectionGUID: RQATfTuXR+62dMCiAMMzCA==
X-CSE-MsgGUID: nuqvytSTQayei+N5XTzzTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1674914"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1674914"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:50:35 -0700
X-CSE-ConnectionGUID: 6NwF8kufSCyeXXkBWLs7eQ==
X-CSE-MsgGUID: S+Z7PpibRiqNQswzbt1hig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6250884"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 27 Oct 2026 02:50:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Suanming Mou <suanmingm@nvidia.com>
Subject: [PATCH v4 4/6] ethdev: fix indirect action conversion with short
 buffer
Date: Tue, 27 Oct 2026 09:50:11 +0000
Message-ID: <a47a889aae1f9cfcd073fcd4f9119a9b9a415f9e.1793094529.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1793094528.git.anatoly.burakov@intel.com>
References: 
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The second pass of rte_flow_conv_actions() copies indirect action
handles whenever the destination size is nonzero, even if the buffer
does not cover the corresponding action entry. This writes beyond
the caller's buffer when an indirect action follows the last entry
that fits. The same applies to deprecated SHARED actions now that
their handles are preserved in the same branch.

Require the destination size to cover the full action entry before
writing its handle.

Fixes: fb131e295ea8 ("ethdev: fix indirect action conversion")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index e29bcefab0e..cee0acbd568 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1054,7 +1054,7 @@ rte_flow_conv_actions(struct rte_flow_action *dst,
 			 * handler. Copy the action handle directly instead
 			 * of duplicating the pointer memory.
 			 */
-			if (size)
+			if (size >= (i + 1) * sizeof(*dst))
 				dst[i].conf = src->conf;
 		} else if (src->conf) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
-- 
2.52.0

