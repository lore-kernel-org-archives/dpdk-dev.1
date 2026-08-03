Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C8C55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89DAC40DDA;
	Mon,  3 Aug 2026 18:53:36 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 355A340A8B
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:29 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so3040985b3a.3
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776009;
 x=1786380809; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i+xFhmUs5SpIt4Sew+WP/6Wew+zrNbdwMCCF+NNSM0I=;
 b=AYckBQEsBhBa6ipZvo8WIuytOQ/V4T7jfn9D6H9QbhxwhxJ6ZPBOQGOSpY9uOkcDo+
 XeXzS/lCApfGccn3JUpprmkUnvhOCjAI0VAvbM8+I/CEqKhSUdaqth6XPT7tMeSziI7m
 rKH3KvuQN4JLsUDiFjkVSRFSya6Q9TiTj7W9sUtNyQw21ppaYUdYii9j5xR20gDu+L4c
 JzLbrwQ5aR03ctwwfkPjNNePClC+ygawvUkQMRoavXdrky7z4dq8SQ5ec8ZFVyvO7s7R
 51pPKK4bDN1xHg+EHNdeOk1FtcKAWn/npSUQfAVO0hzzpnEKLrMFMS7sgolTye+FlTwW
 my6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776009; x=1786380809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i+xFhmUs5SpIt4Sew+WP/6Wew+zrNbdwMCCF+NNSM0I=;
 b=OYhDMCbXvUhq6D7QGB/sP+Rx3rCHHnrzrvq0+q9KOK/akfTfw4yCVbWCDKYMD7ncaB
 0K/NdMgqqE9a13Qu0z5eDPLxUXK6Y1+6dZT/9SpZaDZ0ENqbZsmWfGmtwuJZGSZV6m/d
 iMbBrcjRv9hgoakzMOuRzqIMaARy8En63ZPZ2+TXhX1go3ytQ2glrYaEKntBxoKKvP/Q
 Nn+GwJVEeQ1lhO5EpbxA+9YzNC4Aq9IFwF7ILmlf9NTOSJV9rN3xT3MJlwgGch1txZXI
 FxVE6iBAbYHcUq2e8jWqXtGu+bhT20v/je2wWrea2qh6pULRVFG6+ctiB9dyeID5uGL3
 73gA==
X-Gm-Message-State: AOJu0Ywtm+f6gdn06ArWMlYvgF3azqBAnZGBJ3mcFlU22Tf5FXKgVKew
 UeqR3leBdLZzbafoRel0Ax93CusK+8K0uYNAXJFyp9caXNLnRFAFDViUqzR1jvGPv2OJSnF/5Ih
 r16S9
X-Gm-Gg: AR+sD11KeiRAPaIm3qZPeOytMDkU3IsrRx+wGB7ZjSkDYofdJwzB7uco2k4iDQ7zGK/
 xa8Pck1mk2ziaQl3PPgHCv24e67KZN14ZDTzab1P41qUpLedefIKnk0ZlOMxg+64KLhchK1x4yB
 qImLjpSgD7KAtLySJe3bZiuhPWhbVJV2Y5+ciZmsrZ6TrCN7MOau3/ROuuby6MXTjV+JVcM2HnN
 npZeiK3h0bQcJ27FlluOSYMNYRffOWG/EuIS9iJVDOEYIpN0yfZtT4h+pJkBZwW7vpjHIxP9Lcp
 CoxjcwflTlmJslEbtc+B3JajLwJn+aUtCjELjKzgwPcY6ZDrW0C9Qf1N+o8vFo58GNNwBsBwAPN
 GxUAsSsaGhYHLu0s8q8spZnqd/QIQOInL9i4o4EVvVkw3H+ED2ZwZ6TudO68oJ5OqTYeEYRKsWD
 j91hSJZbo1NsKMRb7dPs1Wwv1i03ftDwawRJiWYs9hOohznXFqecUT58Q8AybGNPXxfwTG6Pz7w
 8GhYa/4EQI5W6CXCIIqkTBE3S4=
X-Received: by 2002:a05:6a21:9985:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3c92a750892mr10866221637.26.1785776009069; 
 Mon, 03 Aug 2026 09:53:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Rosen Xu <rosen.xu@altera.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 21/22] ethdev, drivers: isolate flow director
Date: Mon,  3 Aug 2026 09:52:07 -0700
Message-ID: <20260803165304.289869-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

