Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED20ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65E8040E31;
	Wed, 11 Feb 2026 19:13:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 30B1640A6F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833630; x=1802369630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hthdubai36KYetKixt2ygn89t4omV605tW/0IUalcoU=;
 b=QkhTkBqgTHXYEkw8ChAZtW040h2T2TWuTf2uOiUO0PlCFYiJd2QPukbk
 gNRBJlthDp6aKzYvuXIv1Rqehry1bRWRNfoJe/M9fEd+e3EkzcJBoUKHf
 KMvm+D0ZWVyzDkCjoz0BNl6jnmI/IFF6Yg5vT2sR3PHNeiUfB4frcmdZa
 63LrFf63YVLPSOM06RwA8kASd/Lq1RGcke7IEy8MNb0NtGq6BfeGDfHbY
 XLO14HzAtX56DB0p0QSYgw93uR2sOsQhbaQOf/xG6Lqb9pLWNEYBDiwQB
 5lQpERN85FrJUFpkyqX7X5abyj8N7wFQhlujho0V0hrwzWXls1mhdM0UZ g==;
X-CSE-ConnectionGUID: MpK7+unlQ6CYYdvlmi7gqA==
X-CSE-MsgGUID: xVMlbCwaSy6NBAfuCR5rYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834685"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:50 -0800
X-CSE-ConnectionGUID: x7VhKp7bTp62RZ5CZMhMOw==
X-CSE-MsgGUID: mmdYEPG0TC6aoc9TdXSTIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986352"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 17/35] net/i40e: document requirement for QinQ support
Date: Wed, 11 Feb 2026 18:12:46 +0000
Message-ID: <20260211181309.2838042-18-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
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

