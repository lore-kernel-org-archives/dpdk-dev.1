Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3DFC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCC924068E;
	Tue, 18 Aug 2026 15:19:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id EA53F40616
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787059181; x=1818595181;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=feDV0Wr4tPuBvcpTmT/t+GbpvQWfVrV0SYkkceilLuE=;
 b=POb4/ggntx5qC8JOmKTHdG5/GQx1fFOnASncIofjN536uJIK2SnaHdfR
 Sb3IagsyUHdVO+LpEgkooLT9ThrhK2PL24azUUQZU3489x/qQ7WxTCMCe
 9iDPA3YgB9hcYHj6g1KRcWRwMyMr0GmHajLKur9L4D1mWRcJGU8szdAK/
 2SsBUdZyOoK+H8j7703cDzt4Keox2Xwtb/MO+tkSF3MZAhg0X3EYzkPZu
 ZQk7BlT+igNfFqOwCH28HPhxKmoHfNmoXH3XQkZF6prXRRujltz+sRNqd
 RUPWHCqnThvkJmHFZVaoGCnAM6KjJkWrYyQEmTIsSPI+mQMx6JI9QJF0C A==;
X-CSE-ConnectionGUID: nYg97l0+Q/Cmv8P7dqX/Ow==
X-CSE-MsgGUID: Rol7uoEDQA+rzb3QtCPlYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="86669421"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="86669421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:19:40 -0700
X-CSE-ConnectionGUID: CmPWyHVMRyGrqYKPvD9eRw==
X-CSE-MsgGUID: +oUsZxJ0T9GbUTtSZM0IzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261015699"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:19:39 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 3/6] net/ixgbe: harmonize return values in IPsec
Date: Tue, 18 Aug 2026 14:19:29 +0100
Message-ID: <1c5a7ba5403b732d6cd3d7e8126c58691f4490f5.1787059138.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787059137.git.anatoly.burakov@intel.com>
References: 
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

Currently, some paths in add/remove SA code return negative errno values
while others just return -1. Harmonize all of them to return appropriate
negative errno values.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ipsec.c | 30 +++++++++++----------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index e2ec402b52..41fc7551ff 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -119,9 +119,8 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 
 		/* Fail if no match and no free entries*/
 		if (ip_index < 0) {
-			PMD_DRV_LOG(ERR,
-				    "No free entry left in the Rx IP table");
-			return -1;
+			PMD_DRV_LOG(ERR, "No free entry left in the Rx IP table");
+			return -ENOSPC;
 		}
 
 		/* Find a free entry in the SA table*/
@@ -133,9 +132,8 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 		}
 		/* Fail if no free entries*/
 		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR,
-				    "No free entry left in the Rx SA table");
-			return -1;
+			PMD_DRV_LOG(ERR, "No free entry left in the Rx SA table");
+			return -ENOSPC;
 		}
 
 		priv->rx_ip_tbl[ip_index].ip.ipv6[0] =
@@ -231,9 +229,8 @@ ixgbe_crypto_add_sa(struct ixgbe_crypto_session *ic_session)
 		}
 		/* Fail if no free entries*/
 		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR,
-				    "No free entry left in the Tx SA table");
-			return -1;
+			PMD_DRV_LOG(ERR, "No free entry left in the Tx SA table");
+			return -ENOSPC;
 		}
 
 		priv->tx_sa_tbl[sa_index].spi =
@@ -289,9 +286,8 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 
 		/* Fail if no match*/
 		if (ip_index < 0) {
-			PMD_DRV_LOG(ERR,
-				    "Entry not found in the Rx IP table");
-			return -1;
+			PMD_DRV_LOG(ERR, "Entry not found in the Rx IP table");
+			return -ENOENT;
 		}
 
 		/* Find a free entry in the SA table*/
@@ -304,9 +300,8 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 		}
 		/* Fail if no match*/
 		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR,
-				    "Entry not found in the Rx SA table");
-			return -1;
+			PMD_DRV_LOG(ERR, "Entry not found in the Rx SA table");
+			return -ENOENT;
 		}
 
 		/* Disable and clear Rx SPI and key table entries*/
@@ -347,9 +342,8 @@ ixgbe_crypto_remove_sa(struct ixgbe_crypto_session *ic_session)
 		}
 		/* Fail if no match entries*/
 		if (sa_index < 0) {
-			PMD_DRV_LOG(ERR,
-				    "Entry not found in the Tx SA table");
-			return -1;
+			PMD_DRV_LOG(ERR, "Entry not found in the Tx SA table");
+			return -ENOENT;
 		}
 		reg_val = IPSRXIDX_WRITE | (sa_index << 3);
 		IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(0), 0);
-- 
2.52.0

