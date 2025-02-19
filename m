Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BDCC021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C14440F1A;
	Wed, 19 Feb 2025 11:58:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2168E40EE5
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739962716; x=1771498716;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q+xYc8IGoOgAzvC29fSbPcyTWqwgMTeEl18S9FfoZsc=;
 b=jSwdyY147N+qIBSG1JuHv0j1wRXS1cxZoMcCSOVtE5wxTMdnVP/T9CaN
 A+OBVJ8/KO2YqAerIWxNRCKufpCDbRkn86/L+KjdRJZgjcRjATqJSJ1A0
 pdD5d5I+zsgYNCvJjcwu7fUTTaprxVe16wDyWuOXJRBgkl+YVcSyBIRy3
 Xnhg8y1AB5O8RPjOZH2GW39j6iCDr+BmvyzOB+tPNFmMRcYdLnZBPyZyK
 h0WpscbLUIe2QOMrB8nVRFDAgpm4976Gub8H9qijwV7fg4O3RXLPnooLT
 LnJkbcDnlp4mKzutUPGv4H0bECDEew3XTNNKB7bNC9QPTYl0RwtGDWsNI A==;
X-CSE-ConnectionGUID: eISS8WDUQUyZD6PlwJNiFA==
X-CSE-MsgGUID: S6uylCRMSGe8mjWuNrZlcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44610027"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="44610027"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 02:58:35 -0800
X-CSE-ConnectionGUID: ZMkgRAL9Qeag1i0XDrsvQg==
X-CSE-MsgGUID: uwtjmc9jSBSmX0hmFOSuQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="145533572"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 19 Feb 2025 02:58:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v7 7/8] app: reduce app dependencies
Date: Wed, 19 Feb 2025 10:57:53 +0000
Message-ID: <a1b797efdea9aa80bb7b899f5c6c072b2434d2b9.1739962646.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739962645.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739962645.git.anatoly.burakov@intel.com>
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

Notes:
    v6 -> v7:
    - Fixed test-crypto-perf dependencies

 app/dumpcap/meson.build   | 2 +-
 app/graph/meson.build     | 2 +-
 app/pdump/meson.build     | 2 +-
 app/proc-info/meson.build | 2 +-
 app/test-fib/meson.build  | 2 +-
 app/test-sad/meson.build  | 2 +-
 app/test/meson.build      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

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