There are leftover bits of legacy flow director that are
still being used by drivers. Move the definitions contained
in ethdev_driver.h and rte_eth_ctrl.h into a single file
ethdev_fdir.h and only include it in the drivers that
require it.

Change rte_ethdev.h to include the headers required
which it was previously getting from rte_eth_ctrl.h -> rte_flow.h.

Since ethdev_fdir.h is internal for driver SDK only
it does not have to include as many secondary headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/api/doxy-api-index.md                     |  1 -
 drivers/net/hinic/hinic_pmd_ethdev.h          |  2 +
 drivers/net/hinic3/hinic3_ethdev.h            |  1 +
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |  2 +-
 drivers/net/intel/e1000/e1000_ethdev.h        |  1 +
 drivers/net/intel/e1000/igc_filter.h          |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |  1 +
 drivers/net/intel/iavf/iavf_fsub.c            |  2 +-
 drivers/net/intel/iavf/iavf_hash.c            |  2 +-
 drivers/net/intel/ice/ice_acl_filter.c        |  2 +-
 drivers/net/intel/ice/ice_ethdev.h            |  2 +
 drivers/net/intel/ice/ice_generic_flow.c      |  1 +
 drivers/net/intel/ice/ice_hash.c              |  2 +-
 drivers/net/intel/ice/ice_switch_filter.c     |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  1 +
 drivers/net/txgbe/txgbe_ethdev.h              |  1 +
 lib/ethdev/ethdev_driver.h                    | 36 ------------
 lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h}  | 58 ++++++++++++++-----
 lib/ethdev/meson.build                        |  2 +-
 lib/ethdev/rte_ethdev.h                       | 13 +----
 22 files changed, 67 insertions(+), 70 deletions(-)
 rename lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h} (91%)

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..ac8314e908 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -11,7 +11,6 @@ The public API headers are grouped by topics:
 - **device**:
   [dev](@ref rte_dev.h),
   [ethdev](@ref rte_ethdev.h),
-  [ethctrl](@ref rte_eth_ctrl.h),
   [rte_flow](@ref rte_flow.h),
   [rte_tm](@ref rte_tm.h),
   [rte_mtr](@ref rte_mtr.h),
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.h b/drivers/net/hinic/hinic_pmd_ethdev.h
index 8e6251f69f..10285ce814 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.h
+++ b/drivers/net/hinic/hinic_pmd_ethdev.h
@@ -7,7 +7,9 @@
 
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
+#include <rte_flow.h>
 #include <ethdev_driver.h>
+#include <ethdev_fdir.h>
 
 #include "base/hinic_compat.h"
 #include "base/hinic_pmd_cfg.h"
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index 9061e2b217..515ba044a1 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -7,6 +7,7 @@
 
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
+#include <ethdev_fdir.h>
 
 #include "hinic3_fdir.h"
 
diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
index f42156e28f..977036bec5 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -16,7 +16,7 @@
 #include <rte_ether.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 #include <rte_tailq.h>
 #include <rte_flow_driver.h>
 #include <rte_flow.h>
diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 0907c7c259..da4dacc7d4 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -9,6 +9,7 @@
 #include <sys/queue.h>
 
 #include <rte_flow.h>
+#include <ethdev_fdir.h>
 #include <rte_time.h>
 #include <rte_pci.h>
 
diff --git a/drivers/net/intel/e1000/igc_filter.h b/drivers/net/intel/e1000/igc_filter.h
index 2b7e6b619a..d1e098e5bb 100644
--- a/drivers/net/intel/e1000/igc_filter.h
+++ b/drivers/net/intel/e1000/igc_filter.h
@@ -8,7 +8,7 @@
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
 #include <ethdev_driver.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 
 #include "igc_ethdev.h"
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3968bfd267..c03eaab946 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -13,6 +13,7 @@
 #include <rte_hash.h>
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
+#include <ethdev_fdir.h>
 #include <rte_tm_driver.h>
 #include "rte_pmd_i40e.h"
 #include <rte_vect.h>
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 19ae0e2dc2..745089c1e4 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -14,7 +14,7 @@
 #include <rte_ethdev.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 #include <rte_tailq.h>
 #include <rte_flow_driver.h>
 #include <rte_flow.h>
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 9515094402..38526eb7e6 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -15,7 +15,7 @@
 #include <ethdev_driver.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 #include <rte_tailq.h>
 #include <rte_flow_driver.h>
 
diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 30ff1254c9..08f44e26cf 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -13,9 +13,9 @@
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
+#include <ethdev_fdir.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
 #include <rte_tailq.h>
 #include <rte_flow_driver.h>
 #include <rte_flow.h>
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..fe0dc19c98 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -8,8 +8,10 @@
 #include <rte_compat.h>
 #include <rte_kvargs.h>
 #include <rte_time.h>
+#include <rte_flow.h>
 
 #include <ethdev_driver.h>
+#include <ethdev_fdir.h>
 #include <rte_tm_driver.h>
 #include <rte_vect.h>
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 76b3800545..9c81c3aea8 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -13,6 +13,7 @@
 
 #include <rte_ether.h>
 #include <ethdev_driver.h>
+#include <ethdev_fdir.h>
 #include <rte_hexdump.h>
 #include <rte_malloc.h>
 #include <rte_tailq.h>
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 7a9a4f1a04..5158a4f886 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -16,7 +16,7 @@
 #include <ethdev_driver.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 #include <rte_tailq.h>
 #include <rte_flow_driver.h>
 
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 6f5af03f6a..cbc3df6d7c 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -15,7 +15,7 @@
 #include <ethdev_driver.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 #include <rte_tailq.h>
 #include <rte_flow_driver.h>
 #include <rte_flow.h>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_flow.c b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
index 941d2921fb..47f4936bc6 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_flow.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
@@ -16,7 +16,7 @@
 #include <ethdev_driver.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_eth_ctrl.h>
+#include <ethdev_fdir.h>
 #include <rte_tailq.h>
 #include <rte_rawdev.h>
 #include <rte_rawdev_pmd.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index c290f04611..68b54ae750 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -16,6 +16,7 @@
 #include "ixgbe_bypass.h"
 #include "ixgbe_ipsec.h"
 #include <rte_flow.h>
+#include <ethdev_fdir.h>
 #include <rte_time.h>
 #include <rte_hash.h>
 #include <rte_pci.h>
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index eeae6a3301..c1383e7b4e 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -27,6 +27,7 @@
 
 #include <rte_alarm.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index c32c61d8bf..a48d710ab1 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -18,6 +18,7 @@
 #include <rte_time.h>
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
+#include <ethdev_fdir.h>
 #include <rte_hash.h>
 #include <rte_hash_crc.h>
 #include <bus_pci_driver.h>
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..2dc63cfa18 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -2365,42 +2365,6 @@ struct rte_eth_tunnel_filter_conf {
 	uint16_t queue_id;      /**< Queue assigned to if match */
 };
 
-/**
- *  Memory space that can be configured to store Flow Director filters
- *  in the board memory.
- */
-enum rte_eth_fdir_pballoc_type {
-	RTE_ETH_FDIR_PBALLOC_64K = 0,  /**< 64k. */
-	RTE_ETH_FDIR_PBALLOC_128K,     /**< 128k. */
-	RTE_ETH_FDIR_PBALLOC_256K,     /**< 256k. */
-};
-
-/**
- *  Select report mode of FDIR hash information in Rx descriptors.
- */
-enum rte_fdir_status_mode {
-	RTE_FDIR_NO_REPORT_STATUS = 0, /**< Never report FDIR hash. */
-	RTE_FDIR_REPORT_STATUS, /**< Only report FDIR hash for matching pkts. */
-	RTE_FDIR_REPORT_STATUS_ALWAYS, /**< Always report FDIR hash. */
-};
-
-/**
- * A structure used to configure the Flow Director (FDIR) feature
- * of an Ethernet port.
- *
- * If mode is RTE_FDIR_MODE_NONE, the pballoc value is ignored.
- */
-struct rte_eth_fdir_conf {
-	enum rte_fdir_mode mode; /**< Flow Director mode. */
-	enum rte_eth_fdir_pballoc_type pballoc; /**< Space for FDIR filters. */
-	enum rte_fdir_status_mode status;  /**< How to report FDIR hash. */
-	/** Rx queue of packets matching a "drop" filter in perfect mode. */
-	uint8_t drop_queue;
-	struct rte_eth_fdir_masks mask;
-	/** Flex payload configuration. */
-	struct rte_eth_fdir_flex_conf flex_conf;
-};
-
 /**
  * @internal
  * Fetch from the driver what kind of configuration must be restored by ethdev layer,
diff --git a/lib/ethdev/rte_eth_ctrl.h b/lib/ethdev/ethdev_fdir.h
similarity index 91%
rename from lib/ethdev/rte_eth_ctrl.h
rename to lib/ethdev/ethdev_fdir.h
index 9ec3f5eff9..ca3f866e69 100644
--- a/lib/ethdev/rte_eth_ctrl.h
+++ b/lib/ethdev/ethdev_fdir.h
@@ -1,24 +1,19 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2015 Intel Corporation
+ * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#ifndef _RTE_ETH_CTRL_H_
-#define _RTE_ETH_CTRL_H_
-
-#include <stdint.h>
-#include <rte_common.h>
-#include <rte_ether.h>
-#include "rte_flow.h"
-#include "rte_ethdev.h"
+#ifndef _ETHDEV_FDIR_H_
+#define _ETHDEV_FDIR_H_
 
 /**
- * @deprecated Please use rte_flow API instead of this legacy one.
  * @file
  *
- * Ethernet device features and related data structures used
- * by control APIs should be defined in this file.
+ * Ethernet device definitions used by devices still dependent on legacy
+ * flow director definitions. Do not use in new drivers.
  */
 
