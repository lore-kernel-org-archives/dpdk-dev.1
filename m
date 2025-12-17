Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D588CD65C56
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88CF54066E;
	Wed, 17 Dec 2025 15:32:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 055EB40613
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:32:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765981962; x=1797517962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Cpdd20AwnTzAkvQWl99witYidOm+ghtu5Id9R4aiQdw=;
 b=Pgmk5OtAadWw7lUh7WALpRawKQG+jOYPSQJJUbdsis+Kq2uiqK+aMEg9
 a0xNsDpLPZkCifpmGMUevn/no+OJwmKFyQ6zHnlTSFMqscjhDH+yRf6mh
 qI9QxDBHwPjUeqYEyj4P4QJTu1sbw8Zc0akIyJCdyIpUneK7MPVdfDbp/
 RhRgYz5ANJ6WW/HjLR6I00iYypXIf+SrkjNSE/y3G9jSNvK4oXW0dBsiR
 9P+TRkVtVfiq/5bJAW0f8UT6ahyCWw4zHVM3yAMJZ/fIr7sMZsvQxkxRt
 jpjJha9eqjlEqq755ujlElvMOhuWGbqZe6vF9pYy+WB+UacC13pYU7AQp w==;
X-CSE-ConnectionGUID: v/WzYcWBRXCqf4KDK4Z25w==
X-CSE-MsgGUID: m45EBsobQl+mTa3+Pibmnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70495940"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="70495940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:32:41 -0800
X-CSE-ConnectionGUID: ycKH2wWdR+OWJZgjaydnaQ==
X-CSE-MsgGUID: ma1HCumASGylgHblTS1jlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="202690352"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 17 Dec 2025 06:32:40 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 5/5] doc: remove deprecation notice of SSE in some Intel
 drivers
Date: Wed, 17 Dec 2025 14:32:23 +0000
Message-ID: <20251217143223.3208830-6-ciara.loftus@intel.com>
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

The SSE paths in the i40e, iavf and ice Intel drivers have been
removed, so this deprecation notice is no longer required.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 8653d6ca03..ac667e91a6 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -139,11 +139,3 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
-
-* net/intel: Drivers that have an SSE vector path alongside other vector paths,
-  namely i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11.
-  Modern x86 systems all support AVX2, if not AVX-512,
-  so the SSE path is no longer widely used.
-  This change will not result in any feature loss,
-  as the fallback scalar paths which have feature parity with SSE
-  will be used in the cases where the SSE paths would have been used.
-- 
2.43.0

