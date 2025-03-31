Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86CBC3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05E8540B95;
	Mon, 31 Mar 2025 18:10:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F412540B94
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437449; x=1774973449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PYtQC7bgcuwo06DNX7miP6FiwMRNaCDQzb2KC3lrUsI=;
 b=bYGphojKi4rIu9RJv4x7g3+gaV5Xlui4JuDYq9GqQEOAtiiw/Qwk9ftW
 xph7mq6iju32mBCzaRNeihV84lBe4BmUW6KeqFTmmsCOhjVGKgkFCjjHI
 IIYK73BR9/ThNvY0bgB6DL5peeiyknByNAG+mshvW2xV8oUDMJrmYMAvo
 k/KTTPVFj1V88ndZeWd54TukLjGOM97RJ1n2dpR1yr2kKQqvcKQo0FpEd
 XzPE/cvanvQoUIxyUK63hzAIZjc9OPxpolHBYQhyhLx7aA/Rjwiax5EJB
 T1L6H3ZVbKegzFKr73XGy/38GU6joNYGgy4cmRD8zC53yvApzBhV58n1k w==;
X-CSE-ConnectionGUID: ywLwjQG+TYaK0yEdda2coQ==
X-CSE-MsgGUID: 6go+m6THRGug8J89stDpsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125735"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:49 -0700
X-CSE-ConnectionGUID: LD6oxnb9R0KUj3B/5qKIWg==
X-CSE-MsgGUID: 9QpzhlRnSIGc0jhEgMptuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132781"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:47 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH 08/10] net/thunderx: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:58 +0100
Message-ID: <20250331161000.9886-10-bruce.richardson@intel.com>
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

