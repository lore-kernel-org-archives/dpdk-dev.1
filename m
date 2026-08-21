Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A0EC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BF8C40678;
	Fri, 21 Aug 2026 21:27:54 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 602E340289
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:27:52 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-848761b5897so571318b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340471;
 x=1787945271; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cR0eeZ+R2aDM+0nixxQeTSAWJShcH1dE0qfPm5kA6Q8=;
 b=eJuiY3AbQZIPp135lP188mJE5FbNGj1W49p6BGtgNsnZhUfuI+uVpU3NoaVPjH1NhU
 YAApFynjYWPiH4JGvWymrHToaJ/xgjqgZ3VlPYp7OahR29ScqOp/PFrb3IXZQD7lcM+C
 yKnRtO6OkTo7y6vyPApnXHbeS8qollmTzqXjKSEpzp99oOpOZ65NLNmT5jyJYoYmyExK
 15ItNOJOpN3c4YSC6kV07IjA/JAPK0xurLXKVhUUtVX0W0xZgSIwBPSvVykAHsrNkxpH
 f5Ou0BKNFxoyNUZuffeblDKXHcFj0vAVeVmb2uLSo+hNEPuk9b3Xuwz8a+qvrPNwuHcF
 jrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340471; x=1787945271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cR0eeZ+R2aDM+0nixxQeTSAWJShcH1dE0qfPm5kA6Q8=;
 b=a3NcvhsdasP/PAYOWT+Ctktjryq2XTo5JvqRY6mOUmzXUKkd8O48tc+y5J4A8DyM20
 xNuSYFsnB+kp/P2KiWvd/vTj6In+zenKwJSZ2ihlz3HJOa+HR/ltek1Xq84eR5pumRtF
 w41NwvtrXND+btvZlMsVFweZcgYR8RYuV2tvmg3Hqpjc/cJI7hzQe0skfkgfAWsij2U0
 CiuzCmbNnpcdDySIstJI0Y0kgIDYeee+Y6XZ0/84cSWcWJLB7WSSp5BqUiHZ69y8id9e
 VpC5VHPcTSGbktpUKL35xuLjHmhAq4NF+U97neRY9SohEPAY2ZqsM6KBI+5EYBUWJ7Ph
 P6rg==
X-Gm-Message-State: AFuF++lTvQQDveYqc6NZdJQhgbBH/gXYN94R8eanvtcNna5Id1ol3r+a
 IL2RiFxQQG34KKy+z+jhcfO+MkukztRpHE7zpdPD4dliK1K/3fgFvWy9/SwbFzYK/4B2sKc3EAM
 wBCm5uJk=
X-Gm-Gg: AR+sD13f8WB/9j0NO3HXNl3hAh9AEfs/W8oLd0MJTBVsEnjUHNKtKUi9Z9FGfS/2QnF
 7EROBenp+dDMNb1Nj1bil4F+ezuLJrGzvEpOMza3ldU1cf0FazmWGg0xRJGQDgOnS2YCju5tvGK
 uywUCJPR7hHICnElO1yKx/hET41bVoJrqppOAkyvQtYoUfrUuhPDi6x3e45AZ9T/h/EmOBEqcmT
 TyXqgCcYTwCFvVLpQENBCpXzS9jGwNmUw7vYipozBXbJ0r1Y+8JLXO65+xp7QhjpsmygXIevZVC
 4qTre3JQfBXOmpE0e/tChXZowMD8nOQ0I+XHnE2rqQENzf4x0KJwcq/d/Uqv2SMD+rXiv864RHG
 tXDAKDG5aNXax0jvcrFyzsqwbmFPxkm9kU9LzrYsIMcNv+Kip27AdFjkz9pDWahjC8whnIh+adV
 hQq7+c/ulyTdkFfR6Ui6TBa6C24Jna3kGNmVS5PbYyybnSxxgMCFPFxaUoB0JGrSFvIhy+vRmcV
 WER9CgJ79MkFAq+E1bkIAie+vc=
