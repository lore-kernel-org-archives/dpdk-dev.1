Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9AECD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 15:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4CCF40A67;
	Thu,  7 May 2026 17:00:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6191840687;
 Thu,  7 May 2026 17:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778166003; x=1809702003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n1TK4RZX7BOUY1EnR5bpRJBUp4mzCW/zCtmd65Gmm9c=;
 b=eSG8iJMEU/Fk7Dwa5E9y2/+vA+AUZp9BorTzrTXjGcSsoQ3TvJC4tbtM
 9Q6meA404KkpW1ITdVL3TLDvKfG9xAJkmePqNvDd9FRMBgr8oRQLc/2uB
 pG3UoBCrO6nPDxXhw8X5iltDn1smkQV16mMDTwG6zOPIKo/p4FeYHP+NS
 9jgTsOnWnVXrC3V37XYD7LmylqICc3/Ics1anAfEalVaT3dV0M0yHtGwg
 mVusCBRz55QnNfCKD+tUYwQWELNwEwxI8SZnidLhZo0M/ks+bQG0B4Dul
 xCJILFB835v/DoGDcQIkcR/RxNQxDcrQ3AT9R1NMF0OKp3MUYtevPTJNg g==;
X-CSE-ConnectionGUID: lmEeDT/RTm+Vv08H70+R9g==
X-CSE-MsgGUID: rdLzQKkSQV23+LjHujNwoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82738170"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="82738170"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 08:00:02 -0700
X-CSE-ConnectionGUID: FUgOMmJQSNKQyNLudtBKNw==
X-CSE-MsgGUID: L6wOLKHNQEexDbSfGbFf0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="233818223"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 07 May 2026 08:00:01 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH 5/6] cmdline: guard zero-size destination buffers
Date: Thu,  7 May 2026 15:59:48 +0100
Message-ID: <20260507145950.197753-6-bruce.richardson@intel.com>
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

Add missing zero-size destination checks in cmdline helper routines.
Always check for size == 0, before doing an assignment of '\0' to string
position of "size - 1".

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/cmdline/cmdline_parse_num.c    | 2 +-
 lib/cmdline/cmdline_parse_string.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline/cmdline_parse_num.c b/lib/cmdline/cmdline_parse_num.c
index f21796bedb..4cfc900391 100644
--- a/lib/cmdline/cmdline_parse_num.c
+++ b/lib/cmdline/cmdline_parse_num.c
@@ -323,7 +323,7 @@ cmdline_get_help_num(cmdline_parse_token_hdr_t *tk, char *dstbuf, unsigned int s
 	struct cmdline_token_num_data nd;
 	int ret;
 
-	if (!tk)
+	if (!tk || !dstbuf || size == 0)
 		return -1;
 
 	memcpy(&nd, &((struct cmdline_token_num *)tk)->num_data, sizeof(nd));
diff --git a/lib/cmdline/cmdline_parse_string.c b/lib/cmdline/cmdline_parse_string.c
index 731947159f..33cf89f84f 100644
--- a/lib/cmdline/cmdline_parse_string.c
+++ b/lib/cmdline/cmdline_parse_string.c
@@ -171,6 +171,9 @@ int cmdline_complete_get_elt_string(cmdline_parse_token_hdr_t *tk, int idx,
 	if (!tk || !dstbuf || idx < 0)
 		return -1;
 
+	if (size == 0)
+		return -1;
+
 	tk2 = (struct cmdline_token_string *)tk;
 	sd = &tk2->string_data;
 
-- 
2.51.0

