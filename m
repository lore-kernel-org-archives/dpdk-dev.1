Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0543C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:26:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBCAB40DF6;
	Mon,  7 Apr 2025 17:25:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5825840B9A
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039523; x=1775575523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3s/I7QUGE1fdScd20s/exUKDXKaHY1+lz5JDIfodIWY=;
 b=hRc56UC6rYAAN7xDhEoNgXEeVYZAfTVm0Nddjigq+MvEVb13bY4kPTX3
 knmofNF0np4o5LY9VVAgdjngWTkAraPqz31r7Wv16rn/GAb0mlOTbJDDh
 O+om0OPal17DyUnrElu67GhmKMhKqdvj1qZMViw+dpS1pJGJNE4XGjrG7
 xg8ph4bFHoV04m2VaoEarEb1JCC2GouhipbJNr0aw2lnflMNP+h0CqBCX
 lTOrTG5/XznW/X+Z9BTw5wN/KX4PVPil4Czl0DGnaaBJMQP7fYlln8s52
 aMh0l+kQNMwHYQkFq+PPe6kkiydkpSOIHCUeyK1t4rREMitdZ504td1n9 A==;
X-CSE-ConnectionGUID: ONJ6Q5OBT+SHeciBum1Kug==
X-CSE-MsgGUID: Dx3pfWhpQMurTgnA88F8xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809373"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:22 -0700
X-CSE-ConnectionGUID: r0t9s8KRRMqDQjrtPYeE7g==
X-CSE-MsgGUID: Sbe8aQUuSNS7XjrGIG6RYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125585"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 07/10] net/qede: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:06 +0100
Message-ID: <20250407152509.2203243-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250407152509.2203243-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250407152509.2203243-1-bruce.richardson@intel.com>
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

Use the base code build handling logic in the drivers/meson.build file,
rather than re-implementing it in the driver itself.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/qede/base/meson.build | 17 +++++------------
 drivers/net/qede/meson.build      |  1 -
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/qede/base/meson.build b/drivers/net/qede/base/meson.build
index 66251360bf..a6dad3ec7b 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
 
-sources = [
+base_sources = files(
         'bcm_osal.c',
         'ecore_cxt.c',
         'ecore_dcbx.c',
@@ -16,8 +16,7 @@ sources = [
         'ecore_spq.c',
         'ecore_sriov.c',
         'ecore_vf.c',
-]
-
+)
 
 if is_ms_compiler
         error_cflags = [
@@ -51,14 +50,8 @@ else
         ]
 endif
 
-c_args = cflags
 foreach flag: error_cflags
-        if cc.has_argument(flag)
-                c_args += flag
-        endif
+    if cc.has_argument(flag)
+        base_cflags += flag
+    endif
 endforeach
-
-base_lib = static_library('qede_base', sources,
-    dependencies: [static_rte_net, static_rte_bus_pci],
-    c_args: c_args)
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index 3783e24db7..e1b21d6ff5 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -8,7 +8,6 @@ if is_windows
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'qede_debug.c',
-- 
2.45.2

