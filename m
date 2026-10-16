Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B3CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 604A64065A;
	Fri, 16 Oct 2026 13:00:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 25F7E40658
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148408; x=1823684408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bDO/peRwkN2jqnCbfr1VN/mjnrs26QDeaIjWAqLPGEU=;
 b=LIPJhhey7+sTS6jnUV3G7xsn/qcxO/JeXpgpkMz7u4XTXNZUJ8qpPaPX
 UpxC9YujUslwAXPySBQdxpcqE78bBszp7quNydPXBS451SpHjxcwtd9kJ
 GQ+0yG4gP2bw3IrCoBlkrcwE50z59cqX1bH4I21Baf674BvRPDJ1tiyHk
 L4+UlBEhpueBPtaB/piypEXHkpcE0MC9b6R+0TbX3uaYLM/O8uoLRUPpB
 9QvYkxpmqNWrzCaOIPEMtUj0Z0BWiA5HzhLD/K6KSG8cZiRlFcdcjG1VB
 3JdX/NR1znoITvHgwaYzYe9fc4TvZYHCQkZ18k/5ISjQFFUuiGUnp6uKB w==;
X-CSE-ConnectionGUID: vEXm5WF5Q12GpMnfL6LNxA==
X-CSE-MsgGUID: nMoQzX2LRWyyUtXVwym4bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944134"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944134"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:07 -0700
X-CSE-ConnectionGUID: g+/MOC1BSrOPd/lwEnhEvA==
X-CSE-MsgGUID: iWGe46KRSz+4cc5YTsdBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759383"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 05/12] net/bond: rename directory for consistency
Date: Fri, 16 Oct 2026 11:59:43 +0100
Message-ID: <20261016105950.273068-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

