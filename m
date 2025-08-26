Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C63EDF040
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40C4F40695;
	Thu, 12 Feb 2026 06:31:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 104C240659
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:31:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770874301; x=1802410301;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gKuCuuJudrV0WZY8hv5khri0Ybp+IQ2h/GPqMzPj+cs=;
 b=bKBD/dyfkHcN1PTKWcvQUADRdSJshk7wal4zrcBisSczD5CN2Rb8/JBL
 v3vst3QhiyzIQCIDocmWtH0tvTimK3+NeUvurYcslIErdTqU5fLEmEBRA
 5r6bGskC9WkZlXr1F0k/uK6BTSzySXWZazUc+dqUo1gltyM3935eWRMd9
 FdZPqJ4MWptVHkAZ+1hZyxiVkmN2cLzP8ZddF8qTFq8s8dzCFPppZEBxZ
 Z7DKZ7LTzHnYH6DQi24NeUOkGim38RFi1xVjTEE1bU9DgwrJCooEnndzx
 BrJUZeLNjgdTWCW7GgOAitvHZlvw6M1hX2UgQc5fE8744ztZkyAb7j9ar w==;
X-CSE-ConnectionGUID: KtLM1LFWSiqf5aEY+2KTwA==
X-CSE-MsgGUID: ThgVZI+5RR6c/XJAnZIrag==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83405360"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83405360"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 21:31:40 -0800
X-CSE-ConnectionGUID: RT0hIsDLT0yHt/A7IAeclw==
X-CSE-MsgGUID: Q25Pkd2NTKCf7ihWtzygXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212581424"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 21:31:40 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 7/7] doc: update release notes
Date: Tue, 26 Aug 2025 22:35:41 +0530
Message-Id: <20250826170541.5010-8-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826170541.5010-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826170541.5010-1-shaiq.wani@intel.com>
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

Add L2TPv2 over UDP support for ice PMD in the release notes.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 5c2a4bb32e..d312c47531 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -67,6 +67,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated Intel ice driver.**
+
+  * Added Flow Director (FDIR) support for L2TPv2 over UDP.
+
 * **Updated ZTE zxdh ethernet driver.**
 
   * Added support for modifying queue depth.
-- 
2.34.1