X-Received: by 2002:a05:6a21:4c06:b0:3c4:3112:3b with SMTP id
 adf61e73a8af0-3cd3021b509mr17427865637.18.1787340471412; 
 Fri, 21 Aug 2026 12:27:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:27:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Igor Russkikh <irusskikh@marvell.com>, Julien Aube <julien_dpdk@jaube.fr>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Andrew Boyer <andrew.boyer@amd.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Martin Spinler <spinler@cesnet.cz>, Chaoyong He <chaoyong.he@corigine.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang <wang.junlong1@zte.com.cn>,
 Ming Ran <ran.ming@zte.com.cn>
Subject: [PATCH v2 03/68] net: add missing include of rte_memcpy.h
Date: Fri, 21 Aug 2026 12:23:58 -0700
Message-ID: <20260821192646.146382-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

These files use rte_memcpy() but relied on rte_memcpy.h being
included indirectly via another header. Add the direct include
so that later patches which remove now-unnecessary includes of
rte_memcpy.h do not break the build.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_xdp/rte_eth_af_xdp.c              | 1 +
 drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c  | 1 +
 drivers/net/bnx2x/bnx2x.h                        | 1 +
 drivers/net/bnx2x/ecore_sp.c                     | 1 +
 drivers/net/bnx2x/ecore_sp.h                     | 1 +
 drivers/net/cnxk/cn10k_ethdev_sec.c              | 1 +
 drivers/net/cnxk/cn10k_rx.h                      | 1 +
 drivers/net/cnxk/cn20k_ethdev_sec.c              | 1 +
 drivers/net/cnxk/cn20k_rx.h                      | 1 +
 drivers/net/cnxk/cnxk_ethdev_ops.c               | 1 +
 drivers/net/cnxk/cnxk_rep_flow.c                 | 1 +
 drivers/net/cnxk/cnxk_rep_msg.c                  | 1 +
 drivers/net/cnxk/cnxk_rep_ops.c                  | 1 +
 drivers/net/cxgbe/cxgbe_ethdev.c                 | 1 +
 drivers/net/cxgbe/sge.c                          | 1 +
 drivers/net/dpaa/dpaa_rxtx.c                     | 1 +
 drivers/net/dpaa2/dpaa2_mux.c                    | 1 +
 drivers/net/ena/ena_ethdev.c                     | 1 +
 drivers/net/ena/ena_rss.c                        | 1 +
 drivers/net/gve/gve_rx.c                         | 1 +
 drivers/net/gve/gve_tx.c                         | 1 +
 drivers/net/hinic/hinic_pmd_tx.c                 | 1 +
 drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 1 +
 drivers/net/ionic/ionic_rxtx.h                   | 1 +
 drivers/net/memif/rte_eth_memif.c                | 1 +
 drivers/net/mlx4/mlx4_rxtx.c                     | 1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c          | 1 +
 drivers/net/mlx5/mlx5_flow.c                     | 1 +
 drivers/net/mlx5/mlx5_flow_dv.c                  | 1 +
 drivers/net/mlx5/mlx5_flow_flex.c                | 1 +
 drivers/net/mlx5/mlx5_flow_hw.c                  | 1 +
 drivers/net/mlx5/mlx5_rx.h                       | 1 +
 drivers/net/mlx5/mlx5_rxq.c                      | 1 +
 drivers/net/mlx5/mlx5_tx.h                       | 1 +
 drivers/net/mlx5/mlx5_txpp.c                     | 1 +
 drivers/net/nfb/nfb_rx.h                         | 1 +
 drivers/net/nfb/nfb_tx.h                         | 1 +
 drivers/net/nfp/flower/nfp_conntrack.c           | 1 +
 drivers/net/nfp/flower/nfp_flower_cmsg.c         | 1 +
 drivers/net/nfp/nfp_net_flow.c                   | 1 +
 drivers/net/nfp/nfpcore/nfp_nsp.c                | 1 +
 drivers/net/ntnic/ntnic_ethdev.c                 | 1 +
 drivers/net/octeon_ep/otx_ep_rxtx.c              | 1 +
 drivers/net/sfc/sfc_ethdev.c                     | 1 +
 drivers/net/sfc/sfc_mae.c                        | 1 +
 drivers/net/sfc/sfc_tbl_meta_cache.c             | 1 +
 drivers/net/sfc/sfc_tso.c                        | 1 +
 drivers/net/vmxnet3/vmxnet3_rxtx.c               | 1 +
 drivers/net/xsc/xsc_tx.c                         | 1 +
 drivers/net/zxdh/zxdh_rxtx.c                     | 1 +
 50 files changed, 50 insertions(+)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..8f976b80d3 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -22,6 +22,7 @@
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <bus_vdev_driver.h>
+#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_branch_prediction.h>
 #include <rte_common.h>
