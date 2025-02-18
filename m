Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE00C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C53A40677;
	Tue, 18 Feb 2025 12:16:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id E3F404060B
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877374; x=1771413374;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9sCNLEMekUBGWwK55xCnOpSBqLchTCEqShpl9p8dbjQ=;
 b=JCKtLcU+CTa+9s0ac6wYpOdV4ydpdZ1wtkAlNb9KtDXUGobz7fxc2TY9
 FvEX6w1jEnwSSoruYi1FagafM6Jq0vNWXIAqgOdmW5LTzjwZC6RWk6LBS
 e+dJSAneQSpqUq9QtBej4gYm8e69GhJclO0QPzUZmWLDPfS7tZLAu+V8z
 1GzeGEZyVt5NkMAffqOHnmHPOQVEBSptFXAXglhNye6J8ldFTldtVxeDR
 gMrGmrLfUoOQaIPsvW36i1E19DI0/qENEWSGU4uJ/QvKb/giGjngDhkf4
 TBnaHwoLRtO17kmO4dWB/wvorTC0DphpbSS0pFgpH1EbiEURWKfXdtSiA A==;
X-CSE-ConnectionGUID: 5FCvWHLoSvCqesWcnYnVAg==
X-CSE-MsgGUID: 10K/a4krQvGq6er406NFMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780869"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780869"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:16:13 -0800
X-CSE-ConnectionGUID: 1kq+CSVuRomSZdROEIIAOA==
X-CSE-MsgGUID: oBtA9gi6T3OybA10VO7yfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466400"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:16:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Brian Dooley <brian.dooley@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v6 7/8] app: reduce app dependencies
Date: Tue, 18 Feb 2025 11:15:33 +0000
Message-ID: <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739877265.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

Remove any unnecessary dependencies from the app dependency lists.
This will give each app a near-minimum set of required dependencies.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/dumpcap/meson.build          | 2 +-
 app/graph/meson.build            | 2 +-
 app/pdump/meson.build            | 2 +-
 app/proc-info/meson.build        | 2 +-
 app/test-crypto-perf/meson.build | 2 +-
 app/test-fib/meson.build         | 2 +-
 app/test-sad/meson.build         | 2 +-
 app/test/meson.build             | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/app/dumpcap/meson.build b/app/dumpcap/meson.build
index 69c016c780..6204cf051a 100644
--- a/app/dumpcap/meson.build
+++ b/app/dumpcap/meson.build
@@ -14,4 +14,4 @@ endif
 
 ext_deps += pcap_dep
 sources = files('main.c')
-deps += ['ethdev', 'pdump', 'pcapng', 'bpf']
+deps += ['pdump']
diff --git a/app/graph/meson.build b/app/graph/meson.build
index 344e4a418f..9c4cd080d9 100644
--- a/app/graph/meson.build
+++ b/app/graph/meson.build
@@ -9,7 +9,7 @@ if not build
     subdir_done()
 endif
 
-deps += ['graph', 'eal', 'lpm', 'ethdev', 'node', 'cmdline', 'net']
+deps += ['node', 'cmdline']
 sources = files(
         'cli.c',
         'conn.c',
diff --git a/app/pdump/meson.build b/app/pdump/meson.build
index a4c7dd44e7..f84f43be51 100644
--- a/app/pdump/meson.build
+++ b/app/pdump/meson.build
@@ -8,6 +8,6 @@ if is_windows
 endif
 
 sources = files('main.c')
-deps += ['ethdev', 'kvargs', 'pdump']
+deps += ['pdump']
 
 cflags += no_wvla_cflag
diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
index 51315f72a1..ee2a3f0317 100644
--- a/app/proc-info/meson.build
+++ b/app/proc-info/meson.build
@@ -8,7 +8,7 @@ if is_windows
 endif
 
 sources = files('main.c')
-deps += ['ethdev', 'security', 'eventdev']
+deps += ['security', 'eventdev']
 optional_deps += 'metrics'
 
 cflags += no_wvla_cflag
diff --git a/app/test-crypto-perf/meson.build b/app/test-crypto-perf/meson.build
index fb48d9ec29..f056431bf4 100644
--- a/app/test-crypto-perf/meson.build
+++ b/app/test-crypto-perf/meson.build
@@ -19,7 +19,7 @@ sources = files(
         'cperf_test_verify.c',
         'main.c',
 )
-deps += ['cryptodev', 'net', 'security']
+deps += ['cryptodev']
 optional_deps += 'crypto_scheduler'
 
 cflags += no_wvla_cflag
diff --git a/app/test-fib/meson.build b/app/test-fib/meson.build
index eb36772cf3..25e2ea1a1d 100644
--- a/app/test-fib/meson.build
+++ b/app/test-fib/meson.build
@@ -8,4 +8,4 @@ if is_windows
 endif
 
 sources = files('main.c')
-deps += ['fib', 'lpm', 'net']
+deps += ['fib', 'lpm']
diff --git a/app/test-sad/meson.build b/app/test-sad/meson.build
index a1cbcc71d6..cd81638819 100644
--- a/app/test-sad/meson.build
+++ b/app/test-sad/meson.build
@@ -8,6 +8,6 @@ if is_windows
 endif
 
 sources = files('main.c')
-deps += ['ipsec', 'net']
+deps += ['ipsec']
 
 cflags += no_wvla_cflag
diff --git a/app/test/meson.build b/app/test/meson.build
index eb0447e8c6..d480d39311 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -2,7 +2,7 @@
 # Copyright(c) 2017-2023 Intel Corporation
 
 # the main test files [test.c and commands.c] relies on these libraries
-deps += ['cmdline', 'ring', 'mempool', 'mbuf']
+deps += ['cmdline']
 sources += files('commands.c', 'test.c')
 
 # optional dependencies: some files may use these - and so we should link them in -
-- 
2.43.5

