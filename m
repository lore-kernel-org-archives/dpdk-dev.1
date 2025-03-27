Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CBAC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55A2D40E21;
	Thu, 27 Mar 2025 15:52:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4FCCA402E6;
 Thu, 27 Mar 2025 15:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087135; x=1774623135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y11MYByd+SplhH7nNI48kZloiueLmXAh0c7Py9Lt82g=;
 b=N66AtlDLdRj1/cPN/iKGcQIYo27/bsFJL6HPKDO36YBs6pLj2rV2lIhB
 F4T8kUmZ8n0eHV1EJPIFaq8DWrMLx3pGKTKh3Rh3jnPur1I+DOkE5O7Yu
 2vu6+srC48qMzOFonW26UFp/tC9LekNQH2Q7jAnUAbxPaO8hnhEXGXNIA
 ZYMQ1Gug3Ks6AsQpswRRynvFpDWbu0vbXL57zbzIqhKwE0mJxN48SYfpW
 HfyzbXKSHNjnx+D5Am0jD/C7aHEOVf9t8xXe/lybiRNmsaHn4/xisc5Jw
 4An7ZK10xYp5JaVHrVqYfqVRU6QZ+187od6y0P6tpYthONHjZbKRMPV3i A==;
X-CSE-ConnectionGUID: 5CnTNhu4QSe+zeMoY6heKw==
X-CSE-MsgGUID: 9wiHXC8eQo+P+0ejokHc+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207062"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207062"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:14 -0700
X-CSE-ConnectionGUID: bRI0fzI9Rk6y2KX+BIOtbA==
X-CSE-MsgGUID: vElGzqYMSoeFT9p7JnbLfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400003"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Jing Chen <jing.d.chen@intel.com>
Subject: [PATCH v3 1/9] net/fm10k/base: fix compilation warnings
Date: Thu, 27 Mar 2025 14:51:53 +0000
Message-ID: <20250327145202.2220153-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
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

The fixes required to re-enable warnings in the fm10k base code are
trivial, so let's make the changes and get a clean compile without any
warning disable flags.

* provide definitions for the UNREFERENCED_PARAMETER macros
* fix the spelling of the work "fallthrough" in comments
* provide a definition of FM10K_READ_PCI_WORD in os_dep.h that marks the
  parameters as used.

Fixes: 7223d200c227 ("fm10k: add base driver")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/fm10k/base/fm10k_mbx.c   |  2 +-
 drivers/net/intel/fm10k/base/fm10k_osdep.h |  2 +-
 drivers/net/intel/fm10k/base/fm10k_pf.c    |  8 ++++----
 drivers/net/intel/fm10k/base/fm10k_type.h  |  6 +++---
 drivers/net/intel/fm10k/base/meson.build   | 14 +-------------
 5 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/fm10k/base/fm10k_mbx.c b/drivers/net/intel/fm10k/base/fm10k_mbx.c
index 2bb0d82efe..9028403757 100644
--- a/drivers/net/intel/fm10k/base/fm10k_mbx.c
+++ b/drivers/net/intel/fm10k/base/fm10k_mbx.c
@@ -1602,7 +1602,7 @@ s32 fm10k_pfvf_mbx_init(struct fm10k_hw *hw, struct fm10k_mbx_info *mbx,
 			mbx->mbmem_reg = FM10K_MBMEM_VF(id, 0);
 			break;
 		}
-		/* fallthough */
+		/* fallthrough */
 	default:
 		return FM10K_MBX_ERR_NO_MBX;
 	}
diff --git a/drivers/net/intel/fm10k/base/fm10k_osdep.h b/drivers/net/intel/fm10k/base/fm10k_osdep.h
index a727a57481..5f8ff10474 100644
--- a/drivers/net/intel/fm10k/base/fm10k_osdep.h
+++ b/drivers/net/intel/fm10k/base/fm10k_osdep.h
@@ -67,7 +67,7 @@ typedef uint64_t   u64;
 #define FM10K_PCI_REG_WRITE(reg, value) rte_write32((value), (reg))
 
 /* not implemented */
