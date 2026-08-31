Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD08C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BA1640A4B;
	Mon, 31 Aug 2026 12:26:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 87BDB4025A;
 Mon, 31 Aug 2026 12:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171994; x=1819707994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gvM+LjJIqZSdVvVc1GsbHpJRRnUIfbIjSRVwW67DSgI=;
 b=JHi1niwuN/zeAeHXqdP1rRhTFFUcV2g6XY+NgRSJs2UI75lnftcZHhGl
 /zWf6hzCzCNZ+YUCiAGQW0RZP2ihOyn43acWu/FEcd2UJCpy6fb66rghS
 Pceqqb+UJKypuxMSwBPLY8WvuMSWNgRn61rjMxcdxQ+Di35xlaIPRqwkV
 JZpo6gE6MYBXOvQ0eMPBPgxAgMPTrIFNhCvxl178CUXMhCJJXeXs44xCm
 L8ZqZcqpOJyQR2wUyhVEsZo6BwVOaJJNZUjn+4a/hYNdd2CXd08PFbNVK
 X/ZlFbPK8DF4TUZ1gjK0Kx/dw7h3TWNgEi+/AVCBPbFXdyHtZDccALQOF Q==;
X-CSE-ConnectionGUID: xnos8ZD2QYKfgW83sSXXrA==
X-CSE-MsgGUID: AKpmCnUCRMu5HWhKaKYIUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88452418"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88452418"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:26:33 -0700
X-CSE-ConnectionGUID: w7AusR7oSb6y0xgOI3pYlQ==
X-CSE-MsgGUID: A+nEDXXmRUO3zkKwKOEHQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267424150"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 31 Aug 2026 03:26:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Date: Mon, 31 Aug 2026 11:26:16 +0100
Message-ID: <20260831102621.495759-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831102621.495759-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
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

The outer VLAN TPID setting for Tx was cached in the driver but was not
properly pushed to hardware (via PF) when changed. Add the necessary
push call to the update function.

Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index c4a6763f28..126be4c9a5 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1461,13 +1461,17 @@ iavf_vlan_tpid_set(struct rte_eth_dev *dev, enum rte_vlan_type vlan_type, uint16
 		return -ENOTSUP;
 	}
 
-	/* This API only fills internal iavf_adapter structure
-	 * and does not send any signal to hardware.
-	 * Inner VLAN always 0x8100, so not set explicitly.
-	 */
+	/* Inner VLAN always 0x8100, so not set explicitly. */
 	if (qinq && vlan_type == RTE_ETH_VLAN_TYPE_OUTER)
 		adapter->tpid = tpid; /* Outer VLAN can be 0x88a8 or 0x8100 */
 
+	/* Re-push insertion, and stripping if already enabled, so the new
+	 * outer TPID reaches the PF instead of only being cached here.
+	 */
+	iavf_dev_vlan_insert_set(dev);
+	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
+		iavf_dev_vlan_offload_set(dev, RTE_ETH_QINQ_STRIP_MASK);
+
 	return 0;
 }
 
-- 
2.53.0

