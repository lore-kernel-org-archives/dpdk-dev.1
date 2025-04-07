Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71339C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C829C40DDA;
	Mon,  7 Apr 2025 17:25:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 79D5340B9A
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039522; x=1775575522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2aFzzD0MwjTMciy0zhNLMsPHL7tIVso+r651WXf2QpM=;
 b=lBh/w/a/NWXIXyuPPTISqiajZ8e0jh8gJyGG/SvhkX7gVH45aVuGTBud
 GN79yjvAJjUjCBvf+TRdDYK2xv3ZFzIoyyYP6Fk0kkCXHPD0AKJOP8fQ7
 8TIzUYqav9YJBxt5HD45iYp2z7slipfUb9puVcKRNTa7NnPMhI1n5eoTm
 cOeve6Un4LU+4cz0/TcKKWYIZALpM45XfGRPNlToKNuvNFkDcro6MaF9c
 7DsK+G36D3U12dFr1e24/A0TM9+T67vMjGDwRPxGtLGXkSalMUEOYeDAt
 yx3NJjns2xeZEeCzdqNJ8V9GE0ttsdkkmduq9xsv2bK6g0J9xjlKiCgbH w==;
X-CSE-ConnectionGUID: Z4Mlng0rTpmXGhhzYo78gQ==
X-CSE-MsgGUID: eoObrmrCRxOTIpqG6UlW5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809372"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809372"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:21 -0700
X-CSE-ConnectionGUID: PMAMpVszT5uFQjwtM1XUCA==
X-CSE-MsgGUID: TVZPcohcQwC9/SHF+wVsfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125582"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 06/10] net/octeontx: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:05 +0100
Message-ID: <20250407152509.2203243-7-bruce.richardson@intel.com>
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
 drivers/net/octeontx/base/meson.build | 19 +------------------
 drivers/net/octeontx/meson.build      |  3 ---
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/net/octeontx/base/meson.build b/drivers/net/octeontx/base/meson.build
index 8e5e8c1b55..244466bd36 100644
--- a/drivers/net/octeontx/base/meson.build
+++ b/drivers/net/octeontx/base/meson.build
@@ -1,25 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Cavium, Inc
 
-sources = [
+base_sources = files(
         'octeontx_pkovf.c',
         'octeontx_pkivf.c',
         'octeontx_bgx.c',
-]
-
-depends = ['ethdev', 'mempool_octeontx']
-static_objs = []
-foreach d: depends
-    if not is_variable('shared_rte_' + d)
-        subdir_done()
-    endif
-    static_objs += get_variable('static_rte_' + d)
-endforeach
-
-c_args = cflags
-base_lib = static_library('octeontx_base', sources,
-    c_args: c_args,
-    dependencies: static_objs,
 )
-
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/octeontx/meson.build b/drivers/net/octeontx/meson.build
index 541d2d9d0b..fc8a5a73f2 100644
--- a/drivers/net/octeontx/meson.build
+++ b/drivers/net/octeontx/meson.build
@@ -8,7 +8,6 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'octeontx_ethdev.c',
@@ -18,6 +17,4 @@ sources = files(
 
 deps += ['mempool_octeontx', 'eventdev']
 
-includes += include_directories('base')
-
 cflags += no_wvla_cflag
-- 
2.45.2

