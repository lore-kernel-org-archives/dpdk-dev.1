Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE76BC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32A4640E64;
	Thu, 27 Mar 2025 15:52:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9940340E35;
 Thu, 27 Mar 2025 15:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087145; x=1774623145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cw1Y6GPz09FwWl27MJX/fHhErTKrq5CCxDjrOvUjphE=;
 b=nlAaLn0xZKO4CY8jHecddkjEOsTNnPIh/pq4L18yWuUF4gtviyKPpw5g
 i9B9o3USyZjDdpKlRCPwXeM3U4r4KCgKLd7GQM3KX76C9JwWbpXpLvBi2
 aGyvoM5xbuK1tEFyeYfLWebuFihWTL7rnEY4ZQeqM5rk67UVgWbVwbeD/
 LcFXYsfEvDO2dL3YJ0j+oh0giZkTO1ddhu6jZbl96qselFReInfxMYfCd
 urkqBbwv66DzDMIPi15u7KCLzb+zQQHssIBB6AeEWBqchMQSZEWpk3Tr8
 C7KYNFk0n6tzQbNYrfiGX5GvzDlE4cu8jOgI27DBgDwkjkBmd+93s6KOs A==;
X-CSE-ConnectionGUID: gH3QPlWLTqGAm9iIv37f2g==
X-CSE-MsgGUID: q2vHQIf+QFWsIizmEhuFpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207078"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207078"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:25 -0700
X-CSE-ConnectionGUID: ycX9O6q7QNy/U7WndFcxeg==
X-CSE-MsgGUID: YjFIkngVQ6W03u5953MMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400035"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ian Stokes <ian.stokes@intel.com>, Heqing Zhu <heqing.zhu@intel.com>,
 Jijiang Liu <jijiang.liu@intel.com>, Helin Zhang <helin.zhang@intel.com>,
 Jing Chen <jing.d.chen@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v3 6/9] net/i40e/base: fix unused value warnings
Date: Thu, 27 Mar 2025 14:51:58 +0000
Message-ID: <20250327145202.2220153-7-bruce.richardson@intel.com>
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

