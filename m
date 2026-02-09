Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C21E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:47:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2D540DD1;
	Mon,  9 Feb 2026 17:46:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2EDF740B9B
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655562; x=1802191562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DzxdsZqMfuv9h2JF69Ei4y2iKFnjIqml89xea4UVbgU=;
 b=QqqZqZTFqoMbZhIFo3JFlnTjPxVbxghbEvskcqTU9k94xyC0f5ucANDU
 SQjiUN0m+VWx0WLQBXKM1VPYCg/JOYV+BZXdAvJiM/5AeypKtDorCyMqD
 2PPu6tz3g7ky7KOH41AknF6WaBKkdtxKoXev4eFPsABUDwnGvRrYyFzr7
 zwX0MqiNjlPeu1pExi8Mm9rVvp3fv1qKO8iDGPWeh5wG5ZpBdy40AxzX7
 IA6e5MOPUDrdJxya2OtWkgdZ1O8GSoYYopm+xtKQ8mxw2x0wYOX1nZsWe
 wxtP52gCXsOlZdRefYJvVs0kkhCqEFNgJjzKvAkN+JtaGbt8d9LvLTL3Q Q==;
X-CSE-ConnectionGUID: FmOp2izBTW2PcvZ5pxi/Gg==
X-CSE-MsgGUID: ho/dcBSxRUuO9E3O11MNWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663458"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663458"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:02 -0800
X-CSE-ConnectionGUID: hs/KIULESh+fXZHAFmDlwg==
X-CSE-MsgGUID: ElmLWE1dTDyPkjHI7mxsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789145"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:01 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 16/35] net/i40e: document requirement for QinQ support
Date: Mon,  9 Feb 2026 16:45:14 +0000
Message-ID: <20260209164538.1428499-17-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

In order to get multiple VLANs inserted in an outgoing packet with QinQ
offload the i40e driver needs to be set to double vlan mode. This is
done by using the VLAN_EXTEND Rx config flag. Add a code check for this
dependency and update the docs about it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/i40e.rst           | 18 ++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 40be9aa755..750af3c8b3 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -245,6 +245,24 @@ Runtime Configuration
   * ``segment``: Check number of mbuf segments not exceed hw limitation.
   * ``offload``: Check any unsupported offload flag.
 
+QinQ Configuration
+~~~~~~~~~~~~~~~~~~
+
+When using QinQ TX offload (``RTE_ETH_TX_OFFLOAD_QINQ_INSERT``), you must also
+enable ``RTE_ETH_RX_OFFLOAD_VLAN_EXTEND`` to configure the hardware for double
+VLAN mode. Without this, only the inner VLAN tag will be inserted.
+
+Example::
+
+  struct rte_eth_conf port_conf = {
+      .rxmode = {
+          .offloads = RTE_ETH_RX_OFFLOAD_VLAN_EXTEND,
+      },
+      .txmode = {
+          .offloads = RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
+      },
+  };
+
 Vector RX Pre-conditions
 ~~~~~~~~~~~~~~~~~~~~~~~~
 For Vector RX it is assumed that the number of descriptor rings will be a power
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 35c1b53c1e..dfd2213020 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2182,6 +2182,15 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	vsi = i40e_pf_get_vsi_by_qindex(pf, queue_idx);
 	if (!vsi)
 		return -EINVAL;
+
+	/* Check if QinQ TX offload requires VLAN extend mode */
+	if ((offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT) &&
+			!(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_EXTEND)) {
+		PMD_DRV_LOG(WARNING, "Port %u: QinQ TX offload is enabled but VLAN extend mode is not set. ",
+				dev->data->port_id);
+		PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly without RTE_ETH_RX_OFFLOAD_VLAN_EXTEND set in Rx configuration.");
+	}
+
 	q_offset = i40e_get_queue_offset_by_qindex(pf, queue_idx);
 	if (q_offset < 0)
 		return -EINVAL;
-- 
2.51.0