diff --git a/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c
index 31d043599e..da687f8809 100644
--- a/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -7,6 +7,7 @@
  */
 
 #include <rte_ether.h>
+#include <rte_memcpy.h>
 #include <pthread.h>
 #include "../atl_hw_regs.h"
 
diff --git a/drivers/net/bnx2x/bnx2x.h b/drivers/net/bnx2x/bnx2x.h
index 35206b4758..16d2fef5d1 100644
--- a/drivers/net/bnx2x/bnx2x.h
+++ b/drivers/net/bnx2x/bnx2x.h
@@ -15,6 +15,7 @@
 #define __BNX2X_H__
 
 #include <rte_byteorder.h>
+#include <rte_memcpy.h>
 #include <rte_spinlock.h>
 #include <bus_pci_driver.h>
 #include <rte_io.h>
diff --git a/drivers/net/bnx2x/ecore_sp.c b/drivers/net/bnx2x/ecore_sp.c
index c6c3857778..0d017500be 100644
--- a/drivers/net/bnx2x/ecore_sp.c
+++ b/drivers/net/bnx2x/ecore_sp.c
@@ -13,6 +13,7 @@
 
 #include "bnx2x.h"
 #include "ecore_init.h"
+#include <rte_memcpy.h>
 
 /**** Exe Queue interfaces ****/
 
diff --git a/drivers/net/bnx2x/ecore_sp.h b/drivers/net/bnx2x/ecore_sp.h
index c0b4d431c8..979197b45b 100644
--- a/drivers/net/bnx2x/ecore_sp.h
+++ b/drivers/net/bnx2x/ecore_sp.h
@@ -16,6 +16,7 @@
 
 #include <rte_bitops.h>
 #include <rte_byteorder.h>
+#include <rte_memcpy.h>
 
 #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
 #ifndef __LITTLE_ENDIAN
diff --git a/drivers/net/cnxk/cn10k_ethdev_sec.c b/drivers/net/cnxk/cn10k_ethdev_sec.c
index 2f1fdf34fc..3ecd19264a 100644
--- a/drivers/net/cnxk/cn10k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn10k_ethdev_sec.c
@@ -4,6 +4,7 @@
 
 #include <rte_cryptodev.h>
 #include <rte_eventdev.h>
+#include <rte_memcpy.h>
 #include <rte_security.h>
 #include <rte_security_driver.h>
 #include <rte_pmd_cnxk.h>
diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
index e55910b575..370e5031cf 100644
--- a/drivers/net/cnxk/cn10k_rx.h
+++ b/drivers/net/cnxk/cn10k_rx.h
@@ -5,6 +5,7 @@
 #define __CN10K_RX_H__
 
 #include <rte_ethdev.h>
+#include <rte_memcpy.h>
 #include <rte_security_driver.h>
 #include <rte_vect.h>
 #include "cn10k_rxtx.h"
diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index a5be85901f..8417c41962 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -4,6 +4,7 @@
 
 #include <rte_cryptodev.h>
 #include <rte_eventdev.h>
+#include <rte_memcpy.h>
 #include <rte_pmd_cnxk.h>
 #include <rte_security.h>
 #include <rte_security_driver.h>
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index f8fa6de2b9..2794ab7d30 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -6,6 +6,7 @@
 
 #include "cn20k_rxtx.h"
 #include <rte_ethdev.h>
