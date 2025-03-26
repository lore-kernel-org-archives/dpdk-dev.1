Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C03C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 16:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6DC640693;
	Wed, 26 Mar 2025 17:05:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D4C314066A;
 Wed, 26 Mar 2025 17:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743005154; x=1774541154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cw1Y6GPz09FwWl27MJX/fHhErTKrq5CCxDjrOvUjphE=;
 b=madLi+3E02P9W0iToz3hbO4DTTSQvhCr81dojUqwcSrH4/vg0iq29Ek8
 qHPy9KakE0O0QiffQMWKbCv1HORMm9airkic5VoIn/ALI3sR8XMR+U3BG
 2HD4RXyakKGTniuNVWlnGTQDjrWaRpZCpYqi7M1EOrl9kdi7wK8cZyL1m
 fLuMrqnsDI6oeXfQeaVVlfdsSSFPiqnnRLhKgYvzV8mEToaxS/lXvK0zB
 s0tB5fyvIP7xh2xdNO762DClHCGUA3HJdL12y2voq8A1lEPutsv0bjvPd
 qMjwVfKiOuhJ08cM83YpK8rBkLQN+X9mACasbTDNN3jn2cnK/nnpixnwV g==;
X-CSE-ConnectionGUID: SSA3DlD/Rb2zrUSWHsQcVQ==
X-CSE-MsgGUID: /ucVR1ZuSCisU/ovwWcjNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54954985"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54954985"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 09:05:54 -0700
X-CSE-ConnectionGUID: bOeo8vt4RvaNSIpbig+xFQ==
X-CSE-MsgGUID: H+T7gbCYTa+HiqryW28f3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="125280773"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2025 09:05:51 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ian Stokes <ian.stokes@intel.com>, Jijiang Liu <jijiang.liu@intel.com>,
 Cunming Liang <cunming.liang@intel.com>, Heqing Zhu <heqing.zhu@intel.com>,
 Jing Chen <jing.d.chen@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 5/8] net/i40e/base: fix unused value warnings
Date: Wed, 26 Mar 2025 16:05:35 +0000
Message-ID: <20250326160539.1316499-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326160539.1316499-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250326160539.1316499-1-bruce.richardson@intel.com>
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

Fix warnings about unused values - parameters, variables, etc., and
remove the warning disable flags for them. Although modifying the
base-code files is not ideal, the changes required are minor, and only
affect two files from the imported base code.

Fixes: 8db9e2a1b232 ("i40e: base driver")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/base/i40e_nvm.c   |  2 +-
 drivers/net/intel/i40e/base/i40e_osdep.h |  4 ++--
 drivers/net/intel/i40e/base/i40e_type.h  | 14 +++++++++-----
 drivers/net/intel/i40e/base/meson.build  |  3 ---
 drivers/net/intel/i40e/i40e_ethdev.c     |  1 +
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/i40e/base/i40e_nvm.c b/drivers/net/intel/i40e/base/i40e_nvm.c
index 3e16a0d997..56dc4d9279 100644
--- a/drivers/net/intel/i40e/base/i40e_nvm.c
+++ b/drivers/net/intel/i40e/base/i40e_nvm.c
@@ -1743,7 +1743,7 @@ STATIC enum i40e_status_code i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
  **/
 STATIC enum i40e_status_code i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
 						    struct i40e_nvm_access *cmd,
-						    u8 *bytes, int *perrno)
+						    u8 *bytes, __rte_unused int *perrno)
 {
 	u32 aq_total_len;
 	u32 aq_desc_len;
diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
index c04f94732a..197f4678bf 100644
--- a/drivers/net/intel/i40e/base/i40e_osdep.h
+++ b/drivers/net/intel/i40e/base/i40e_osdep.h
@@ -184,8 +184,8 @@ struct __rte_packed_begin i40e_dma_mem {
 	const void *zone;
 } __rte_packed_end;
 
-#define i40e_allocate_dma_mem(h, m, unused, s, a) \
-			i40e_allocate_dma_mem_d(h, m, s, a)
+#define i40e_allocate_dma_mem(h, m, mt, s, a) \
+			i40e_allocate_dma_mem_d(h, m, mt, s, a)
 #define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
 
 struct __rte_packed_begin i40e_virt_mem {
diff --git a/drivers/net/intel/i40e/base/i40e_type.h b/drivers/net/intel/i40e/base/i40e_type.h
index 7cc746f82f..968e1982a6 100644
--- a/drivers/net/intel/i40e/base/i40e_type.h
+++ b/drivers/net/intel/i40e/base/i40e_type.h
@@ -14,11 +14,15 @@
 #include "i40e_devids.h"
 
 #define UNREFERENCED_XPARAMETER
-#define UNREFERENCED_1PARAMETER(_p) (_p);
-#define UNREFERENCED_2PARAMETER(_p, _q) (_p); (_q);
-#define UNREFERENCED_3PARAMETER(_p, _q, _r) (_p); (_q); (_r);
-#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s) (_p); (_q); (_r); (_s);
-#define UNREFERENCED_5PARAMETER(_p, _q, _r, _s, _t) (_p); (_q); (_r); (_s); (_t);
+#define UNREFERENCED_1PARAMETER(_p) (void)(_p)
+#define UNREFERENCED_2PARAMETER(_p, _q) \
+	do { (void)(_p); (void)(_q); } while (0)
+#define UNREFERENCED_3PARAMETER(_p, _q, _r) \
+	do { (void)(_p); (void)(_q); (void)(_r); } while (0)
+#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s) \
+	do { (void)(_p); (void)(_q); (void)(_r); (void)(_s); } while (0)
+#define UNREFERENCED_5PARAMETER(_p, _q, _r, _s, _t) \
+	do { (void)(_p); (void)(_q); (void)(_r); (void)(_s); (void)(_t); } while (0)
 
 #define BIT(a) (1UL << (a))
 #define BIT_ULL(a) (1ULL << (a))
diff --git a/drivers/net/intel/i40e/base/meson.build b/drivers/net/intel/i40e/base/meson.build
index a0912b1788..2648e5d0c4 100644
--- a/drivers/net/intel/i40e/base/meson.build
+++ b/drivers/net/intel/i40e/base/meson.build
@@ -13,10 +13,7 @@ sources = [
 
 error_cflags = [
         '-Wno-sign-compare',
-        '-Wno-unused-value',
         '-Wno-strict-aliasing',
-        '-Wno-unused-but-set-variable',
-        '-Wno-unused-parameter',
 ]
 c_args = cflags
 foreach flag: error_cflags
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 1c5ab35a8b..90eba3419f 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4694,6 +4694,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 enum i40e_status_code
 i40e_allocate_dma_mem_d(__rte_unused struct i40e_hw *hw,
 			struct i40e_dma_mem *mem,
+			__rte_unused enum i40e_memory_type mtype,
 			u64 size,
 			u32 alignment)
 {
-- 
2.45.2

