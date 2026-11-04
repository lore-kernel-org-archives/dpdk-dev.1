Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599D6071A03
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l5f+ACRG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FA3840DCD;
	Wed,  4 Nov 2026 21:15:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 8FA5140285
 for <dev@dpdk.org>; Wed,  4 Nov 2026 21:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823313; x=1825359313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CcFeTdNNPkdLKUdVYp7M1E6JQNIybQ7Bm1tLAWRXM14=;
 b=l5f+ACRG1IXvRgio1XcQfaHCF395L/nA4Ojlzdy4GBt2rvYgH2PYsJRX
 /2EBXL38saieYEIFOgAhqP3UArfY2fVfN33mctde0oMOtzNzUP8RmNJ1x
 nqXJAq/fSqY6FmvK2UolmArokpZ6nMO/BbPWvC1dbwRQ+nCqktDWDk99p
 ZoByi1OUQviP3BpDVqaW01xNpD7jfVHcNVawNJwfsgMO8mCdQG1Nhafyo
 lceHb68g7MNtNkHJpoqjsGpcPIG4sO/rB9dd0m/wsDUW/v08QNSi8FLoj
 1mJjy8LsnkFAIRr2lfaZS0qTTM0NGs0ycFU9N58Hl5EFwNaK1o+JJaqGU g==;
X-CSE-ConnectionGUID: jUXqmZjUSH+mCxIXBecZ6g==
X-CSE-MsgGUID: rAKNSv+nSvG221+tt1EdOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2627685"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2627685"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:15:11 -0800
X-CSE-ConnectionGUID: 0eCrLyNnQeexLGpNebHnaA==
X-CSE-MsgGUID: HdmG3yluT/uEC8mTc7QkrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7130656"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2026 12:15:09 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 1/3] build: deprecate kernel dir option
Date: Wed,  4 Nov 2026 20:15:04 +0000
Message-ID: <20261104201506.4091374-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104201506.4091374-1-bruce.richardson@intel.com>
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20261104201506.4091374-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel_dir option does nothing, so it can be deprecated and removed
in future.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 meson_options.txt                    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 02b495f6a8..1fbe03cc04 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -16,6 +16,10 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* build: The following meson build options are deprecated and will be removed in a future release:
+
+  - ``kernel_dir``: option unused as Linux kernel drivers are in a separate ``dpdk-kmods`` repository.
+
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..7bd5ebc084 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -33,7 +33,7 @@ option('ibverbs_link', type: 'combo', choices : ['static', 'shared', 'dlopen'],
 option('include_subdir_arch', type: 'string', value: '', description:
        'subdirectory where to install arch-dependent headers')
 option('kernel_dir', type: 'string', value: '', description:
-       'Path to the kernel for building kernel modules. Headers must be in $kernel_dir or $kernel_dir/build. Modules will be installed in /lib/modules.')
+       '[Deprecated] Value unused. Previously, path to the kernel for building kernel modules.')
 option('machine', type: 'string', value: 'auto', description:
        'Alias of cpu_instruction_set.')
 option('max_ethports', type: 'integer', value: 32, description:
-- 
2.55.0

