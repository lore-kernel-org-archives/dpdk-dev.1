Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D9CCA460
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD58C40693;
	Thu, 15 Oct 2026 16:21:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id CBAF2402E7
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074072; x=1823610072;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hX4KDwCtRXjxgB34YsBRF/u1wOlVI3iBwycQKUAOP1w=;
 b=EzV65yQEniJOQ0Dmvz2SENevX5VwPi3bnSSYmV8kuj40ohOD/gpGSxY6
 5CRpwCtwCBviYBTDtXLOkpAAxUe7q+a5FxrFpizYqd+lbgSz6rBYQ4J0n
 AORV3RZRCSWJBN9h4+2LHSuhq7gS4dDHkqwf2eYpi981sNBRtEp1TH/uC
 kyXN3BC+HyslyNIl8PKTsixxUrEHTZYgAO76lvPhCvf3PdBYMQ0ZcNyhU
 C6SRGXWo7+nyKzsgUAQeoqutSYRF2OE0gDn55vKw82Xn0bYSe7iemZ4J9
 Bd0bXrbxQe1ZUVnwyiJnn5JfzkeBI3xxjZ2DvtHMRlTHgysz6TKFPW9s6 g==;
X-CSE-ConnectionGUID: XgZSYIwSTT20OOvCqaAoYg==
X-CSE-MsgGUID: WCPRAglbS0qBARNaBp+UpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="845363"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="845363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:21:12 -0700
X-CSE-ConnectionGUID: YSVpmqRMSDOMKiBDVGDJPQ==
X-CSE-MsgGUID: Oh9wFHeZTyGui2tWJehVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1779226"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 07:21:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Liu <kevinx.liu@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
Date: Thu, 15 Oct 2026 15:21:04 +0100
Message-ID: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
References: 
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

Currently, the `ice_testpmd.c` file includes headers that are only
available to driver itself, but should not be available to applications,
including testpmd. Instead, testpmd should access them through public PMD
specific API.

The ice driver does not have one (even though it offers a testpmd file), so
add the public PMD-specific API header, move all function definitions
into that file, and get rid of driver-private includes in testpmd file.

Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/nics/ice.rst                |  3 +
 doc/guides/rel_notes/release_26_11.rst |  2 +
 drivers/net/intel/ice/ice_diagnose.c   |  1 +
 drivers/net/intel/ice/ice_ethdev.h     |  9 ---
 drivers/net/intel/ice/ice_testpmd.c    |  7 ++-
 drivers/net/intel/ice/meson.build      |  1 +
 drivers/net/intel/ice/rte_pmd_ice.h    | 76 ++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/intel/ice/rte_pmd_ice.h

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index ba598742c5..e4dd87649b 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -1021,6 +1021,9 @@ To start ``testpmd``, and add vlan 10 to port 0:
 Diagnostic Utilities
 --------------------
 
+The diagnostic dump functions are also available to applications through
+the public ``rte_pmd_ice.h`` header.
+
 Dump DDP Package
 ~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a4f44e5ebd..f3c820a72a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -118,6 +118,8 @@ New Features
     enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
   * Added support for getting and setting link (802.3x) flow control.
   * Added support for Tx rate limiting per queue.
+  * Made the existing diagnostic dump functions available through
+    the public ``rte_pmd_ice.h`` header.
 
 * **Updated Intel ixgbe driver.**
 
diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index 4946ace7ae..ecfcdf5559 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -13,6 +13,7 @@
 
 #include "ice_ethdev.h"
 #include "ice_rxtx.h"
+#include "rte_pmd_ice.h"
 
 #define ICE_BLK_MAX_COUNT          512
 #define ICE_BUFF_SEG_HEADER_FLAG   0x1
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8d5e17e2df..08c2b61519 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -821,15 +821,6 @@ ice_align_floor(int n)
 	((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC) || \
 	((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8))
 
-__rte_experimental
-int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size);
-
-__rte_experimental
-int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
-
-__rte_experimental
-int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
-
 int
 ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32_t node_teid);
 
diff --git a/drivers/net/intel/ice/ice_testpmd.c b/drivers/net/intel/ice/ice_testpmd.c
index 98c02d68c6..0c135d79a3 100644
--- a/drivers/net/intel/ice/ice_testpmd.c
+++ b/drivers/net/intel/ice/ice_testpmd.c
@@ -2,14 +2,17 @@
  * Copyright(c) 2022 Intel Corporation.
  */
 
-#include <stdlib.h>
+#include <errno.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_pmd_ice.h>
 
 #include <cmdline_parse_num.h>
 #include <cmdline_parse_string.h>
 
 #include "testpmd.h"
-#include "ice_ethdev.h"
 
 /* Fixed size for ICE ddp runtime configure */
 #define ICE_BUFF_SIZE	0x000c9000
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 322d9597d2..00077be30a 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -19,6 +19,7 @@ sources = files(
 )
 
 testpmd_sources = files('ice_testpmd.c')
+headers = files('rte_pmd_ice.h')
 
 deps += ['hash', 'net']
 
diff --git a/drivers/net/intel/ice/rte_pmd_ice.h b/drivers/net/intel/ice/rte_pmd_ice.h
new file mode 100644
index 0000000000..dccfdcd5f4
--- /dev/null
+++ b/drivers/net/intel/ice/rte_pmd_ice.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _RTE_PMD_ICE_H_
+#define _RTE_PMD_ICE_H_
+
+/**
+ * @file rte_pmd_ice.h
+ *
+ * ICE PMD specific diagnostic functions.
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#include <rte_compat.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Dump the runtime DDP package configuration.
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @param buff
+ *   Pointer to an allocated buffer. On success, it may be replaced by a
+ *   newly allocated buffer; the caller must free the resulting buffer.
+ * @param size
+ *   Input buffer size in bytes; receives the size of the dump on success.
+ * @return
+ *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non-ICE port,
+ *   or a negative error code on failure.
+ */
+__rte_experimental
+int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size);
+
+/**
+ * Dump the runtime switch configuration.
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @param buff
+ *   Pointer to a caller-allocated output buffer.
+ * @param size
+ *   Input buffer size in bytes; receives the size of the dump on success.
+ * @return
+ *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non-ICE port,
+ *   or a negative error code on failure.
+ */
+__rte_experimental
+int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
+
+/**
+ * Dump the Tx scheduling tree to a stream in DOT format.
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @param detail
+ *   Include node configuration parameters when true.
+ * @param stream
+ *   Output stream opened by the caller.
+ * @return
+ *   0 on success, -ENODEV for an invalid port, or -ENOTSUP for a non-ICE port.
+ */
+__rte_experimental
+int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_PMD_ICE_H_ */
-- 
2.52.0

