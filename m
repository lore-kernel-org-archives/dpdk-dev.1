Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949AE9A053
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E2D04065E;
	Thu, 19 Feb 2026 18:40:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 26D8D40654
 for <dev@dpdk.org>; Thu, 19 Feb 2026 18:40:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771522808; x=1803058808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zfMybrnH3fPeZxWMD+PqVV09tScLquc7xT+0c8wKfnw=;
 b=mdHD7mwPjx3nwjDPWmyLMP298GVOoFHbRoHkmK0s7Yp9HkfxzEReWH+n
 Xw2Gx/XDl2B0vVelbJtFeU4Q7bFhk2K5qu7Z+96LyL+SMUuLVenBzOxKh
 hNeqK5uaEY8eFQx0Mu9Gxv8LKxmUT/o97lN2Sbah9/juevZBUf3PKKPEG
 jC7v3yn2U9bkj1uRInuSCbKtW2dRsauk+bmjymR7R9zQYAd+Haj169Ueo
 7tCg5ZSiKOaUsQ7hsXzXiPNg8G0jORCAzjNepL2rgzWxNVeq4buFQdNR9
 3K3k/y/1MEewEw2c3s6spvSoXNDn4UrSPWAvsl2ngGrd4DJAKyIZvf/2c g==;
X-CSE-ConnectionGUID: zUONMBG1RU6xO2k6oKJNJQ==
X-CSE-MsgGUID: zgui+/8sSfiFupxOFEk0Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72518129"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="72518129"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 09:40:08 -0800
X-CSE-ConnectionGUID: t2e3YCuqRqa+alNwEQURNA==
X-CSE-MsgGUID: p2uTXr/kSaOyOU2UCsORNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="212803362"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2026 09:40:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 4/4] build/tests: add warning for missing NULL PMD
 dependency
Date: Thu, 19 Feb 2026 17:39:53 +0000
Message-ID: <20260219173953.2182757-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219173953.2182757-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260219173953.2182757-1-bruce.richardson@intel.com>
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

In developer builds, warn the user if they are building the unit tests
but don't have net_null enabled, since a number of suites and test cases
within suites depend on that to create dummy ethdev devices for testing.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/app/test/meson.build b/app/test/meson.build
index 31c966d97e..5dde50b181 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -218,6 +218,12 @@ source_file_ext_deps = {
     'test_pcapng.c': ['pcap'],
 }
 
+# the NULL ethdev is used by a number of tests, in some cases as an optional dependency.
+# for developer builds, warn user if its missing and we are building the tests.
+if not dpdk_conf.has('RTE_NET_NULL') and developer_mode
+    warning('For unit testing, the net/null PMD should be enabled in the build to enable tests that depend on it.')
+endif
+
 def_lib = get_option('default_library')
 foreach f, f_deps : source_file_deps
     has_deps = true
-- 
2.51.0

