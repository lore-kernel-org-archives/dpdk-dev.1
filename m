Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD727CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A78840615;
	Thu, 15 Oct 2026 11:17:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B13FD4026E;
 Thu, 15 Oct 2026 11:17:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055850; x=1823591850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HHzlowFM6JZlsfT5wEZNUJ41wTsTMY7Z72pBZjTGvDM=;
 b=LEhCIKNxMl+7VVsV0lgJoEbGJ8gfEnd/wNcXASqNqaf60qd6URyuRb5A
 NNVupvZI5uWOXEcTVq0m7OBwxcC6JIpherwZjQUCdjaDr1x40kQTNfPxu
 esdS6LsbtR1zdrUF5lox/wQbPFp+am39J+S44MYLWwyYeeSMx4/tc31X4
 VBVrRVil3lAUsMXUFrHPuR/8tluuKCgR0FqXgVVZvGzu8/1g0eKm7zB6b
 391CsGI/7FgChaCfh6XGENkoxwTFJ+iKDTWxqBeMnn0QeBzu9isJh5+Gn
 ouEMHlPaQ/PIyJ666FHE8kWnkk9eS3QqfupFNpo6CeirX3hEVrSXgaPii g==;
X-CSE-ConnectionGUID: uy05xdZuT+uLwuArMXpy4Q==
X-CSE-MsgGUID: HY/n5GPYRbuQITCs+b2/Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808464"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808464"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:29 -0700
X-CSE-ConnectionGUID: k6l8Wu+MQ7SBMP+sMAJTrg==
X-CSE-MsgGUID: W68dHIfNR6iP9h3I22sABw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000346"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:28 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 1/6] net/failsafe: fix double release of sub-device port
Date: Thu, 15 Oct 2026 16:19:22 +0000
Message-Id: <20261015161927.194886-2-sandeep.penigalapati@intel.com>
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

fs_dev_remove() releases the sub-device ethdev port a second time after
it has already been released: for an active sub-device by
rte_eth_dev_close(), and for a probed one by the driver remove called
from rte_dev_remove(). The first release sets eth_dev->data to NULL, so
the second rte_eth_dev_release_port() dereferences a NULL pointer and
crashes during hot-unplug.

Remove the redundant release and let the close and bus remove paths own
the release of the port.

Fixes: fac0ae546e5f ("net/failsafe: free port by dedicated function")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v3:
- Reword the commit message and remove the now-redundant braces.

 drivers/net/failsafe/failsafe_ether.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index f0fd662c7b..1702b1a604 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -298,12 +298,9 @@ fs_dev_remove(struct sub_device *sdev)
 		/* fallthrough */
 	case DEV_PROBED:
 		ret = rte_dev_remove(sdev->dev);
-		if (ret < 0) {
+		if (ret < 0)
 			ERROR("Bus detach failed for sub_device %u",
 			      SUB_ID(sdev));
-		} else {
-			rte_eth_dev_release_port(ETH(sdev));
-		}
 		sdev->state = DEV_PARSED;
 		/* fallthrough */
 	case DEV_PARSED:
-- 
2.34.1

