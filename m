Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFEC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:34:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67B86402E0;
	Wed,  1 Jul 2026 10:34:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 446C940278;
 Wed,  1 Jul 2026 10:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782894841; x=1814430841;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=U0/gFydhQFyIcc3aa+22S3P7TVb7lMQPFrmVkT60h5w=;
 b=StPfQVjYgSROZsghDHZSkiPfV8nfXQrL5hGdpeUYuLnCmExNkJWowZ1M
 KIlzYpSI6GbyfK0e7KhEwIjpBFLqnh7z8cbCTNy/0OZHBG5EQrrXKXHs0
 hmmVAveNNJGDI7dY6KZc61ZnzW6MH2t2hyCOHBDs254oct5lPgFHwRcv0
 VSPZ7QihblYZH0ZQndjduqq7kdka3VpVxejGfTThpL9eYSK5F4Nfu/96B
 69gcQklvaC654r0+gHbL9HGGBQ4FVyf/GfJHc3/tC15evD57Brt224UKB
 GiYplohS1vUaNoU41HMsX9MplszBQWRx5Hzdt0284u7/jJChQnsrv8yva A==;
X-CSE-ConnectionGUID: dGrEtBbVQYecybyGdV++YA==
X-CSE-MsgGUID: T2oZ48zfRDOWtB8nUP+MgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="93977341"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="93977341"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:33:44 -0700
X-CSE-ConnectionGUID: AISzIhaBShqr2NVCfGB/1w==
X-CSE-MsgGUID: zJtqPkcNTO+5LVYm9Oj/gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="251453765"
Received: from unknown (HELO dpdk..) ([10.239.252.105])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:33:41 -0700
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Remy Horton <remy.horton@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Zijie Pan <zijie.pan@6wind.com>
Subject: [PATCH] net/ixgbe: fix EEPROM read failure on copper media
Date: Wed,  1 Jul 2026 09:07:03 +0000
Message-ID: <20260701090703.107264-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.43.0
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

The ixgbe_get_module_info() and ixgbe_get_module_eeprom() functions
attempt to read SFF EEPROM data for all port types. However, copper
media ports do not have SFF EEPROMs, causing invalid I2C operations
and generating error logs.

This patch adds a media type check at the beginning of both functions.
If the media type is ixgbe_media_type_copper, return -ENOTSUP to
safely skip the EEPROM read.

Fixes: b74d0cd43e37 ("net/ixgbe: add module EEPROM callbacks for ixgbe")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index f9de95e4fc..44c29f0642 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -7424,6 +7424,12 @@ ixgbe_get_module_info(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return -E_RTE_SECONDARY;
 
+	if (hw->phy.media_type == ixgbe_media_type_copper) {
+		PMD_DRV_LOG(DEBUG, "Port %u is Base-T (copper), no SFF module info.",
+				dev->data->port_id);
+		return -ENOTSUP;
+	}
+
 	/* Check whether we support SFF-8472 or not */
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_SFF_8472_COMP,
@@ -7477,6 +7483,12 @@ ixgbe_get_module_eeprom(struct rte_eth_dev *dev,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return -E_RTE_SECONDARY;
 
+	if (hw->phy.media_type == ixgbe_media_type_copper) {
+		PMD_DRV_LOG(DEBUG, "Port %u is Base-T (copper), cannot read module EEPROM.",
+				dev->data->port_id);
+		return -ENOTSUP;
+	}
+
 	for (i = info->offset; i < info->offset + info->length; i++) {
 		if (i < RTE_ETH_MODULE_SFF_8079_LEN)
 			status = hw->phy.ops.read_i2c_eeprom(hw, i, &databyte);
-- 
2.47.1

