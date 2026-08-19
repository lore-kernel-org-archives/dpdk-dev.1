Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C9C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3A4C40671;
	Wed, 19 Aug 2026 14:33:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2E109402E3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142779; x=1818678779;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VuieRT+K13sUnur89ipPNM7CT1ckhfstYg+/TWkIGH4=;
 b=ZA9X9TurtY5Pe6WaymyPkNepon8g89ZF1Oqycmldd/v6sSufojMdXx2g
 pP+qiuwte9PPXCbq9nje+0ySVlOjSyiEcnaoAOOVg1hPIlnQaNrQvm2r+
 n0rlxqc6hPHbCBIJbEwjtbcc62tKQUejFLi195T3RHHCWOEMzMOZzlTuk
 5YF/G6RqAQ25rrSVohI4EH+Qn8nhA0239/1uOWQhaR9tor6ArjlZfP50U
 Z0yKVwFO362lPe+TKASwKuS1KvvPr/s7gCKMq2UoA6eyfiUEZeo0n2E/e
 aO9pjn0YjJhQZ1cAzoFgdKTx54Jdmagi3bnaS9tOf4sn4keEzJ04gOVzm w==;
X-CSE-ConnectionGUID: MRhV2jdgTCWkBtp7DRQyzw==
X-CSE-MsgGUID: OouAtb+yS9KtQ30KEcWOQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87775530"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87775530"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:32:58 -0700
X-CSE-ConnectionGUID: CWSsAjSASSuDuFl1eSBFUQ==
X-CSE-MsgGUID: YWHaIbVbSAuTh4ThdFPBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269382549"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 19 Aug 2026 05:32:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 3/7] net/ixgbe: harmonize return values in IPsec
Date: Wed, 19 Aug 2026 13:32:35 +0100
Message-ID: <9c975187ca0a629777ac877466eaf438be8604dd.1787142684.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787142684.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
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
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
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

