Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531CBD65C56
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C377A40661;
	Wed, 17 Dec 2025 15:32:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C4A714060F
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765981961; x=1797517961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IcFD3BR4zPtYGMVONUBkP36ju5lzv3XZtAO0a8U6aoE=;
 b=Z7diKvLOT1HhOP5wBN0pVECxQVX/aE2CUaDFzRq30ny8KyNY8UvqopuK
 ag+m9wcClBMgMbPXH6hdmVPkF5EBkP025OoOY59wLhEIKM8AdhOC4beZz
 oJUJhA0aqf6+CBIvDcmgx5QTz9neorEwsCJtT/+FzvjeZeylsOMaxwjgc
 NPoRysa9oUkGYUob/VaA2zROl9rhIFHhvpoYVYVDHMY02QozAPRZu3JAh
 UruvdmILaAMREyGzzoDNEierTi3yP3AWt7WxWCpikfQNZpO8XExyt9ckp
 e2Uzmd2fGzUmh3+yTcbnDKdCwMVCy4Iy52ozMRqYmXEj0Yezp1Z2ofHj4 w==;
X-CSE-ConnectionGUID: 7aNlkp/FTs2/P2p7VblIFg==
X-CSE-MsgGUID: vtpRjLluQF6Zid+MiX05tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70495939"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="70495939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:32:40 -0800
X-CSE-ConnectionGUID: modGoLhdTW+UokEux4YXdg==
X-CSE-MsgGUID: i/sjomc4TdyNJM1twqGXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="202690345"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 17 Dec 2025 06:32:39 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 4/5] doc: add release note entry for SSE removal
Date: Wed, 17 Dec 2025 14:32:22 +0000
Message-ID: <20251217143223.3208830-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217143223.3208830-1-ciara.loftus@intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20251217143223.3208830-1-ciara.loftus@intel.com>
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

The SSE paths have been removed from the i40e, iavf and ice Intel
drivers. Add a release note documenting their removal.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..a50f6ee231 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -68,6 +68,13 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Removed the SSE vector paths from some Intel drivers.**
+
+  The SSE path was not widely used, so it was removed from the i40e, iavf and
+  ice drivers. Each of these drivers have faster vector paths (AVX2 and
+  AVX-512) which have feature parity with the SSE paths, and a fallback scalar
+  path which also has feature parity.
+
 
 API Changes
 -----------
-- 
2.43.0