+#include <rte_flow.h>
+
 /**
  * Define all structures for ntuple Filter type.
  */
@@ -483,4 +478,41 @@ struct rte_eth_fdir_stats {
 	uint32_t best_cnt;     /**< Number of filters in best effort spaces. */
 };
 
-#endif /* _RTE_ETH_CTRL_H_ */
+
+/**
+ *  Memory space that can be configured to store Flow Director filters
+ *  in the board memory.
+ */
+enum rte_eth_fdir_pballoc_type {
+	RTE_ETH_FDIR_PBALLOC_64K = 0,  /**< 64k. */
+	RTE_ETH_FDIR_PBALLOC_128K,     /**< 128k. */
+	RTE_ETH_FDIR_PBALLOC_256K,     /**< 256k. */
+};
+
+/**
+ *  Select report mode of FDIR hash information in Rx descriptors.
+ */
+enum rte_fdir_status_mode {
+	RTE_FDIR_NO_REPORT_STATUS = 0, /**< Never report FDIR hash. */
+	RTE_FDIR_REPORT_STATUS, /**< Only report FDIR hash for matching pkts. */
+	RTE_FDIR_REPORT_STATUS_ALWAYS, /**< Always report FDIR hash. */
+};
+
+/**
+ * A structure used to configure the Flow Director (FDIR) feature
+ * of an Ethernet port.
+ *
+ * If mode is RTE_FDIR_MODE_NONE, the pballoc value is ignored.
+ */
+struct rte_eth_fdir_conf {
+	enum rte_fdir_mode mode; /**< Flow Director mode. */
+	enum rte_eth_fdir_pballoc_type pballoc; /**< Space for FDIR filters. */
+	enum rte_fdir_status_mode status;  /**< How to report FDIR hash. */
+	/** Rx queue of packets matching a "drop" filter in perfect mode. */
+	uint8_t drop_queue;
+	struct rte_eth_fdir_masks mask;
+	/** Flex payload configuration. */
+	struct rte_eth_fdir_flex_conf flex_conf;
+};
+
+#endif /* _ETHDEV_FDIR_H_ */
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 8ba6c708a2..3d556f8b7f 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -32,11 +32,11 @@ headers = files(
 
 indirect_headers += files(
         'rte_ethdev_core.h',
-        'rte_eth_ctrl.h',
 )
 
 driver_sdk_headers += files(
         'ethdev_driver.h',
+        'ethdev_fdir.h',
         'ethdev_pci.h',
         'ethdev_vdev.h',
         'rte_flow_driver.h',
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..7a17b81208 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -164,8 +164,10 @@
 #include <rte_devargs.h>
 #include <rte_bitops.h>
 #include <rte_errno.h>
+#include <rte_ether.h>
 #include <rte_common.h>
 #include <rte_config.h>
+#include <rte_mbuf_history.h>
 #include <rte_power_intrinsics.h>
 
 #include "rte_ethdev_trace_fp.h"
@@ -1505,17 +1507,6 @@ enum rte_eth_tunnel_type {
 	RTE_ETH_TUNNEL_TYPE_MAX,
 };
 
-#ifdef __cplusplus
-}
-#endif
-
-/* Deprecated API file for rte_eth_dev_filter_* functions */
-#include "rte_eth_ctrl.h"
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /**
  * UDP tunneling configuration.
  *
-- 
2.53.0

