Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F67E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 15:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1645402C6;
	Thu, 19 Feb 2026 16:23:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 067FA402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 16:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771514598; x=1803050598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=38S/Eu80GxbTNmbgCiM+EKpLnMb8pw/KVo/8YQnhi/E=;
 b=lN+A6Ty/zrxBSmYNKn/H0yd8+qMAQdh2FRwd/Rh8vds26X7hXJ8FNoNB
 IQulcSNQ95aUr3s8Kw9zRe+RRqdKtbIAP902OrYGlWIEsvq9X2zfZ1aB+
 qKKR6vG433BqCoIMNNr8NqeZVNiCa+sAm40ALxLam8UqytdUlm6CN+Zg4
 QE23PCaj23Qwxx8XXidmhcknOwfXgNngsmpfHTqvcxh6mY1QTchrD1IXl
 PY3bNuKr7GRsGzRHrY65LN/qhboTkYLg98bNUKooFiJ6QaarqY7pquK5z
 bT5fzzWt2UclvZ4yoEMxs33q7h7hdSWmfESRN4IIu8DpGkPN5KpTpI8s/ g==;
X-CSE-ConnectionGUID: aPaOfUfUTLGWqN7XqR3xmQ==
X-CSE-MsgGUID: SMHxTWJqRMCRxci5/J6FOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71806331"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="71806331"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 07:23:17 -0800
X-CSE-ConnectionGUID: q6TXYvVrTFmVZgfiZYrxMg==
X-CSE-MsgGUID: dOdS8Hg5StqbILT1jHei6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218679331"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 07:23:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v2] drivers: disable comma warnings selectively
Date: Thu, 19 Feb 2026 15:22:25 +0000
Message-ID: <20260219152302.2103018-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213151559.656837-1-bruce.richardson@intel.com>
References: <20260213151559.656837-1-bruce.richardson@intel.com>
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

Rather than disabling -Wcomma for all drivers, only disable it on a
case-by-case basis for drivers that need it disabled. Use a variable to
do so, to avoid issues with compilers like MSVC that don't support the
-Wno-comma flag.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V2: resubmit now that dependent patches have hit main
---
 config/meson.build                 | 6 ++++++
 drivers/meson.build                | 2 +-
 drivers/net/axgbe/meson.build      | 4 +++-
 drivers/net/bnxt/meson.build       | 1 +
 drivers/net/gve/meson.build        | 1 +
 drivers/raw/ifpga/base/meson.build | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/config/meson.build b/config/meson.build
index 02e2798cca..9ba7b9a338 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -367,6 +367,12 @@ if cc.has_argument('-Wno-shadow')
     no_shadow_cflag = '-Wno-shadow'
 endif
 
+# per-driver option to disable -Wcomma if supported by the compiler
+no_comma_cflag = []
+if cc.has_argument('-Wno-comma')
+    no_comma_cflag = '-Wno-comma'
+endif
+
 foreach arg: global_cflags
     if cc.has_argument(arg)
         add_project_arguments(arg, language: 'c')
diff --git a/drivers/meson.build b/drivers/meson.build
index 3fe3be48fb..6ae102e943 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -86,7 +86,7 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']
+warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
 foreach cflag:warning_disable_cflags
     if cc.has_argument(cflag)
         default_cflags += cflag
diff --git a/drivers/net/axgbe/meson.build b/drivers/net/axgbe/meson.build
index 5a14549317..1aa523a749 100644
--- a/drivers/net/axgbe/meson.build
+++ b/drivers/net/axgbe/meson.build
@@ -15,7 +15,9 @@ sources = files(
         'axgbe_rxtx.c',
 )
 
-cflags += ['-Wno-cast-qual', no_shadow_cflag]
+cflags += ['-Wno-cast-qual']
+cflags += no_shadow_cflag
+cflags += no_comma_cflag
 
 if arch_subdir == 'x86'
     sources += files('axgbe_rxtx_vec_sse.c')
diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index dc122fb3df..e13aa4e341 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -14,6 +14,7 @@ endif
 
 cflags += no_wvla_cflag
 cflags += no_shadow_cflag
+cflags += no_comma_cflag
 
 headers = files('rte_pmd_bnxt.h')
 cflags_options = [
diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
index add431c2bb..b5d67ee490 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -20,3 +20,4 @@ sources = files(
 includes += include_directories('base')
 
 cflags += no_wvla_cflag
+cflags += no_comma_cflag
diff --git a/drivers/raw/ifpga/base/meson.build b/drivers/raw/ifpga/base/meson.build
index efebff94e9..225bde052b 100644
--- a/drivers/raw/ifpga/base/meson.build
+++ b/drivers/raw/ifpga/base/meson.build
@@ -24,3 +24,4 @@ base_sources = files(
         'opae_at24_eeprom.c',
         'opae_eth_group.c',
 )
+base_cflags += no_comma_cflag
-- 
2.51.0