-#define FM10K_READ_PCI_WORD(hw, reg)     0
+#define FM10K_READ_PCI_WORD(hw, reg)     ((void)hw, (void)reg, 0)
 
 #define FM10K_WRITE_MBX(hw, reg, value) FM10K_WRITE_REG(hw, reg, value)
 #define FM10K_READ_MBX(hw, reg) FM10K_READ_REG(hw, reg)
diff --git a/drivers/net/intel/fm10k/base/fm10k_pf.c b/drivers/net/intel/fm10k/base/fm10k_pf.c
index 439dd224de..b54116a4b5 100644
--- a/drivers/net/intel/fm10k/base/fm10k_pf.c
+++ b/drivers/net/intel/fm10k/base/fm10k_pf.c
@@ -1362,19 +1362,19 @@ STATIC u8 fm10k_iov_supported_xcast_mode_pf(struct fm10k_vf_info *vf_info,
 	case FM10K_XCAST_MODE_PROMISC:
 		if (vf_flags & FM10K_VF_FLAG_PROMISC_CAPABLE)
 			return FM10K_XCAST_MODE_PROMISC;
-		/* fallthough */
+		/* fallthrough */
 	case FM10K_XCAST_MODE_ALLMULTI:
 		if (vf_flags & FM10K_VF_FLAG_ALLMULTI_CAPABLE)
 			return FM10K_XCAST_MODE_ALLMULTI;
-		/* fallthough */
+		/* fallthrough */
 	case FM10K_XCAST_MODE_MULTI:
 		if (vf_flags & FM10K_VF_FLAG_MULTI_CAPABLE)
 			return FM10K_XCAST_MODE_MULTI;
-		/* fallthough */
+		/* fallthrough */
 	case FM10K_XCAST_MODE_NONE:
 		if (vf_flags & FM10K_VF_FLAG_NONE_CAPABLE)
 			return FM10K_XCAST_MODE_NONE;
-		/* fallthough */
+		/* fallthrough */
 	default:
 		break;
 	}
diff --git a/drivers/net/intel/fm10k/base/fm10k_type.h b/drivers/net/intel/fm10k/base/fm10k_type.h
index 84781ba9b2..437fb1c55e 100644
--- a/drivers/net/intel/fm10k/base/fm10k_type.h
+++ b/drivers/net/intel/fm10k/base/fm10k_type.h
@@ -83,9 +83,9 @@ struct fm10k_hw;
 #define FM10K_NOT_IMPLEMENTED			0x7FFFFFFF
 
 #define UNREFERENCED_XPARAMETER
-#define UNREFERENCED_1PARAMETER(_p) (_p)
-#define UNREFERENCED_2PARAMETER(_p, _q)	    do { (_p); (_q); } while (0)
-#define UNREFERENCED_3PARAMETER(_p, _q, _r) do { (_p); (_q); (_r); } while (0)
+#define UNREFERENCED_1PARAMETER(_p) (void)(_p)
+#define UNREFERENCED_2PARAMETER(_p, _q)	    do { (void)(_p); (void)(_q); } while (0)
+#define UNREFERENCED_3PARAMETER(_p, _q, _r) do { (void)(_p); (void)(_q); (void)(_r); } while (0)
 
 /* Start of PF registers */
 #define FM10K_CTRL		0x0000
diff --git a/drivers/net/intel/fm10k/base/meson.build b/drivers/net/intel/fm10k/base/meson.build
index f24e453fd0..a2640d1ee8 100644
--- a/drivers/net/intel/fm10k/base/meson.build
+++ b/drivers/net/intel/fm10k/base/meson.build
@@ -10,19 +10,7 @@ sources = [
         'fm10k_vf.c',
 ]
 
-error_cflags = [
-        '-Wno-unused-parameter',
-        '-Wno-unused-value',
-        '-Wno-implicit-fallthrough',
-]
-c_args = cflags
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        c_args += flag
-    endif
-endforeach
-
 base_lib = static_library('fm10k_base', sources,
     dependencies: static_rte_eal,
-    c_args: c_args)
+    c_args: cflags)
 base_objs = base_lib.extract_all_objects(recursive: true)
-- 
2.45.2

