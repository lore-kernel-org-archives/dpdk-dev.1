Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45355FC591C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0F9F4064A;
	Thu, 26 Feb 2026 10:45:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id A0E0340608
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:45:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772099151; x=1803635151;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nFyefTlaRAU1GnBcAOo+tvD1ERX45eVKLfU+oH4YVhU=;
 b=GYqGq940+O/PRH+qbqOumnE7LVxiJW5D+IF4j0xtOiFbR2gGRCNA3zmx
 siX2WVjM9gt/b28U1tawDOtuujvy1r/gzGvYk8hQqMkskjLxvCKPAX9ZK
 VmzkDCJOP55e3gGqgB9oroiJx6K+t2t/8XekP61EvkSqVyrzdgtXyBJEb
 or6GTjyyAjM270IqYkK1z0AoZD1MHeqRDLgETVD444WTVkwyhdOy8SZGK
 AGedYIIJBlEBFuxW1p2KJd6aipk8WKY5RD2I+nxAEXfRxjPRcjeKZqKRS
 oHFrqm9xGZ0/aRdmJQPwe7kWDHvqYudZeQYZhmmqHt6vbX81UJeG0wO27 Q==;
X-CSE-ConnectionGUID: HTrJTntKSKGpdpwdrh8xtA==
X-CSE-MsgGUID: F7rFCneQR6yiAnyth7xtwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73259102"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73259102"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 01:45:50 -0800
X-CSE-ConnectionGUID: UjU/SO+kT3KiVSBAOqYu5A==
X-CSE-MsgGUID: ETrtcy+GRN2POrflGdvZgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="221021314"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2026 01:45:49 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v14 3/3] doc: add note on unsupported completion queue sharing
Date: Thu, 26 Feb 2026 15:12:22 +0530
Message-Id: <20260226094222.1393288-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226094222.1393288-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260226094222.1393288-1-shaiq.wani@intel.com>
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

Added a note in the IDPF Poll Mode Driver documentation
to clarify that sharing a completion queue among multiple
TX queues serviced by different CPU cores is not supported
in split queue mode.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/nics/idpf.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
index b99cc18188..47e38fcb13 100644
--- a/doc/guides/nics/idpf.rst
+++ b/doc/guides/nics/idpf.rst
@@ -79,6 +79,11 @@ Runtime Configuration
   Then the PMD will configure Tx queue with single queue mode.
   Otherwise, split queue mode is chosen by default.
 
+.. note::
+
+  In split queue mode, sharing a completion queue among multiple TX queues that are
+  serviced by different CPU cores is not supported.
+
 
 Driver compilation and testing
 ------------------------------
-- 
2.34.1

