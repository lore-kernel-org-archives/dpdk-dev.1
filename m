Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4436CA601D
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:00:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 733B5402DC;
	Fri,  9 Oct 2026 12:59:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4AFF340B92
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791543582; x=1823079582;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=J/vnFG2kzLuuFq9ZZ/8bxN+63+geTSPMcrC+pgIWuKI=;
 b=PiOfQbS/0GObOqRIqm+P8PnZfhStmx6ga9nkGutA7/oyM90wDhSZ3W93
 WompUdJ0h6Ug+/7Ai27wNutfND2FoRNadlT+OuHknMDUIltlukePWOMD5
 hZX78B6TJlhPJS1WXvvwsAdP2EJdqEkDuwN0tXve74GJsgR+wlzqVdHIR
 qwwapmdiCr8mBf5RtbWI26jpZDBZGND9Daup/Ow/A8rTumHsuZoDEaqQ5
 fAuMOoJwmYgJWkzQrsYnK73Ni59YfM+OK9fUtfy+Efc6ENZlAINhkE5Q+
 Vf32i0TxBgUFM/dnbv8TjFiIGZ50ZRN5XZ0/TrHSoOqawO5jD6KhVfg30 w==;
X-CSE-ConnectionGUID: qBwveBS0SnuMRoEuEBiDXA==
X-CSE-MsgGUID: 1w5ZL+o9Sg2Tg8ZfsCg3Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="241415"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="241415"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:59:41 -0700
X-CSE-ConnectionGUID: HWRk0JhKTI2nZ9jHf7SAeg==
X-CSE-MsgGUID: vXC/A/8ORwWd9gfP9lYx8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2088386"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 09 Oct 2026 03:59:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Zhao <wei.zhao1@intel.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: [PATCH v6 12/25] net/ixgbe: fix protocol-only ntuple parsing
Date: Fri,  9 Oct 2026 11:59:02 +0100
Message-ID: <27b39f9a15d6f5aeaffd1dcbf2955761dfe90f9c.1791543155.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791543153.git.anatoly.burakov@intel.com>
 <cover.1791543153.git.anatoly.burakov@intel.com>
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

