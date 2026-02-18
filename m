Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF24AE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20BF940616;
	Wed, 18 Feb 2026 10:50:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 48EA84014F;
 Wed, 18 Feb 2026 10:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408207; x=1802944207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BOdFnI73/LegpoNg3GJarmEyfWt2KvvdbIYmySkWBdw=;
 b=nLWS05S1UhZ1bmlhKliS3rKQiKs9+ObcxSm/qr90i8WT2vEFmJ3Ic9tO
 fHkZ5zlbCxu67LelUZE7l3oTwgxgtmQ6414A0pXfytrOR1sU+dq75DdSo
 x/tgGK+3fAIQBnnI/v4pYNO0BmxaunKnvxgGRqIeF5GD95gpkjWkNYN7v
 zy1jNjuFdQk5vD032CrBrEz5yagQiN++wysjAac6MdmeKYlKiPUHqg47H
 fupbkv8knaTUphJJi63OJDlZ5JGsOthPbX9Cq2JY9QqJpcaVdoZUv77rZ
 lTpPa3+R/0K32Zi6LzXUGrck4gsTju0XYmS1vxZcSfHrM16U0/2nNQoD3 g==;
X-CSE-ConnectionGUID: NCdeI2hdRE2CJtIsNYMVuA==
X-CSE-MsgGUID: xPrGBciPST2dXGGqfBTRCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929843"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929843"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:06 -0800
X-CSE-ConnectionGUID: rRFwXKxbSP+zMdQuqVeKEA==
X-CSE-MsgGUID: FRYstsaNRja0lJ00/gaLSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257072"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:04 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v3 02/10] net/iavf: permit secondary process Rx path selection
Date: Wed, 18 Feb 2026 09:49:29 +0000
Message-ID: <20260218094937.1652391-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
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

Commit 3f59c3d97a89 ("net/iavf: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 3f59c3d97a89 ("net/iavf: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index e621d4bf47..a47d2547dd 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3815,8 +3815,8 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-- 
2.43.0

