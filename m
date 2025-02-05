Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3F5C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 11:56:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0F5040659;
	Wed,  5 Feb 2025 12:55:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EB12F40657
 for <dev@dpdk.org>; Wed,  5 Feb 2025 12:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738756555; x=1770292555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oVuHUbJdBxIFfTvqtHjLsdRwG19XavEANKRb+UjGySw=;
 b=P0JoB38dTQa5P6DPS8yADwHmtC4Hnu7rFm6fuq8NRihuFwQebKuaHieB
 9D+XwwALoEl7jR1F5Eh9nwdHUL2G88tRETB8zuWJMYilV+grPm6jfeBzL
 TF5Nzdpnd9IjImWoeyOTz6oryZT1njLLERlNM86qJGBgAV4NpCdyqAnyO
 TR0cfs0UcPKDGnv4FWY4xee6UrpsqWuGzaL1uLRd19aBlRfDrYVwxtCaz
 eQy3sN1ODkxHYTbN3tugjCZdL8hssmm2+yUnNfNia/bnomTDQIjh0curF
 EgMkTbmEYXg+anV/eelW8apOpioghBu5171C87FJxZwBQPe68dGl5HuhT A==;
X-CSE-ConnectionGUID: BIFpKoHsQwaLZXbpRVegWw==
X-CSE-MsgGUID: 3qvX9QdTTpCq/8bozNIjmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49568742"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49568742"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 03:55:55 -0800
X-CSE-ConnectionGUID: En0/gjE9TF6OBVX4088EDA==
X-CSE-MsgGUID: 4CWbCPbwQpa/eV1btw5f0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141781739"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2025 03:55:53 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 4/4] net/intel: allow building ice driver without iavf
Date: Wed,  5 Feb 2025 11:55:31 +0000
Message-ID: <20250205115533.2746196-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205115533.2746196-1-bruce.richardson@intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250205115533.2746196-1-bruce.richardson@intel.com>
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

The ice PMD relies on a number of functions from the iavf base code,
which can be got by linking against that iavf driver. However, since
only three C files are necessary here, we can allow ice to be built
independently of iavf by including the base files directly in cases
where iavf is not part of the build. If it is part of the build, the
dependency remains as now.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/base/iavf_prototype.h |  8 ++++++++
 drivers/net/intel/ice/meson.build            | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/base/iavf_prototype.h b/drivers/net/intel/iavf/base/iavf_prototype.h
index 7c43a817bb..5d2ee0a785 100644
--- a/drivers/net/intel/iavf/base/iavf_prototype.h
+++ b/drivers/net/intel/iavf/base/iavf_prototype.h
@@ -11,6 +11,14 @@
 
 #include <rte_compat.h>
 
+/* functions only need exporting if this is being built into
+ * iavf driver itself. If included in ice driver, then no export
+ */
+#ifndef RTE_NET_IAVF
+#undef __rte_internal
+#define __rte_internal
+#endif
+
 /* Prototypes for shared code functions that are not in
  * the standard function pointer structures.  These are
  * mostly because they are needed even before the init
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 5faf887386..ff7f84597a 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -18,9 +18,20 @@ sources = files(
 
 testpmd_sources = files('ice_testpmd.c')
 
-deps += ['hash', 'net', 'net_iavf']
+deps += ['hash', 'net']
 includes += include_directories('base')
 
+if dpdk_conf.has('RTE_NET_IAVF')
+    deps += 'net_iavf'
+else
+    includes += include_directories('../iavf/base')
+    sources += files(
+            '../iavf/base/iavf_adminq.c',
+            '../iavf/base/iavf_common.c',
+            '../iavf/base/iavf_impl.c',
+    )
+endif
+
 if arch_subdir == 'x86'
     sources += files('ice_rxtx_vec_sse.c')
 
-- 
2.43.0