+#include <rte_memcpy.h>
 #include <rte_security_driver.h>
 #include <rte_vect.h>
 
diff --git a/drivers/net/cnxk/cnxk_ethdev_ops.c b/drivers/net/cnxk/cnxk_ethdev_ops.c
index 0ea3d7e89f..b1ccc6598c 100644
--- a/drivers/net/cnxk/cnxk_ethdev_ops.c
+++ b/drivers/net/cnxk/cnxk_ethdev_ops.c
@@ -3,6 +3,7 @@
  */
 
 #include <cnxk_ethdev.h>
+#include <rte_memcpy.h>
 
 int
 cnxk_nix_info_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *devinfo)
diff --git a/drivers/net/cnxk/cnxk_rep_flow.c b/drivers/net/cnxk/cnxk_rep_flow.c
index 1b013ce598..68ee334e01 100644
--- a/drivers/net/cnxk/cnxk_rep_flow.c
+++ b/drivers/net/cnxk/cnxk_rep_flow.c
@@ -8,6 +8,7 @@
 #include <cnxk_flow.h>
 #include <cnxk_rep.h>
 #include <cnxk_rep_msg.h>
+#include <rte_memcpy.h>
 
 #define DEFAULT_DUMP_FILE_NAME "/tmp/fdump"
 #define MAX_BUFFER_SIZE	       1500
diff --git a/drivers/net/cnxk/cnxk_rep_msg.c b/drivers/net/cnxk/cnxk_rep_msg.c
index a222e2b5cd..48179dab36 100644
--- a/drivers/net/cnxk/cnxk_rep_msg.c
+++ b/drivers/net/cnxk/cnxk_rep_msg.c
@@ -4,6 +4,7 @@
 
 #include <cnxk_rep.h>
 #include <cnxk_rep_msg.h>
+#include <rte_memcpy.h>
 
 #define CTRL_MSG_RCV_TIMEOUT_MS 2000
 #define CTRL_MSG_READY_WAIT_US	2000
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index c481015592..6dab022732 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -4,6 +4,7 @@
 
 #include <cnxk_rep.h>
 #include <cnxk_rep_msg.h>
+#include <rte_memcpy.h>
 
 #define MEMPOOL_CACHE_SIZE 256
 #define TX_DESC_PER_QUEUE  512
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 82e67eeff1..d311ae06a5 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -19,6 +19,7 @@
 #include <rte_interrupts.h>
 #include <rte_log.h>
 #include <rte_debug.h>
+#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_branch_prediction.h>
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..4697aab217 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -19,6 +19,7 @@
 #include <rte_interrupts.h>
 #include <rte_log.h>
 #include <rte_debug.h>
+#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <rte_branch_prediction.h>
 #include <rte_memory.h>
diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index 272960b6e3..a25807f422 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -18,6 +18,7 @@
 #include <rte_interrupts.h>
 #include <rte_log.h>
 #include <rte_debug.h>
+#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <rte_atomic.h>
 #include <rte_branch_prediction.h>
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 9bb1bbca38..7b7bf4161c 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -15,6 +15,7 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_flow_driver.h>
+#include <rte_memcpy.h>
 #include <rte_tailq.h>
 
 #include <bus_fslmc_driver.h>
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index ad2ac6dbbf..e194fd5ab1 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -4,6 +4,7 @@
  */
 
 #include <rte_alarm.h>
+#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
 #include <rte_version.h>
diff --git a/drivers/net/ena/ena_rss.c b/drivers/net/ena/ena_rss.c
index 0af1879dc4..e8c20eb1d6 100644
--- a/drivers/net/ena/ena_rss.c
+++ b/drivers/net/ena/ena_rss.c
@@ -7,6 +7,7 @@
 #include "ena_logs.h"
 
 #include <ena_admin_defs.h>
