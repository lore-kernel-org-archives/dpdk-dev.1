Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995BCD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 15:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F764066A;
	Thu,  7 May 2026 17:00:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8991B4068A
 for <dev@dpdk.org>; Thu,  7 May 2026 17:00:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778166004; x=1809702004;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wt9C4C5hmL10dobZaEyg48on0vDcDRJhEZf5UcQci94=;
 b=CDsF8KIAqCzJJquFz/BNdqpV75KdbIG4i15IquKq32X8MHAsNLq2Shgu
 eFoNUcdLEvjuEFKfbZA1pgMZiK8yIOrCfYjlsXZEfWqbPGcoGwKK0hKX9
 oQjPClFAhzBHEwI0mLl4B/RrnM4iW3HP8XVGGFqnuhx1yXahzpFNoSNsr
 2Qo4/vLXLxXQG3FMe1+48aqLwHb278rf2ltHlGFW/ou1yy5WIfb1CHPbR
 v+q6Xj7v1r4SoCa6nqSlwTQw5C2cquzCIijwk1cVtGkEjTDF1JFD1C80M
 Pr4N2P5g7/TIkvVcvmS/69STi2fS+uwhe4jWCaCmo0NAMvAOxod6Rhu/H Q==;
X-CSE-ConnectionGUID: RfOPQwRfRemCQbMP1rz3nA==
X-CSE-MsgGUID: 5FKF+46fS5aO3TVXPTM3Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738173"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738173"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 08:00:04 -0700
X-CSE-ConnectionGUID: z//Tbm/gQW+ab4WB6oJF6g==
X-CSE-MsgGUID: 7BUDNe2fRWenUcHaQA5MZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818280"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 08:00:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 6/6] cmdline: add null checks for invalid input
Date: Thu,  7 May 2026 15:59:49 +0100
Message-ID: <20260507145950.197753-7-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507145950.197753-1-bruce.richardson@intel.com>
References: <20260507145950.197753-1-bruce.richardson@intel.com>
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

To harden the public API, add some NULL checks before dereferencing
pointers. Properly written apps should never call these with NULL, but
to increase resilience, we'll add the checks.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/cmdline/cmdline.c        | 3 +++
 lib/cmdline/cmdline_rdline.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/lib/cmdline/cmdline.c b/lib/cmdline/cmdline.c
index d1003f0b8e..51fbc36cef 100644
--- a/lib/cmdline/cmdline.c
+++ b/lib/cmdline/cmdline.c
@@ -103,6 +103,9 @@ RTE_EXPORT_SYMBOL(cmdline_get_rdline)
 struct rdline*
 cmdline_get_rdline(struct cmdline *cl)
 {
+	if (!cl)
+		return NULL;
+
 	return &cl->rdl;
 }
 
diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
index 0a5a399b32..15da285c8d 100644
--- a/lib/cmdline/cmdline_rdline.c
+++ b/lib/cmdline/cmdline_rdline.c
@@ -618,6 +618,9 @@ RTE_EXPORT_SYMBOL(rdline_get_history_buffer_size)
 size_t
 rdline_get_history_buffer_size(struct rdline *rdl)
 {
+	if (!rdl)
+		return 0;
+
 	return sizeof(rdl->history_buf);
 }
 
-- 
2.51.0

