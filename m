Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7201EEFB811
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:51:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAFE540655;
	Tue, 24 Feb 2026 08:51:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EFD0640609
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771919460; x=1803455460;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Kc/nuWArAQ0uV8X/kuu+No3Y/nswmQQyNeplV2/rDTk=;
 b=nT5hOETu+GN19PZvy7aaeoZt6RxCkdz3GzF+GKUrRFTxo02X/knI3VZ2
 rISK7uGYUtcpR03Hpt/ZvH0vp/5BEeJQ7jPDLYP+mkaVTAntezAx2QCsT
 74IGDWpq7+iGyCLB+NzzBTO9laj+OBgho+fzfpm/POzuDRMR5oDdjPmjH
 9hpV2Lb96pXSUOcyaWisSxIp1f0/vu4LAMvbhO3SwlNRxqRJw7aQ/SVrQ
 fOWs1uS1LU0NzFhjJixKcb2f51KV1bAAMbaGyHUQCE2Ag90TFVtUH3mRg
 iZX+Tz2hrCs+BDZ9l6YaEzSA7DIj4DI1k9vkkiN8E7sTWY/4OKBbp69Xu g==;
X-CSE-ConnectionGUID: uWO1wLGhRki0Qm1YTET5Kw==
X-CSE-MsgGUID: N6NAiKwcTGahl9ukxdoUgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60504709"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="60504709"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 23:51:00 -0800
X-CSE-ConnectionGUID: E7gDSA6RRtSHeehfKO19hw==
X-CSE-MsgGUID: mo0Bcr8eSmyGTCza4uXUwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="214916778"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 23:50:59 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v12 3/3] doc: add note on unsupported completion queue sharing
Date: Tue, 24 Feb 2026 13:17:26 +0530
Message-Id: <20260224074726.2392669-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224074726.2392669-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260224074726.2392669-1-shaiq.wani@intel.com>
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

Added a note in the IDPF Poll Mode Driver documentation to clarify
that sharing a completion queue among multiple TX queues serviced
by different CPU cores is not supported in split queue mode.

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

