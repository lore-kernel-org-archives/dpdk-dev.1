Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B7EDF02F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 04:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DE6D40673;
	Thu, 12 Feb 2026 05:53:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 174A14064E
 for <dev@dpdk.org>; Thu, 12 Feb 2026 05:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770871983; x=1802407983;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gKuCuuJudrV0WZY8hv5khri0Ybp+IQ2h/GPqMzPj+cs=;
 b=YY2/U9GY0FMiBngjE0MaDxpk67fKHJh9wvIvIcHGkyTfSN79TP1NtDQB
 Z8g0D8l5aTswHLku0pcorYRRfuyV1W2IMKFnSzYW8efxQaojieCcY2iLX
 tRUIO/mnq84ghkPfRiJDUCX4hQW+zndJBxZdHIZwBheiZV/Y3R9zTip/9
 YkIMl7Af9WJVi0Oz3rnD7sxyhlrWN2SV0KApZZUI1mOQdoJcQ/36x8H/e
 OZamgB/NPXFnYIUqWmcEHFuEB8uIYnVTWf7GCdwDCdKstw1agExy4AlRb
 hL7YiA2G/uAF266E3xFil814ahR23ddb6RyEzkMQ2xxwNG9motpflRsNH A==;
X-CSE-ConnectionGUID: wr62itMtS2ug2dVCiis9Ew==
X-CSE-MsgGUID: FWJy8lnVQyO92xGM2FXDYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71940244"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71940244"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 20:53:03 -0800
X-CSE-ConnectionGUID: 4jQ0DSyGRlOuaIYIF6XmPQ==
X-CSE-MsgGUID: FUxk2I77Rbu7bYP0chxQmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216715433"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2026 20:53:01 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v4 7/7] doc: update release notes
Date: Tue, 26 Aug 2025 21:57:04 +0530
Message-Id: <20250826162704.4636-8-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826162704.4636-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826162704.4636-1-shaiq.wani@intel.com>
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

