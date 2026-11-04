Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32A6071A05
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FgO9C2ds
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33D5540DDB;
	Wed,  4 Nov 2026 21:15:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id DD4F940288
 for <dev@dpdk.org>; Wed,  4 Nov 2026 21:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823313; x=1825359313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=93qDswUtvtJUQ+8uHfH0eC/zz0EIC7jVkp5Fo0j4pp4=;
 b=FgO9C2dshKwLWxCbFrLTOXbXVUuctXlcwY9R316cd4BhSVloeFwy2f9c
 ZvspCmQtzklCpd8NnMDv7aOl9QXCENlpfZlrMsCJIM2hM8oDLvakvWUJS
 X35O6Qpxa2Tx0ZFbYlrhAixZ3DNIHItqeNW3d7AtKi3b3iNuSugtWIIdw
 zbUi8hjMWRTE5Y07XQEgPDwK/KnpGrxJLWhtrnn7SZKSaFh6LTbK54YIp
 qE2mt1xrzWWwY932c3O+KN9Z7WOGkv4xVrksqXl295SddBuGrdZuZqHf0
 zXqasj/3w/j4VRVQC0kuEiB/agTV3pXXqqE+ZDUEyzBV4m20cthLnu051 Q==;
X-CSE-ConnectionGUID: VpdypjEaQFiz0auaiGWRaA==
X-CSE-MsgGUID: KhJK2CuBSsCqa2htuAqPrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2627689"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2627689"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:15:12 -0800
X-CSE-ConnectionGUID: Bynmv4BlSz24McFs+wBSOw==
X-CSE-MsgGUID: lg0GG0VETGe26u9O9IOtmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7130663"
Received: from silpixa00401385.ir.intel.com ([10.20.227.220])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2026 12:15:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 2/3] build: deprecate standalone tests option
Date: Wed,  4 Nov 2026 20:15:05 +0000
Message-ID: <20261104201506.4091374-3-bruce.richardson@intel.com>
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

The unit tests can be disabled in DPDK in a couple of ways. Firstly,
there is the original "tests" boolean option - when set to false, the
tests are skipped as part of the build. However, the newer
enable_apps/disable_apps options also can be used to disable the tests
[you can disable using the "enable" option by omitting "tests" from the
list to enable].

This duplication of functionality is unnecessary, so let's remove the
standalone tests option.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/meson.build                      | 6 +-----
 doc/guides/rel_notes/deprecation.rst | 1 +
 meson_options.txt                    | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/app/meson.build b/app/meson.build
index 24fadc1963..a3be3e24e2 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -17,6 +17,7 @@ apps = [
         'graph',
         'pdump',
         'proc-info',
+        'test',
         'test-acl',
         'test-bbdev',
         'test-cmdline',
@@ -35,11 +36,6 @@ apps = [
         'validate-bpf',
 ]
 
-if get_option('tests')
-# build the auto test app if enabled.
-    apps += 'test'
-endif
-
 default_cflags = machine_args + ['-DALLOW_EXPERIMENTAL_API']
 default_ldflags = []
 if get_option('default_library') == 'static' and not is_windows
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 1fbe03cc04..ae2205827b 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -19,6 +19,7 @@ Deprecation Notices
 * build: The following meson build options are deprecated and will be removed in a future release:
 
   - ``kernel_dir``: option unused as Linux kernel drivers are in a separate ``dpdk-kmods`` repository.
+  - ``tests``: disabling tests can be achieved by using the ``enable_apps`` / ``disable_apps`` options instead.
 
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
diff --git a/meson_options.txt b/meson_options.txt
index 7bd5ebc084..323a3901e1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -55,6 +55,6 @@ option('enable_stdatomic', type: 'boolean', value: false, description:
 option('enable_trace_fp', type: 'boolean', value: false, description:
        'enable fast path trace points.')
 option('tests', type: 'boolean', value: true, description:
-       'build unit tests')
+       '[Deprecated] Value unused. Add "tests" to disable_apps setting to disable the unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
        'use HPET timer in EAL')
-- 
2.55.0

