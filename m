Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE0C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7352B40DD3;
	Sun,  2 Aug 2026 20:19:09 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 6CC6440A76
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:19:01 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1748530a91.2
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694740;
 x=1786299540; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XITLqLMvufTog90UlXrxL3ax61zfZSjwKKzLKXGqlXA=;
 b=MVveD5j7Ya3MMlxZQATwCmDule6XyzyPOz9RM2PUjrfRrWtbMefoVhOWiZ85X7iPpk
 z+VtM4eQolLQ4JOk5q7tD5sLoh2HHom62DUSwHH4Ml+/wq6Hqek3WLR8YiVDhdQBSwj6
 4/QIfg7LDFsJqT+wppv5yT94MKyckc4g8/h3oESuAeqoTp+15BdqyzEdBEkw/osTbywt
 yRB2/N831h0A92CU3msG3ZmseyTIvz1U/UKk20IJcurIUpNlgpWoYS1VfxmsvajVKdKk
 lMoRxojeO9f1GLoinuD/IkS8ZnwwGPCYplvChGGacWJS/4syESVuuyI4IFF/zg8B9bEU
 g8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694740; x=1786299540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XITLqLMvufTog90UlXrxL3ax61zfZSjwKKzLKXGqlXA=;
 b=bTG/RPnT6iMF2uUhZsYLwPsNyVIDJWRsu2BZApDDyk5hGFHQc6B2iNifHIO1IyrQ2o
 NTiildfth23WaZt/ijR/HXmm6YjLmiOHRzkPUX6cL65CLx+fv97fafw+lOoFJbHk+bgh
 LwiL8/AVXBRcWKcVNExKXttxYO93mz2OeeOpjM+FypX1tfdTWni8rhr9CMECrO0LDAg6
 W/z9ahkhrdA7vYYQJSdzKcsL82tXJPXgUUDrlFpg3FIeZWcsx+D1iN7Rxz4PwT1qkHQ7
 o8mqAcfo4W17pLYCGbbQ1X5//Ce92vZ9wcQkCJqCVldz0NpkKRGuan7KIHcnkeS9diIe
 p0Fg==
X-Gm-Message-State: AOJu0YyF4JHvTmDQ8KxtXxmDDAxqyV0LmlUzRfqkNe5dALmUewpm8X3e
 KYxG6sNwz6jmteweZtbEGacE5xl3jFkUK0oRhKyewqynch2W/qm4dY/x1BGJg5aKMDXV24j2Lsg
 7Q5GS
X-Gm-Gg: AR+sD12FJR+BwMbWosXMiMAWqzVMxw/mxVHrd0H+81rlJrcZMvjeqF3RPHn3HgxwbUc
 KzOh+0ddINin3GKKVFpOCe5QGi3hVwdyBUUNcNjBGa95Y5z2S3ZXv+GZ1pmS92iVPdH7ltsFt7q
 C7+9/M60lHrXCx4ew0fHJZrbZNzQr9Yen/FV6qVS67M3dYILPfaPVz0mKmnWE66UoC30AhYQ4Ec
 dY1/M8EK5k8HSSeEzlYd+rI25y5L1wrYF4BH7+Atgq+Hnm9th3yLotjFOhDXDYwhNJGaVax3qda
 4INKUdogZbM6QEafZ1f9KFlV86f6UgOMUtxsBFj2QKpMj4bvawKuM2mcSc2BV0NFLcqQHCXEJ8K
 kW/mmE9PKTUDCDqvuLHTZkuR4etWMo5wnxUDqNSfZRKP6RjZnWCP8ak7wthI1EPG/hyaV/Ro2nQ
 6t/NTrz5qafrUKQp0GJZpVBtugozNQr01K1VgB61VRebS/3oEQRMm2dP/hljl29tevo66FhRzwu
 8+zUFP782B1QKAhn+Zj1jM/4YY=
X-Received: by 2002:a17:90b:3a8e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-38fbc3f09e8mr6377604a91.5.1785694740353; 
 Sun, 02 Aug 2026 11:19:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:59 -0700 (PDT)
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
Subject: [RFC 20/21] ethdev, drivers: isolate flow director
Date: Sun,  2 Aug 2026 11:15:25 -0700
Message-ID: <20260802181835.476887-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

