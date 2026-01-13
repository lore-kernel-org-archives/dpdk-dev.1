Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6647D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2F4A40BA2;
	Tue, 13 Jan 2026 16:15:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4BDF040B91
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317337; x=1799853337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GF80bsWZ3a1xxeXlRyBkqAR7sTHFaNfx7wMID3mmIFQ=;
 b=NbfS0A5+rcbe6qu1uNkpZfjbL8jve5u2Vqdq4mIn9Kmj2XYJzKRKei90
 3kYL/3LhMF7yA+f6LaBr67dU2m6s7eiAjpguyj23Kvt+PZ066lQKjs857
 xsKWbPRpzZqEcryf+AB+xZ3XmWROeXmape4CYC0itAnSls3+nZ2ahtWLm
 wEoQJyOCx+byB83AaXeWCVlXR0sd9M+Lc+etIroj8VCepNP6btPmtyJM+
 CTkd/rS44U0gbM9oC2He3swgkUsazKr2qLOUzM98LvWEiB7tpWyX2MorE
 WdrUjBl559ban1ZoxUEyyUB60lAV4FHNHy7Mj6rzTDlebMvxPrLrBGb0j w==;
X-CSE-ConnectionGUID: KAMQsGRgTTSNNMFY36YxUg==
X-CSE-MsgGUID: +dOKzx6dQWCqSqkyGqjR9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969193"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969193"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:36 -0800
X-CSE-ConnectionGUID: TmJpXZH2SHu/AHnkJ/w0sA==
X-CSE-MsgGUID: 3rWAZgXDSVSKkCCMnZCmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556612"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:35 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 17/36] net/i40e: document requirement for QinQ support
Date: Tue, 13 Jan 2026 15:14:41 +0000
Message-ID: <20260113151505.1871271-18-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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
index f0047e4f59..0ccd8e8b2a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2169,6 +2169,15 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
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

