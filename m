Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D11E6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20CAA40A84;
	Fri, 30 Jan 2026 12:42:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BF3BA402E0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773361; x=1801309361;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0NcggWj8zLUSnnBr2XYIIaEG3vm6OEUyIOC4XNSqBYA=;
 b=QsgQe0xABn7lWoeALn2NAPLW7yjv2Ujs6oBA+B5y/esvJka42RLqeTO+
 V+oNoLhfK/aBo5PFULNBGVtlKcIMShLkYapBH61Eu3NnG6OQl6NHpEsvp
 uP1L/PF1qc9y3oe0IxdxLoo1WwQIYSyxFToDf0MMPKwpzrrIxoUXmFweh
 X6N2peQ6L85lvXoCREblmlgUwgympZq1uj09JdNMA/nsXoqWrXu6uqLJG
 z7YnbIv9FUIpzPo9bN/sdhRs/rrIXpX1jP2avtNbaHqqgorN/z2BqIDOI
 VKuefkdX7X/pkQTkfTM+qek+A2vyTY+q8RTLwRXdIth4suwf4aSpRCCm4 A==;
X-CSE-ConnectionGUID: YQ7WdFOvTnGcwH/YwX1mJw==
X-CSE-MsgGUID: fL4VVFhMRrCfSvEOuhIK2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392313"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392313"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:40 -0800
X-CSE-ConnectionGUID: OWu7WY+aQgSlkBYKW+l9Sw==
X-CSE-MsgGUID: 5cd+JiJsR0a9uj29JESD2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190514"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 17/36] net/i40e: document requirement for QinQ support
Date: Fri, 30 Jan 2026 11:41:44 +0000
Message-ID: <20260130114207.1126032-18-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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
index 45dc083c94..cbfaddbdd8 100644
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
index 4e2071c024..49ec4dd8a1 100644
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

