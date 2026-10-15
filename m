Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D8CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB71740659;
	Thu, 15 Oct 2026 11:17:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6764140430;
 Thu, 15 Oct 2026 11:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055851; x=1823591851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UlKJrOASEgbXxDjGMNU7B3JTzLLPLNSS0uBTF9qokOc=;
 b=Zsyy+Sl1DBdi7HiwAs6krgG9dGqvv4NnjoL3pxM4o986deaAoXCFBQoR
 J7WqCbxSMM2P1Jqo6e2W0TnK8mqhplq/z8TkCp+HfJwEVFgcGpMTlfrxE
 2AhAjl7bTYql2dyPsaI88GI8QpPFiyFqODSf4VRt7bw88ofDiJflTDURo
 W3BP5EWQpTaMKctwXr+08CmjTceMyAHNL80i8nO/NsrKR9MBlDXDCHtbl
 Vnj2YP4r2QEvffGhUdYiFqqDu4NuiSEcflVwdGhmasUtOjLlJtPYmpyb3
 K2gt9F/g9W3dWhhg0y+RUESR9CJCZh6r/knmuWv5DKehGMYmn7WgW8KIB g==;
X-CSE-ConnectionGUID: CcqbShLjTDmVmmwv7fF4jQ==
X-CSE-MsgGUID: gKSS5HndTZKlwNV7B9R2dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808467"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808467"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:31 -0700
X-CSE-ConnectionGUID: PRYpQWzHSDqxeetGxgmJMg==
X-CSE-MsgGUID: qiApSIkfQrOVB9i0ImqCUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000351"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:29 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 2/6] net/failsafe: fix queue release without sub-device op
Date: Thu, 15 Oct 2026 16:19:23 +0000
Message-Id: <20261015161927.194886-3-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015161927.194886-1-sandeep.penigalapati@intel.com>
References: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
 <20261015161927.194886-1-sandeep.penigalapati@intel.com>
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

fs_rx_queue_release() and fs_tx_queue_release() iterate over the active
sub-devices and call the sub-device Rx/Tx queue release op directly.
Some PMDs do not implement that op, so the function pointer is NULL.
Calling it unconditionally could dereference a NULL pointer and crash
when releasing fail-safe queues.

Check that the sub-device provides the release op before calling it.

Fixes: a46f8d584eb8 ("net/failsafe: add fail-safe PMD")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v2:
- Added an ETH(sdev) != NULL check.
v3:
- Removed the ETH(sdev) != NULL check (ETH(sdev) is never NULL for an
  active sub-device) and corrected the Fixes tag.

 drivers/net/failsafe/failsafe_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 8761cb07c3..79aa57cb35 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -398,7 +398,8 @@ fs_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	if (rxq->event_fd >= 0)
 		close(rxq->event_fd);
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
-		if (ETH(sdev)->data->rx_queues != NULL &&
+		if (SUBOPS(sdev, rx_queue_release) != NULL &&
+		    ETH(sdev)->data->rx_queues != NULL &&
 		    ETH(sdev)->data->rx_queues[rxq->qid] != NULL)
 			SUBOPS(sdev, rx_queue_release)(ETH(sdev), rxq->qid);
 	}
@@ -574,7 +575,8 @@ fs_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	if (fs_lock(dev, 0) != 0)
 		return;
 	FOREACH_SUBDEV_STATE(sdev, i, dev, DEV_ACTIVE) {
-		if (ETH(sdev)->data->tx_queues != NULL &&
+		if (SUBOPS(sdev, tx_queue_release) != NULL &&
+		    ETH(sdev)->data->tx_queues != NULL &&
 		    ETH(sdev)->data->tx_queues[txq->qid] != NULL)
 			SUBOPS(sdev, tx_queue_release)(ETH(sdev), txq->qid);
 	}
-- 
2.34.1