+#include <rte_memcpy.h>
 
 #define TEST_BIT(val, bit_shift) ((val) & (1UL << (bit_shift)))
 
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 567b82d020..c8c303e67d 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -4,6 +4,7 @@
 
 #include "gve_ethdev.h"
 #include "base/gve_adminq.h"
+#include <rte_memcpy.h>
 
 #define GVE_PKT_CONT_BIT_IS_SET(x) (GVE_RXF_PKT_CONT & (x))
 
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index c0400b07bf..9578adc712 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -4,6 +4,7 @@
 
 #include "gve_ethdev.h"
 #include "base/gve_adminq.h"
+#include <rte_memcpy.h>
 
 static inline void
 gve_free_bulk_mbuf(struct rte_mbuf **txep, int num)
diff --git a/drivers/net/hinic/hinic_pmd_tx.c b/drivers/net/hinic/hinic_pmd_tx.c
index 22fb0bffaf..b5654dbd38 100644
--- a/drivers/net/hinic/hinic_pmd_tx.c
+++ b/drivers/net/hinic/hinic_pmd_tx.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_mbuf.h>
+#include <rte_memcpy.h>
 #include <rte_tcp.h>
 #include <rte_sctp.h>
 #include <rte_udp.h>
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 5788a009ab..c591cb56e0 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -3,6 +3,7 @@
  */
 
 #include <eal_export.h>
+#include <rte_memcpy.h>
 #include <rte_vect.h>
 #include "idpf_common_device.h"
 #include "idpf_common_rxtx.h"
diff --git a/drivers/net/ionic/ionic_rxtx.h b/drivers/net/ionic/ionic_rxtx.h
index b3e4e5e5b3..64e6b7e5fc 100644
--- a/drivers/net/ionic/ionic_rxtx.h
+++ b/drivers/net/ionic/ionic_rxtx.h
@@ -8,6 +8,7 @@
 #include <stdint.h>
 
 #include "ionic_if.h"
+#include <rte_memcpy.h>
 
 struct ionic_rx_qcq;
 struct ionic_tx_qcq;
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 5d153c3a5a..cd46d94042 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <sys/eventfd.h>
 
+#include <rte_memcpy.h>
 #include <rte_version.h>
 #include <rte_mbuf.h>
 #include <rte_ether.h>
diff --git a/drivers/net/mlx4/mlx4_rxtx.c b/drivers/net/mlx4/mlx4_rxtx.c
index 3ad1c5b6ec..937db7040c 100644
--- a/drivers/net/mlx4/mlx4_rxtx.c
+++ b/drivers/net/mlx4/mlx4_rxtx.c
@@ -25,6 +25,7 @@
 #include <rte_common.h>
 #include <rte_io.h>
 #include <rte_mbuf.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_prefetch.h>
 
diff --git a/drivers/net/mlx5/linux/mlx5_ethdev_os.c b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
index 4bbc590e91..09e084f5e7 100644
--- a/drivers/net/mlx5/linux/mlx5_ethdev_os.c
+++ b/drivers/net/mlx5/linux/mlx5_ethdev_os.c
@@ -33,6 +33,7 @@
 #include <rte_eal_paging.h>
 #include <rte_interrupts.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_rwlock.h>
 #include <rte_cycles.h>
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index b0eac185b5..ccc3cb97aa 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -19,6 +19,7 @@
 #include <rte_flow_driver.h>
 #include <rte_malloc.h>
 #include <rte_ip.h>
+#include <rte_memcpy.h>
 
 #include <mlx5_glue.h>
 #include <mlx5_devx_cmds.h>
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 58ebcf87eb..72b5f627c9 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -19,6 +19,7 @@
 #include <bus_pci_driver.h>
 #include <rte_ip.h>
 #include <rte_gre.h>
