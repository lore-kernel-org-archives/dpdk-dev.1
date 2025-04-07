Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9547C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:26:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EDB940DDD;
	Mon,  7 Apr 2025 17:25:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE3040BA2
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039523; x=1775575523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PYtQC7bgcuwo06DNX7miP6FiwMRNaCDQzb2KC3lrUsI=;
 b=flpBlXEtumDOV6uw7S0idzTFOfsWPrn1bDxXZDiyGvfbO70T1ezWvWkS
 0bjHAy+RMQj8itb1MabTXkehj6wiJ7y8LZXyvUaAQhwI5QwD/bPnPB7B0
 cG5sOpumUG+HDtv4xLJPYr9JcKzzhZ7gC1Oo2O6ybfBY/EABi5Ai5ba5o
 lvfuoA5C3CaE6okz6kvla5AupyjGFqkglUU5lW40R3bG+KIK0aEM7z4lE
 Nph6MfdkD0obv1nQmWrIeglDMFlyekODEEVKIPLuktHI8Fv9nxbXzXsyF
 wLLY65aFYRtVbXtwcgGKACFsZColJrcISR3zDlKTqjdLdsnUkx/3BUzMT A==;
X-CSE-ConnectionGUID: J4yeEHLHRC2wwACxmSEx4A==
X-CSE-MsgGUID: TRQ5aUzpToCQNu8+KuyJSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809375"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809375"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:23 -0700
X-CSE-ConnectionGUID: +c1mty33TfO67+ka5ZWkvw==
X-CSE-MsgGUID: Zox777K9Q/eGEy5Wzzd/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125588"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 08/10] net/thunderx: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:07 +0100
Message-ID: <20250407152509.2203243-9-bruce.richardson@intel.com>
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
 drivers/net/thunderx/base/meson.build | 10 +---------
 drivers/net/thunderx/meson.build      |  3 ---
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/thunderx/base/meson.build b/drivers/net/thunderx/base/meson.build
index cec45d0ae1..abf0b64e79 100644
--- a/drivers/net/thunderx/base/meson.build
+++ b/drivers/net/thunderx/base/meson.build
@@ -1,16 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Cavium, Inc
 
-sources = [
+base_sources = files(
         'nicvf_hw.c',
         'nicvf_mbox.c',
         'nicvf_bsvf.c',
-]
-
-c_args = cflags
-base_lib = static_library('nicvf_base', sources,
-    c_args: c_args,
-    dependencies: static_rte_ethdev
 )
-
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/thunderx/meson.build b/drivers/net/thunderx/meson.build
index da665bd76f..03262af8ca 100644
--- a/drivers/net/thunderx/meson.build
+++ b/drivers/net/thunderx/meson.build
@@ -8,7 +8,6 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'nicvf_ethdev.c',
@@ -23,5 +22,3 @@ endif
 if cc.has_argument('-Wno-maybe-uninitialized')
     cflags += '-Wno-maybe-uninitialized'
 endif
-
-includes += include_directories('base')
-- 
2.45.2