All libraries and drivers in DPDK have the directory name match the
resulting .so library name, with the exception of "net/bonding" which is
internally renamed to "net/bond". The shorter name is used for the .so
object and for dependency tracking in other DPDK components. Remove the
inconsistency by renaming the directory from "bonding" to "bond",
thereby removing the need for any tooling to take account of the fact
that directory names may not be the same as object or dependency names.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS                                              | 2 +-
 doc/api/doxy-api.conf.in                                 | 2 +-
 doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst | 2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst              | 2 +-
 drivers/meson.build                                      | 1 +
 drivers/net/{bonding => bond}/bonding_testpmd.c          | 0
 drivers/net/{bonding => bond}/eth_bond_8023ad_private.h  | 0
 drivers/net/{bonding => bond}/eth_bond_private.h         | 0
 drivers/net/{bonding => bond}/meson.build                | 1 -
 drivers/net/{bonding => bond}/rte_eth_bond.h             | 0
 drivers/net/{bonding => bond}/rte_eth_bond_8023ad.c      | 0
 drivers/net/{bonding => bond}/rte_eth_bond_8023ad.h      | 0
 drivers/net/{bonding => bond}/rte_eth_bond_alb.c         | 0
 drivers/net/{bonding => bond}/rte_eth_bond_alb.h         | 0
 drivers/net/{bonding => bond}/rte_eth_bond_api.c         | 0
 drivers/net/{bonding => bond}/rte_eth_bond_args.c        | 0
 drivers/net/{bonding => bond}/rte_eth_bond_flow.c        | 0
 drivers/net/{bonding => bond}/rte_eth_bond_pmd.c         | 0
 drivers/net/meson.build                                  | 2 +-
 19 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/net/{bonding => bond}/bonding_testpmd.c (100%)
 rename drivers/net/{bonding => bond}/eth_bond_8023ad_private.h (100%)
 rename drivers/net/{bonding => bond}/eth_bond_private.h (100%)
 rename drivers/net/{bonding => bond}/meson.build (95%)
 rename drivers/net/{bonding => bond}/rte_eth_bond.h (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.h (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_alb.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_alb.h (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_api.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_args.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_flow.c (100%)
 rename drivers/net/{bonding => bond}/rte_eth_bond_pmd.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 482bc7df76..02a06d9506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,7 +671,7 @@ F: doc/guides/nics/features/default.ini
 Link bonding
 M: Chas Williams <chas3@att.com>
 M: Min Hu (Connor) <humin29@huawei.com>
-F: drivers/net/bonding/
+F: drivers/net/bond/
 F: doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
 F: app/test/test_link_bonding*
 F: examples/bond/
diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index 94096ee710..f8b80e1110 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -15,7 +15,7 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/drivers/mempool/dpaa2 \
                           @TOPDIR@/drivers/net/ark \
                           @TOPDIR@/drivers/net/bnxt \
-                          @TOPDIR@/drivers/net/bonding \
+                          @TOPDIR@/drivers/net/bond \
                           @TOPDIR@/drivers/net/cnxk \
                           @TOPDIR@/drivers/net/dpaa \
                           @TOPDIR@/drivers/net/dpaa2 \
diff --git a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
index 2fa1ac4028..469a8f1d9e 100644
--- a/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
+++ b/doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
@@ -29,7 +29,7 @@ bonding device and its member devices.
 
     The Link Bonding PMD Library is enabled by default in the build
     configuration, the library can be disabled using the meson option
-    "-Ddisable_drivers=net/bonding".
+    "-Ddisable_drivers=net/bond".
 
 
 Link Bonding Modes Overview
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 30cac0ad8c..72c4f5bec7 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -5738,6 +5738,6 @@ Driver specific commands
 Some drivers provide specific features.
 See:
 
-- :ref:`net/bonding testpmd driver specific commands <bonding_testpmd_commands>`
+- :ref:`net/bond testpmd driver specific commands <bonding_testpmd_commands>`
 - :ref:`net/i40e testpmd driver specific commands <i40e_testpmd_commands>`
 - :ref:`net/ixgbe testpmd driver specific commands <ixgbe_testpmd_commands>`
diff --git a/drivers/meson.build b/drivers/meson.build
index e75fa983e2..cb71bc8231 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -35,6 +35,7 @@ endif
 
 # map legacy driver names
 driver_map = {
+    'net/bonding': 'net/bond',
     'net/cpfl': 'net/intel/cpfl',
     'net/e1000': 'net/intel/e1000',
     'net/fm10k': 'net/intel/fm10k',
diff --git a/drivers/net/bonding/bonding_testpmd.c b/drivers/net/bond/bonding_testpmd.c
similarity index 100%
rename from drivers/net/bonding/bonding_testpmd.c
rename to drivers/net/bond/bonding_testpmd.c
diff --git a/drivers/net/bonding/eth_bond_8023ad_private.h b/drivers/net/bond/eth_bond_8023ad_private.h
similarity index 100%
rename from drivers/net/bonding/eth_bond_8023ad_private.h
rename to drivers/net/bond/eth_bond_8023ad_private.h
diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bond/eth_bond_private.h
similarity index 100%
rename from drivers/net/bonding/eth_bond_private.h
rename to drivers/net/bond/eth_bond_private.h
diff --git a/drivers/net/bonding/meson.build b/drivers/net/bond/meson.build
similarity index 95%
rename from drivers/net/bonding/meson.build
rename to drivers/net/bond/meson.build
index 14304b68a8..bf73ce2e57 100644
--- a/drivers/net/bonding/meson.build
+++ b/drivers/net/bond/meson.build
@@ -7,7 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-name = 'bond' #, james bond :-)
 sources = files(
         'rte_eth_bond_8023ad.c',
         'rte_eth_bond_alb.c',
diff --git a/drivers/net/bonding/rte_eth_bond.h b/drivers/net/bond/rte_eth_bond.h
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond.h
rename to drivers/net/bond/rte_eth_bond.h
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bond/rte_eth_bond_8023ad.c
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_8023ad.c
rename to drivers/net/bond/rte_eth_bond_8023ad.c
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.h b/drivers/net/bond/rte_eth_bond_8023ad.h
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_8023ad.h
rename to drivers/net/bond/rte_eth_bond_8023ad.h
diff --git a/drivers/net/bonding/rte_eth_bond_alb.c b/drivers/net/bond/rte_eth_bond_alb.c
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_alb.c
rename to drivers/net/bond/rte_eth_bond_alb.c
diff --git a/drivers/net/bonding/rte_eth_bond_alb.h b/drivers/net/bond/rte_eth_bond_alb.h
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_alb.h
rename to drivers/net/bond/rte_eth_bond_alb.h
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bond/rte_eth_bond_api.c
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_api.c
rename to drivers/net/bond/rte_eth_bond_api.c
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bond/rte_eth_bond_args.c
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_args.c
rename to drivers/net/bond/rte_eth_bond_args.c
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bond/rte_eth_bond_flow.c
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_flow.c
rename to drivers/net/bond/rte_eth_bond_flow.c
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bond/rte_eth_bond_pmd.c
similarity index 100%
rename from drivers/net/bonding/rte_eth_bond_pmd.c
rename to drivers/net/bond/rte_eth_bond_pmd.c
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 4e8ccb945f..0de3e30cf2 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -11,7 +11,7 @@ drivers = [
         'axgbe',
         'bnx2x',
         'bnxt',
-        'bonding',
+        'bond',
         'cnxk',
         'cxgbe',
         'dpaa',
-- 
2.53.0