+#include <rte_memcpy.h>
 #include <rte_vxlan.h>
 #include <rte_gtp.h>
 #include <rte_eal_paging.h>
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index baa5ddd977..9dd5099727 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2021 NVIDIA Corporation & Affiliates
  */
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <mlx5_devx_cmds.h>
 #include <mlx5_malloc.h>
 #include "mlx5.h"
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 1cffdcc54d..626e10ca74 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5,6 +5,7 @@
 #include <eal_export.h>
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
+#include <rte_memcpy.h>
 #include <rte_stdatomic.h>
 
 #include <mlx5_malloc.h>
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index cd48ee37ef..1d17a00c47 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -10,6 +10,7 @@
 #include <sys/queue.h>
 
 #include <rte_mbuf.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_common.h>
 #include <rte_spinlock.h>
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 25dba7f4d9..bf7b9f4bf7 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -19,6 +19,7 @@
 #include <rte_debug.h>
 #include <rte_io.h>
 #include <rte_eal_paging.h>
+#include <rte_memcpy.h>
 
 #include <mlx5_glue.h>
 #include <mlx5_malloc.h>
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 682dc07718..aec2d05196 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -10,6 +10,7 @@
 #include <sys/queue.h>
 
 #include <rte_mbuf.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_common.h>
 #include <rte_spinlock.h>
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index 6de969a6be..50946cc3cb 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -11,6 +11,7 @@
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_eal_paging.h>
+#include <rte_memcpy.h>
 
 #include <mlx5_malloc.h>
 #include <mlx5_common_devx.h>
diff --git a/drivers/net/nfb/nfb_rx.h b/drivers/net/nfb/nfb_rx.h
index 831945c577..66489653e7 100644
--- a/drivers/net/nfb/nfb_rx.h
+++ b/drivers/net/nfb/nfb_rx.h
@@ -13,6 +13,7 @@
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_ethdev.h>
+#include <rte_memcpy.h>
 #include <rte_time.h>
 
 #include "nfb.h"
