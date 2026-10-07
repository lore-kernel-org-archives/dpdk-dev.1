Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494FACA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83080427BD;
	Wed,  7 Oct 2026 12:50:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4DFE1427D8
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370242; x=1822906242;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yvymFa86vhQKPB3/rBU8Pff6j16E9UM/DAw/Jr8Dgms=;
 b=dKAHZUMte26UWhRtwCAHhY1Nz6xTOK4YdOPUtcvPKQjlbygxry95rKIp
 TKxVlM1UTHAt0XIWw9iz3ERLf1EltLb6dQoOBOUpfFMKc2EZ/CYCsxuix
 0DsSe0dcERZDGQ2p8Kk4umoGtaRquEdBpgjEXvZT+n/y6qBfQtKviURTD
 mZSidEjbPjL9l6A1k0O5q+VOrD4C1ulolwwMIffSZfabsSnXVm61hSXv/
 YdBrzdj1irxGx3IoC7KCH7aodiI4y39+xsnqQjSfF346UtUZTs4WlUT3p
 5x3hUCYMhzL7/r2vp7tO5pzQ501aPcb5N+3hQY+QblqiTd9ooPaMRG56f Q==;
X-CSE-ConnectionGUID: QAziaU9HQMWultj3aFjNxg==
X-CSE-MsgGUID: fmGi/4qTQSKjCcgChBmkhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121818"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121818"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:42 -0700
X-CSE-ConnectionGUID: BoeeLfBpTOis844G+QQy3g==
X-CSE-MsgGUID: 35nH6tseQBaaGzJAwwegtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652103"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Beilei Xing <beilei.xing@intel.com>,
 Wei Zhao <wei.zhao1@intel.com>, Wei Dai <wei.dai@picocom.com>
Subject: [PATCH v5 08/25] net/ixgbe: fix syn filter priority
Date: Wed,  7 Oct 2026 11:50:03 +0100
Message-ID: <e963931c8f5a86c66ca808dd7c86a8f2f68949a7.1791369980.git.anatoly.burakov@intel.com>
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

In rte_flow API, 0 means highest priority. Fix SYN filter priority being
wrongly set to lower priority when API requests priority 0.

Fixes: 429f6ebb42cc ("net/ixgbe: parse TCP SYN filter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index a2b9403d3a1..6ba36a8b44a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -804,10 +804,10 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr, const struct rte_flow_it
 	filter->queue = q_act->index;
 
 	/* Support 2 priorities, the lowest or highest. */
-	if (!attr->priority) {
-		filter->hig_pri = 0;
-	} else if (attr->priority == (uint32_t)~0U) {
+	if (attr->priority == 0) {
 		filter->hig_pri = 1;
+	} else if (attr->priority == (uint32_t)~0U) {
+		filter->hig_pri = 0;
 	} else {
 		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
 		rte_flow_error_set(error, EINVAL,
-- 
2.52.0

