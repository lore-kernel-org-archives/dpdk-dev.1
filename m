Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1CEEDF173
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 15:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0872A402C0;
	Fri, 13 Feb 2026 16:16:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 99004402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 16:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770995770; x=1802531770;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sWCiPy5dT2KjSwvI91hFMN4zNXmLF9Aqk9uwpWMgJSo=;
 b=QR9Lc4SEr2LM7JVs3z4qx99NKQGSClSIoS8P87fiWqFQElHFOtF3cyCK
 dQ30+NPIzj59mXcePG0X8e0KAD+zTPK1cIVXMGNZXvKW1V34rTlc8LzEb
 6uzrsbAkSjYlggFSK0KGWBH0+bbrSCPAP4rUXrrwz177MQMzKAOzxk6C5
 KAATATiZFCU2H7N+E3UnKptnRSDUfkfD3eE6trOs2iXovfsQtVwZvW+uC
 Opas9y1ekrQxsBIfGmoawvDzdAzAcDXgi9R0g4d29H56ApZwYPQeiSu2w
 ApjfGu7mmu2yt2cVj15X+JTJFdfPPyjFAIp9sXSnRIFWLc4QmX1psEPLV w==;
X-CSE-ConnectionGUID: YmP5pu2HR5uoDMV7uOGNEg==
X-CSE-MsgGUID: ZgFj23OGQfWu9Ah3bv5hJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76024447"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="76024447"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 07:16:08 -0800
X-CSE-ConnectionGUID: TFZuOQHkQSqzvxQCOBr6uA==
X-CSE-MsgGUID: 9/7fE6SlS7G/FIaRUkMAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="212969314"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 13 Feb 2026 07:16:07 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH] drivers: disable comma warnings selectively
Date: Fri, 13 Feb 2026 15:14:00 +0000
Message-ID: <20260213151559.656837-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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
NOTE: this builds cleanly for me on my system with most drivers enabled
and builds clean in the github CI. Hoping the other CIs will catch issues
with any other drivers that I haven't been able to test due to missing
deps on my system. If any issues show up in CI, will fix in V2.
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

