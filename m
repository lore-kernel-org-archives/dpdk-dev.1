Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3016F0182F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9A6A40395;
	Fri,  6 Mar 2026 13:37:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6CD8E402D3;
 Fri,  6 Mar 2026 13:37:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772800641; x=1804336641;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=25DvCLXIWUYtW+lRo0OPiJTlZEn8OoNZYfNG9s3y19A=;
 b=JOrikrHejPqHEYlF+y+A2yA6KkH/VEs4XwlVD94EgnhHnDtgYeWkWRGl
 K2gLxYFdqQhe8E81u1sDwSEKDC5zzKGywPN2lTBxaxjLujZ6qMWeF0dMm
 fQd0UZVrZwypxXsKtC76WMDy4XSO8n4ExnMZt8jV9OU3qz12MgtprE6Sm
 CoVS4bAlO1heYIS1g48xmoWRG5lQ9cR2uhEcejtF7/X1SFfTQQqhjDDGE
 iGcdt96U87NrUFcymdd7bAjcvgXSdqXDih6OiTqrBS+yqwDZbsWPRlcPK
 g9UvUvgfuD9DKNFh4cphmj50uVEJWmiFAk6mkF9Q8+gfqwFxVAkIUgng8 A==;
X-CSE-ConnectionGUID: IQADuNcWSqqnJQj5f9NNIA==
X-CSE-MsgGUID: JyxATeUXR+2YQ1+3d43wWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84543208"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84543208"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 04:37:19 -0800
X-CSE-ConnectionGUID: RIP1pAWdReyDul8vF+YPlw==
X-CSE-MsgGUID: U/rozJBoQl64cofsUYrVuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="219134664"
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by orviesa007.jf.intel.com with ESMTP; 06 Mar 2026 04:37:18 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com,
	stable@dpdk.org,
	Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v1] examples/fips_validation: fix dangling pt.val after MCT
 test
Date: Fri,  6 Mar 2026 12:37:12 +0000
Message-ID: <20260306123712.2448851-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
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

After fips_mct_sha_test() and fips_mct_shake_test() complete,
vec.pt.val is freed but left as a non-NULL dangling pointer.
Since vec is a file-scope global, the next SHA algorithm's AFT
test calls parse_uint8_hex_str(&vec.pt), which checks val->val
and calls rte_free() on the stale pointer, producing:

  EAL: Error: Invalid memory

Fix by setting vec.pt.val to NULL after rte_free() at the end
of both MCT functions so the subsequent rte_free() guard in
parse_uint8_hex_str() skips the already-freed pointer.

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 examples/fips_validation/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/examples/fips_validation/main.c b/examples/fips_validation/main.c
index daf273bc85..cfb5f0124c 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -2610,6 +2610,7 @@ fips_mct_sha_test(void)
 		rte_free(md[i].val);
 
 	rte_free(vec.pt.val);
+	vec.pt.val = NULL;
 
 	rte_free(val.val);
 	return 0;
@@ -2698,6 +2699,7 @@ fips_mct_shake_test(void)
 
 	rte_free(md.val);
 	rte_free(vec.pt.val);
+	vec.pt.val = NULL;
 	rte_free(val.val);
 	return 0;
 }
-- 
2.43.0