diff --git a/drivers/net/nfb/nfb_tx.h b/drivers/net/nfb/nfb_tx.h
index c253af1a86..80dc961ee5 100644
--- a/drivers/net/nfb/nfb_tx.h
+++ b/drivers/net/nfb/nfb_tx.h
@@ -13,6 +13,7 @@
 #include <ethdev_driver.h>
 #include <rte_ethdev.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 
 struct ndp_tx_queue {
 	struct nfb_device *nfb;     /* nfb dev structure */
diff --git a/drivers/net/nfp/flower/nfp_conntrack.c b/drivers/net/nfp/flower/nfp_conntrack.c
index 439a1a1b0e..0852d28fa7 100644
--- a/drivers/net/nfp/flower/nfp_conntrack.c
+++ b/drivers/net/nfp/flower/nfp_conntrack.c
@@ -8,6 +8,7 @@
 #include <rte_malloc.h>
 #include <rte_hash.h>
 #include <rte_jhash.h>
+#include <rte_memcpy.h>
 
 #include "../nfp_logs.h"
 #include "nfp_flower_cmsg.h"
diff --git a/drivers/net/nfp/flower/nfp_flower_cmsg.c b/drivers/net/nfp/flower/nfp_flower_cmsg.c
index 92bb927196..f5aa66dc4a 100644
--- a/drivers/net/nfp/flower/nfp_flower_cmsg.c
+++ b/drivers/net/nfp/flower/nfp_flower_cmsg.c
@@ -10,6 +10,7 @@
 #include "../nfp_net_meta.h"
 #include "nfp_flower_ctrl.h"
 #include "nfp_flower_representor.h"
+#include <rte_memcpy.h>
 
 static char*
 nfp_flower_cmsg_get_data(struct rte_mbuf *m)
diff --git a/drivers/net/nfp/nfp_net_flow.c b/drivers/net/nfp/nfp_net_flow.c
index 0e5003ebe3..c25d90a89b 100644
--- a/drivers/net/nfp/nfp_net_flow.c
+++ b/drivers/net/nfp/nfp_net_flow.c
@@ -9,6 +9,7 @@
 #include <rte_hash.h>
 #include <rte_jhash.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 
 #include "nfp_logs.h"
 #include "nfp_net_cmsg.h"
diff --git a/drivers/net/nfp/nfpcore/nfp_nsp.c b/drivers/net/nfp/nfpcore/nfp_nsp.c
index 43c13baabe..187e7c43a8 100644
--- a/drivers/net/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/nfp/nfpcore/nfp_nsp.c
@@ -7,6 +7,7 @@
 
 #include <nfp_platform.h>
 #include <rte_common.h>
+#include <rte_memcpy.h>
 
 #include "nfp_logs.h"
 #include "nfp_resource.h"
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..d536a41c4e 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -7,6 +7,7 @@
 
 #include <rte_eal.h>
 #include <rte_dev.h>
+#include <rte_memcpy.h>
 #include <rte_vfio.h>
 #include <rte_ethdev.h>
 #include <rte_bus_pci.h>
diff --git a/drivers/net/octeon_ep/otx_ep_rxtx.c b/drivers/net/octeon_ep/otx_ep_rxtx.c
index 09ed3c8da0..a4deb2881e 100644
--- a/drivers/net/octeon_ep/otx_ep_rxtx.c
+++ b/drivers/net/octeon_ep/otx_ep_rxtx.c
@@ -5,6 +5,7 @@
 #include <unistd.h>
 #include <assert.h>
 #include <rte_eal.h>
+#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_io.h>
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 6be91789cf..0a8551fac7 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -12,6 +12,7 @@
 #include <dev_driver.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
+#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_errno.h>
diff --git a/drivers/net/sfc/sfc_mae.c b/drivers/net/sfc/sfc_mae.c
index b0e8b02b41..cbc7c9ecb0 100644
--- a/drivers/net/sfc/sfc_mae.c
+++ b/drivers/net/sfc/sfc_mae.c
@@ -12,6 +12,7 @@
 #include <rte_byteorder.h>
 #include <rte_bitops.h>
 #include <rte_common.h>
+#include <rte_memcpy.h>
 #include <rte_vxlan.h>
 
 #include "efx.h"
diff --git a/drivers/net/sfc/sfc_tbl_meta_cache.c b/drivers/net/sfc/sfc_tbl_meta_cache.c
index bffbc4a158..dfab08a06c 100644
--- a/drivers/net/sfc/sfc_tbl_meta_cache.c
+++ b/drivers/net/sfc/sfc_tbl_meta_cache.c
@@ -5,6 +5,7 @@
 
 #include <rte_malloc.h>
 #include <rte_jhash.h>
+#include <rte_memcpy.h>
 
 #include "sfc_tbl_meta_cache.h"
 #include "sfc_debug.h"
diff --git a/drivers/net/sfc/sfc_tso.c b/drivers/net/sfc/sfc_tso.c
index a0827d1c0d..76094669e9 100644
--- a/drivers/net/sfc/sfc_tso.c
+++ b/drivers/net/sfc/sfc_tso.c
@@ -8,6 +8,7 @@
  */
 
 #include <rte_ip.h>
+#include <rte_memcpy.h>
 #include <rte_tcp.h>
 
 #include "sfc.h"
diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index 552b8a9823..433552d6f8 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -19,6 +19,7 @@
 #include <rte_log.h>
 #include <rte_debug.h>
 #include <rte_interrupts.h>
+#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/net/xsc/xsc_tx.c b/drivers/net/xsc/xsc_tx.c
index 265439fec0..d15fb0d508 100644
--- a/drivers/net/xsc/xsc_tx.c
+++ b/drivers/net/xsc/xsc_tx.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_io.h>
+#include <rte_memcpy.h>
 
 #include "xsc_log.h"
 #include "xsc_defs.h"
diff --git a/drivers/net/zxdh/zxdh_rxtx.c b/drivers/net/zxdh/zxdh_rxtx.c
index db86922aea..3c30ed8a7d 100644
--- a/drivers/net/zxdh/zxdh_rxtx.c
+++ b/drivers/net/zxdh/zxdh_rxtx.c
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <stdalign.h>
 
+#include <rte_memcpy.h>
 #include <rte_net.h>
 
 #include "zxdh_logs.h"
-- 
2.53.0

