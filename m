Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55480C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8DDC40653;
	Mon, 31 Aug 2026 12:36:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 76A844025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788172605; x=1819708605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MNLfSyOuInlCK8u7cskQwUgSeHCNCFjvA0S2Zoq8vNU=;
 b=iy0S6ye6a7QWe6Ps4WBVez09PQo8B00LkgbDWGU7tVvBM19DXgWC1YKG
 m3tgNn/CI5brgGxq2ejm7SFAwxoXVKqiYhHTv49RjeMGIhjthliwrQoSX
 Qb9BQlbe8NSBzwYfcYDtXWdcOhGCn9wr66hOYhemFRvyxCBfEKH1HdODo
 foyUb+vwtdWWB+1we2GzzFG5+xN4k5d6CreENunfh8qoWNy8/rWTXXxru
 iA+y9c3ynRs182EkhzIwNods6RAYTG5fmp07UPkO0Gzyat80ItwjnJQyF
 uSbqiUsIufYAMZQQjHPwtKIxV6J5wobG/Rqm+byHXigm+yFQO87o4Ghov Q==;
X-CSE-ConnectionGUID: Tj5ihQwgSeGdIuBxjj3CQg==
X-CSE-MsgGUID: kXMSp5ktTDy8WJwz+FSw8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88625947"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88625947"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:36:45 -0700
X-CSE-ConnectionGUID: eSPA/x0HTne/A/e3+EY9Xw==
X-CSE-MsgGUID: BiFXwX4qROaNF7AhZg0f9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268807429"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 31 Aug 2026 03:36:44 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 1/4] net/common: share Tx context descriptor flag
Date: Mon, 31 Aug 2026 10:35:27 +0000
Message-Id: <1e2a3778ab771dd7daa08d2ae33546a02f0d61c4.1788171502.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788171502.git.anurag.mandal@intel.com>
References: <cover.1788171502.git.anurag.mandal@intel.com>
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

Moved context descriptor state to the common
Tx queue for reuse by ice.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/common/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 55757d34d7..61ad041065 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -175,6 +175,7 @@ struct ci_tx_queue {
 	bool tx_deferred_start; /* don't start this queue in dev start */
 	bool q_set;             /* indicate if tx queue has been configured */
 	bool use_vec_entry;     /* use sw_ring_vec (true for vector and simple paths) */
+	bool use_ctx;           /* each packet uses a context and data descriptor */
 	union {                  /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct iavf_vsi *iavf_vsi;
@@ -196,7 +197,6 @@ struct ci_tx_queue {
 #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 BIT(1)
 			uint8_t vlan_flag;
 			uint8_t tc;
-			bool use_ctx;  /* with ctx info, each pkt needs two descriptors */
 			bool lldp_enabled;
 		};
 		struct { /* ixgbe specific values */
-- 
2.34.1

