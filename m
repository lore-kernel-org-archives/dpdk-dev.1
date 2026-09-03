Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E593C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 14:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E58F42D7A;
	Thu,  3 Sep 2026 16:38:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 113E7402D8;
 Thu,  3 Sep 2026 16:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788446318; x=1819982318;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/0H5iR4mMRbe2/3CGO5wQUr1YK7wKIyWjP3teKLolF4=;
 b=nFjQUtmBzn021ti1jEMfighMaoWael5KOgLltq2CwyKGgmg/QVtWViff
 1jGJNK6wpB9tFUheV0zNl+GpnNU6jfSqU2psoDQny10QsuwgXmCSj81if
 g7uB8roz3MoOe7kjOYOsNBm9DZJ0kaVSJ9iGpLIkI/ScGjvV2021+JuDD
 ep1ChDGn1tsyE3zoiAgJgjGAEShUgyCp6j7VsR1Nq0h8ZMPfn0fs9DeON
 ebk5lDSwPzLpxeFRSgtA/kbjoI3MIvVN25wTpmpx3yFBUSZCBPWbC++/s
 facGullOhyRjkrxP6LOOl5HhnnklQxIkWiTMUZgKXwMUEiodLpRtyRbU2 w==;
X-CSE-ConnectionGUID: pwV+ORFzQJGBw2g0gWpD5g==
X-CSE-MsgGUID: uAzwHigLQx+wZIqtmoGZ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87869774"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87869774"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 07:38:37 -0700
X-CSE-ConnectionGUID: Gv1uSZepT1iyUWAyK994QQ==
X-CSE-MsgGUID: d9+Z3tF4SdGi8DHKw9sIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273894937"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 07:38:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Date: Thu,  3 Sep 2026 15:37:25 +0100
Message-ID: <20260903143827.327131-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903143827.327131-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260903143827.327131-1-bruce.richardson@intel.com>
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
 drivers/net/intel/iavf/iavf_ethdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index c4a6763f28..2ac4dbdac4 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1461,13 +1461,20 @@ iavf_vlan_tpid_set(struct rte_eth_dev *dev, enum rte_vlan_type vlan_type, uint16
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
+	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP) {
+		int ret = iavf_dev_vlan_offload_set(dev, RTE_ETH_QINQ_STRIP_MASK);
+		if (ret != 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

