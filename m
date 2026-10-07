Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E6CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2676542D0C;
	Wed,  7 Oct 2026 12:50:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0769F427CE
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370248; x=1822906248;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=J/vnFG2kzLuuFq9ZZ/8bxN+63+geTSPMcrC+pgIWuKI=;
 b=I2W5831SbKvAV0a5WW8s2YNjdiEVViGbXwckT+h3kOc3yyrFo+DRBGM9
 aGFN/bV16I1sX3kWex10AcGzb3CZP2fQP1dxVeIffmdaJCWpOoKRtR1VU
 TKAv7RMoeSBbSCrUQiOxVidSKnUnfnXZwve9DTLGaOBQTvWdPaTznBshe
 jGFAIteE7oeC5VjKTCz48zTIvH4ZyfQDSoeyj+N9DjIrM5MsU1IiJGBPO
 Te+QBaYsNlYwiFHVWu9Dhzi8ER6rtU98e6Q+KdA8tYp1rYpEIxhf0l63r
 B79BNWMm/JK8ndG3vnyzVORTS/HCoECriU5DxS/qPHy+sF/JzVqOIfoUr Q==;
X-CSE-ConnectionGUID: SawOhZejRNKhZjLipNaMzA==
X-CSE-MsgGUID: ZkBekgfAT4m7vmQjMxAm5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121825"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121825"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:48 -0700
X-CSE-ConnectionGUID: 7xzU6NEBSa2dqQ5rytZ9bg==
X-CSE-MsgGUID: /gy9BBp1Q1mbJq+pwTyeGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652122"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v5 12/25] net/ixgbe: fix protocol-only ntuple parsing
Date: Wed,  7 Oct 2026 11:50:07 +0100
Message-ID: <e962022cac7f161d03e56e1621a98207e1cf91ef.1791369981.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791369979.git.anatoly.burakov@intel.com>
 <cover.1791369979.git.anatoly.burakov@intel.com>
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

Currently, when parsing ntuple flows, we may hit an empty L4 protocol item
(i.e. one that does not have a mask or spec), in which case we just skip to
the end. However, we do not set a protocol mask, which means we will not
be matching L4 flows even though the flow structure implies that we should.

Fix it by setting up match-by-protocol when we have an empty L4 flow.

Additionally, there's a separate issue with how empty L4 protocol items are
handled in that once we see one, we do not check whether there's anything
else past it, and instead go straight to exit. This means that we might
have any other flow item after L4 (e.g. ipv4 / tcp / gtp) and this will be
silently accepted. Fix by enforcing that last item is END.

Fixes: 46ea969177f3 ("net/ixgbe: add ntuple support to flow parser")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 547c6621d3e..808d3b955d8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -358,9 +358,28 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
+	/* an empty L4 item still implies its protocol */
 	if ((item->type != RTE_FLOW_ITEM_TYPE_END) &&
 		(!item->spec && !item->mask)) {
-		goto action;
+		uint8_t proto;
+
+		if (item->type == RTE_FLOW_ITEM_TYPE_TCP)
+			proto = IPPROTO_TCP;
+		else if (item->type == RTE_FLOW_ITEM_TYPE_UDP)
+			proto = IPPROTO_UDP;
+		else
+			proto = IPPROTO_SCTP;
+
+		if (filter->proto_mask != 0 && filter->proto != proto) {
+			*filter = (struct rte_eth_ntuple_filter){0};
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "L4 item conflicts with IPv4 protocol");
+			return -rte_errno;
+		}
+		filter->proto = proto;
+		filter->proto_mask = UINT8_MAX;
+		goto check_end;
 	}
 
 	/* get the TCP/UDP/SCTP info */
@@ -490,6 +509,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 		goto action;
 	}
 
+check_end:
 	/* check if the next not void item is END */
 	item = next_no_void_pattern(pattern, item);
 	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-- 
2.52.0

