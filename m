Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF2FC3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E782640B91;
	Mon, 31 Mar 2025 18:10:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id E3D1C40B8D
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437447; x=1774973447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3s/I7QUGE1fdScd20s/exUKDXKaHY1+lz5JDIfodIWY=;
 b=Yli6PL1KSrS8N3Ximo4MxSd2CRCV5x7Z8bB8Vbmevs51/wnVBjFgBDRU
 Lp2eiVdjoOuIN3L3LdgPoYGlVJs5SKhX4FdhwNRC8i0IO3xRE/OX9Mgk2
 oFfmQyQOGhNprjqvDXPh5jhvEBKCto+KnAGbkI5DEpaAxGS0oHk62OjY3
 TAMZti/GXZkO3PnBZr2GAkNAIbaY4v+3qKj18koddTd/uEkp4y7YHXmB9
 /GFETuJRjnjXPYigEry5kNfmN0fgjcLHidp77qNVCY7ohxivDrTd9C15s
 sCwhP0sokVOS7uMc1+DWyKH82UrHYmKk+kYZ/060QxT+7sRWT94SE4LEz Q==;
X-CSE-ConnectionGUID: MCKEuqGOQ9ebj/ppybhIxA==
X-CSE-MsgGUID: GvQ4ujwdR+euh4FByBSmDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125729"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125729"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:46 -0700
X-CSE-ConnectionGUID: aJPKRuAzTgi78qUKsemFKA==
X-CSE-MsgGUID: EqoX1xLuQG+yzOeU/1bA1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132776"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH 07/10] net/qede: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:57 +0100
Message-ID: <20250331161000.9886-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
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

