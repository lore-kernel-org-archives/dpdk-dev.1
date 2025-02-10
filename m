Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DB2C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62115427BD;
	Mon, 10 Feb 2025 17:44:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 325F3427B0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739205880; x=1770741880;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oVuHUbJdBxIFfTvqtHjLsdRwG19XavEANKRb+UjGySw=;
 b=n8hCXAaCSY3184Z/lHSicx8NlKc8BE/+YuGEfBeNDiZ0AZrfDbwHP8Hf
 +6DsqaDEi3EAywN+Knc6zY50IBes3EFDe7FKQ3GQ7VLzSyA1r+jRECBTw
 aheD18gpnT+Gzi3CVSTjQYKIrddaskcf3GYYTT1T3lRa8JknNkSyP43RQ
 gj4p6ZDiXOzJDOYKmkd9aWNDTJniZRJJnQmKYtsA6RSkfBpWcGQYtNajv
 1IEU+ZLZR6UV59RKa2g2OU9eiDFKw+jGBxPdQ9d6AxRF0UJZ9RAiCbrPS
 GSvwltk3rvgs96etJSdqQ3b0dPEZvAyOqz4XYKf3c18gNv8de8uqfEtnX A==;
X-CSE-ConnectionGUID: vUwshwQ5Q1iSHTlmgAOwUg==
X-CSE-MsgGUID: ZDivG4OSS2y5GXNrsap2Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43453712"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="43453712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 08:44:39 -0800
X-CSE-ConnectionGUID: kEKl6sWNRp2OQVXZg2Iuwg==
X-CSE-MsgGUID: FRviNnkvTSSdeDrFqoJztA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="112753365"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa010.fm.intel.com with ESMTP; 10 Feb 2025 08:44:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 4/4] net/intel: allow building ice driver without iavf
Date: Mon, 10 Feb 2025 16:44:26 +0000
Message-ID: <20250210164427.1118265-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210164427.1118265-1-bruce.richardson@intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250210164427.1118265-1-bruce.richardson@intel.com>
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

