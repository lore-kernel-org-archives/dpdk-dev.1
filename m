Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD6EDF170
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 15:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFCE44060A;
	Fri, 13 Feb 2026 16:22:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4BBE0402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 16:22:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770996165; x=1802532165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O1JtCxPCI949W8hUoHbu6uZ00aaXWAZRdnlUGLTAIWs=;
 b=Mw1oqLRs0huFcc03ZBeFpw8I6gSVsv7a9uD48ygTiL6Qk8v9iEJm/Gjk
 SglhnESGo8mrQ9Z8lolCm7+On82Ue1ifS9nMBLgLIymHK5dBbXaMKr636
 2T1UWmeaxMPUfB4XCZQ4pr/w1sMd+DzKlPNQUOlQlGHujDP9I6eJIATFf
 Q1Lu1TCd9RH1KEFpxDmwTrW1oKIJHEqMigxxkeaOzyQCu1H4MBaPz9pJ6
 bTkd/W6H81Hv0vKXoOLChmklrE3V7fN92TnJfRVdZ1fG4Fecv8Anb+MVC
 SpsxW1V4ume4dkQmfS/H04Wvy7UnzJEOa7AFgATA2Pp8Q0hSkoVFbqt0Q A==;
X-CSE-ConnectionGUID: K8Wythl4QmeRNmgpJd/ppA==
X-CSE-MsgGUID: G0ZTFrxZSlSqbKCnWL6gQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="75803791"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="75803791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 07:22:45 -0800
X-CSE-ConnectionGUID: SpHjk43MR2ew1zcHI9D0mQ==
X-CSE-MsgGUID: ZgSw2uu+S1CkP9dIOEVBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217094202"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 07:22:44 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 1/3] eal: add location info to interrupt error message
Date: Fri, 13 Feb 2026 15:22:24 +0000
Message-ID: <20260213152227.879170-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213152227.879170-1-bruce.richardson@intel.com>
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
 <20260213152227.879170-1-bruce.richardson@intel.com>
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

The error message about the interrupt being unallocated is called from
multiple positions, so if seen in the logs the user cannot tell which
function is actually generating the message. Add function name and line
number info to the message to clarify things.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_interrupts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index b42fa862f3..a2a310750a 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -17,7 +17,7 @@
 /* Macros to check for valid interrupt handle */
 #define CHECK_VALID_INTR_HANDLE(intr_handle) do { \
 	if (intr_handle == NULL) { \
-		EAL_LOG(DEBUG, "Interrupt instance unallocated"); \
+		EAL_LOG(DEBUG, "%s, ln %d: Interrupt instance unallocated", __func__, __LINE__); \
 		rte_errno = EINVAL; \
 		goto fail; \
 	} \
-- 
2.51.0

